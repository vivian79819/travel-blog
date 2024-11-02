import yup from "yup";
import { getDatabase } from "./database.js";
import { updateDatabase } from "./util.js";
import bcrypt from "bcrypt";

//Gets the user with the given username, if it exists.

export async function getUserWithUsername(username) {
  const db = await getDatabase();
  return await db.get("SELECT * from Users WHERE username = ?", username);
}

/**
 * Gets the user with the given username and password, if it exists.
 *
 */
async function validatePassword(enteredPassword, storedHashedPassword) {
  const isMatch = await bcrypt.compare(enteredPassword, storedHashedPassword);
  return isMatch;
}
export async function getUserWithCredentials(username, password) {
  const db = await getDatabase();
  const user = await db.get("SELECT * FROM Users WHERE username = ?", username);

  if (!user) {
    return null; // User not found
  }

  // Validate the entered password against the stored hashed password
  const isPasswordValid = await validatePassword(password, user.password);

  // Return the user if the password is valid; otherwise, return null
  return isPasswordValid ? user : null;
}

/**
 * Schema for "update user".
 */
const updateUserSchema = yup
  .object({
    selectedAvatar: yup.string().min(1).optional(),
    username: yup.string().min(1).optional(),
    firstName: yup.string().min(1).optional(),
    lastName: yup.string().min(1).optional(),
    password: yup.string().min(5).optional(),
    blurb: yup.string().optional()
  })
  .required();

export async function updateUser(id, udpateData) {
  const parsedUpdateData = updateUserSchema.validateSync(udpateData, {
    abortEarly: false,
    stripUnknown: true
  });

  const db = await getDatabase();
  const dbResult = await updateDatabase(db, "Users", parsedUpdateData, id);

  return dbResult.changes > 0;
}

export async function deleteUser(id) {
  const db = await getDatabase();
  const dbResult = await db.run("DELETE FROM Users WHERE id = ?", parseInt(id));
  return dbResult.changes > 0;
}
const createUserSchema = yup
  .object({
    selectedAvatar: yup.string().required(),
    username: yup.string().required(),
    firstName: yup.string().required(),
    lastName: yup.string().required(),
    password: yup.string().min(5).required(),
    dob: yup.date().required(),
    email: yup.string().email().required(),
    blurb: yup.string().nullable()
  })
  .required();

/**
 * Creates a new user and returns it. Throws an error if any of the required data is undefined.
 *
 */
export async function createUser(userData) {
  const newUser = createUserSchema.validateSync(userData, {
    abortEarly: false,
    stripUnknown: true
  });

  // Insert new customer into database
  const db = await getDatabase();
  const hashedPassword = await bcrypt.hash(newUser.password, 10);
  const dobFormatted = new Date(newUser.dob).toISOString().split("T")[0];
  const dbResult = await db.run(
    "INSERT INTO Users (selectedAvatar, username, firstName, lastName, password,email,dob,blurb) VALUES(?, ?, ?,?,?,?,?,?)",
    newUser.selectedAvatar,
    newUser.username,
    newUser.firstName,
    newUser.lastName,
    hashedPassword,
    newUser.email,
    dobFormatted,
    newUser.blurb
  );

  // Give the returned customer an ID, which was created by the database, then return.
  newUser.id = dbResult.lastID;
  return newUser;
}
