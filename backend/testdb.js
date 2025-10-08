const { connectDB } = require("./db");

(async () => {
  const pool = await connectDB();
  if (pool) console.log("🎉 Đã sẵn sàng truy vấn!");
})();
