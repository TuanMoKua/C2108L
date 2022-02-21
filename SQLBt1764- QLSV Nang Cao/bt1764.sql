--csdl Sinh_vien
create database Sinh_Vien_1764
go

use Sinh_Vien_1764
go

--table
create table Students (
	roll_no int primary key,
	ho_ten nvarchar (30),
	tuoi int,
	dia_chi nvarchar(50),
	email nvarchar (50),
	So_dien_thoai nvarchar(16),
	Gioi_tinh nvarchar(15)
)
go

create table Subjects(
	Subjects_id int primary key,
	Subjects_name nvarchar (20)
)
go

create table bang_diem_mon_hoc(
	mark_sub int,
	roll_no int,
	Subjects_id int
)
go

create table Lop_hoc(
	id_lophoc nvarchar(10) primary key,
	Ten_Lop_hoc nvarchar (20)
)
go


create table QL_Lop_hoc(
	id_lophoc nvarchar(10),
	roll_no int,
	primary key (id_lophoc, roll_no)
)
go

create table Phong_hoc(
	id_Phong_hoc nvarchar(10) primary key,
	Ten_phong_hoc nvarchar (20),
	sl_banhoc int,
	sl_ghehoc int,
	dia_chi_phong nvarchar(20)
)
go

create table Book_gio(
	id_lophoc nvarchar(10),
	Begin_at datetime,
	end_at datetime,
	id_Phong_hoc nvarchar(10)
)
go

-- Tạo fk_key table
alter table bang_diem_mon_hoc
add constraint fk_roll_no foreign key (roll_no) references Students (roll_no)
go

alter table bang_diem_mon_hoc
add constraint fk_Subjects_id foreign key (Subjects_id) references Subjects (Subjects_id)
go

alter table QL_Lop_hoc
add constraint fk_id_lophoc foreign key (id_lophoc) references Lop_hoc (id_lophoc)
go

alter table QL_Lop_hoc
add constraint fk_roll_no_ql foreign key (roll_no) references Students (roll_no)
go

alter table Book_gio
add constraint fk_id_lophoc_book foreign key (id_lophoc) references Lop_hoc (id_lophoc)
go

alter table Book_gio
add constraint fk_id_Phong_hoc_book foreign key (id_Phong_hoc) references Phong_hoc (id_Phong_hoc)
go

--TEST
select * from Students
select * from Subjects
select * from Lop_hoc
select * from bang_diem_mon_hoc
select * from QL_Lop_hoc
select * from Phong_hoc
select * from Book_gio
go

--them du lieu vao bang
insert into Students(roll_no, ho_ten, tuoi, dia_chi, email, So_dien_thoai, Gioi_tinh)
values 
(101, 'Nguyen Thanh C', 22, 'Thach That', 'nguyenthanhc@gmail.com', '0902154514', 'Nam'),
(102, 'Hoang Thi B', 21, 'Nam Dinh', 'thib@gmail.com', '0912789546', 'Nu'),
(103, 'Tran Van A', 21, 'Thai Binh', 'tranvana@gmail.com', '0904564578', 'Nam'),
(104, 'Tran Van D', 23, 'Nam Dinh', 'd@gmail.com', '0985654525', 'Nam'),
(105, 'Nguyen Thi H', 20, 'Ha Noi', 'h@gmail.com', '0985647894', 'Nu')
go

insert into Subjects(Subjects_id, Subjects_name)
values
(22, 'Toan'),
(15, 'Ly'),
(11, 'Hoa'),
(20, 'Anh'),
(8, 'Ngu Van')
go

insert into bang_diem_mon_hoc(roll_no, Subjects_id, mark_sub)
values 
(101, 22, 8),
(102, 15, 6),
(103, 11, 9),
(104, 20, 7),
(105, 8, 7 ),
(103, 15, 7),
(103, 22, 8)
go

insert into Lop_hoc(id_lophoc, Ten_Lop_hoc)
values
('A1245', 'Chuyen Toan'),
('A8541', 'Chuyen Ly'),
('A2456', 'Chuyen Hoa'),
('A3845', 'Chuyen Anh'),
('A4578', 'Chuyen Van')
go

insert into QL_Lop_hoc(id_lophoc, roll_no)
values
('A1245', 101),
('A8541', 102),
('A2456', 103),
('A3845', 104),
('A4578', 105)
go

insert into Phong_hoc(id_Phong_hoc, Ten_phong_hoc, sl_banhoc, sl_ghehoc, dia_chi_phong)
values
('B145', 'C2115', 15, 12, 'Stage 1'),
('B143', 'C2116', 20, 20, 'Stage 1'),
('B224', 'C2020', 18, 18, 'Stage 2'),
('B350', 'C2021', 22, 20, 'Stage 3'),
('B412', 'C2022', 25, 22, 'Stage 4')
go

insert into Book_gio(id_lophoc, Begin_at, end_at, id_Phong_hoc)
values
('A1245', '2021-09-02 07:00:00', '2021-09-02 09:00:00', 'B145'),
('A8541', '2021-10-02 08:00:00', '2021-10-02 11:00:00', 'B143'),
('A2456', '2021-08-03 07:30:00', '2021-08-03 09:30:00', 'B224'),
('A3845', '2021-11-02 10:00:00', '2021-11-02 12:00:00', 'B350'),
('A4578', '2021-07-02 14:00:00', '2021-07-02 16:00:00', 'B412')
go

--TEST
select * from Students
select * from Subjects
select * from Lop_hoc
select * from bang_diem_mon_hoc
select * from QL_Lop_hoc
select * from Phong_hoc
select * from Book_gio
go

-- tim kiem theo yc
select * from Students
where dia_chi = 'Nam Dinh'
go

select * from Lop_hoc
where id_lophoc like '%A8%'
go

select Students.roll_no as 'MSSV', Students.ho_ten as 'Tên Sv', bang_diem_mon_hoc.mark_sub as 'Điểm thi' 
from Students left join bang_diem_mon_hoc on Students.roll_no = bang_diem_mon_hoc.roll_no
where Students.ho_ten = 'Tran Van A'
group by Students.roll_no, Students.ho_ten, bang_diem_mon_hoc.mark_sub
go

select Students.roll_no as 'MSSV', Students.ho_ten as 'Tên Sv', bang_diem_mon_hoc.mark_sub as 'Điểm thi' 
from Students left join bang_diem_mon_hoc on Students.roll_no = bang_diem_mon_hoc.roll_no
group by Students.roll_no, Students.ho_ten, bang_diem_mon_hoc.mark_sub
go

select Students.roll_no as 'MSSV', Students.ho_ten as 'Tên Sv', bang_diem_mon_hoc.mark_sub as 'Điểm thi', Subjects.Subjects_name as 'Ten mon học'
from bang_diem_mon_hoc left join Students on Students.roll_no = bang_diem_mon_hoc.roll_no
	left join Subjects on Subjects.Subjects_id = bang_diem_mon_hoc.Subjects_id
group by Students.roll_no, Students.ho_ten, bang_diem_mon_hoc.mark_sub, Subjects.Subjects_name
go








               

                             