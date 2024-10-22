import { getDatabase } from "./database.js";

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

export async function addArticles(article) {
  const db = await getDatabase();
  const response = await db.run(
    "INSERT INTO Articles (title, description, content, image, userId, date) VALUES (?, ?, ?, ?, ?, ?)",
    [article.title, article.description, article.content, article.image, article.userId, article.date]
  );

  return getArticleById(response.lastID);
}

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
}