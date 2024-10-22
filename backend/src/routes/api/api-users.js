import express from "express";
import { requiresAuthentication } from "../../middleware/auth-middleware.js";
import { createUser, deleteUser, updateUser, getUserWithUsername } from "../../data/users-dao.js";
import { getArticleByUserId } from "../../data/articles-dao.js";

const router = express.Router();

router.get("/me", requiresAuthentication, (req, res) => {
  return res.json(req.user);
});

router.patch("/me", requiresAuthentication, async (req, res) => {
  try {
    const isUpdated = await updateUser(req.user.id, req.body);
    return res.sendStatus(isUpdated ? 204 : 404);
  } catch {
    return res.sendStatus(422);
  }
});

router.post("/", async (req, res) => {
  try {
    // Create the new customer, create a location based on its id, and send everything back with a 201.
    const newUser = await createUser(req.body);
    const location = `/api/users/${newUser.id}`;
    return res.status(201).location(location).json(newUser);
  } catch (err) {
    return res.status(422).json(err.errors);
  }
});

router.delete("/:id", async (req, res) => {
  await deleteUser(req.params.id);
  return res.sendStatus(204);
});

router.get("/check-username", async (req, res) => {
  const { username } = req.query; // Get the username from query parameters

  // Validate if the username parameter is provided
  if (!username) {
    return res.status(400).json({ error: "Username query parameter is required" });
  }

  // Check if the username exists in the database
  const user = await getUserWithUsername(username);

  if (user) {
    // If user exists, return that the username is not available
    return res.json({ available: false });
  } else {
    // If user doesn't exist, return that the username is available
    return res.json({ available: true });
  }
});

router.get("/articles", requiresAuthentication, async (req, res) => {
  const articles = await getArticleByUserId(req.user.id);
  return res.json(articles);
});

export default router;
