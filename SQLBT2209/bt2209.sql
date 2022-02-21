-- CSDL Sở thú Zoo
create database Zoo_2209
go

use Zoo_2209
go

-- table
create table Room(
	id int,
	name nvarchar(20),
	max int
)
go

create table Animal(
	id int,
	name nvarchar(50),
	age int,
	buy_at datetime,
	room_id int
)
go

create table FoodType(
	id int,
	name nvarchar(50),
	price float,
	amount float
)
go

create table FoodAnimal(
	food_id int,
	animal_id int
)
go

-- tao pk và fk 
alter table Room
add constraint pk_room primary key (id)
go

alter table Animal
add constraint pk_animal primary key (id)
go

alter table FoodType
add constraint pk_FoodType primary key (id)
go

alter table FoodAnimal
add constraint pk_FoodAnimal primary key (id)
go

alter table Animal
add constraint fk_room_id foreign key (room_id) references Room (id)
go

alter table FoodAnimal
add constraint fk_fa_animal_id foreign key (animal_id) references Animal (id)
go

lter table FoodAnimal
add constraint fk_fa_food_id foreign key (food_id) references FoodType (id)
go

--test
select * from Room
select * from Animal
select * from FoodType
select * from FoodAnimal
go

-- insert
insert into Room(id, name, max)
values
(1, 'R01', 5),
(2, 'R02', 15),
(3, 'R03', 2),
(4, 'R04', 25),
(5, 'R05', 50)
go

insert into FoodType(id, name, price, amount)
values
(1, 'F01', 11, 100),
(2, 'F02', 10, 80),
(3, 'F03', 21, 30),
(4, 'F04', 100, 1000),
(5, 'F05', 101, 200)
go

insert into Animal(id, name, age, buy_at, room_id)
values
(1, 'A01', 1, '2021-05-19', 1),
(2, 'A02', 2, '2020-05-12', 1),
(3, 'A03', 5, '2021-11-16', 2),
(4, 'A04', 1, '2021-08-09', 2),
(5, 'A05', 2, '2021-06-29', 2)
go

insert into FoodAnimal (animal_id, food_id)
values
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 2),
(5, 1)
go

--  Xem thông tin động vật gồm các trường sau: tên chuồng, tên động vật, tuổi, ngày mua về
select Animal.name 'Ten Dong Vat', Animal.age 'Tuoi', Animal.buy_at 'Ngay Mua', Room.name 'Ten Chuong'
from Animal left join Room on Animal.room_id = Room.id
go

-- Xem thông tin những chuồng có số động vật đang lưu vượt quá max của chuồng đó
select Room.name 'Ten Chuong', Room.max 'So Luong Toi Da', count(Animal.id) 'So Dong Vat'
from Room left join Animal on Room.id = Animal.room_id
group by Room.name, Room.max
order by 'So Dong Vat' desc

update Room set max = 2 where id = 2

select Room.name 'Ten Chuong', Room.max 'So Luong Toi Da', count(Animal.id) 'So Dong Vat'
from Room left join Animal on Room.id = Animal.room_id
group by Room.name, Room.max
having count(Animal.id) > Room.max
order by 'So Dong Vat' desc

-- Xem thông tin những chuồng còn so khả năng lưu thêm động vật vào
select Room.name 'Ten Chuong', Room.max 'So Luong Toi Da', count(Animal.id) 'So Dong Vat'
from Room left join Animal on Room.id = Animal.room_id
group by Room.name, Room.max
having count(Animal.id) < Room.max
order by 'So Dong Vat' desc

-- Viết proc có tham số là @animalId -> cho phép xem được thông tin loại thức ăn của động vật này.
select Animal.name 'Ten Dong Vat', FoodType.name 'Ten Thuc An'
from Animal left join FoodAnimal on Animal.id = FoodAnimal.animal_id
	left join FoodType on FoodType.id = FoodAnimal.food_id

create proc proc_view_food_animal
	@animalId int
as
begin
	select Animal.name 'Ten Dong Vat', FoodType.name 'Ten Thuc An'
	from Animal left join FoodAnimal on Animal.id = FoodAnimal.animal_id
		left join FoodType on FoodType.id = FoodAnimal.food_id
	where Animal.id = @animalId
end

exec proc_view_food_animal 1
exec proc_view_food_animal 2