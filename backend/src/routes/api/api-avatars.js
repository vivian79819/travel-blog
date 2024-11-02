import express from "express";
import fs from "fs";
import path from "path";

const router = express.Router();

// Avatar route to fetch all images in the avatars folder
router.get("/", (req, res) => {
  const avatarsDir = path.join(process.cwd(), "public", "images", "avatars");

  fs.readdir(avatarsDir, (err, files) => {
    if (err) {
      return res.status(500).json({ error: "Unable to fetch avatars" });
    }
    const avatars = files.map((file) => ({
      name: path.basename(file, path.extname(file)),
      src: `avatars/${file}`
    }));
    return res.json(avatars);
  });
});

export default router;
