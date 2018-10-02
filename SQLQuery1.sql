--Tạo DB 1
CREATE DATABASE SQLDBUI
GO

USE SQLDBUI
GO

--Tao bảng giáo viên có 2 thuộc tính
CREATE TABLE GiaoVien
(
	MaGV NVARCHAR(10),
	Name NVARCHAR(100)
)
GO

--Xóa cả bảng giáo viên
DROP TABLE GiaoVien

--Xóa dữ liệu trong bảng
TRUNCATE TABLE GiaoVien

--Sửa bảng, Thêm 1 cột ngày sinh
ALTER TABLE GiaoVien ADD NgaySinh DATE

--Các kiểu dữ liệu hay dùng trong SQL
-- int: Kiểu số nguyên, tập hợp N
-- float: Kiểu số thực, tập hợp R
-- char: Kiểu ký tự, không viết tiếng việc được, bộ nhớ cấp phát cứng, char(10): cấp phát 10 ô nhớ
-- varchar: Kiểu ký tự, bộ nhớ cấp phát động, varchar(10) -> 10 ô nhớ này chỉ được lấy khi có dữ liệu bên trong
-- nchar: Kiểu ký tự, có thể lưu tiếng việt.
-- nvarchar: Kiểu ký tự, cấp phát động có thể lưu tiếng việt
-- date: lưu trữ ngày tháng năm giờ
-- time: lưu trữ giờ phút giây
-- byte: lưu trữ giá trị 0 và 1
-- text: lưu văn bản lớn
-- ntext: lưu văn bản lớn có tiếng Việt

CREATE TABLE Test
(
	Doc NVARCHAR(50), --khai báo trường Doc kiểu nvarchar cáp phát động 50 ô nhớ
	MaSV CHAR(10),	--khai báo trường sinh viên kiểu char 10 ô nhớ
	Birthday DATE,
	Sex BIT --Lưu trữ giá trị 0 hoặc 1
)
GO

--Thêm xóa sửa dữ liệu trong bảng
--Thêm dữ liệu
--Kiểu số -> số bình thường
--Kiểu ký tự hoặc ngày để trong nháy đơn
--Nếu là unicode thì cần N trước nháy đơn N''
INSERT INTO dbo.GiaoVien (MaGV, Name, NgaySinh)
VALUES ( N'5',
		 N'Nguyễn Văn A',
		 '19900929'
		)

CREATE TABLE Test1
(
	MaSo INT,
	Ten NVARCHAR(10),
	NgaySinh DATE,
	Nam BIT,
	DiaChi CHAR(20),
	TienLuong FLOAT
)

--Xóa dữ liệu có điều kiện
--nếu chỉ Delete <Tên bảng> xóa toàn bộ dữ liệu trong bảng
--Xóa có điều kiện dùng WHERE
--Các toán tử: < > <= >= AND OR =

--Xóa toàn bộ bảng
DELETE dbo.Test1
--Xóa có điều kiện
DELETE dbo.Test1 WHERE MaSo = 3 AND TienLuong < 10000

--Update dữ liệu 1 trường
UPDATE dbo.Test1 SET TienLuong = 1000

--Update dữ liệu 2 trường
UPDATE dbo.Test1 SET TienLuong = 1000, DiaChi = 'Nam Dinh'

--Update dữ liệu theo trường có điều kiện
UPDATE dbo.Test1 SET TienLuong = 1000, DiaChi = 'Nam Dinh' WHERE Ten = 'B'


--Tạo khóa chính: định danh là khóa duy nhất trong bảng và là tiền đề 
--cho khóa ngoại tham chiếu tới


--UNIQUE là duy nhất trong toàn bộ bảng, trường nào có từ khóa thì không có 2 giá trị
--Not Null: trường đó không được phép Null
--Default: giá trị mặc định của trường đó nếu không gián giá trị
CREATE TABLE TestPrimaryKey1
(
	ID INT UNIQUE NOT NULL,	
	Name NVARCHAR(100) DEFAULT N'HOW'
)

