--csdl
create database Travel_Management_Testmodum
go

use Travel_Management_Testmodum
go

--table
create table Travelss(
	trID int not null,
	name varchar(100) not null,
	price float,
	days int not null,
	catID int not null,
	startdate datetime
)
go

create table Categoriess(
	catID int not null,
	catname varchar(100) not null,
	counts int
)
go

-- constraint
alter table Travelss
add constraint pk_trID_Travelss primary key (trID)
go

alter table Categoriess
add constraint pk_catID_Categoriess primary key (catID)
go

alter table Travelss
add constraint fk_catID_Travelss foreign key (catID) references Categoriess (catID)
go

alter table Travelss
add constraint check_days_Travelss check (days between 0 and 15)
go

alter table Travelss
add constraint un_name_Travelss unique (name)
go

alter table Travelss
add constraint def_stardate_Travelss default getdate() for startdate
go

--insert 
insert into Categoriess(catID, catname)
values
(100, 'Beach'),
(200, 'Family Travel'),
(300, 'Food and Drink'),
(400, 'Skiing')
go

insert into Travelss (trID, name, price, days, catID, startdate)
values
(10, 'Manele Bay, Hawaii', 200, 2, 100, '2011-04-30'),
(11, 'Hilton Waikoloa Village', 250, 4, 200, '2011-04-16'),
(12, 'Clearwater Beachm Florida', 300, 7, 100, '2011-02-11'),
(13, 'Sandwich Paradise', 180, 2, 300, '2011-01-10'),
(14, 'MCape may, New Jeesey', 380, 4, 100, '2011-01-18')
go

---view table
select * from Categoriess
select * from Travelss
go

--Select Queries
--select SQL
select Categoriess.catID, Categoriess.catname as 'Category', count(Travelss.catID) 'Quantity'
from Categoriess, Travelss
where Categoriess.catID = Travelss.catID
group by Categoriess.catID, Categoriess.catname
order by 'Quantity' desc
go

--view select
create view view_quantity_Travelss
as
select Categoriess.catID, Categoriess.catname as 'Category', count(Travelss.catID) 'Quantity'
from Categoriess, Travelss
where Categoriess.catID = Travelss.catID
group by Categoriess.catID, Categoriess.catname
go

select * from view_quantity_Travelss
order by 'Quantity' desc
go

-- update
update Categoriess 
set Categoriess.counts = view_quantity_Travelss.Quantity
from Categoriess left join view_quantity_Travelss on Categoriess.catID = view_quantity_Travelss.catID
go

select * from Categoriess
go

update Travelss
set Travelss.price = Travelss.price * 1.1
from Travelss left join Categoriess on Travelss.catID = Categoriess.catID
where Travelss.days >5 or Categoriess.catname = 'Food and Drink'
go

select * from Travelss
go

--trigger
--7.1
create trigger TG_Travels_Update on Travelss
for update
as
begin
	if(select count(*) from inserted where price <=0) >0

	begin
	print N'Travel tour’s price must be greater than zero !'
	rollback transaction
	end
	
end
go

update Travelss
set price =-10 where trID = 11
go

--7.2
create trigger TG_Travels_Delete on Travelss
after delete
as
begin
	update Categoriess 
	set Categoriess.counts = view_quantity_Travelss.Quantity
	from Categoriess left join view_quantity_Travelss on Categoriess.catID = view_quantity_Travelss.catID
end
go

delete Travelss 
where name = 'Manele Bay, Hawaii'
go

select * from Categoriess
go

--7.3
create trigger TG_Travels_Insert on Travelss
for insert
as
begin
	if(select count(*) from inserted where startdate < getdate() ) >0

	begin
		print N'Travel tour’s startdate must be after the current date.'
		rollback transaction
	end

end
go

insert into Travelss (trID, name, price, days, catID, startdate)
values
(15, 'aaaaaaa', 300, 3, 400, '2022-02-16 07:16:00')
go

--END!!!