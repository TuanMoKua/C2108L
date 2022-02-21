---csdl
create database Travel_Management
go

use Travel_Management
go

---table
create table Travels(
	trID int not null,
	name nvarchar(100) not null,
	price float,
	days int not null,
	catID int not null,
	startdate datetime
)
go

create table Categories(
	catID int not null,
	catname nvarchar(100),
	counts int
)
go


-- Constraint
alter table Travels
add constraint pk_trID primary key (trID)
go

alter table Categories
add constraint pk_catID primary key (catID)
go

alter table Travels
add constraint fk_catID_Travels foreign key (catID) references Categories (catID)
go

alter table Travels
add constraint check_days_Travels check (days between 0 and 15)
go

alter table Travels
add constraint ui_name_Travels unique (name)
go

alter table Travels
add constraint def_startdate_Travels default getdate() for startdate
go

--View Table
select * from Travels
select * from Categories
go

-- insert table
insert into Categories (catID, catname)
values
(100, 'Beaches' ),
(200, 'Family Travel'),
(300, 'Food and Drink'),
(400, 'Skiing')
go

insert into Travels(trID, name, price, days, catID, startdate)
values
(10, 'Manele Bay, Hawaii', 200, 2, 100, '2011-04-30'),
(11, 'hilton Waikoloa Village', 250, 4, 200, '2011-04-16'),
(12, 'Clearwater Beach, Florida', 300, 7, 100, '2011-02-11'),
(13, 'Sandwich Paradise', 180, 2, 300, '2011-01-10'),
(14, 'Cape May New Jersey', 380, 4, 100, '2011-01-18')
go



-- Truy vấn Select 
-- Select SQL
select Categories. catID, Categories.catname 'Category', count(Travels.catID) 'Quantity'
from Categories join Travels on Categories.catID = Travels.catID
group by Categories. catID, Categories.catname
order by 'Quantity' desc
go

--select view
create view view_Categories_quantity
as
select Categories. catID, Categories.catname 'Category', count(Travels.catID) 'Quantity'
from Categories   left join Travels on Categories.catID = Travels.catID
group by Categories. catID, Categories.catname
go

select *from view_Categories_quantity
order by 'Quantity' desc
go

--Q6 Update=
update Categories set Categories.counts = view_Categories_quantity.Quantity
from Categories left join view_Categories_quantity  on Categories.catID = view_Categories_quantity.catID
go

select * from Categories
go

update Travels set Travels.price = 1.1*Travels.price
from Travels left join Categories on Travels.catID = Categories.catID
where Categories.catname = 'Food and Drink' or Travels.days >5
go

select * from Travels
go


--trigger update
create trigger Tg_Travels_update on Travels
for update
as
begin
	if(select count(*) from  inserted where price <=0)>0
	begin
		print N'Loi va Khong cho phep cap nhat'
		rollback transaction
	end
end
go

update Travels set price = 0 where trID =10
go


-- trigger delete 7-2

create trigger TG_Travels_Delete on Travels
after delete
as
begin
	update Categories
	set counts = view_Categories_quantity.Quantity
	from Categories
	left join view_Categories_quantity on Categories.catID = view_Categories_quantity.catID 
end
go

delete from Travels where name = 'Manele Bay, Hawaii'
go

select * from Categories
go


--trigger 7-3
create trigger TG_Travels_inserted on Travels
for insert
as
begin
	if (select count(*) from inserted where startdate < getdate() ) >0
	begin
		print N'Travel tour ’ s startdate must be after the current date'
		rollback transaction
	end
end
go


insert into Travels(trID, name, price, days, catID, startdate)
values
(16, 'ASAS Bay, Hawaii', 200, 3, 100, '2012-04-30')
go



