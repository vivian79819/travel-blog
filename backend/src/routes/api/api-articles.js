import express from "express";
import {
  getArticles,
  getArticleById,
  deleteArticleById,
  createArticle,
  updateArticle,
  addLike,
  deleteLike,
  getLikeCount,
  checkUserLike
} from "../../data/articles-dao.js";
import { requiresAuthentication } from "../../middleware/auth-middleware.js";
import multer from "multer";

const router = express.Router();

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/images/");
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  }
});

const upload = multer({ storage: storage });

router.get("/", async (req, res) => {
  const articles = await getArticles();

  const callCountCookie = req.cookies.callCount;
  const callCount = callCountCookie ? parseInt(callCountCookie) + 1 : 1;

  return res.cookie("callCount", callCount.toString(), { httpOnly: true }).json(articles);
});

router.post("/", requiresAuthentication, upload.single("image"), async (req, res) => {
  const { title, description, content } = req.body;
  const image = req.file ? req.file.filename : null;
  if (!req.file) {
    return res.status(400).json({ error: "File not uploaded" });
  }

  try {
    if (!title || !description || !content) {
      return res.status(400).json({ error: "Missing required fields." });
    }
    const userId = req.user.id;
    const articleData = {
      title,
      description,
      content,
      image,
      userId
    };

    const newArticle = await createArticle(articleData);
    return res.status(201).location(`/api/articles/${newArticle.id}`).json(newArticle);
  } catch (error) {
    console.error("Error creating article:", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
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

router.patch("/:id", upload.single("image"), async (req, res) => {
  try {
    const { title, description, content } = req.body;

    const existingArticle = await getArticleById(req.params.id);
    if (!existingArticle) {
      return res.sendStatus(404);
    }

    const image = req.file ? req.file.filename : existingArticle.image;

    const updateData = {
      title,
      description,
      content,
      image
    };

    const isUpdated = await updateArticle(req.params.id, updateData);
    return res.sendStatus(isUpdated ? 204 : 404);
  } catch (error) {
    console.error("Update error:", error);
    return res.sendStatus(422);
  }
});

router.post("/:id/like", requiresAuthentication, async (req, res) => {
  const userId = req.user.id;
  const articleId = req.params.id;
  try {
    const result = await addLike(userId, articleId);
    if (result.success) {
      return res.status(204).end();
    } else {
      return res.status(500).json({ message: result.message });
    }
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
});

router.delete("/:id/like", requiresAuthentication, async (req, res) => {
  const userId = req.user.id;
  const articleId = req.params.id;
  try {
    const result = await deleteLike(userId, articleId);
    if (!result.success) {
      return res.status(404).json({ message: result.message });
    }

    res.status(200).json({ message: result.message });
  } catch (error) {
    res.status(500).json({ message: "Error unliking article" });
  }
});

router.get("/:id/like-data", requiresAuthentication, async (req, res) => {
  const articleId = req.params.id;
  const userId = req.user.id;

  try {
    const likeCount = await getLikeCount(articleId);
    const userLike = await checkUserLike(userId, articleId);

    return res.status(200).json({
      likeCount: likeCount || 0,
      hasLiked: !!userLike
    });
  } catch (error) {
    return res.status(500).json({ message: "Error fetching like data" });
  }
});

export default router;
