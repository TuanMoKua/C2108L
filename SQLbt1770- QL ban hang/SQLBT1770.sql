--CSDL Qan ly Ban hang
create database Management_ban_hang
go

use Management_ban_hang
go
 
 -- Tao table
 create table Product(
	Product_ID int primary key identity(1, 1),
	Title nvarchar(200)not null,
	Thumbnail nvarchar(500),
	Content text
 )
 go

 create table Danh_sach_sp(
	Sp_Id int primary key identity(1, 1),
	Name_Sp nvarchar(30)
 )
 go

 -- them cot vao table san pham
 alter table Product
 add price int
 go

 alter table Product
 add num int
 go

 alter table Product
 add created_at date
 go

 alter table Product
 add update_at date
go

alter table Product
add id_cat int
go

-- tao fk_key cho 
alter table Product
add constraint fk_id_cat foreign key (id_cat) references Danh_sach_sp (Sp_Id)
go



-- TEst
select * from Product
select * from Danh_sach_sp
go
-- insert table
insert into Product (Title, Thumbnail, Content, price, num, created_at, update_at, id_cat)
values
('Ao dai', 'link1', 'Ao dai Viet Nam', '0', '10', '2021-10-10', '2021-10-12', '1'),
('Ao Khoac bong', 'link2', 'Made in USD', '3000', '12', '2020-01-06', '2021-05-06', '2'),
('Ao phong', 'link3', 'Chat lieu cotton', '2500', '15', '2016-12-20', '2021-12-25', '1'),
('Quan Au', 'link4', 'Ao dai Viet Nam', '4000', '20', '2020-03-06', '2021-03-08', '3'),
('Vest', 'link5', 'Ao dai Viet Nam', '5000', '22', '2021-12-10', '2021-12-12', '2')
go

insert into Danh_sach_sp (Name_Sp)
values
('New Faction'),
('Old Faction'),
('Super Sale')
go

-- Update thong tin du lieu
update Product set price = 5000
where price = 0 or price is null
go

update Product set price = price *0.9
where created_at < '2020-06-06'
go

delete from Product
where created_at < '2016-12-31'
go




