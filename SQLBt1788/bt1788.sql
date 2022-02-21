--CSDL: Hotel
create database Management_Hotel
go

use Management_Hotel
go

--table
create table Hotel(
	ID_Hotel int not null primary key identity(1, 1),
	Hotel_Name nvarchar(50),
	Address nvarchar(100),
	Dien_tich int,
	Managenment_Hotel nvarchar(30)
)
go

create table Room(
	Room_no int not null primary key,
	ID_Hotel int,
	Room_Dientich int,
	Room_style nvarchar(30),
	Room_floor int
)
go

alter table Room
alter column Room_floor nvarchar(30)
go

create table Book(
	book_id int not null primary key identity(1, 1),
	Room_no int,
	Ngay_check_in date,
	Ngay_check_out date,
	Number_Cust int
)
go

--Tạo Fk_key lien kết các table
alter table Room
add constraint fk_id_Hotel foreign key (ID_Hotel) references Hotel (ID_Hotel)
go

alter table Book
add constraint fk_Room_no foreign key (Room_no) references Room (Room_no)
go

-- Insert table 
insert into Hotel (Hotel_Name, Address, Dien_tich, Managenment_Hotel)
values
('Hotel Anh Sao', '123 Hai Ba Trung', '1500', 'Nguyen Van A'),
('Hotel Sao Mai', '254 Hoang Quoc Viet', '1000', 'Nguyen Van B'),
('Hotel TanTan', ' 69 Giang Vo', '2000', 'Tran Van C'),
('Hotel An An', '77 Trần Duy Hưng', '1200', 'Hoang Van D'),
('Hotel BenA', '12 Lang Ha', '800', 'Tran Van G')
go

insert into Room(Room_no, Id_Hotel, Room_Dientich, Room_style, Room_floor)
values
('102', '2', '25', 'Single room', 'Stage 1'),
('202', '1', '40', 'Double room', 'Stage 2'),   
('305', '3', '50', 'VIP room', 'Stage 3'),
('605', '5', '20', 'Single room', 'Stage 6'),
('405', '4', '30', 'Single room', 'Stage 4')
go

insert into Book(Room_no, Ngay_check_in, Ngay_check_out, Number_Cust)
values
('102', '2021-10-20', '2021-10-21', '2'),
('202', '2021-11-20', '2021-11-21', '4'),
('305', '2021-12-10', '2021-12-15', '5'),
('605', '2021-11-10', '2021-11-15', '3'),
('405', '2021-10-6', '2021-10-10', '2')
go

delete from Book
where book_id > 5
go

-- Test
select * from Hotel
select * from Room
select * from Book
go

-- TiM KIEM THEO YEU CAU

select Hotel.Hotel_Name, Hotel.Address, Room.Room_no, Room.Room_style, Room.Room_Dientich, Room.Room_floor 
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel
go

select Hotel.Hotel_Name, Hotel.Address, Room.Room_no, Room.Room_style, Room.Room_Dientich, Room.Room_floor 
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel
where Room.Room_Dientich >= 30
go

select Hotel.Hotel_Name, Hotel.Address, count(Room.Room_no) as Tong_So_Phong
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel 
group by Hotel.Hotel_Name, Hotel.Address
having count(Room.Room_no)>5
go

select Hotel.Hotel_Name, Hotel.Address, min(Room.Room_Dientich) as Dien_Tich_Nho_Nhat
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel 
group by Hotel.Hotel_Name, Hotel.Address
order by Dien_Tich_Nho_Nhat asc
go

select Hotel.Hotel_Name, Hotel.Address, max(Room.Room_Dientich) as Dien_Tich_Lon_Nhat
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel  
group by Hotel.Hotel_Name, Hotel.Address
order by Dien_Tich_Lon_Nhat desc
go

select Hotel.Hotel_Name, Hotel.Address, sum(Room.Room_Dientich) as Tong_Dien_Tich
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel
group by Hotel.Hotel_Name, Hotel.Address
go

select Hotel.Hotel_Name, Hotel.Address, avg(Room.Room_Dientich) as Dien_Tich_TB
from Hotel left join Room on Room.ID_Hotel = Hotel.ID_Hotel
group by Hotel.Hotel_Name, Hotel.Address
go

-- Column total_money trong bang book
alter table Book
add total_money int default 0
go

select * from Book
update Book set total_money = 5000000 where book_id = 1
update Book set total_money = 10000000 where book_id = 2
update Book set total_money = 8000000 where book_id = 3
go