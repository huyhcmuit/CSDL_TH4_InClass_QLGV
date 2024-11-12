CREATE DATABASE QuanLyGiaoVu
--Tao bang khoa
CREATE TABLE KHOA
(
	MAKHOA varchar(4) primary key, 
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
);
--Tao bang mon hoc
CREATE TABLE MONHOC
(
	MAMH varchar(10) primary key,
	TENMH varchar(40),
	TCLT tinyint, 
	TCTH tinyint, 
	MAKHOA varchar(4),
	FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);
--Tao bang dieu kien
CREATE TABLE DIEUKIEN
(
	MAMH varchar(10), 
	MAMH_TRUOC varchar(10),
	primary key (MAMH, MAMH_TRUOC),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH), 
	FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);
--Tao bang giao vien
CREATE TABLE GIAOVIEN
(
	MAGV char(4) primary key, 
	HOTEN varchar(40), 
	HOCVI varchar(10),
	HOCHAM varchar(10), 
	GIOITINH varchar(3),
	NGSINH smalldatetime, 
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money, 
	MAKHOA varchar(4),
	FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);
--Tao bang lop
CREATE TABLE LOP
(
	MALOP char(3) primary key,
	TENLOP varchar(40), 
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4),
	FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)
);
--Tao bang hoc vien
CREATE TABLE HOCVIEN
(
	MAHV char(5) primary key,
	HO varchar(40),
	TEN varchar(10), 
	NGSINH smalldatetime,
	GIOITINH varchar(3), 
	NOISINH varchar(40),
	MALOP char(3), 
	GHICHU varchar(100),
	DIEMTB numeric(4,2),
	XEPLOAI varchar(20),
	FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);
--Tao bang giang day
CREATE TABLE GIANGDAY
(
	MALOP char(3), 
	MAMH varchar(10),
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	primary key (MALOP, MAMH),
	FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);
--Tao bang ket qua thi
CREATE TABLE KETQUATHI
(
	MAHV char(5),
	MAMH varchar(10),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	GHICHU varchar(100),
	primary key (MAHV, MAMH, LANTHI),
	FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
	FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);
--Them khoa ngoai bo sung
ALTER TABLE KHOA
ADD FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE LOP
ADD FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);

--Cau 3
ALTER TABLE HOCVIEN
ADD CONSTRAINT check_GIOITINH CHECK(GIOITINH IN ('Nam','Nu'));

--Cau 4:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_DIEM CHECK (DIEM >=0 AND DIEM <=10);

--Cau 5:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_KQ CHECK ((DIEM >=5 AND KQUA = 'Dat') OR (DIEM < 5 AND KQUA = 'Khong dat'));

--Cau 6:
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_LANTHI CHECK (LANTHI <= 3);

--Cau 7:
ALTER TABLE GIANGDAY
ADD CONSTRAINT check_HOCKY CHECK (HOCKY BETWEEN 1 AND 3);

