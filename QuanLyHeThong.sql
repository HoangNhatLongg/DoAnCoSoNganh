CREATE DATABASE QuanLyHeThong;
GO

USE QuanLyHeThong;
GO


-- Bảng Quản trị hệ thống

CREATE TABLE Admins (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Sdt CHAR(10),
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50) DEFAULT 'Admin',
    NgayTao DATETIME DEFAULT GETDATE()
);

-- Bảng Khách hàng

CREATE TABLE KhachHang (
    IDKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Sdt NVARCHAR(20),
    DiaChi NVARCHAR(255),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- Đăng nhập Khách hàng

CREATE TABLE KhachHangLogin (
    LoginID INT IDENTITY(1,1) PRIMARY KEY,
    IDKhachHang INT FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    Provider NVARCHAR(50) NOT NULL,         -- Local / Google / Facebook
    ProviderKey NVARCHAR(200) NOT NULL,     -- Email / GoogleID / FacebookID
    PasswordHash NVARCHAR(255) NULL,        -- Chỉ dùng cho Local
    NgayTao DATETIME DEFAULT GETDATE(),
    UNIQUE(IDKhachHang, Provider)
);

-- Danh mục loại xe

CREATE TABLE DanhMucXe (
    IDDanhMuc INT IDENTITY(1,1) PRIMARY KEY,
    TenDanhMuc NVARCHAR(100) NOT NULL
);

-- Sản phẩm / Xe
CREATE TABLE Cars (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    IDDanhMuc INT FOREIGN KEY REFERENCES DanhMucXe(IDDanhMuc),
    TenXe NVARCHAR(200) NOT NULL,
    LoaiSo NVARCHAR(50),          
    SoCapSo NVARCHAR(50),    
    SoCho INT,                         
    NamSanXuat INT,               
    AnhXe NVARCHAR(255),             
    GiaXe DECIMAL(18,2) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE()
);

-- Chi tiết xe

CREATE TABLE ChiTietXe (
    ChiTietID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    AnhNoiThat NVARCHAR(255),
    MoTaNoiThat NVARCHAR(MAX),
    AnhNgoaiThat NVARCHAR(255),
    MoTaNgoaiThat NVARCHAR(MAX),
    ThongSoKyThuat NVARCHAR(MAX)            
);

-- Chi phí ước tính xe

CREATE TABLE GiaXeUocTinh (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TinhThanh NVARCHAR(100) NOT NULL,
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    PhiDangKy DECIMAL(18,2) NOT NULL, 
    PhiDuongBo DECIMAL(18,2) NOT NULL,
    PhiBaoHiem DECIMAL(18,2) NOT NULL,
    PhiDangKyBienSo DECIMAL(18,2) NOT NULL
);


-- Yêu thích xe của Khách hàng

CREATE TABLE XeYeuThich (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDKhachHang INT FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    NgayTao DATETIME DEFAULT GETDATE(),
    UNIQUE(IDKhachHang, CarID)
);


--Danh sách đại lý

CREATE TABLE DaiLy (
    IDDaiLy INT IDENTITY(1,1) PRIMARY KEY,
    TenDaiLy NVARCHAR(200) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    Sdt NVARCHAR(20),
    Email NVARCHAR(100),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- Lịch hẹn lái thử

CREATE TABLE DatLaiThu (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDKhachHang INT FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    NgayLaiThu DATETIME NOT NULL,       
    IDDaiLy INT FOREIGN KEY REFERENCES DaiLy(IDDaiLy),         
    GhiChu NVARCHAR(MAX),             
    TrangThai NVARCHAR(50) DEFAULT 'Pending',     
    NgayTao  DATETIME DEFAULT GETDATE(),
	NgayThayDoi  DATETIME DEFAULT NULL,
	NgayHuy  DATETIME DEFAULT NULL
);

