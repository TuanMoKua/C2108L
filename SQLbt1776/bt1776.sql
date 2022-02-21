--CSDL Shop Ban hang
create database Shop_ban_Hang
go

use Shop_ban_Hang
go

--table
create table Hang_Hoa(
	Id int primary key identity(1, 1),
	Ten_Sp nvarchar(100),
	Nha_Sx nvarchar (100),
	Xuat_xu nvarchar(50),
	Gia_nhap int,
	Gia_ban int,
	Ngay_SX datetime
)
go

alter table Hang_Hoa
alter column Ngay_SX date
go


create table Ban_hang(
	DonHang_Id int primary key identity(1, 1),
	Id_Hanghoa int,
	Note nvarchar (100),
	Ngay_ban datetime,
	So_luong int
)
go

alter table Ban_hang
alter column Ngay_ban date
go
-- Insert DL
insert into Hang_Hoa(Ten_Sp, Nha_Sx, Xuat_xu, Gia_nhap, Gia_ban, Ngay_SX)
values
('Quan Nam', 'Yuto', 'Japan', '200', '220', '2003-10-11'),
('Quan Jean', 'Abc', 'VietNames', '150', '220', '2002-6-10'),
('Vay Nu', 'IIO', 'China', '80', '120', '2001-5-1'),
('Ao Dai', 'POPO', 'Taiwan', '300', '320', '2003-8-7'),
('Ao Khoac', 'TUXS', 'USA', '700', '820', '2001-8-8'),
('Quan Kaki', 'Abc', 'VietNames', '500', '520', '2000-10-8'),
('Pijama', 'IIO', 'China', '500', '620', '2010-10-11'),
('ToXeDo', 'Yuto', 'Japan', '500', '550', '2008-9-10'),
('Ao Thun', 'POPO', 'Taiwan', '300', '420', '2005-9-6'),
('Ao Khoac Bong', 'YUYU', 'Korea', '300', '220', '2009-6-6')
go

delete from Hang_Hoa
where ID >10
go

insert into Ban_hang(Id_Hanghoa, Note, Ngay_ban, So_luong)
values
('2', 'HangXuatKhau', '2003-10-15', '20'),
('2', 'HangXuatKhau', '2002-6-15', '25'),
('3', 'HangXuatKhau', '2001-5-5', '30'),
('4', 'HangXuatKhau', '2003-8-8', '15'),
('5', 'HangXuatKhau', '2001-8-10', '23'),
('6', 'HangXuatKhau', '2000-10-15', '20'),
('7', 'HangXuatKhau', '2010-10-15', '26'),
('8', 'HangXuatKhau', '2008-9-15', '28'),
('8', 'HangXuatKhau', '2005-9-11', '40'),
('9', 'HangXuatKhau', '2009-6-10', '100')
go

delete from Ban_hang
where DonHang_Id >10
go

--TEST
select * from  Hang_Hoa
select * from Ban_hang
go

-- tao fk_key & check
alter table Ban_hang
add constraint fk_ID_hanghoa foreign key (Id_Hanghoa) references Hang_Hoa (ID)
go

-- tìm kiếm theo yeu cầu

select * from Hang_Hoa
where Xuat_xu = 'VietNames'
go

select Hang_Hoa.ID, Hang_Hoa.Ten_Sp, Hang_Hoa.Nha_Sx, Hang_Hoa.Xuat_xu, Hang_Hoa.Gia_nhap, Hang_Hoa.Gia_ban,Hang_Hoa.Ngay_SX, Ban_hang.DonHang_Id, Ban_hang.Note, Ban_hang.Ngay_ban, Ban_hang.So_luong
from Hang_Hoa, Ban_hang
Where Hang_Hoa.ID =  Ban_hang.Id_Hanghoa
go

select Ten_Sp, Gia_ban, sum(Gia_ban) as TongGiaBan from Hang_Hoa
group by Ten_Sp, Gia_ban
go





