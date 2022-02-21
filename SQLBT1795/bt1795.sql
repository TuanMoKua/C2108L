--CSDL Bai do xe
create database Car_parking
go

use Car_parking
go

--Table 
create table BaiDoXe(
	MaBDX int primary key identity(1, 1),
	Name nvarchar(50) not null,
	Address nvarchar(200)
)
go

create table ThongTinGuiXe(
	ID int primary key identity(1, 1),
	Tenxe nvarchar(50),
	BienSoXe nvarchar(20),
	MaBDX int,
	OwnerID int
)
go

create table Owner(
	ID int primary key identity(1, 1),
	Name nvarchar(50),
	CMTND nvarchar(20),
	Address nvarchar(200)
)
go

--Insert DL

insert into BaiDoXe(Name, Address)
values
('BDX 01', 'Cau GIay Ha Noi'),
('BDX 02', 'Ba Dinh Ha Noi'),
('BDX 03', 'Lang Ha Ha Noi'),
('BDX 04', 'Hai Ba Trung Ha Noi'),
('BDX 05', 'Thanh Xuan Ha Noi')
go

insert into Owner(Name, CMTND, Address)
values
('A', '123456', 'Ha Noi'),
('B', '234543', 'Ha Noi'),
('C', '232541', 'Ha Noi'),
('D', '258975', 'Ha Noi'),
('E', '365874', 'Ha Noi')
go

insert into ThongTinGuiXe (Tenxe, BienSoXe, MaBDX, OwnerID)
values
('Xe 01', 'BSX01', '1', '1'),
('Xe 02', 'BSX02', '2', '2'),
('Xe 03', 'BSX03', '5', '3'),
('Xe 04', 'BSX04', '3', '5'),
('Xe 05', 'BSX05', '4', '4')
go

-- test
select * from ThongTinGuiXe
select * from Owner
select * from BaiDoXe
go

-- Set foreign key cho tung bang MaBDX va owner ID
alter table ThongTinGuiXe
add constraint fk_mabdx  foreign key (MaBDX) references BaiDoXe (MaBDX)
go

alter table ThongTinGuiXe
add constraint fk_owner_id foreign key (OwnerID) references Owner (ID)
go

-- Set unique cho CMTND 
alter table Owner
add constraint unique_cmtnd unique (CMTND)
go

-- Them cot tuoi vao bang Owner va them dieu kien cho Age

alter table Owner
add Age int
go

alter table Owner
add constraint check_age check (Age between 0 and 100)
go

-- sua lai thong tin tuoi cho Owner trong bangr Owner
update Owner set Age = '20' where ID = 1
go
update Owner set Age = '22' where ID = 2
go
update Owner set Age = '25' where ID = 3
go
update Owner set Age = '30' where ID = 4
go
update Owner set Age = '45' where ID = 5 
go


-- test
select * from ThongTinGuiXe
select * from Owner
select * from BaiDoXe
go

-- Tra cuu theo yeu cau
----Hien thi thong tin ng  gui xe

select Owner.ID OwnerID, Owner.Name 'Owner Name', BaiDoXe.MaBDX, BaiDoXe.Name 'BDX Name', ThongTinGuiXe.TenXe, ThongTinGuiXe.BienSoXe
from ThongTinGuiXe, BaiDoXe, Owner
where ThongTinGuiXe.MaBDX = BaiDoXe.MaBDX and ThongTinGuiXe.OwnerID = Owner.ID

select BienSoXe, OwnerID, count(OwnerID) as Total from ThongTinGuiXe
group by BienSoXe, OwnerID