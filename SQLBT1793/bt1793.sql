--CSDL  Sinh vien
create database StudentManagementSystem
go

use StudentManagementSystem
go

-- tao Table
create table Class(
	ClassId int not null,
	ClassCode nvarchar(50)
)
go

create table Student(
	StudentId int not null,
	StudentName nvarchar(50),
	BrithDate datetime,
	ClassId int
)
go

-- Update lại dữ liệu của brithday 
alter table Student
alter column BrithDate date
go


create table Subject(
	SubjectId int not null,
	Subjectname nvarchar(100),
	SessionCount int
)
go

create table Result(
	StudentId int not null,
	SubjectId int not null,
	Mark int
)
go

--index
create nonclustered index NCL_Student_StudentName on Student(StudentName)
go

-- Tao pk-key& Fk-key & check
alter table Class
add constraint Pk_Class primary key (ClassId)
go

alter table Student
add constraint Pk_Student primary key (StudentId)
go

alter table Subject
add constraint Pk_Subject primary key (SubjectId)
go

alter table Result
add constraint Pk_Result primary key (StudentId, SubjectId)
go


alter table Student
add constraint fk_Student_Class foreign key (ClassId) references Class (ClassId)
go
alter table Result
add constraint fk_Result_Student foreign key (StudentId) references Student (StudentId)
go
alter table Result
add constraint fk_Result_Subject foreign key (SubjectId) references Subject (SubjectId)
go

alter table Subject
add constraint check_Subject_SessionCount  check (SessionCount>0)
go

--Tesst
select * from Class
select * from Student
select * from Subject
select * from Result
go

--Insert Table
insert into Class ( ClassId, ClassCode)
values
(1, 'C1106KV'),
(2, 'C110GKV'),
(3, 'C1108IV'),
(4, 'C1108HV'),
(5, 'C1109GV')
go

insert into Student ( StudentId, StudentName, BrithDate, ClassId)
values
(1, 'Phạm Tuấn Anh', '1993-08-05', '1'),
(2, 'Phạm Văn Huy', '1992-06-10', '1'),
(3, 'Nguyễn Hoàng Minh', '1992-09-07', '2'),
(4, 'Trần Tuấn Tú', '1993-10-10',  '2'),
(5, 'Đỗ Tài Anh', '1992-06-06', '3')
go

insert into Subject (SubjectId, Subjectname, SessionCount)
values
(1, 'C Programming', '22'),
(2, 'Web Design', '18'),
(3, 'Database Managenment', '23')
go

insert into Result (StudentId, SubjectId, Mark)
values
('1', '1', '8'),
('1', '2', '7'),
('2', '3', '5'),
('3', '2', '6'),
('4', '2', '9'),
('5', '1', '8')
go

-- search information Brithday between 1992-10-10 and 1993-10-10
select * from Student
where BrithDate  between '1992-10-10' and '1993-10-10'
go

select Class.ClassId , Class.ClassCode,  Count(Student.StudentId) as Total from Class, Student
where  Class.ClassId = Student.ClassId
group by Class.ClassId, Class.ClassCode
go

select Student.StudentName as ' Ten Sinh Vien', Student.StudentId as 'Ma Sinh Vien', Sum(Result.Mark ) as TongDiem from Result, Student
where Student.StudentId= Result.StudentId
group by StudentName, Student.StudentId
having Sum(Mark )>10
order by 'TongDiem' asc
go

-- view
create view view_StudentSubjectMark 
as
select  Student.StudentId, Student.StudentName, Subject.Subjectname, Result.Mark 
from Student, Subject, Result
where Student.StudentId = Result.StudentId 
	and Result.SubjectId = Subject.SubjectId
order by Result.Mark  desc
go

select top(3) * from view_StudentSubjectMark
go

--Store/Proc
create proc Up_IncreaseMark
	@SubjectId int
as
begin
	select  Student.StudentId, Student.StudentName, Subject.Subjectname, Result.Mark 
	from Student, Subject, Result
	where Student.StudentId = Result.StudentId 
	and Result.SubjectId = Subject.SubjectId
	and Subject.SubjectId =@SubjectId
end
go

exec Up_IncreaseMark 2
go


--trigger
create trigger TG_Result_Insert on Result
for insert
as
begin
	if(select count(*) from inserted where Mark <0 ) >0
	begin
		print N'Cannot insert mark <0'
		rollback transaction
	end
end
go

insert into Result (StudentId, SubjectId, Mark)
values
(1,3,-2)
go

create trigger Tg_Subject_Update on Subject
for update
as
	if update(SubjectName)
begin
	print N'You don''t update this column '
	rollback transaction
end
go

select * from Subject
go


update Subject set Subjectname = 'Asasdasd'
where SubjectId = 1
go
 
 --------END--------------













