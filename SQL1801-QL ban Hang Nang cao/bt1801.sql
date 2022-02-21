--CSDL 1801 Ql_ban hang
create database QL_ban_hang_1801
go

use QL_ban_hang_1801
go

-- table
create table Sp_Hang_Hoa(
	id int primary key identity(1, 1),
	name_sp nvarchar(50),
	name_NhaSX nvarchar(50),
	Xuat_xu nvarchar(50),
	price_in money,
	price_sell money,9
	ngay_sx date
)
go

create table Ban_Hang(
	id int primary key identity(1, 1),
	id_hanghoa int,
	Note nvarchar(200),
	Day_sell date,
	number int,
	price_sell money
)
go

-- fk
alter table Ban_Hang
add constraint fk_id_hanghoa foreign key (id_hanghoa) references Sp_Hang_Hoa (id)
go

--- insert
insert into Sp_Hang_Hoa (name_sp, name_NhaSX, Xuat_xu, price_in, price_sell, ngay_sx)
values
('sp1', 'NSX1', 'VN', 2000, 3000, '2020-10-05'),
('sp2', 'NSX2', 'VN', 1000, 1500, '2020-01-01'),
('sp3', 'NSX3', 'VN', 900, 1000, '2020-02-07'),
('sp4', 'NSX4', 'VN', 850, 900, '2020-03-05'),
('sp5', 'NSX5', 'VN', 1500, 2000, '2020-04-09'),
('sp6', 'NSX6', 'VN', 3000, 3000, '2020-05-10'),
('sp7', 'NSX7', 'VN', 10000, 15000, '2020-06-06'),
('sp8', 'NSX8', 'VN', 5000, 6000, '2020-07-03'),
('sp9', 'NSX9', 'VN', 150, 300, '2020-08-07'),
('sp10', 'NSX10', 'VN', 800, 1000, '2020-09-02')
go

update Sp_Hang_Hoa set Xuat_xu = 'JPN' where id = 2
update Sp_Hang_Hoa set Xuat_xu = 'CN' where id = 3
update Sp_Hang_Hoa set Xuat_xu = 'KORE' where id = 5
update Sp_Hang_Hoa set Xuat_xu = 'USA' where id = 7
update Sp_Hang_Hoa set Xuat_xu = 'ITALY' where id = 9


insert into Ban_Hang(id_hanghoa, Note, Day_sell, number, price_sell)
values
('1', 'XK', '2020-11-04', 10, 3000),
('2', 'XK', '2020-11-04', 15, 1500),
('3', 'XK', '2020-11-04', 20, 1000),
('4', 'XK', '2020-11-04', 60, 900),
('5', 'XK', '2020-11-04', 100, 2000),
('6', 'XK', '2020-11-04', 30, 3000),
('7', 'XK', '2020-11-04', 41, 15000),
('8', 'XK', '2020-11-04', 19, 6000),
('9', 'XK', '2020-11-04', 16, 300),
('10', 'XK', '2020-11-04', 05, 1000)
go

-- test
select * from Sp_Hang_Hoa
select * from Ban_Hang
go

--Thực hiện yêu cầu
--Thực hiện liệt kê tất cả các đơn hàng đã được bán ra -> Dùng view để thiết kế
select Sp_Hang_Hoa.name_sp as 'Ten SP', Sp_Hang_Hoa.name_NhaSX as 'Nha SX', Sp_Hang_Hoa.Xuat_xu, Sp_Hang_Hoa.ngay_sx as 'Ngay SX', Sp_Hang_Hoa.price_in as 'Gia nhap', 
	Ban_Hang.Day_sell as ' Ngay ban', Ban_Hang.number as 'So luong', Ban_Hang. price_sell as 'Gia ban'
	from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
go

create view view_infor_SP
as
select Sp_Hang_Hoa.name_sp as 'Ten SP', Sp_Hang_Hoa.name_NhaSX as 'Nha SX', Sp_Hang_Hoa.Xuat_xu, Sp_Hang_Hoa.ngay_sx as 'Ngay SX', Sp_Hang_Hoa.price_in as 'Gia nhap', 
	Ban_Hang.Day_sell as ' Ngay ban', Ban_Hang.number as 'So luong', Ban_Hang. price_sell as 'Gia ban'
	from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
go

select * from view_infor_SP
go

 --Liệt kê các đơn hàng được bán ra có xuất xứ -> yêu cầu viết procedure có tham số truyền vào là xuất xứ
 create proc proc_view_infor_SP
	@namexuatxu nvarchar(50)
as
 begin
	select Sp_Hang_Hoa.name_sp as 'Ten SP', Sp_Hang_Hoa.name_NhaSX as 'Nha SX', Sp_Hang_Hoa.Xuat_xu, Sp_Hang_Hoa.ngay_sx as 'Ngay SX', Sp_Hang_Hoa.price_in as 'Gia nhap', 
			Ban_Hang.Day_sell as ' Ngay ban', Ban_Hang.number as 'So luong', Ban_Hang. price_sell as 'Gia ban'
	from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa

	where Sp_Hang_Hoa.Xuat_xu = @namexuatxu
 end
go

exec proc_view_infor_SP 'VN'
exec proc_view_infor_SP 'JPN'
exec proc_view_infor_SP 'CN'
exec proc_view_infor_SP 'USA'
go

--Thống kê tổng giá bán được cho từng mặt hàng. -> viết procedure có tham số truyền vào là mặt hàng và tham số đấu già là total
create proc proc_view_sumtotal
	@namesp nvarchar(50),
	@total money output
as
begin
	select Sp_Hang_Hoa.name_sp as 'Ten SP', Sp_Hang_Hoa.name_NhaSX as 'Nha SX', Sp_Hang_Hoa.Xuat_xu, Sp_Hang_Hoa.ngay_sx as 'Ngay SX', Sp_Hang_Hoa.price_in as 'Gia nhap', 
			Ban_Hang.Day_sell as ' Ngay ban', Ban_Hang.number as 'So luong', Ban_Hang. price_sell as 'Gia ban'
	from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
	where Sp_Hang_Hoa.name_sp = @namesp

	select @total = sum(Ban_Hang.number * Ban_Hang. price_sell)
		from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
		where Sp_Hang_Hoa.name_sp = @namesp
	print @total

end
go

alter proc proc_view_sumtotal
	@namesp nvarchar(50),
	@total float output
as
begin
	select Sp_Hang_Hoa.name_sp as 'Ten SP', Sp_Hang_Hoa.name_NhaSX as 'Nha SX', Sp_Hang_Hoa.Xuat_xu, Sp_Hang_Hoa.ngay_sx as 'Ngay SX', Sp_Hang_Hoa.price_in as 'Gia nhap', 
			Ban_Hang.Day_sell as ' Ngay ban', Ban_Hang.number as 'So luong', Ban_Hang. price_sell as 'Gia ban'
	from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
	where Sp_Hang_Hoa.name_sp = @namesp

	select @total = sum(Ban_Hang.number * Ban_Hang. price_sell)
		from Sp_Hang_Hoa left join Ban_Hang on Sp_Hang_Hoa.id = Ban_Hang.id_hanghoa
		where Sp_Hang_Hoa.name_sp = @namesp
	

end
go

declare @giasp float
exec proc_view_sumtotal @namesp = 'sp1', @total = @giasp output
print @giasp
print N'Tong so tien ban ra cua sp la  = ' + convert(nvarchar, @giasp)
go

