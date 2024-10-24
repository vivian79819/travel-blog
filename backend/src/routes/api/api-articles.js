import express from "express";
import { getArticles, addArticles, getArticleById, deleteArticleById } from "../../data/articles-dao.js";
import { requiresAuthentication } from "../../middleware/auth-middleware.js";
import multer from 'multer';
import path from 'path';

const router = express.Router();


const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/images/') 
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname)
  }
});

const upload = multer({ storage: storage });

router.get("/", async (req, res) => {
  const articles = await getArticles();

  const callCountCookie = req.cookies.callCount;
  const callCount = callCountCookie ? parseInt(callCountCookie) + 1 : 1;

  return res.cookie("callCount", callCount.toString(), { httpOnly: true }).json(articles);
});

router.post("/", requiresAuthentication, upload.single('image'), async (req, res) => {
  const { title, description, content } = req.body;
  const image = req.file.filename;
  
  const article = {
    title,
    description,
    content,
    image,
    userId: req.user.id,
    date: new Date().toISOString().split('T')[0]
  };

  const dbMessage = await addArticles(article);
  return res.status(201).location(`/api/articles/${dbMessage.id}`).json(dbMessage);
});

router.get("/:id", async (req, res) => {
  const articleId = req.params.id;
  const article = await getArticleById(articleId);
  if (article) {
    res.json(article);
  } else {
    return res.sendStatus(404);
  }
});

router.delete("/:id", requiresAuthentication, async (req, res) => {
  const articleId = req.params.id;
  try {
      await deleteArticleById(articleId);
      res.sendStatus(200);
  } catch (error) {
      console.error("Error deleting article:", error);
      res.sendStatus(500);
  }
});

export default router;