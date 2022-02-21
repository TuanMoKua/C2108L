--csdl
create database test02
go

use test02
go

-- table
create table quanhuyen1(
	maqh1 int identity(1, 1) not null,
	tenqh1 nvarchar(100)
)
go

create table duong_pho1(
	duongid1 int not null,
	maqh1 int not null,
	tenduong1 nvarchar(max) not null,
	date_duyet datetime
)
go

create table nha_tren_pho1 (
	nhaid1 int not null,
	duongid1 int not null,
	chuho1 nvarchar(50),
	dientich1 money
)
go

--index
create clustered index cl_nha_tren_pho1_QH on nha_tren_pho1 (nhaid1)
go

create unique nonclustered index ul_qh_tenqh1 on quanhuyen1 (tenqh1)
go

alter table nha_tren_pho1
add sonhankhau int
go

select * from nha_tren_pho1
go

--constraint
alter table quanhuyen1
add constraint pk_quanhuyen1 primary key (maqh1)
go

alter table duong_pho1
add constraint pk_duongpho1 primary key (duongid1)
go

alter table nha_tren_pho1
add constraint pk_nhatrenpho1 primary key (nhaid1)
go

alter table nha_tren_pho1
add constraint fk_nhatrenpho1_dgpho foreign key (duongid1) references duong_pho1 (duongid1)
go

alter table duong_pho1
add constraint fk_dgpgo_quanhuyen1  foreign key (maqh1) references quanhuyen1 (maqh1)
go

alter table duong_pho1
add constraint check_dgpho_ngayduyetten check (date_duyet between '1945-09-02' and getdate() )
go

--view table
select * from quanhuyen1
select *from duong_pho1
select *  from nha_tren_pho1
go

--insert table
insert into quanhuyen1(tenqh1)
values
('Ba Dinh'),
('Hoang mai')
go

insert into duong_pho1(duongid1, maqh1, tenduong1, date_duyet)
values
(1, 1, 'Doi Can', '1946-10-19'),
(2, 1, 'Van Phuc', '1998-11-30'),
(3, 2, 'giai toa', '1975-09-21')
go

insert into nha_tren_pho1(nhaid1, duongid1, chuho1, dientich1, sonhankhau)
values
(1, 1, 'Ha Khanh Toan', 100, 4),
(2, 1, 'Le hong hai',20, 12),
(3, 2, 'Tran Khanh', 40, 1)
go

--update basic
update duong_pho1
set tenduong1 = 'Giai phong' where duongid1 = 3
go

--view
create view vw_all_nhatrenpho1
as
select quanhuyen1.tenqh1 'TenQH', duong_pho1.tenduong1 'Ten Duong', duong_pho1.date_duyet 'Ngay duyet', nha_tren_pho1.chuho1 'Chu ho',
nha_tren_pho1.dientich1 'Dientich', nha_tren_pho1.sonhankhau
from quanhuyen1, duong_pho1, nha_tren_pho1
where quanhuyen1.maqh1 = duong_pho1.maqh1 and duong_pho1.duongid1 = nha_tren_pho1.duongid1
go

select * from vw_all_nhatrenpho1
go

--view2
create view vw_avg_nhatrenpho1
as
select duong_pho1.tenduong1 'Ten Duong', avg(nha_tren_pho1.dientich1) 'DIen tich trung binh', avg(nha_tren_pho1.sonhankhau) 'Nhan Khau trung binh'
from duong_pho1 left join nha_tren_pho1 on duong_pho1.duongid1 = nha_tren_pho1.duongid1
group by duong_pho1.tenduong1
go

alter view vw_avg_nhatrenpho1
as
select duong_pho1.tenduong1 'Ten Duong', avg(nha_tren_pho1.dientich1) 'DIen tich trung binh', avg(nha_tren_pho1.sonhankhau) 'Nhan Khau trung binh'
from duong_pho1 right join nha_tren_pho1 on duong_pho1.duongid1 = nha_tren_pho1.duongid1
group by duong_pho1.tenduong1
go

select * from vw_avg_nhatrenpho1
order by 'DIen tich trung binh' asc
go

--proc
create procedure sp_ngayduyetten_dgpho1 
	@ngayduyet1 datetime
as
begin
	select duong_pho1.date_duyet 'Ngay duyet ten', duong_pho1.tenduong1 'Ten Duong', quanhuyen1.tenqh1 'Ten QH'
	from duong_pho1, quanhuyen1 where duong_pho1.maqh1 = quanhuyen1.maqh1
	 and duong_pho1.date_duyet = @ngayduyet1
end
go

exec sp_ngayduyetten_dgpho1 '1998-11-30 00:00:00'
go

--trigger
create trigger trigger_for_update_nha_tren_pho1 on nha_tren_pho1
for update
as
begin
	if(select  count(*) from inserted where sonhankhau <=0) >0
	begin
	print N'So nhan khau yeu cau >0'
	rollback transaction
	end
end
go

update nha_tren_pho1 set sonhankhau =0 where nhaid1 =1
go

create trigger trigger_insteadof_delete_dgpho on duong_pho1
instead of delete
as
begin
	-- xoa fk bang 
	delete from nha_tren_pho1 where duongid1 in (select duongid1 from deleted)
	--xoa bang chinh
	delete from duong_pho1 where duongid1 in (select duongid1 from deleted)

end
go



