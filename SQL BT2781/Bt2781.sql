--CSDL 2781
create database Bt2781
go

use Bt2781
go

--- Table
create table Roles (
	id int primary key identity(1,1),
	rolename nvarchar(50)
)
go

create table Users (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	gender nvarchar(20),
	email nvarchar(150),
	phone_number nvarchar(20),
	address nvarchar(200),
	role_id int references Roles (id)
)
go

create table Room (
	id int primary key identity(1,1),
	room_no nvarchar(20) not null,
	type nvarchar(20),
	max_num int,
	price float
)
go

create table Booking (
	id int primary key identity(1,1),
	staff_id int references Users (id),
	customer_id int references Users (id),
	checkin datetime,
	checkout datetime
)
go

create table BookingDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	price float,
	unit float,
	primary key (booking_id, room_id)
)
go

create table UserDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	customer_id int references Users (id),
	primary key (booking_id, room_id, customer_id)
)

create table Category (
	id int primary key identity(1,1),
	name nvarchar(50)
)
go

create table Product (
	id int primary key identity(1,1),
	category_id int references Category (id),
	title nvarchar(150),
	thumbnail nvarchar(500),
	description ntext,
	price float,
	amount int
)
go

create table Services (
	id int primary key identity(1,1),
	booking_id int references Booking (id),
	customer_id int references Users (id),
	product_id int references Product (id),
	price float,
	amount int,
	buy_date datetime
)
go

--view table
select * from Roles
select * from Users
select * from Room
select * from Booking
select * from BookingDetail
select * from UserDetail
select * from Category
select * from Product
select * from Services
go

--Insert table
insert into Roles(rolename)
values
('Bang Nhan vien'),
('Bang Khach hang')
go

insert into Users(fullname, birthday, gender, email, phone_number, address, role_id)
values
('Nguyen van A', '1999-02-09', 'Nam', 'anguyenvan@gmail.com	', '0984567894', 'Ha Noi', 1),
('Nguyen Thi B', '2000-10-10', 'Nu', 'b@gmail.com', '0956456789', 'Ha Noi', 1),
('Nguyen Hoang C', '1989-05-09', 'Nam', 'hoangc@gmail.com', '0985986325', 'Ha Noi', 2),
('Nguyen Thu D', '1992-02-12', 'Nu', 'thud@gmail.com', '0904561278', 'Ha Noi', 2),
('Nguyen Cao E', '1995-08-08', 'Nam', 'caoe@gmail.com', '0965231478', 'Ha Noi', 2)
go

insert into Category(name)
values
('Nuoc tang luc Sting'),
('Dich vu giat nhanh'),
('Dich vu massage'),
('Dich vu don phong'),
('Dich vu cham soc khach hang')
go

insert into Product(category_id, title, thumbnail, description, price, amount)
values
(1, 'nuoc uong', 'LinkA', 'giup nap nang luong', 18000, 5),
(2, 'Dich vu lam sach', 'LinkB', 'Giat la hoi lau ngay',200000, 10),
(3, 'Dich vu ngoai', 'LinkC', 'Cham soc suc khoe', 150000, 2),
(4, 'Don phong', 'LinkD', 'Dich vu khach san', 35000, 6),
(5, 'Dich vu', 'LinkE', 'dich vu', 20000, 1)
go

insert into Room(room_no, type, max_num, price)
values
(1052,'VIP', 5, 12000000),
(2052,'Normal', 4, 500000),
(4052,'Signal', 2, 350000),
(5052,'Coupel', 4, 70000),
(6052,'Romantic', 2, 2000000)
go

insert into Booking(staff_id, customer_id, checkin, checkout)
values
(1, 3, '2021-12-25 08:00:00', '2021-12-30 12:00:00'),
(2, 4, '2021-12-10 08:00:00', '2021-12-15 12:00:00'),
(2, 5, '2021-01-05 08:00:00', '2021-01-15 12:00:00'),
(2, 3, '2022-01-10 08:00:00', '2021-01-12 12:00:00'),
(1, 5, '2021-01-18 08:00:00', '2021-01-21 12:00:00')
go

insert into BookingDetail(booking_id, room_id, price, unit)
values
(1, 2, 1000000, 2),
(2, 1, 12000000, 1),
(3, 3, 700000, 5),
(4, 4, 140000, 3),
(5, 5, 1800000, 3)
go

insert into UserDetail(booking_id, room_id, customer_id)
values
(1, 2, 3),
(2, 1, 4),
(3, 3, 5),
(4, 4, 3),
(5, 5, 5)
go

