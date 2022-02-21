--CSDL Quan_ly_sinh_vien
create database quanly_sinhvien
go

use quanly_sinhvien
go

create table Sinh_vien(
	RollNo nvarchar(5) primary key,
	Full_name nvarchar (30),
	Age nvarchar(5),
	Address text,
	email nvarchar(30),
	Phone_number nvarchar (16),
	Gender nvarchar(5)
)
go

select * from Sinh_vien
go

insert into Sinh_vien (RollNo, Full_name, Age, Address, email,  Phone_number, Gender)
values
('01', 'Nguyen Van A', '23', 'Ha noi', 'nguyenvana@gmail.com', '+84 965879663', 'Nam')
go

insert into Sinh_vien (RollNo, Full_name, Age, Address, email,  Phone_number, Gender)
values
('02', 'Nguyen Van B', '22', 'Ha noi', 'nguyenvanB@gmail.com', '+84 658897489', 'Nam'),
('03', 'Pham Thi Na', '20', 'Quang Ninh', 'na@gmail.com', '+84 256974898', 'Nu')
go
insert into Sinh_vien (RollNo, Full_name, Age, Address, email,  Phone_number, Gender)
values
('04', 'Tran Thi Ha', '20', 'Bac Ninh', 'tranha@gmail.com', '+84 8569874239', 'Nu'),
('05', 'Pham Thanh Hung', '21', 'Phu Tho', 'hungpham@gmail.com', '+84 5689741258', 'Nam')
go


create table Mon_hoc(
	class_id int primary key identity (1, 1),
	monhoc_name nvarchar (30),
)
go

select * from Mon_hoc
go

insert into Mon_hoc ( monhoc_name)
values
('Toan'),
('Ly'),
('Hoa'),
('Ngu Van'),
('Lich Su')
go

create table Bang_diem(
	RollNo nvarchar(5),
	class_id int,
	diem_monhoc nvarchar(5),
	primary key(RollNo, class_id)
)
go

select * from Bang_diem
go

insert into Bang_diem(RollNo, class_id, diem_monhoc)
values
('01', '1', '8'),
('02', '3', '9'),
('02', '5', '7'),
('05', '5', '9'),
('03', '2', '8')
go

create table myClass(
	RollNo nvarchar(5),
	class_id int primary key identity(1, 1),
	class_name nvarchar(10),
)
go

select * from myClass
go



insert into myClass(RollNo, class_name)
values
('1', 'Lop Toan'),
('2', 'Lop Ly'),
('3', 'Lop Hoa'),
('4', 'Lop Van'),
('5', 'Lop Su')
go


create table classRoom(
	Ma_phong_hoc int primary key identity (1, 1),
	classRoom_name nvarchar(20),
	table_number nvarchar(10),
	char_number nvarchar(10),
	classRoom_add nvarchar(20)
)
go

select *from classRoom
go

insert into classRoom(classRoom_name, table_number, char_number, classRoom_add)
values
('C252', '20', '15', 'Stage1'),
('C252', '5', '5', 'Stage2'),
('C252', '10', '8', 'Stage4'),
('C252', '15', '12', 'Stage9'),
('C252', '25', '18', 'Stage6')
go

select classRoom_name, table_number, char_number, classRoom_add from classRoom
where 
table_number>5 and char_number>5
go

select classRoom_name, table_number, char_number, classRoom_add from classRoom
where 
table_number between 5 and 20 and char_number between 5 and 20
go

