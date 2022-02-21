--CSDL Quản lý quán cafe
create database Ql_Coffe
go

use Ql_Coffe
go

--table
create table SP_Cafe(
	id int not null primary key,
	name_sp nvarchar(50),
	Ngay_sx date,
	Nha_SX nvarchar(100),
	Xuat_xu_sp nvarchar(50),
	Gia_nhap float
)
go

create table Drink_Coffe(
	id int not null primary key,
	Name nvarchar (50),
	id_spcafe int,
	Gia_ban  float,
	Ngay_ban date
)
go

create table Nhan_vien(
	id int not null primary key,
	Name_Nv nvarchar(50),
	Age int,
	Address nvarchar(200),
	Phone_number nvarchar(16),
	Thoigian_batdau_lamviec datetime,
	Thoigian_ketthuc_lamviec datetime
)
go

create table Don_hang(
	id int not null primary key identity(1, 1),
	id_nhanvien int,
	id_drink int,
	Ngay_taodon datetime,
	Gia_donhang float--- thay doi bang cach index vs gia ban của drink coffe
)
go

create table Khach_hang(
	id int not null primary key identity(1, 1),
	id_donhang int,
	Name_Kh nvarchar(50),
	kh_Phonenumber nvarchar(16),
	Check_in date,
	Check_out date
)
go

alter table Khach_hang
alter column Check_in datetime
go

alter table Khach_hang
alter column Check_out datetime
go

--mapping
alter table Drink_Coffe
add constraint fk_id_spcafe foreign key (id_spcafe) references SP_Cafe (id)
go

alter table Don_hang
add constraint fk_id_nhanvien foreign key (id_nhanvien) references Nhan_vien (id)
go

alter table Don_hang
add constraint fk_id_drink foreign key (id_drink) references Drink_Coffe (id)
go

alter table Khach_hang
add constraint fk_id_donhang foreign key (id_donhang) references Don_hang (id)
go

-- Index -- ten kh trong bai nay th ten khach hang ko thay doi
create index index_Name_Kh on Khach_hang (Name_Kh)
go

create nonclustered index Cl_index_Name_Nv on Nhan_vien (Name_Nv)
go

create  index Cl_index_Name_Sp on SP_Cafe (name_sp)
go

--insert table
insert into SP_Cafe (id, name_sp,  Xuat_xu_sp, Nha_SX, Ngay_sx, Gia_nhap)
values
(1, 'Hat Coffe Den', 'VN', 'Trung Nguyen', '2020-10-10', 200000),
(2, 'Cam Canh', 'VN', 'CTyA', '2020-10-10', 25000),
(3, 'Xoai', 'VN', 'CtyB', '2020-10-10', 35000),
(4, 'QUa Thom', 'VN', 'CTyC', '2020-10-10', 40000),
(5, 'Qua Bo', 'VN', 'CtyD', '2020-10-10', 60000)
go

insert into Drink_Coffe (id, id_spcafe, Name, Ngay_ban, Gia_ban)
values
(1, 2, 'Nuoc Cam Vat', '2020-11-01', 35000),
(2, 1, 'Bac Xiu', '2020-10-20', 40000),
(3, 3, 'Sinh To Xoai', '2020-10-30', 45000),
(4, 5, 'Sinh To Bo', '2020-11-11', 30000),
(5, 4, 'Nuoc Dua Ep', '2020-11-20', 25000)
go

insert into Nhan_vien (id, Name_Nv, Phone_number, Age, Address, Thoigian_batdau_lamviec, Thoigian_ketthuc_lamviec)
values
(1, 'Tran Van A', '09045689749', 20, 'Le Thanh Nghi', '2020-11-01 08:30:00', '2020-11-01 17:40:00' ),
(2, 'Tran Van B', '09645689749', 21, 'Le Thanh Nghi', '2020-10-20 08:30:00', '2020-11-01 17:40:00' ),
(3, 'Tran Van C', '09545689749', 22, 'Le Thanh Nghi', '2020-10-30 08:30:00', '2020-11-01 17:40:00' ),
(4, 'Tran Van D', '09445689749', 23, 'Le Thanh Nghi', '2020-11-11 08:30:00', '2020-11-01 17:40:00' ),
(5, 'Tran Van E', '09845689749', 25, 'Le Thanh Nghi', '2020-11-20 08:30:00', '2020-11-01 17:40:00' )
go

insert into  Don_hang (id_nhanvien, id_drink, Ngay_taodon, Gia_donhang)
values
(1, 1, '2020-11-01', 35000),
(2, 2, '2020-10-20', 40000),
(3, 3, '2020-10-30', 45000),
(4, 4, '2020-11-11', 30000),
(5, 5, '2020-11-20', 25000)
go

insert into Khach_hang (id_donhang, Name_Kh, kh_Phonenumber, Check_in, Check_out)
values
(1, 'Nguyen Van A', '0985784125', '2020-11-01 10:00:00', '2020-11-01 12:20:00'),
(2, 'Nguyen Van B', '0965784125', '2020-10-20 14:00:00', '2020-11-01 16:20:00'),
(3, 'Nguyen Van C', '0955784125', '2020-10-30 11:00:00', '2020-11-01 11:30:00'),
(4, 'Nguyen Van D', '0905784125', '2020-11-11 16:00:00', '2020-11-01 17:00:00'),
(5, 'Nguyen Van E', '0975784125', '2020-11-20 09:30:00', '2020-11-01 11:20:00')
go

