import express from "express";
import { getArticles, addArticles, getArticleById} from "../../data/articles-dao.js";
import multer from 'multer';
import path from 'path';

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/images/') 
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)) 
  }
})


const router = express.Router();

router.get("/", async (req, res) => {
  const articles = await getArticles();

  const callCountCookie = req.cookies.callCount;
  const callCount = callCountCookie ? parseInt(callCountCookie) + 1 : 1;

  return res.cookie("callCount", callCount.toString(), { httpOnly: true }).json(articles);
});

const upload = multer({ storage: storage })

router.post("/", upload.single('image'), async (req, res) => {
  const { title, description, content } = req.body;
  const image = req.file ? req.file.filename : null;

  // need to pull the user data from user route will jsut hard code to start
  const username = "system_user";
  const userAvatar = "Dragonite.png";

  const article = {
    title,
    description,
    content,
    image,
    date: new Date().toISOString().split('T')[0],
    username,
    userAvatar
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

export default router;