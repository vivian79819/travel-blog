import { getDatabase } from "./database.js";
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
  const date = new Date().toISOString().split('T')[0];

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
};


export async function getArticleById(id) {
  const db = await getDatabase();
  const article = await db.get(`
    SELECT 
      Articles.*, 
      Users.username, 
      Users.selectedAvatar as userAvatar
    FROM Articles 
    JOIN Users ON Articles.userId = Users.id
    WHERE Articles.id = ?`, id);
  return article;
};
export async function getArticleByUserId(userId) {
  const db= await getDatabase();
  const articles=await db.all("SELECT * FROM Articles WHERE userId=?",userId);
  return articles;
}

export async function deleteArticleById(id) {
  const db = await getDatabase();
  await db.run("DELETE FROM Articles WHERE id = ?", id);
  return true;
}