--Khi đã tạo bảng muốn sửa cột thành Primary
ALTER TABLE bdo.TestPrimaryKey1 ADD PRIMARY KEY

INSERT dbo.TestPrimaryKey1 (ID)
VALUES (1)

--Tạo Primary key ngay khi tạo bảng
CREATE TABLE TestPrimaryKey2
(
	ID INT PRIMARY KEY,	
	Name NVARCHAR(100) DEFAULT N'HOW'
)

--Tạo Primary Key trong bảng không phải ngay khi khai báo
CREATE TABLE TestPrimaryKey3
(
	ID INT NOT NULL,	
	Name NVARCHAR(100) DEFAULT N'HOW'

	PRIMARY KEY(ID)
)

--Tạo Primary Key trong bảng và đặt tên cho nó
CREATE TABLE TestPrimaryKey4
(
	ID INT NOT NULL,	
	Name NVARCHAR(100) DEFAULT N'HOW'

	CONSTRAINT PK_Test4 --sau này xóa key cho dễ
	PRIMARY KEY(ID)
)

--Tạo Primary key sau khi tạo bảng và đặt tên cho nó
CREATE TABLE TestPrimaryKey5
(
	ID INT NOT NULL,	
	Name NVARCHAR(100) DEFAULT N'HOW'
)
ALTER TABLE dbo.TestPrimaryKey5 ADD CONSTRAINT PK_Test4 PRIMARY KEY (ID)

--Khóa chính có 2 trường
CREATE TABLE TestPrimaryKey6
(
	ID1 INT NOT NULL,	
	ID2 INT NOT NULL,
	Name NVARCHAR(100) DEFAULT N'HOW'

	PRIMARY KEY(ID1, ID2)
)


--Khóa ngoại trong SQL
CREATE DATABASE Primary_Foreign
GO

USE Primary_Foreign
GO

CREATE TABLE BoMon
(
	MaBM CHAR(10) PRIMARY KEY,
	Name NVARCHAR(100) DEFAULT N'Tên bộ môn'
)
GO

CREATE TABLE Lop
(
	MaLop CHAR(10) NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Tên lớp'

	PRIMARY KEY (MALOP)
)

--Điều kiện để tạo khóa ngoại
--Tham chiếu tới khóa chính
--cùng kiểu dữ liệu
--cùng số lượng trường có sắp xếp
--đảm bảo tính toàn vẹn, không có trường hợp tham chiếu tới dự liệu không tồn tại
CREATE TABLE GiaoVien
(
	MaGV CHAR(10) NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Tên giáo viên',
	DiaChi NVARCHAR(100) DEFAULT N'Địa chỉ giáo viên',
	NgaySinh DATE,
	Sex BIT,
	MaBM CHAR(10),

	--tạo khóa ngoại ngay khi tạo bảng
	FOREIGN KEY(MaBM) REFERENCES dbo.BoMon(MaBM)
)
GO
ALTER TABLE dbo.GiaoVien ADD PRIMARY KEY(MaGV)

CREATE TABLE HocSinh
(
	MaHS CHAR(10) PRIMARY KEY,
	Name NVARCHAR(100),
	MaLop CHAR(10)
)

--tạo khóa ngoại sau khi tạo bảng
ALTER TABLE dbo.HocSinh ADD CONSTRAINT FK_HS FOREIGN KEY(MaLop) REFERENCES dbo.Lop(MaLop)

--hủy khóa
ALTER TABLE dbo.HocSinh DROP CONSTRAINT FK_HS

INSERT INTO dbo.BoMon
			(MaBM, Name)
VALUES		('BM01',
			  N'Bộ môn 1'
			 )

INSERT INTO dbo.BoMon
			(MaBM, Name)
VALUES		('BM02',
			  N'Bộ môn 2'
			 )

INSERT INTO dbo.BoMon
			(MaBM, Name)
VALUES		('BM03',
			  N'Bộ môn 3'
			 )

--Cấu trúc truy vấn
SELECT MaBM FROM dbo.BoMon