--view table
select * from SP_Cafe
select * from Drink_Coffe
select * from Nhan_vien
select * from Don_hang
select * from Khach_hang
go

--TIm kiem
----Hiển thị danh sách loại đồ uống theo một danh mục -> yêu cầu viết truy vấn sql, tạo store (phần này làm 2 ý tách biết)
----C1": SQL
select SP_Cafe.name_sp 'Ten San Pham', SP_Cafe.Nha_SX, SP_Cafe.Ngay_sx, SP_Cafe.Xuat_xu_sp, SP_Cafe.Gia_nhap, Drink_Coffe.Name 'Ten Do Uong', Drink_Coffe.Ngay_ban, Drink_Coffe.Gia_ban
from Drink_Coffe left join SP_Cafe on Drink_Coffe.id_spcafe = SP_Cafe.id
go

----C2 View
create view view_Danhsach_DrinkCoffe
as
select SP_Cafe.name_sp 'Ten San Pham', SP_Cafe.Nha_SX, SP_Cafe.Ngay_sx, SP_Cafe.Xuat_xu_sp, SP_Cafe.Gia_nhap, Drink_Coffe.Name 'Ten Do Uong', Drink_Coffe.Ngay_ban, Drink_Coffe.Gia_ban
from Drink_Coffe left join SP_Cafe on Drink_Coffe.id_spcafe = SP_Cafe.id
go

select * from view_Danhsach_DrinkCoffe
go

--- Hiển thị danh mục sản phẩm trong 1 đơn hàng -> yêu cầu viết truy vấn sql và tạo 1 store cho chức năng này
----c1: SQL
select  SP_Cafe.name_sp 'Ten San Pham', SP_Cafe.Nha_SX, SP_Cafe.Ngay_sx, SP_Cafe.Xuat_xu_sp, SP_Cafe.Gia_nhap, Drink_Coffe.Name 'Ten do Uong', Drink_Coffe.Ngay_ban, Drink_Coffe.Gia_ban, Don_hang.Ngay_taodon, Don_hang.Gia_donhang
from Don_hang left join Drink_Coffe on Don_hang.id_drink = Drink_Coffe.id
	left join SP_Cafe on Drink_Coffe.id_spcafe = SP_Cafe.id
go

---C2. Proc
create proc proc_Donhang_Coffe
	@Tensp nvarchar(50)
as
begin
select  SP_Cafe.name_sp 'Ten San Pham', SP_Cafe.Nha_SX, SP_Cafe.Ngay_sx, SP_Cafe.Xuat_xu_sp, SP_Cafe.Gia_nhap, Drink_Coffe.Name 'Ten do Uong', Drink_Coffe.Ngay_ban, Drink_Coffe.Gia_ban, Don_hang.Ngay_taodon, Don_hang.Gia_donhang
from Don_hang left join Drink_Coffe on Don_hang.id_drink = Drink_Coffe.id
	left join SP_Cafe on Drink_Coffe.id_spcafe = SP_Cafe.id

	where SP_Cafe.name_sp = @Tensp
end
go

exec proc_Donhang_Coffe 'Cam Canh'
go

-- Hiển thị danh mục các đơn hàng theo mã KH.
---_C1:SQL
select Khach_hang.Name_Kh 'Ten Khach Hang', Khach_hang. kh_Phonenumber 'SDT KH', Khach_hang.Check_in 'Thoi gian vao', Khach_hang.Check_out 'Thoi Gian Ra Ve', Don_hang.Ngay_taodon, Don_hang.Gia_donhang
from Khach_hang left join Don_hang on Khach_hang.id_donhang = Don_hang.id
go

--C2:proc
create proc proc_Kh_Donhang
	@Custumid int,
	@total float output
as
begin
	select Khach_hang.Name_Kh 'Ten Khach Hang', Khach_hang. kh_Phonenumber 'SDT KH', Khach_hang.Check_in 'Thoi gian vao', Khach_hang.Check_out 'Thoi Gian Ra Ve', Don_hang.Ngay_taodon, Don_hang.Gia_donhang
		from Khach_hang left join Don_hang on Khach_hang.id_donhang = Don_hang.id
		where Khach_hang.id = @Custumid

	select @total = sum(Don_hang.Gia_donhang)
		from Khach_hang left join Don_hang on Khach_hang.id_donhang = Don_hang.id
		where Khach_hang.id = @Custumid
end
go

declare @total int
exec proc_Kh_Donhang 1, @total = @total output
print N'Tong So tien don hang = ' + convert(nvarchar, @total)
go

declare @total int
exec proc_Kh_Donhang 3, @total = @total output
print N'Tong So tien don hang = ' + convert(nvarchar, @total)
go

-- Hiển thị doanh thu theo ngày bắt đầu và ngày kết thức -> yêu cầu viết theo store.
