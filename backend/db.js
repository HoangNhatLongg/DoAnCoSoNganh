const sql = require("mssql/msnodesqlv8");

const sqlConfig = {
  connectionString:
    "Driver={SQL Server Native Client 11.0};Server=(localdb)\\MSSQLLocalDB;Database=QuanLyHeThong;Trusted_Connection=Yes;",
};

async function connectDB() {
  try {
    const pool = await sql.connect(sqlConfig);
    console.log("✅ Kết nối SQL LocalDB thành công!");
    return pool;
  } catch (err) {
    console.error("❌ Lỗi kết nối SQL LocalDB:", err);
  }
}

module.exports = { sql, connectDB };
