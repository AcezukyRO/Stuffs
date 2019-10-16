CREATE DATABASE QLBH
USE QLBH
CREATE TABLE KHACHHANG
(
	MAKH CHAR(4) CONSTRAINT KH_MAKH_PK PRIMARY KEY,
	HOTEN VARCHAR(40) CONSTRAINT KH_HOTEN_NN NOT NULL,
	DCHI VARCHAR(50),
	SODT VARCHAR(20) NOT NULL,
	NGSINH SMALLDATETIME CONSTRAINT KH_NGSINH_CK
	CHECK (NGSINH > '01-01-1900'),
	DOANHSO MONEY CONSTRAINT KH_DOANHSO_DF DEFAULT(10000),
	NGDK SMALLDATETIME
)

CREATE TABLE NHANVIEN
(
	MANV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40) NOT NULL,
	SODT VARCHAR(20) UNIQUE,
	NGVL SMALLDATETIME DEFAULT (GETDATE())
)

CREATE TABLE HOADON
(
	SOHD INT PRIMARY KEY,
	NGHD SMALLDATETIME,
	MAKH CHAR(4),
	MANV CHAR(4),
	TRIGIA MONEY
)

ALTER TABLE HOADON ADD
CONSTRAINT HD_MAKH_FK FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH),
CONSTRAINT HD_MANV_FK FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV),
CONSTRAINT HD_NGHD_DF DEFAULT GETDATE() FOR NGHD

CREATE TABLE SANPHAM
(
	MASP CHAR(4) PRIMARY KEY,
	TENSP VARCHAR(40),
	DVT VARCHAR(20),
	NUOCSX VARCHAR(40),
	GIA MONEY
)

CREATE TABLE CTHD
(
	SOHD INT,
	MASP CHAR(4),
	SL INT,
	CONSTRAINT CTHD_SOHD_MASP_PK PRIMARY KEY (SOHD, MASP),
	CONSTRAINT CTHD_SOHD_FK FOREIGN KEY (SOHD)
	REFERENCES HOADON(SOHD),
	CONSTRAINT CTHD_MASP_FK FOREIGN KEY (MASP)
	REFERENCES SANPHAM(MASP)
)

--CAU 2
ALTER TABLE SANPHAM ADD
GHICHU VARCHAR(20)
--CAU 3
ALTER TABLE KHACHHANG ADD
LOAIKH TINYINT
--CAU 4
ALTER TABLE SANPHAM ALTER COLUMN
GHICHU VARCHAR(100)
--DROP CO CHU COLUMN, ADD KHONG CO CHU COLUMN, CAU 5
ALTER TABLE SANPHAM DROP COLUMN GHICHU
--CAU 6
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH VARCHAR(20)
--CAU 7
ALTER TABLE SANPHAM
ADD CONSTRAINT SANPHAM_DVT CHECK (DVT IN('CAY', 'HOP', 'CAI', 'QUYEN', 'CHUC'))
--CAU 8
ALTER TABLE SANPHAM
ADD CONSTRAINT SANPHAM_GIA CHECK (GIA > 500)
--CAU 9
ALTER TABLE CTHD
ADD CONSTRAINT CTHD_SL CHECK (SL >= 2)
--CAU 10
ALTER TABLE KHACHHANG
ADD CONSTRAINT KHACHHANG_NDK_NGSINH CHECK (NGDK > NGSINH)

--DELETE FROM SANPHAM WHERE MASP = 'ST11' THEM DONG NAY` VAO PHAN INSERT INTO

--CAU 2
SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG

--CAU 3
UPDATE SANPHAM1
SET GIA = GIA + ((GIA*5)/100) --HOAC GHI LA "SET GIA = GIA * 1.05"
WHERE NUOCSX = 'THAILAN'

--CAU 4
UPDATE SANPHAM1
SET GIA = GIA - ((GIA*5)/100)
WHERE NUOCSX = 'TRUNGQUOC' AND GIA <= 10000

--CAU 5
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < 1/1/2997 AND DOANHSO >= 10000000) OR (NGDK >= 1/1/2007 AND DOANHSO >= 2000000)



