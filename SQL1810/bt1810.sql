--CSDL Bt1810 Điểm danh Aptech
create database Aptech_VN
go

use Aptech_VN
go

---Table
create table Student_aptech(
	Rollno nvarchar (16) not null,
	Name_Student nvarchar (50),
	Gender nvarchar(10),
	Birthday date,
	Address nvarchar(250),
	email nvarchar(200),
	phone_number nvarchar(16)
)
go

create table Teacher_Aptech(
	Ma_Giaovien nvarchar(16) not null,
	Name_teacher nvarchar(50),
	Birthday date,
	Gender nvarchar(10)
)
go

create table Subject_Aptech(
	Ma_monhoc nvarchar(16) not null,
	Name_Subject nvarchar(50),
	Tong_so_buoi_hoc int
)
go

create table Class_Aptech(
	ma_Class nvarchar(16) not null,
	Name_class nvarchar(50),
	Note nvarchar(50)
)
go

create table ClassMember(
	RollNo nvarchar(16),--fk vs Student_aptech
	Class_No nvarchar(16),--fk vs Class_Aptech(
	JoinedDate date,
	OutedDate date
)
go

create table Schedule(
	id int identity(1, 1),
	Ma_Giaovien nvarchar(16),  -- fk vs Teacher_Aptech 
	Ma_monhoc nvarchar(16),   -- fk vs Subject_Aptech
	ma_Class nvarchar(16),     --fk vs Class_Aptech(
	day_begin date,
	day_end date
)
go

create table Attendance(
	id int identity(1 , 1),
	Schedule_id int,
	RollNo nvarchar(16),
	ngay_diem_danh date,
	Attendance_1 int,
	Attendance_2 int,
	note nvarchar(50)
)
go

---PK & fk
--PK
alter table Student_aptech
add constraint pk_id_Student_aptech primary key (Rollno)
go

alter table Teacher_Aptech
add constraint pk_id_Teacher_Aptech primary key (Ma_Giaovien)

alter table Subject_Aptech
add constraint pk_id_Subject_Aptech primary key (Ma_monhoc)
go

alter table Class_Aptech
add constraint pk_id_Class_Aptech primary key (ma_Class)
go

alter table Schedule
add constraint pk_id_Schedule primary key (id)
go

alter table Attendance
add constraint pk_id_Attendance primary key (id)
go

--fk
alter table ClassMember
add constraint fk_RollNo_class foreign key (RollNo) references Student_aptech (Rollno)
go

alter table ClassMember
add constraint fk_Class_No_class foreign key (Class_No) references Class_Aptech (ma_Class)
go

alter table Schedule
add constraint fk_Ma_Giaovien_Schedule foreign key (Ma_Giaovien) references Teacher_Aptech (Ma_Giaovien)
go

alter table Schedule
add constraint fk_Ma_monhoc_Schedule foreign key (Ma_monhoc) references Subject_Aptech (Ma_monhoc)
go

alter table Schedule
add constraint fk_ma_Class_Schedule foreign key (ma_Class) references Class_Aptech (ma_Class)
go

alter table Attendance
add constraint fk_Schedule_id_Attendance foreign key (Schedule_id) references Schedule (id)
go

alter table Attendance
add constraint fk_RollNo_Attendance foreign key (RollNo) references Student_aptech (Rollno)
go


-- insert cac bang ko co fk truoc 
insert into Student_aptech (Rollno, Name_Student, Gender, Birthday, Address, email, phone_number)
values
('HS101', 'Nguyen Van A', 'Nam', '1996-10-10', 'Thai Binh', 'nva@gamil.com', '0904657895'),
('HS202', 'Nguyen Van B', 'Nam', '1996-05-10', 'Ha Noi', 'nvb@gamil.com', '0904657845'),
('HS303', 'Nguyen Van C', 'Nam', '1996-04-10', 'Nam Dinh', 'nvc@gamil.com', '0904657789'),
('HS404', 'Nguyen Van D', 'Nam', '1996-08-10', 'TThanh Hoa', 'nvd@gamil.com', '0904657564'),
('HS505', 'Nguyen Van E', 'Nam', '1996-11-10', 'Vinh Phuc', 'nve@gamil.com', '0904657365')
go

insert into Teacher_Aptech (Ma_Giaovien, Name_teacher, Gender, Birthday)
values
('GV1', 'Le Thi T', 'Nu', '1989-05-06'),
('GV2', 'Hoang Van Q', 'Nam', '1985-03-09'),
('GV4', 'Do Van K', 'Nam', '1990-08-08'),
('GV5', 'Nguyen Thi T', 'Nu', '1987-10-08')
go

insert into Teacher_Aptech (Ma_Giaovien, Name_teacher, Gender, Birthday)
values
('GV3', 'Tran Van A', 'Nam', '1988-07-08')
go

insert into Subject_Aptech (Ma_monhoc, Name_Subject, Tong_so_buoi_hoc)
values
('Math01', 'Toan', '15'),
('Phy01', 'Ly', '10'),
('Chem01', 'Hoa', '20'),
('NguVanh01', 'Van hoc', '8'),
('Enghh01', 'Tieng Anh', '12')
go

insert into Class_Aptech(ma_Class, Name_class, Note)
values
('C2108L', 'Toan Tin', 'Chuyen toan tin'),
('C2589D', 'Chuyen Ly', 'Chuyen Vat Ly'),
('C5641T', 'Hoa Ly', 'Chuyen Hoa Ly'),
('C4587Q', 'Van Anh', 'Chuyen Van Anh'),
('C6548R', 'Anh Ngu', 'Chuyen Anh')
go

insert into Schedule(Ma_Giaovien, Ma_monhoc, ma_Class, day_begin, day_end)
values
('GV1', 'Math01', 'C2108L', '2020-09-02', '2020-10-02' ),
('GV2', 'Phy01', 'C2589D', '2020-09-02', '2020-10-02' ),
('GV4', 'NguVanh01', 'C4587Q','2020-09-02', '2020-10-02'),
('GV5', 'Enghh01', 'C6548R', '2020-09-02', '2020-10-02')
go

insert into Schedule(Ma_Giaovien, Ma_monhoc, ma_Class, day_begin, day_end)
values
('GV3', 'Chem01', 'C5641T', '2020-09-02', '2020-10-02')
go


insert into ClassMember (RollNo, Class_No, JoinedDate, OutedDate)
values
('HS101', 'C2108L', '2020-08-25', '2020-12-05'),
('HS202', 'C2589D', '2020-08-25', '2020-12-05'),
('HS303', 'C5641T','2020-08-25', '2020-12-05'),
('HS404', 'C4587Q', '2020-08-25', '2020-12-05'),
('HS505', 'C6548R', '2020-08-25', '2020-12-05')
go

insert into Attendance(Schedule_id, RollNo, ngay_diem_danh, Attendance_1, Attendance_2, note)
values
(4, 'HS101', '2020-09-02', 1, 1, 'P'),
(5, 'HS202', '2020-09-02', 0, 0, 'A'),
(6, 'HS303', '2020-09-02', 0, 1, 'PA'),
(7, 'HS404', '2020-09-02', 1, 0, 'PA'),
(8, 'HS505', '2020-09-02', 1, 1, 'P')
go

-- tesst
select * from Student_aptech
select * from Teacher_Aptech
select * from Subject_Aptech
select * from Schedule
select * from Class_Aptech
select * from ClassMember
select * from Attendance
go


-- TIm kiem theo yeu cau
--Tạo procedure để xem thông tin học viên trong một lớp học - đầu vào là tên lớp
select Student_aptech.Name_Student as 'Ten HV', Student_aptech.Gender as 'Gioi tinh',  Student_aptech.Birthday as 'Ngay sinh',  Student_aptech.Address as 'Dia chi', Student_aptech.email, Student_aptech.phone_number,
		ClassMember. JoinedDate as 'Ngay Nhap hoc',  ClassMember.OutedDate as 'Ngay Ket Thuc Hoc', Class_Aptech.Name_class as 'Ten Lop', Class_Aptech.Note
	from Student_aptech left join ClassMember on Student_aptech.Rollno = ClassMember.RollNo
	left join Class_Aptech on ClassMember.Class_No = Class_Aptech.ma_Class
go

create proc proc_view_infor_hv
	@nameclass nvarchar(50)
as
begin
		select Student_aptech.Name_Student as 'Ten HV', Student_aptech.Gender as 'Gioi tinh',  Student_aptech.Birthday as 'Ngay sinh',  Student_aptech.Address as 'Dia chi', Student_aptech.email, Student_aptech.phone_number,
				ClassMember. JoinedDate as 'Ngay Nhap hoc',  ClassMember.OutedDate as 'Ngay Ket Thuc Hoc', Class_Aptech.Name_class as 'Ten Lop', Class_Aptech.Note
		from Student_aptech left join ClassMember on Student_aptech.Rollno = ClassMember.RollNo
				left join Class_Aptech on ClassMember.Class_No = Class_Aptech.ma_Class

		where Class_Aptech.Name_class = @nameclass
end
go

exec proc_view_infor_hv 'Toan Tin'
go

--Tạo procedure để xem danh sách điểm danh của lớp học, của môn môn học cụ thể. - đầu vào là mã lớp học và môn học
select Class_Aptech.Name_class as 'Ten Lop', Subject_Aptech.Name_Subject as 'Ten Mon Hoc', Teacher_Aptech.Name_teacher as 'Ten GV',  Attendance.ngay_diem_danh as 'Ngay Diem danh'
from Attendance left join Schedule on Attendance.Schedule_id = Schedule.id
		left join Class_Aptech on Schedule.ma_Class = Class_Aptech.ma_Class
		left join Subject_Aptech on Schedule.Ma_monhoc = Subject_Aptech.Ma_monhoc
		left join Teacher_Aptech on Schedule.Ma_Giaovien = Teacher_Aptech.Ma_Giaovien
go

create proc proc_view_Attendance_infor
	@classnumber nvarchar(16),
	@Subnumber nvarchar(16)
as
begin
	select Class_Aptech.Name_class as 'Ten Lop', Subject_Aptech.Name_Subject as 'Ten Mon Hoc', Teacher_Aptech.Name_teacher as 'Ten GV',  Attendance.ngay_diem_danh as 'Ngay Diem danh'
	from Attendance left join Schedule on Attendance.Schedule_id = Schedule.id
		left join Class_Aptech on Schedule.ma_Class = Class_Aptech.ma_Class
		left join Subject_Aptech on Schedule.Ma_monhoc = Subject_Aptech.Ma_monhoc
		left join Teacher_Aptech on Schedule.Ma_Giaovien = Teacher_Aptech.Ma_Giaovien

		where Class_Aptech.ma_Class = @classnumber and Subject_Aptech.Ma_monhoc = @Subnumber
end
go

exec proc_view_Attendance_infor 'C2108L', 'Math01'
go

-- tạo trigger để xóa dữ liệu học viên
create trigger trigger_insteadof_delete_hv on Student_aptech
instead of delete
as
begin
	delete from 

	select Name_Student from deleted where Name_Student = 'Nguyen Van D'
	begin
	print N' Xoa Thanh cong'
	rollback transaction
	end
end
go

delete from Student_aptech where Name_Student = 'Nguyen Van D'
go

select * from Student_aptech
go

drop trigger trigger_delete_hv
