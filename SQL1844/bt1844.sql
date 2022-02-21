--CSDL Ðua dón h?c sinh
create database Travel_Student_1844
go

use Travel_Student_1844
go

-- table
 create table Infor_Hoc_vien(
	id int primary key identity(1, 1),
	name_hoc_vien nvarchar(30),
	address nvarchar(250),
	ten_bo nvarchar(30),
	phone_bo nvarchar(16),
	ten_me nvarchar(30),
	phone_me nvarchar(16),
	brithday date,
	id_dia_diem_don int
 )
 go

 create table Bus(
	id int primary key identity(1, 1),
	bien_so nvarchar(16),
	loai_xe nvarchar(20),
	so_ghe int,
	id_taixe int
 )
 go

 create table Tai_xe(
	id int primary key identity(1, 1),
	Name_tai_xe nvarchar(16),
	gender nvarchar(16),
	address nvarchar(250)
 )
go

create table Lo_trinh_xe(
	id_bus int,
	id_dia_diem_don int
)
go

create table Dia_diem_don(
	id int primary key identity(1, 1),
	addres nvarchar(250)
)
go

--- fk
alter table Infor_Hoc_vien
add constraint fk_id_dia_diem_don_hv foreign key (id_dia_diem_don) references Dia_diem_don (id)
go

alter table Bus
add constraint fk_id_taixe_lotrinhxe foreign key (id_taixe) references Tai_xe (id)
go

alter table Lo_trinh_xe
add constraint fk_id_dia_diem_don_lotrinhxe foreign key (id_dia_diem_don) references Dia_diem_don (id)
go

alter table Lo_trinh_xe
add constraint fk_id_bus_lotrinhxe foreign key (id_bus) references Bus (id)
go

-- insert cac bang ko chua fk truowcs roi ms den cac bang chua fk 
insert into Dia_diem_don(addres)
values
('112 Hai Ba Trung'),
('24 Dinh Cong'),
('10 Hoang Mai'),
('24 Le Thanh Nghi'),
('13 Dai Co Viet')
go
 
insert into Tai_xe (Name_tai_xe, gender, address)
values
('Tran Van A', 'Nam', '24 Ly Thuong Kiet'),
('Nguyen Van B', 'Nam', '13 Hoang Mai'),
('Hoang Van C', 'Nam', '20 Giai Phong'),
('Le Van T', 'Nam', '10 Truong Dinh'),
('Nguyen Hoang D', 'Nam', '25 Tran Dai Nghia')
go

insert into Bus(bien_so, loai_xe, so_ghe, id_taixe)
values
('29B1256', 'Xe 20 Cho', '22', 1 ),
('30H5641', 'Xe 30 Cho', '30', 2 ),
('30B5897', 'Xe 40 Cho', '45', 3 ),
('29P4587', 'Xe 30 Cho', '35', 4 ),
('30B8965', 'Xe 9 Cho', '9', 5 )
go

insert into Lo_trinh_xe(id_bus, id_dia_diem_don)
values
(1, 2),
(2, 3),
(3, 5),
(4, 1),
(2, 3)
go

update Lo_trinh_xe set id_dia_diem_don = 4 where id_bus = 2
go

insert into Infor_Hoc_vien(name_hoc_vien, address, ten_bo, phone_bo, ten_me, phone_me, brithday, id_dia_diem_don)
values
('Hoang Van Anh', 'Le Thanh Nghi', 'Hoang Van Cuong', '0904897589', 'Pham Thi Huyen', '0965789456', '2000-06-06', '4'),
('Le Van Binh', 'Hai Ba Trung', 'Le Van Huyen', '0985461238', 'Tran Thi My', '0965784123', '2000-08-10', '1'),
('Nguyen Hoang Trong', 'Dai Co Viet', 'Ngyuyen Hoang Ha', '0986784152', 'Dang Thuy Dung', '0986524174', '2000-10-11', '5'),
('Tran Binh Trong', 'Hoang Mai', 'Tran Van Cong', '0985457896', 'Le Thuy Duong', '0965231478', '2000-09-21', '3'),
('Le Bao Binh', 'Dinh Cong', 'Le Bao Anh', '0984135178', 'Nguyen Hoang Han', '0985781246', '2000-01-12', '2')
go

--Tesst 
select * from Infor_Hoc_vien
select * from Bus
select * from Tai_xe
select * from Dia_diem_don
select * from Lo_trinh_xe
go


-- Select & proc view
--- Co ban
--Tạo Proc xem thông tin lộ trình đi của xe bus : tài xế, biển số xe, địa chỉ đón.
select Tai_xe.Name_tai_xe as 'Ten Tai Xe', Bus.bien_so as 'Bien So Xe', Dia_diem_don.addres as 'Dia diem'
from Bus left join Tai_xe on Tai_xe.id = Bus.id_taixe
	left join Lo_trinh_xe on Bus.id = Lo_trinh_xe.id_bus
	left join Dia_diem_don on Lo_trinh_xe.id_dia_diem_don = Dia_diem_don.id
go

create proc proc_view_plant_Bus
as
begin
select Tai_xe.Name_tai_xe as 'Ten Tai Xe', Bus.bien_so as 'Bien So Xe', Dia_diem_don.addres as 'Dia diem'
from Bus left join Tai_xe on Tai_xe.id = Bus.id_taixe
	left join Lo_trinh_xe on Bus.id = Lo_trinh_xe.id_bus
	left join Dia_diem_don on Lo_trinh_xe.id_dia_diem_don = Dia_diem_don.id
end
go

exec proc_view_plant_Bus
go

--Tạo Proc xem thông tin sinh viên theo biển số xe.
select Infor_Hoc_vien.name_hoc_vien as 'Ten HV', Bus.bien_so as 'Bien So Xe'
from Dia_diem_don left join Infor_Hoc_vien on Infor_Hoc_vien.id_dia_diem_don = Dia_diem_don.id
		left join Lo_trinh_xe on Dia_diem_don.id = Lo_trinh_xe.id_dia_diem_don
		left join Bus on Lo_trinh_xe.id_bus = Bus.id
go

create proc proc_view_Hs_Bus
as
begin
select Infor_Hoc_vien.name_hoc_vien as 'Ten HV', Bus.bien_so as 'Bien So Xe'
from Dia_diem_don left join Infor_Hoc_vien on Infor_Hoc_vien.id_dia_diem_don = Dia_diem_don.id
		left join Lo_trinh_xe on Dia_diem_don.id = Lo_trinh_xe.id_dia_diem_don
		left join Bus on Lo_trinh_xe.id_bus = Bus.id
end
go

exec proc_view_Hs_Bus
go

--Tao View xem thông tin sinh viên gồm : Tên SV, giới tính, địa chỉ đó
select name_hoc_vien, address from Infor_Hoc_vien
go

create view view_infor_Hv
as
select name_hoc_vien, address from Infor_Hoc_vien
go

select * from view_infor_Hv
