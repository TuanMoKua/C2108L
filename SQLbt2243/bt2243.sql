--csdl FIfa 
create database Management_Fifa_2243
go

use Management_Fifa_2243
go

--Table
create table Ql_Trong_tai(
	id_trongtai int primary key identity(1, 1),
	Full_name nvarchar(50) not null,
	Address nvarchar(200) not null,
	Level float,
	exp_checkin date
)
go

create table History_Trong_tai(
	id_history int primary key identity(1, 1),
	id_trongtai int,
	giai_dau nvarchar(100) not null,
	begin_day date,
	rate float,
	id_club_1 int,
	id_club_2 int,
	Note_history nvarchar(500)
)
go

create table Club_footbal(
	id_club int primary key identity(1, 1),
	Name_club nvarchar(50),
	Home_stadium nvarchar (100),
	Coach nvarchar (50)
)
go

create table Player(
	id_player int primary key identity(1, 1),
	Fullname_player nvarchar(50),
	Birthday date,
	Salary_week money,
	begin_play date
)
go

create table infor_club_player(
	id_club int,
	id_player int,
	Ngay_tham_gia date
)
go

-- Tạo fk_key
alter table History_Trong_tai
add constraint fk_id_club_1 foreign key (id_club_1) references Club_footbal (id_club)
go

alter table History_Trong_tai
add constraint fk_id_club_2 foreign key (id_club_2) references Club_footbal (id_club)
go

alter table History_Trong_tai
add constraint fk_id_trongtai foreign key (id_trongtai) references Ql_Trong_tai (id_trongtai)
go

alter table infor_club_player
add constraint fk_id_club_infor foreign key (id_club) references Club_footbal (id_club)
go

alter table infor_club_player
add constraint fk_id_player_infor foreign key (id_player) references Player (id_player)
go

--test 
select * from Ql_Trong_tai
select * from History_Trong_tai
select * from Club_footbal
select * from Player
select * from infor_club_player
go

--insert DL
insert into Ql_Trong_tai (Full_name, Address, Level, exp_checkin)
values
('Alex A', '225 Stres West', 10, '2000-10-10'),
('Tran Dang K', 'Ha Noi', 8, '2001-09-01'),
('Nguyen Van B', 'Sai Gon', 9, '2001-06-10'),
('Hoang Van C', '225 Stres West', 7, '2003-05-10'),
('Le Van D', '225 Stres West', 8, '2005-08-10')
go

insert into History_Trong_tai(id_trongtai, giai_dau, begin_day, rate, id_club_1, id_club_2, Note_history)
values
(1, 'AFF', '2021-11-10', 8, 2, 3,'Bang C'),
(3, 'VPF Vong 8', '2021-11-15', 9, 1, 4,'Vong 8 Giai VPF'),
(2, 'AFF', '2020-11-20', 7, 5, 4,'Bang D'),
(4, 'AFF', '2020-11-25', 9, 4, 3,'Ban Ket'),
(5, 'AFF', '2020-11-30', 10, 1, 5,'Ban ket')
go

insert into Club_footbal(Name_club, Home_stadium, Coach)
values
('Super A', 'Stadium A', 'Mr.Smith'),
('Super B', 'Stadium B', 'Mr.Kol'),
('Super C', 'Stadium C', 'Mr.Gizmul'),
('Super D', 'Stadium D', 'Mr.Power'),
('Super E', 'Stadium E', 'Mr.Ole')
go

insert into Player(Fullname_player, Birthday, Salary_week, begin_play)
values
('Hoang Van K', '1995-05-08', '800', '2015-05-08'),
('Tran Van M', '1994-10-11', '1000', '2017-08-01'),
('Nguyen Van D', '1996-03-08', '900', '2018-09-10'),
('Hoang M', '1998-10-20', '500', '2020-06-08'),
('Nguyen Cong P', '1993-09-02', '1200', '2010-10-10')
go

insert into infor_club_player(id_club, id_player, Ngay_tham_gia)
values
(1, 2, '2018-05-08'),
(2, 4, '2020-09-08'),
(5, 3, '2019-10-10'),
(4, 1, '2017-11-12'),
(2, 2, '2020-05-08')
go

-- tesst
select * from Ql_Trong_tai
select * from History_Trong_tai
select * from Club_footbal
select * from Player
select * from infor_club_player
go

-- tim kiem theo yeu cau
---- tim kiem co ban

select Ql_Trong_tai.Full_name as 'Ten Trong Tai', Ql_Trong_tai.Level, Ql_Trong_tai.exp_checkin, History_Trong_tai.giai_dau, DB1.Name_club as ' Doi Bong 1', DB2.Name_club as 'Doi Bong 2'
from Ql_Trong_tai left join History_Trong_tai on Ql_Trong_tai.id_trongtai = History_Trong_tai.id_trongtai
	left join Club_footbal DB1 on DB1.id_club = History_Trong_tai.id_club_1
	left join Club_footbal DB2 on DB2.id_club = History_Trong_tai.id_club_2
go

create view view_History_Club
as
select Ql_Trong_tai.Full_name as 'Ten Trong Tai', Ql_Trong_tai.Level, Ql_Trong_tai.exp_checkin, History_Trong_tai.giai_dau, DB1.Name_club as ' Doi Bong 1', DB2.Name_club as 'Doi Bong 2'
from Ql_Trong_tai left join History_Trong_tai on Ql_Trong_tai.id_trongtai = History_Trong_tai.id_trongtai
	left join Club_footbal DB1 on DB1.id_club = History_Trong_tai.id_club_1
	left join Club_footbal DB2 on DB2.id_club = History_Trong_tai.id_club_2

go

select * from view_History_Club
go

select Club_footbal.Name_club, Player.Fullname_player as 'Ten Cau Thu', infor_club_player.Ngay_tham_gia
from Club_footbal left join infor_club_player on Club_footbal.id_club = infor_club_player.id_club
		left join Player on Player.id_player = infor_club_player.id_player
order by Club_footbal.Name_club asc
go

create view view_thongtin_cauthu
as
select Club_footbal.Name_club, Player.Fullname_player as 'Ten Cau Thu', infor_club_player.Ngay_tham_gia
from Club_footbal left join infor_club_player on Club_footbal.id_club = infor_club_player.id_club
		left join Player on Player.id_player = infor_club_player.id_player
go

select * from view_thongtin_cauthu
order by Name_club asc
go


create proc proc_ind_lichsu
		@club_id int
as
begin
	select Ql_Trong_tai.Full_name as 'Ten Trong Tai', Ql_Trong_tai.Level, Ql_Trong_tai.exp_checkin, History_Trong_tai.giai_dau, DB1.Name_club as ' Doi Bong 1', DB2.Name_club as 'Doi Bong 2'
	from Ql_Trong_tai left join History_Trong_tai on Ql_Trong_tai.id_trongtai = History_Trong_tai.id_trongtai
			left join Club_footbal DB1 on DB1.id_club = History_Trong_tai.id_club_1
			left join Club_footbal DB2 on DB2.id_club = History_Trong_tai.id_club_2
	where DB1.id_club = @club_id or DB2.id_club = @club_id 
end

exec proc_ind_lichsu 1
exec proc_ind_lichsu 3

