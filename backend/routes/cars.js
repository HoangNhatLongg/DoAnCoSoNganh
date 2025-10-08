const express = require("express");
const router = express.Router();
const { connectDB, sql } = require("../db"); // đúng tên hàm trong db.js

// Lấy toàn bộ danh sách xe
router.get("/", async (req, res) => {
  try {
    const pool = await connectDB(); // kết nối DB
    const result = await pool.request().query("SELECT * FROM Cars"); // truy vấn
    res.json(result.recordset); // trả kết quả về client
  } catch (err) {
    console.error("❌ Lỗi khi truy vấn SQL:", err);
    res.status(500).send("Lỗi truy vấn SQL Server");
  }
});

module.exports = router;
