const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { sql, connectDB } = require("./db"); // import file db.js

const app = express();
const PORT = 8000;

// Import routes
const carsRoute = require("./routes/cars");

app.use(cors());
app.use(bodyParser.json());

// Route test API
app.get("/", (req, res) => {
  res.send("🚗 API bán ô tô kết nối SQL LocalDB thành công!");
});

// Sử dụng routes
app.use("/api/cars", carsRoute);

// 🔹 Khởi động server SAU khi kết nối DB thành công
(async () => {
  try {
    await connectDB(); // Gọi hàm kết nối trong db.js
    app.listen(PORT, () => {
      console.log(`✅ SQL LocalDB đã sẵn sàng`);
      console.log(`🚀 Server đang chạy tại http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error("❌ Không thể khởi động server do lỗi DB:", err);
  }
})();
