--csdl Quản lý nhân khẩu 
create database QL_Nhan_khau
go

use QL_Nhan_khau
go

-- table
create table Quan_huyen(
	ma_QH int not null identity(1, 1),
	Ten_QH nvarchar(100)
)
go

create table Duong_Pho(
	id_duong int not null,
	ma_QH int,
	Ten_duong nvarchar(max) not null,
	Ngay_duyet_ten datetime
)
go

create table Nha_tren_pho (
	id_nha int not null,
	id_duong int not null,
	Chu_ho nvarchar(50),
	Dien_tich money
)
go

-- Index & table
create clustered index CI_NhaTrenPho_NhaID on Nha_tren_pho (id_nha)
go

create unique nonclustered index UI_QuanHuyen_TenQH on Quan_huyen (Ten_QH)
go
-- update table
alter table Nha_tren_pho
add So_Hk int
go

--pk & fk
---pk
alter table Quan_huyen
add constraint pk_QUanHuyen primary key (ma_QH)
go

alter table Duong_Pho
add constraint pk_DuongPho primary key (id_duong)
go

alter table Nha_tren_pho
add constraint pk_NhaTrenPho primary key (id_nha)
go

--fk
alter table Nha_tren_pho
add constraint fk_NhaTrenPho_DuongPho foreign key (id_duong) references Duong_Pho (id_duong)
go

alter table Duong_Pho
add constraint fk_DuongPho_QuanHuyen foreign key (ma_QH) references Quan_huyen (ma_QH)
go

--check
alter table Duong_Pho
add constraint ck_DuongPho_NgayDuyetTen check (Ngay_duyet_ten between '1945-09-02' and '2020-12-30')
go

--view table
select * from Quan_huyen
select * from Duong_Pho
select * from Nha_tren_pho
go

--insert data
insert into Quan_huyen (Ten_QH)
values
('Ba Dinh'),
('Hoang Mai')
go

insert into Nha_tren_pho (id_nha, id_duong, Chu_ho, Dien_tich, So_Hk)
values
(1, 1, 'Ha Khanh Toan', 100, 4),
(2, 1, 'Le Hong Hai', 20, 12),
(3, 2, 'Tran Khanh', 40, 1)
go

insert into Duong_Pho(id_duong, ma_QH, Ten_duong, Ngay_duyet_ten)
values
(1, 1, 'Doi Can', '1946-10-19'),
(2, 1, 'Van Phuc', '1998-12-30'),
(3, 2, 'Giai Toa', '1975-09-21')
go

--view table
select * from Quan_huyen
select * from Duong_Pho
select * from Nha_tren_pho
go

--update sua thong tin
update Duong_Pho set Ten_duong = 'Giai Phong' where id_duong = 3
go

--truy van
--view
create view vv_all_Nha_Tren_Pho
as
select Quan_huyen.Ten_QH as 'Ten QH', Duong_Pho.Ten_duong as 'Ten Duong', Duong_Pho.Ngay_duyet_ten as 'Ngay Duyet Ten', Nha_tren_pho.Chu_ho as 'CHu Ho',  Nha_tren_pho.Dien_tich, Nha_tren_pho.So_Hk as 'So Nhan Khau'
from Duong_Pho left join Quan_huyen on Duong_Pho.ma_QH = Quan_huyen.ma_QH
	left join Nha_tren_pho on Duong_Pho.id_duong = Nha_tren_pho.id_duong
go

select * from vv_all_Nha_Tren_Pho
go

---
select  Duong_Pho.Ten_duong as 'Ten Duong', avg (Dien_tich) 'Dien Tich Trung Binh', avg(So_Hk) 'So Nhan Khau Trung Binh'
from Duong_Pho left join Nha_tren_pho on Duong_Pho.id_duong = Nha_tren_pho.id_duong
group by Duong_Pho.Ten_duong
go

create view vv_AVG_Nha_Tren_Pho
as
select  Duong_Pho.Ten_duong as 'Ten Duong', avg (Dien_tich) 'Dien Tich Trung Binh', avg(So_Hk) 'So Nhan Khau Trung Binh'
from Duong_Pho left join Nha_tren_pho on Duong_Pho.id_duong = Nha_tren_pho.id_duong
group by Duong_Pho.Ten_duong
go


select * from vv_AVG_Nha_Tren_Pho
order by   'Dien Tich Trung Binh', 'So Nhan Khau Trung Binh' desc
go

--proc
create proc proc_sp_NgayQuyetTen_DuongPho
	@ngayduyet datetime
as
begin
	select Duong_Pho.Ngay_duyet_ten as 'NgayQuyetTen', Duong_Pho.Ten_duong as 'TenDuong', Quan_huyen.Ten_QH as 'TenQH'
	from Duong_Pho left join Quan_huyen on Duong_Pho.ma_QH = Quan_huyen.ma_QH

	where Duong_Pho.Ngay_duyet_ten = @ngayduyet
end
go

exec proc_sp_NgayQuyetTen_DuongPho '1998-12-30'
go

--Trigger update
create trigger trigger_for_update_NHA_TREN_PHO on Nha_tren_pho
for update
as
begin
	if (select count(*) from inserted where So_Hk <= 0) > 0
	begin
		print N'Loi Khong The Update'
		rollback transaction
	end	
end
go

update Nha_tren_pho set So_Hk = 8 where id_nha = 1
go

--trigger Delete
create trigger trigger_insteadof_delete_DuongPho on Duong_Pho
instead of delete 
as
begin
	delete from Nha_tren_pho where id_duong in (select id_duong from deleted)

	delete from Duong_Pho where id_duong in (select id_duong from deleted)

end
go

delete from Duong_Pho where id_duong = 3
go

--view table
select * from Duong_Pho
go