insert into Services(booking_id, customer_id, product_id, price, amount, buy_date)
values
(1, 3, 1, 18000, 5, '2021-12-25 08:00:00'),
(2, 4, 2, 200000, 5, '2021-12-10 08:00:00'),
(3, 5, 3, 150000, 1, '2021-01-05 08:00:00'),
(4, 3, 4, 35000, 6, '2022-01-10 08:00:00' ),
(5, 5, 5, 20000, 1, '2021-01-18 08:00:00')
go

--view table
select * from Roles
select * from Users
select * from Room
select * from Booking
select * from BookingDetail
select * from UserDetail
select * from Category
select * from Product
select * from Services
go

--Proc and view
---- xem thông tin khách hàng đã tới khách sạn gồm: tên, sđt, ngày checkin, checkout, mã phòng tìm theo customer_id -> Sử dụng proc
create proc proc_infor_customer
	@customerid int
as
begin
	select Users.fullname 'Name', Users.phone_number, UserDetail.customer_id,  Booking.checkin, Booking.checkout, Room.room_no 'Ma Phong'
	from Users, Booking, Room, UserDetail
	where Users.id = UserDetail.customer_id
		and UserDetail.booking_id = Booking.id
		and UserDetail.room_id = Room.id
		and UserDetail.customer_id = @customerid
end
go

exec proc_infor_customer 3
go

----Xem danh sách khách hàng tới khách sạn: tên, sđt, ngày checkin, checkout, mã phòng tìm theo booking_id -> sử dụng proc
create proc proc_infor_booking
	@cbookingid int
as
begin
	select Users.fullname 'Name', Users.phone_number, UserDetail.customer_id,  Booking.checkin, Booking.checkout, Room.room_no 'Ma Phong'
	from Users, Booking, Room, UserDetail
	where Users.id = UserDetail.customer_id
		and UserDetail.booking_id = Booking.id
		and UserDetail.room_id = Room.id
		and UserDetail.booking_id = @cbookingid
end
go

exec proc_infor_booking 2

--Tính tổng tiền sử dụng đặt phòng theo booking_id
create proc  proc_money_bookingdetail
	@bookingid int,
	@total_bookingdetail float output
as
begin
	select * from BookingDetail
	where BookingDetail.booking_id = @bookingid

	select @total_bookingdetail = sum (BookingDetail.price * BookingDetail.unit)
	from BookingDetail
	where BookingDetail.booking_id = @bookingid
end
go

alter proc  proc_money_bookingdetail
	@bookingid int,
	@total money output
as
begin
	select * from BookingDetail
	where BookingDetail.booking_id = @bookingid

	select @total = sum (BookingDetail.price * BookingDetail.unit)
	from BookingDetail
	where BookingDetail.booking_id = @bookingid
end
go

declare @total_bookingdetail_out float
exec proc_money_bookingdetail 3, @total =  @total_bookingdetail_out output
print @total_bookingdetail_out
print N'Tong tien DV dat phong' + convert(nvarchar, @total_bookingdetail_out)
go

---Tính tổng tiền sử dụng dịch vụ theo booking_id
create proc  proc_money_booking_services
	@bookingid int,
	@total money output
as
begin
	select * from Services
	where Services.booking_id = @bookingid

	select @total = sum (Services.price * Services.amount)
	from Services
	where Services.booking_id = @bookingid
end
go

declare @total_booking_services_out float
exec proc_money_booking_services 3, @total =  @total_booking_services_out output
print @total_booking_services_out
print N'Tong tien DV ' + convert(nvarchar, @total_booking_services_out)
go

--Tính tổng tiền đặt phòng và dịch vụ theo booking_id
create proc proc_money_booking
	@bookingid int,
	@total money output
as
begin 
	select BookingDetail.booking_id, BookingDetail.room_id, BookingDetail.unit, BookingDetail.price, 
			Services.customer_id, Services.product_id, Services.amount, Services.price
			from BookingDetail, Services, Booking
			where BookingDetail.booking_id = Booking.id
				and Booking.id = Services.booking_id
				and BookingDetail.booking_id = @bookingid

	select @total = sum(BookingDetail.unit * BookingDetail.price) + sum(Services.amount*Services.price)
	from BookingDetail, Services, Booking
			where BookingDetail.booking_id = Booking.id
				and Booking.id = Services.booking_id
				and BookingDetail.booking_id = @bookingid
end
go

declare @total_money float
exec proc_money_booking 1, @total = @total_money output
print N'Tổng tiền đặt phòng và dịch vụ = ' + convert(nvarchar, @total_money)
go

--view table
select * from Roles
select * from Users
select * from Room
select * from Booking
select * from BookingDetail
select * from UserDetail
select * from Category
select * from Product
select * from Services
go

--



