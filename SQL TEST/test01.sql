--csdl
create database test_01
go

use test_01
go

--table
create table Travels1(
	trid1 int not null,
	nametr1 varchar(100) not null,
	price float,
	days int not null,
	catId1 int not null,
	startdate datetime
)
go

create table Categories1(
	catId1 int not null,
	catname1 varchar(100) not null,
	counts1 int
)
go

--Constraints
alter table Travels1
add constraint pk_trid1 primary key (trid1)
go

alter table Categories1
add constraint pk_catId1 primary key (catId1)
go

alter table Travels1
add constraint fk_Travels1_Categories1 foreign key (catId1) references Categories1 (catId1)
go

alter table Travels1
add constraint check_days check (days between 0 and 15)
go

alter table Travels1
add constraint un_name unique (nametr1)
go

alter table Travels1
add constraint def_startdate default getdate() for startdate
go

--insert
insert into Categories1(catId1, catname1)
values
(100, 'beaches'),
(200, 'family travel'),
(300, 'food and drink'),
(400, 'skiing')
go

insert into Travels1 (trid1, nametr1, price, days, catId1, startdate)
values
(10, 'manele bay, hawaii', 200, 2, 100, '2011-04-30'),
(11, 'hilton waikoloa village', 250, 4, 200, '2011-04-16'),
(12, 'clearwater beach, florida', 300, 7, 100, '2011-02-11'),
(13, 'sandwich paradise', 180, 2, 300, '2011-01-10'),
(14, 'cape may, new jersey', 380, 4, 100, '2011-01-18')
go

-- view table
select * from Travels1
select * from Categories1
go

-- queries
--select sQL
select Categories1.catId1, Categories1.catname1 'category', count(Travels1.catId1) 'quantity'
from Categories1 left join Travels1 on Categories1.catId1 = Travels1.catId1
group by Categories1.catId1, Categories1.catname1
order by 'quantity' desc
go

--view
create view view_quantity_travels
as
select Categories1.catId1, Categories1.catname1 'category', count(Travels1.catId1) 'quantity'
from Categories1 left join Travels1 on Categories1.catId1 = Travels1.catId1
group by Categories1.catId1, Categories1.catname1
go

select * from view_quantity_travels
order by  quantity desc
go

--update
update Categories1
set Categories1.counts1 = view_quantity_travels.quantity
from Categories1 left join view_quantity_travels on Categories1.catId1 = view_quantity_travels.catId1
go

select * from Categories1
go

update Travels1
set Travels1.price = Travels1.price * 1.1
from Categories1 left join Travels1 on Categories1.catId1 = Travels1.catId1
where Categories1.catname1 = 'food and drink' or Travels1.days >5
go

select * from Travels1
go

--trigger
--7.1
create trigger tg_travels_update on Travels1
for update
as
begin
	if(select count(*) from inserted where price <= 0) >0
		begin
		print N'Travel tour''s price must be greater than zero'
		rollback transaction
		end
end
go

update Travels1
set price = -100 where catId1 = 100
go

--7.2
create trigger tg_travels_delete on Travels1
after delete
as
begin
	update Categories1
	set Categories1.counts1 = view_quantity_travels.quantity
	from Categories1 left join view_quantity_travels on Categories1.catId1 = view_quantity_travels.catId1
end
go

delete Travels1 
where nametr1 ='manele bay, hawaii'
go

select * from Categories1
go

--7.3
create trigger tg_travels_insert on Travels1
for insert
as
begin
	if(select count(*) from inserted where startdate < getdate() ) >0

	begin
	print N'Travel tour''s startdate must be after the current date'
	rollback transaction
	end

end
go

insert into Travels1 (trid1, nametr1, price, days, catId1, startdate)
values
(15, 'manele bay, hawaii', 200, 3, 200, '2011-05-15')
go





