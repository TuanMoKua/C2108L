--CSDL BT2137
create database Bt2137
go

use Bt2137
go

--table
create table Music_Type(
	type_id int primary key identity(1, 1),
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go

create table Album(
	album_id varchar(20) primary key,
	Title nvarchar(100) not null,
	type_id int,
	Artists nvarchar(100),
	Rate int
)
go

create table Song(
	Song_id int primary key identity(1, 1),
	album_id nvarchar(20),
	Song_title nvarchar(200),
	Artists nvarchar(50),
	Author nvarchar(50),
	Hits int
)
go

alter table Song
alter column album_id varchar(20)
go


--Index và fk, check
---index
create index IX_SongTitle on Song (Song_title)
go

create index IX_Artists on Album (Artists)
go

---fk
alter table Album
add constraint fk_type_id foreign key (type_id) references Music_Type (type_id)
go

alter table Song
add constraint fk_album_id foreign key (album_id) references Album (album_id)
go

--check
alter table Album
add constraint check_rate_album check (Rate between 0 and 5)
go

alter table Song
add constraint check_hits_song check (Hits >=0)
go

---insert table
insert into Music_Type(Name, Description)
values
('Balad', 'Country Style'),
('Pop', 'US Uk Style'),
('Rock', 'Street Style')
go

insert into Album(album_id, type_id, Title, Artists, Rate)
values
(1, 2, 'Goodbye Swallow', 'Taylor Swith', 5),
(2, 1, 'The Light', 'Marron5', 4),
(3, 3, 'In The End', 'LinkinPark', 5)
go

insert into Song(album_id, Song_title, Artists, Author, Hits)
values
(1, 'Romatic', 'Taylor Swith', 'Arthur', 1000),
(2, 'Country', 'Marron5', 'Marron5', 300),
(3, 'Rock', 'LinkinPark', 'LinkinPark', 200)
go

--view table
select * from Music_Type
select * from Song
select * from Album
go

--find 
-- rate 5 in album
select * from Album
where Rate = 5
go

--Goodbye Swallow
select Song.Song_title 'Title of Song', Song.Artists, Song.Author, Song.Hits, Album.Title 'Title of Album'
from Song, Album
where Song.album_id = Album.album_id 
	and Album.Title = 'Goodbye Swallow'
go

-- View
create view view_v_Albums
as
select Album.album_id, Album.Title, Album.Rate, Music_Type.Name, Music_Type.Description
from Album left join Music_Type on Album.type_id = Music_Type.type_id
go

select * from view_v_Albums
go

create view view_v_TopSongs
as 
select * from Song
go

alter  view view_v_TopSongs
as
select Song_title, Artists, Author, Hits from Song
go

select * from view_v_TopSongs
order by Hits desc
go

--view table
select * from Music_Type
select * from Song
select * from Album
go


--Store/proc
create proc proc_sp_SearchByArtits
	@nameSinger nvarchar(50)
as
begin
	select Song.Song_title 'Title of Song', Song.Artists, Song. Author, Song.Hits, Album.Title, Album.Artists, Album.Rate
	from Song left join Album on Song.album_id = Album.album_id
	where Song.Artists = @nameSinger 
end
go

exec proc_sp_SearchByArtits 'Marron5'
go

create proc proc_sp_ChangeHits 
	@idSong int,
	@numberHits int
as
begin
	select Song.Song_title 'Title of Song', Song.Artists, Song. Author, Song.Hits, Album.Title, Album.Artists, Album.Rate
	from Song left join Album on Song.album_id = Album.album_id
	where Song.Song_id = @idSong and Song.Hits = @numberHits
end
go

exec proc_sp_ChangeHits 1, 1000
go

create trigger trigger_proc_sp_ChangeHits on Song
for update
as
begin
	if( select count(*) from inserted where Hits <0)>0
	begin
		print N'Khongf duoc cap nhat Hits <0'
		rollback transaction
		end
end
go

---END!!