--Cau 8:
ALTER TABLE GIAOVIEN
ADD CONSTRAINT check_HOCVI CHECK (HOCVI IN ('CN', 'KS','Ths', 'TS', 'PTS'));
--Bai tap 2: 
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES 
('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'),
('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
('MTT', 'Mang va truyen thong', '2005-10-20', 'GV03'),
('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);
INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES 
('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');
INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 1, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');
INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES 
('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');
INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES 
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');
INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES 
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');
INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES 
('K1101', 'CSDL', 1, '2006-07-20', 10.00, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),
('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),
('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dat'),
('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'Khong Dat'),
('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dat'),
('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dat'),
('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dat'),
('K1201', 'CTRR', 1, '2006-05-13', 9.00, 'Dat'),
('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dat'),
('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1202', 'CTDLGT', 2, '2007-01-05', 5.00, 'Dat'),
('K1202', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'THDC', 2, '2006-05-27', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'Khong Dat'),
('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
('K1203', 'THDC', 1, '2006-05-20', 10.00, 'Dat'),
('K1203', 'CTRR', 1, '2006-05-13', 10.00, 'Dat'),
('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
('K1204', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1204', 'CTRR', 1, '2006-05-13', 6.00, 'Dat'),
('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dat'),
('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'Khong Dat'),
('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
('K1303', 'THDC', 1, '2006-05-20', 4.50, 'Khong Dat'),
('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, 'Dat'),
('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1305', 'CTRR', 1, '2006-05-13', 10.00, 'Dat');
INSERT INTO HOCVIEN (MAHV,HO, NGSINH, GIOITINH, NOISINH, MALOP)
VALUES 
('K1101', 'Nguyen Van A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu Nghia', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');
--Bai tap 4 cau 11: 
ALTER TABLE HOCVIEN
ADD CONSTRAINT check_HOCVIEN_NGSINH CHECK (DATEDIFF(YEAR, NGSINH, GETDATE()) >= 18);
--Bai tap 4 cau 12: 
ALTER TABLE GIANGDAY
ADD CONSTRAINT check_GIANGDAY_TUNGAY_DENNGAY CHECK (TUNGAY < DENNGAY);
--Bai tap 4 cau 13: 
ALTER TABLE GIAOVIEN
ADD CONSTRAINT check_GIAOVIEN_NGVL CHECK (DATEDIFF(YEAR, NGVL, GETDATE()) >= 22);
--Bai tap 4 cau 14: 
ALTER TABLE MONHOC
ADD CONSTRAINT check_MONHOC_TCLT_TCTH CHECK (ABS(TCLT - TCTH) <= 3);
--Bai tap 6 cau 1: 
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOVATEN, H.NGSINH, H.MALOP
FROM HOCVIEN H JOIN LOP L ON H.MAHV = L.TRGLOP;
--Bai tap 6 cau 2: 
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOVATEN, K.LANTHI, K.DIEM
FROM KETQUATHI K JOIN HOCVIEN H ON K.MAHV = H.MAHV
WHERE K.MAMH = 'CTRR' AND H.MALOP = 'K12'ORDER BY H.TEN, H.HO;
--Bai tap 6 cau 3: 
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOVATEN, K.MAMH
FROM HOCVIEN H JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE K.LANTHI = 1 AND K.KQUA = 'Dat';
--Bai tap 6 cau 4: 
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOVATEN
FROM HOCVIEN H JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE H.MALOP = 'K11' AND K.MAMH = 'CTRR' AND K.LANTHI = 1 AND K.KQUA = 'Khong dat';
--Bai tap 6 cau 5: 
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOVATEN
FROM HOCVIEN H JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE H.MALOP = 'K' AND K.MAMH = 'CTRR' AND K.KQUA = 'Khong dat'
GROUP BY H.MAHV, H.HO, H.TEN HAVING COUNT(*) = COUNT(CASE WHEN K.KQUA = 'Khong dat' THEN 1 END);

--Lab03_Inclass 
--Bai tap 2 cau 1 
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA);
--Bai tap 2 cau 2
UPDATE HOCVIEN
SET DIEMTB = (
    SELECT AVG(DIEM)
    FROM (
        SELECT MAHV, MAMH, DIEM
        FROM KETQUATHI K1
        WHERE NGTHI = (
            SELECT MAX(NGTHI)
            FROM KETQUATHI K2
            WHERE K1.MAHV = K2.MAHV AND K1.MAMH = K2.MAMH
        )
    ) AS LAST_EXAM
    WHERE LAST_EXAM.MAHV = HOCVIEN.MAHV
);
--Bai tap 2 cau 3
UPDATE KETQUATHI
SET GHICHU = 'Cam thi'
WHERE LANTHI = 3 AND DIEM < 5;
--Bai tap 2 cau 4 
UPDATE HOCVIEN
SET XEPLOAI = CASE
    WHEN DIEMTB >= 9 THEN 'XS'
    WHEN DIEMTB >= 8 THEN 'G'
    WHEN DIEMTB >= 6.5 THEN 'K'
    WHEN DIEMTB >= 5 THEN 'TB'
    ELSE 'Y'
END;
--Bai tap 3 cau 6
SELECT MH.TENMH
FROM MONHOC AS MH
JOIN GIANGDAY AS GD ON MH.MAMH = GD.MAMH
JOIN GIAOVIEN AS GV ON GD.MAGV = GV.MAGV
WHERE GV.HOTEN = 'Tran Tam Thanh' AND GD.HOCKY = 1 AND GD.NAM = 2006;
--Bai tap 3 cau 7 
SELECT MH.MAMH, MH.TENMH
FROM MONHOC AS MH
JOIN GIANGDAY AS GD ON MH.MAMH = GD.MAMH
JOIN LOP AS L ON GD.MALOP = L.MALOP
WHERE L.TENLOP = 'K11' AND GD.HOCKY = 1 AND GD.NAM = 2006;
--Bai tap 3 cau 8 
SELECT HV.HO + ' ' + HV.TEN AS LOP_TRUONG
FROM HOCVIEN AS HV
JOIN LOP AS L ON HV.MALOP = L.MALOP
JOIN GIANGDAY AS GD ON L.MALOP = GD.MALOP
JOIN GIAOVIEN AS GV ON GD.MAGV = GV.MAGV
WHERE GV.HOTEN = 'Nguyen To Lan' AND GD.MAMH = 
(
    SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu'
);
--Bai tap 3 cau 9
SELECT MH.MAMH, MH.TENMH
FROM MONHOC AS MH
JOIN DIEUKIEN AS DK ON MH.MAMH = DK.MAMH_TRUOC
WHERE DK.MAMH = 
(
    SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu'
);
--Bai tap 3 cau 10 
SELECT MH.MAMH, MH.TENMH
FROM MONHOC AS MH
JOIN DIEUKIEN AS DK ON MH.MAMH = DK.MAMH
WHERE DK.MAMH_TRUOC = 
(
    SELECT MAMH FROM MONHOC WHERE TENMH = 'Cau Truc Roi Rac'
);
--Bai tap 5 cau 11: 
SELECT GV.HOTEN
FROM GIAOVIEN AS GV
JOIN GIANGDAY AS GD ON GV.MAGV = GD.MAGV
WHERE GD.MAMH = 
(
    SELECT MAMH FROM MONHOC WHERE TENMH = 'Cau Truc Roi Rac'
) AND GD.MALOP IN 
(
    SELECT MALOP FROM LOP WHERE TENLOP IN ('K11', 'K12')
) AND GD.HOCKY = 1 AND GD.NAM = 2006
GROUP BY GV.HOTEN
HAVING COUNT(DISTINCT GD.MALOP) = 2;
--Bai Tap 5 cau 12 
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HO_TEN
FROM HOCVIEN AS HV
WHERE HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI AS KQ
    WHERE KQ.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu')
    AND KQ.LANTHI = 1 AND KQ.KQUA = 'Khong dat'
) AND NOT EXISTS 
(
    SELECT 1
    FROM KETQUATHI AS KQ2
    WHERE KQ2.MAHV = HV.MAHV
    AND KQ2.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu')
);
--Bai Tap 5 cau 13 
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN AS GV
WHERE NOT EXISTS 
(
    SELECT 1
    FROM GIANGDAY AS GD
    WHERE GD.MAGV = GV.MAGV
);
--Bai tap 5 cau 14 
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN AS GV
WHERE NOT EXISTS 
(
    SELECT 1
    FROM GIANGDAY AS GD
    JOIN MONHOC AS MH ON GD.MAMH = MH.MAMH
    WHERE GD.MAGV = GV.MAGV AND MH.MAKHOA = GV.MAKHOA
);
--Bai tap 5 cau 15 
SELECT HV.HO + ' ' + HV.TEN AS HO_TEN
FROM HOCVIEN AS HV
JOIN KETQUATHI AS KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP = 'K11' AND 
(
    (KQ.LANTHI > 3 AND KQ.KQUA = 'Khong dat') OR
    (KQ.LANTHI = 2 AND KQ.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Cau Truc Roi Rac') AND KQ.DIEM = 5)
);
--Bai tap 5 cau 16 
SELECT GV.HOTEN
FROM GIAOVIEN AS GV
JOIN GIANGDAY AS GD ON GV.MAGV = GD.MAGV
WHERE GD.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Cau Truc Roi Rac')
GROUP BY GV.HOTEN, GD.HOCKY, GD.NAM
HAVING COUNT(DISTINCT GD.MALOP) >= 2;
--Bai tap 5 cau 17 
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HO_TEN, KQ.DIEM
FROM HOCVIEN AS HV
JOIN KETQUATHI AS KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu')
AND KQ.LANTHI = 
(
    SELECT MAX(LANTHI) FROM KETQUATHI WHERE MAHV = HV.MAHV AND MAMH = KQ.MAMH
);
--Bai tap 5 cau 18 
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HO_TEN, MAX(KQ.DIEM) AS DIEM_CAO_NHAT
FROM HOCVIEN AS HV
JOIN KETQUATHI AS KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = 'Co So Du Lieu')
GROUP BY HV.MAHV, HV.HO, HV.TEN;
--TH4_Inclass
--Phan III cau 19: 
SELECT MAKHOA, TENKHOA
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP) FROM KHOA);
--Cau 20:
SELECT COUNT(*) AS SoLuongGiaoVien
FROM GIAOVIEN
WHERE HOCHAM IN ('GS', 'PGS');
--Cau 21
SELECT MAKHOA, HOCVI, COUNT(*) AS SoLuongGiaoVien
FROM GIAOVIEN
WHERE HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS')
GROUP BY MAKHOA, HOCVI;
--Cau 22
SELECT MAMH, KQUA, COUNT(*) AS SoLuongHocVien
FROM KETQUATHI
GROUP BY MAMH, KQUA;
--Cau 23
SELECT DISTINCT gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv
JOIN LOP l ON gv.MAGV = l.MAGVCN
JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV AND l.MALOP = gd.MALOP;
--Cau 24
SELECT hv.HO, hv.TEN
FROM HOCVIEN hv
JOIN LOP l ON hv.MAHV = l.TRGLOP
WHERE l.SISO = (SELECT MAX(SISO) FROM LOP);
--Cau 25
SELECT hv.HO, hv.TEN
FROM HOCVIEN hv
JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE hv.MAHV IN (
	SELECT l.TRGLOP
	FROM LOP l
)
GROUP BY hv.HO, hv.TEN, hv.MAHV
HAVING COUNT(DISTINCT kq.MAMH) <= 3
	AND COUNT(CASE WHEN kq.KQUA = 'Khong Dat' THEN 1 END) = COUNT(*);
--Part 2 cau 26
SELECT TOP 1 HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, COUNT(*) AS SoMonDiemCao
FROM KETQUATHI
JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE KETQUATHI.DIEM IN (9, 10)
GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
ORDER BY SoMonDiemCao DESC;
--Cau 27
SELECT MALOP, MAHV, HO, TEN, MAX(SoMonDiemCao) AS SoMonDiemCao
FROM (
    SELECT HOCVIEN.MALOP, HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, COUNT(*) AS SoMonDiemCao
    FROM KETQUATHI
    JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
    WHERE DIEM IN (9, 10)
    GROUP BY HOCVIEN.MALOP, HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
) AS SubQuery
GROUP BY MALOP, MAHV, HO, TEN;
--Cau 28
SELECT NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) AS SoMonHoc, COUNT(DISTINCT MALOP) AS SoLop
FROM GIANGDAY
GROUP BY NAM, HOCKY, MAGV
HAVING COUNT(DISTINCT MAMH) > 0 AND COUNT(DISTINCT MALOP) > 0;
--Cau 29 
SELECT NAM, HOCKY, GIAOVIEN.MAGV, GIAOVIEN.HOTEN, COUNT(*) AS SoTietDay
FROM GIANGDAY
JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
GROUP BY NAM, HOCKY, GIAOVIEN.MAGV, GIAOVIEN.HOTEN
HAVING COUNT(*) = (
    SELECT MAX(SoTietDay)
    FROM (
        SELECT NAM, HOCKY, MAGV, COUNT(*) AS SoTietDay
        FROM GIANGDAY
        GROUP BY NAM, HOCKY, MAGV
    ) AS SubQuery
)
ORDER BY NAM, HOCKY;
--Cau 30 
SELECT KETQUATHI.MAMH, MONHOC.TENMH, COUNT(*) AS SoHocVienKhongDat
FROM KETQUATHI
JOIN MONHOC ON KETQUATHI.MAMH = MONHOC.MAMH
WHERE KETQUATHI.LANTHI = 1 AND KETQUATHI.KQUA = 'Khong Dat'
GROUP BY KETQUATHI.MAMH, MONHOC.TENMH
HAVING COUNT(*) = (
    SELECT MAX(SoHocVienKhongDat)
    FROM (
        SELECT MAMH, COUNT(*) AS SoHocVienKhongDat
        FROM KETQUATHI
        WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
        GROUP BY MAMH
    ) AS SubQuery
)
ORDER BY SoHocVienKhongDat DESC;
--Cau 31
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
WHERE NOT EXISTS (
    SELECT 1
    FROM KETQUATHI
    WHERE KETQUATHI.MAHV = HOCVIEN.MAHV
    AND KETQUATHI.LANTHI = 1
    AND KETQUATHI.KQUA = 'Khong Dat'
);
--Cau 32
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
WHERE NOT EXISTS (
    SELECT 1
    FROM KETQUATHI AS kt1
    JOIN (
        SELECT MAHV, MAMH, MAX(LANTHI) AS MaxLanThi
        FROM KETQUATHI
        GROUP BY MAHV, MAMH
    ) AS kt2 ON kt1.MAHV = kt2.MAHV AND kt1.MAMH = kt2.MAMH AND kt1.LANTHI = kt2.MaxLanThi
    WHERE kt1.MAHV = HOCVIEN.MAHV
    AND kt1.KQUA = 'Khong Dat'
);
--Cau 33
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE KETQUATHI.LANTHI = 1 AND KETQUATHI.KQUA = 'Dat'
GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
HAVING COUNT(DISTINCT KETQUATHI.MAMH) = (SELECT COUNT(*) FROM MONHOC);
--Cau 34
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
WHERE NOT EXISTS (
    SELECT 1
    FROM MONHOC AS mh
    LEFT JOIN (
        SELECT MAHV, MAMH, MAX(LANTHI) AS MaxLanThi
        FROM KETQUATHI
        GROUP BY MAHV, MAMH
    ) AS kt ON HOCVIEN.MAHV = kt.MAHV AND mh.MAMH = kt.MAMH
    LEFT JOIN KETQUATHI ON kt.MAHV = KETQUATHI.MAHV AND kt.MAMH = KETQUATHI.MAMH AND kt.MaxLanThi = KETQUATHI.LANTHI
    WHERE KETQUATHI.KQUA <> 'Dat' OR KETQUATHI.MAMH IS NULL
);
--Cau 35
SELECT kt.MAHV, HOCVIEN.HO, HOCVIEN.TEN, kt.MAMH, kt.DIEM
FROM KETQUATHI AS kt
JOIN HOCVIEN ON kt.MAHV = HOCVIEN.MAHV
JOIN (
    SELECT MAMH, MAHV, MAX(LANTHI) AS LastLanThi
    FROM KETQUATHI
    GROUP BY MAMH, MAHV
) AS lastTry ON kt.MAHV = lastTry.MAHV AND kt.MAMH = lastTry.MAMH AND kt.LANTHI = lastTry.LastLanThi
JOIN (
    SELECT MAMH, MAX(DIEM) AS MaxDiem
    FROM KETQUATHI
    WHERE LANTHI = (SELECT MAX(LANTHI) FROM KETQUATHI WHERE MAMH = KETQUATHI.MAMH AND MAHV = KETQUATHI.MAHV)
    GROUP BY MAMH
) AS max_score ON kt.MAMH = max_score.MAMH AND kt.DIEM = max_score.MaxDiem;
-------------------------------END-----------------------------------








