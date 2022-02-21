
--CSDL BT1809
create database BT1809
go

use BT1809
go

--table
create table tblUser(
	UserId int not null,
	UserName nvarchar(50)
)
go

create table tblProduct(
	ProductId int not null,
	ProductName nvarchar(50),
	Quanlity int,
	Price money,
	Description ntext
)
go


create table tbOrder(
	OrderId int not null,
	UserID int not null,
	OrderDate datetime
)
go

create table tblOrderDetail(
	OrderId int not null,
	ProductId int not null,
	Quantity int,
	Price money
)
go

---Index & table Alter
create index CI_tblUser_UserID on tblUser (UserId)
go

drop index CI_tblUser_UserID on tblUser (UserId)
go

alter table tblUser
add BirthDate datetime
go


---view table
select * from tblUser
select * from tblProduct
select * from tbOrder
select * from tblOrderDetail
go

--Constraint
alter table tbOrder
add constraint DF_tblOrder_OrderDate default getdate() for OrderDate
go

alter table tblUser
add constraint PK_tblUser primary key (UserId)
go

alter table tbOrder
add constraint PK_tblOrder primary key (OrderId)
go

alter table tblProduct
add constraint PK_ttblProduct primary key (ProductId)
go

alter table tblOrderDetail
add constraint PK_tblOrderDetail primary key (OrderId, ProductId)
go

alter table tbOrder
add constraint fk_tblOrder_tblUser foreign key (UserID) references tblUser (UserId)
go

alter table tblOrderDetail
add constraint fk_tblOrderDetail_tbOrder foreign key (OrderId) references tbOrder (OrderId)
go

alter table tblOrderDetail
add constraint fk_tblOrderDetail_tblProduct foreign key (ProductId) references tblProduct (ProductId)
go

alter table tbOrder
add constraint CK_tbOrder_OrderDate check (OrderDate between '2000-01-01' and getdate())
go

alter table tblUser
add constraint UN_tblUser_UserName unique (UserName)
go

---view table
select * from tblUser
select * from tblProduct
select * from tbOrder
select * from tblOrderDetail
go

--insert data
 insert into tblUser (UserId, UserName, BirthDate)
 values
 (1, 'SteveJob', '1996-08-28'),
 (2, 'BillGate', '1998-06-18'),
 (3, 'Larry', '1997-05-25'),
 (4, 'mark', '1984-03-27'),
 (5, 'Dell', '1955-08-15'),
 (6, 'Eric', '1955-07-28')
 go

insert into tblProduct(ProductId, ProductName, Quanlity, Price, Description)
values
(1, 'Asus Zen', 2, 10, 'See What others can''t see'),
(2, 'Bphpne', 10, 20, 'The first flat=design...'),
(3, 'Iphone', 13, 300, 'The only Thing...'),
(4, 'Xperia', 7, 80, 'The world''s ...'),
(5, 'Galaxy Note', 12, 120, 'Created to ...')
go

insert into tbOrder(OrderId, UserID, OrderDate)
values
(1, 2, '2002-12-01'),
(2, 3, '2000-03-02'),
(3, 2, '2004-08-03'),
(4, 1, '2001-05-12'),
(5, 4, '2002-10-04'),
(6, 6, '2002-03-08'),
(7, 5, '2002-05-02')
go

insert into tblOrderDetail(OrderId, ProductId, Quantity, Price)
values
(1, 1, 10, 10),
(1, 2, 4, 20),
(2, 3, 5, 50),
(3, 3, 6, 8),
(4, 2, 21, 120),
(5, 2, 122, 300)
go

---view table
select * from tblUser
select * from tblProduct
select * from tbOrder
select * from tblOrderDetail
go

---Query Operation
update tblProduct set  Price = 0.9 * Price where ProductId =3 
go

select tblUser.UserId, tblUser.UserName, tbOrder.OrderId, tbOrder.OrderDate, tblOrderDetail.Quantity, tblOrderDetail.Price, tblProduct.ProductName
from tblUser, tbOrder, tblOrderDetail, tblProduct
where tblUser.UserId = tbOrder.UserID
	and tbOrder.OrderId = tblOrderDetail.OrderId
	and tblOrderDetail.ProductId = tblProduct.ProductId
go

--view
create view view_Top2Product
as
select top (2) tblProduct.ProductId, tblProduct.ProductName, tblProduct.Price,  Sum(tblOrderDetail.Quantity) 'Total Quantity'
from tblProduct, tblOrderDetail
where tblProduct.ProductId = tblOrderDetail.ProductId
group by tblProduct.ProductId, tblProduct.ProductName, tblProduct.Price 
order by Sum(tblOrderDetail.Quantity) desc
go

drop view view_Top2Product
go

select * from view_Top2Product
go

--store/proc
create proc sp_TimSanPham
	@Giamua money,
	@Count int output
as
begin
	select tblProduct.ProductId, tblProduct.ProductName, tblProduct.Quanlity, tblProduct.Price, tblProduct.Description
	from tblProduct
	where tblProduct.Price <=  @Giamua

	select @Count = count(*) from tblProduct
	where tblProduct.Price <=  @Giamua
end
go

declare @Count int
exec sp_TimSanPham 50, @Count = @Count output
print N'Tim thay'  +  convert(nvarchar, @Count) + 'San Pham'
go

---trigger update price <10
create trigger Tg_tblProduct_Update on tblProduct
for update
as
begin
	if (select count(*) from inserted where Price <10) >0
	begin
	print N'You don''t update price less than 10'
	rollback transaction
	end

end
go

select * from tblProduct
go

drop trigger Tg_tblProduct_Update
go

--Trigger update Username
select * from tblUser
go

create trigger Tg_tblUser_Update on tblUser
for update
as
	if update (Username)
begin
	print N'You don''t update this column UserNane'
	rollback transaction
end
go

update tblUser set UserName = 'AA' where UserID = 1