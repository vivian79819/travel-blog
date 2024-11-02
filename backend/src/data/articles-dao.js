import { getDatabase } from "./database.js";
import { updateDatabase } from "./util.js";
import yup from "yup";
export async function getArticles() {
  const db = await getDatabase();
  const articles = await db.all(`
    SELECT 
      Articles.*, 
      Users.username, 
      Users.selectedAvatar as userAvatar
    FROM Articles 
    JOIN Users ON Articles.userId = Users.id`);
  return articles;
}

/**
 * Schema for "update article".
 */
const updateArticleSchema = yup
  .object({
    title: yup.string().min(1).optional(),
    description: yup.string().min(1).optional(),
    content: yup.string().min(1).optional(),
    image: yup.mixed().optional()
  })
  .required();

export async function updateArticle(id, udpateData) {
  const parsedUpdateData = updateArticleSchema.validateSync(udpateData, {
    abortEarly: false,
    stripUnknown: true
  });

  const db = await getDatabase();
  const dbResult = await updateDatabase(db, "Articles", parsedUpdateData, parseInt(id));

  return dbResult.changes > 0;
}

export const createArticleSchema = yup.object({
  title: yup.string().required("Title is required"),
  description: yup.string().required("Description is required"),
  content: yup.string().required("Content is required"),
  image: yup.string().nullable(),
  userId: yup.number().required("User ID is required")
});

export async function createArticle(articleData) {
  const newArticle = createArticleSchema.validateSync(articleData, {
    abortEarly: false,
    stripUnknown: true
  });
  const db = await getDatabase();
  const date = new Date().toISOString().split("T")[0];

  const dbResult = await db.run(
    `INSERT INTO Articles (title, description, content, image, userId, date)
     VALUES (?, ?, ?, ?, ?, ?)`,
    newArticle.title,
    newArticle.description,
    newArticle.content,
    newArticle.image,
    newArticle.userId,
    date
  );

  newArticle.id = dbResult.lastID;
  return newArticle;
}

export async function getArticleById(id) {
  const db = await getDatabase();
  const article = await db.get(
    `
    SELECT 
      Articles.*, 
      Users.username, 
      Users.selectedAvatar as userAvatar
    FROM Articles 
    JOIN Users ON Articles.userId = Users.id
    WHERE Articles.id = ?`,
    id
  );
  return article;
}
export async function getArticleByUserId(userId) {
  const db = await getDatabase();
  const articles = await db.all("SELECT * FROM Articles WHERE userId=?", userId);
  return articles;
}

export async function deleteArticleById(id) {
  const db = await getDatabase();
  await db.run("DELETE FROM Articles WHERE id = ?", id);
  return true;
}

export async function addLike(userId, articleId) {
  const db = await getDatabase();
  try {
    // Insert a like entry into the Likes table
    await db.run(`INSERT INTO Likes (user_id, article_id) VALUES (?, ?)`, userId, articleId);
    return { success: true, message: "Article liked successfully" };
  } catch (error) {
    // Handle unique constraint violation
    if (error.code === "SQLITE_CONSTRAINT") {
      return { success: false, message: "You have already liked this article" };
    }
    // Handle other errors
    return { success: false, message: "Error liking article", error };
  }
}

export async function deleteLike(userId, articleId) {
  const db = await getDatabase();
  const result = await db.run(
    `DELETE FROM Likes WHERE user_id = ? AND article_id = ?`,
    userId,
    articleId
  );
  if (result.changes === 0) {
    return { success: false, message: "Like not found" };
  }

  return { success: true, message: "Like removed successfully" };
}

export async function getLikeCount(articleId) {
  const db = await getDatabase();

  const result = await db.get(
    `SELECT COUNT(*) AS likeCount FROM Likes WHERE article_id = ?`,
    articleId
  );
  return result.likeCount;
}
export async function checkUserLike(userId, articleId) {
  const db = await getDatabase();
  const sql = "SELECT * FROM Likes WHERE user_Id = ? AND article_Id = ?";
  const dbResult = await db.all(sql, userId, articleId);
  return dbResult.length > 0;
}
