-- csdl
create database Bt1800
go

use Bt1800
go

-- table
create table class (
	classid int not null,
	classcode nvarchar(50)
)
go

create table student(
	studentid int not null,
	studentname nvarchar(50),
	birthdate datetime,
	classid int
)
go

create table subject (
	subjectid int not null,
	subjectname nvarchar(100),
	sessioncount int
)
go

create table result (
	studentid int not null,
	subjectid int not null,
	mark int
)
go

--index
create nonclustered index ncl_student_studentname on student (studentname)
go

alter table result
alter column mark float
go

--constraint
---pk key
alter table class
add constraint pk_class primary key (classid)
go

alter table student
add constraint pk_student primary key (studentid)
go

alter table subject 
add constraint pk_subject primary key (subjectid)
go

alter table result
add constraint pk_result primary key (studentid, subjectid)
go

---fk key
alter table student
add constraint fk_student_class foreign key (classid) references  class (classid)
go

alter table result
add constraint fk_result_student foreign key (studentid) references student(studentid)
go

alter table result
add constraint fk_result_subject foreign key (subjectid) references subject(subjectid)
go

-- check
alter table subject
add constraint CK_subject_sessioncount check (sessioncount > 0)
go


--insert
insert into class (classid, classcode)
values
(1, 'C1106kv'),
(2, 'C1108gv'),
(3, 'C1108iv'),
(4, 'C1108hv'),
(5, 'C1109gv')
go

insert into student (studentid, studentname, birthdate, classid)
values
(1, 'Pham Tuan Anh', '1993-08-05', 1),
(2, 'Pham Van Huy', '1992-06-10', 1),
(3, 'Nguyen Hoang Minh', '1992-09-07', 2),
(4, 'Tran Tuan Tu', '1993-10-10', 2),
(5, 'Do Anh Tai', '1992-06-06', 3)
go

insert into subject (subjectid, subjectname, sessioncount)
values
(1, 'C progaramming', 22),
(2, 'Web design', 18),
(3, 'Data management', 23)
go

insert into result(studentid, subjectid, mark)
values
(1, 1, 8),
(1, 2, 7),
(2, 3, 5),
(3, 2, 6),
(4, 3, 9),
(5, 2, 8)
go

-- view table
select * from class
select * from student
select * from result
select * from subject

-- Query
-- slect sQL
select * from student
where birthdate between '1992-10-10' and '1993-10-10'
go

select class.classid 'Ma lop', class.classcode 'Ten Lop', count(student.studentid) 'Si so Lop'
from student right join class on student.classid = class.classid
group by class.classid, class.classcode
order by  'Si so Lop' desc
go

select student.studentid 'Ma Sinh Vien', student.studentname 'Ten sinh vien', sum(result.mark) 'Tong diem'
from student left join result on student.studentid = result.studentid
group by student.studentid, student.studentname
having sum(result.mark) >10
go

--view
create view virew_studentsubjectmark 
as
select top (3) student.studentid 'Ma Sinh Vien', student.studentname ' Ten Sinh vien', subject.subjectname 'Ten Mon hoc', result.mark 'Diem mon hoc'
from student left join result on student.studentid = result.studentid
		  left join  subject on result.subjectid = subject.subjectid
go

select * from virew_studentsubjectmark
order by 'Diem mon hoc' desc
go

--- proc
create proc up_increasemark 
	@subjectid int
as
begin
	update  result set mark = mark +1
		where result.subjectid = @subjectid
end
go

alter proc up_increasemark 
	@subjectid int
as
begin
	update  result set mark = mark +1
		where result.subjectid = @subjectid
end
go

exec up_increasemark 2
go

select * from result
go

--trigger
create trigger TG_result_insert on result
for insert
begin
	if( select count(*) from inserted where mark <0) >0
	begin
	print N'Cannot insert mark less than zero'
	rollback transaction
	end
end
go

insert into result (studentid, subjectid, mark)
values
(1, 3, -2)
go

create trigger TG_subject_update on subject
for update
as
if update (subjectname)
begin
	print N'you don"t update this column'
	rollback transaction
end
go

select * from subject
go

update subject set subjectname = 'Asasdasd'
where subjectid = 1
go
