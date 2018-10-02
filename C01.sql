select * from Student
use StudentManagement1
insert into [Subject] values ('C001', N'C++ cơ bản')
select * from [Subject]

update [Subject] set [Name] = N'C++ cơ bản' where SubjectId = 'C001'

insert into [Subject] values ('SQL', N'SQL cơ bản')
insert into [Subject] values ('MFC', N'MFC nâng cao')

delete from [Subject] where [Name] = N'SQL cơ bản'

create table Student1
(
  StudentId int primary key identity,
  StudentName nvarchar(30) not null,
  Faculty nvarchar(50),
  Class nvarchar(50)
)

create table Mark
(
SubjectId nvarchar(50) foreign key references [Subject](SubjectId),
StudentId int references Student(StudentId),
Mark float,
primary key (StudentId, SubjectId)
)

insert into Mark(SubjectId, StudentId) values ('C001', 2)
select * from Mark
update Mark set Mark = 9 where StudentId=2

SELECT        Student.StudentName, [Subject].Name, Mark.Mark
FROM            Mark INNER JOIN
                         Student ON Mark.StudentId = Student.StudentId INNER JOIN
                         [Subject] ON Mark.SubjectId = [Subject].SubjectId
WHERE        (Student.StudentName LIKE N'%Băng%')

select * from Student inner join Mark 
on Student.StudentId = Mark.StudentId

insert into Mark(SubjectId, StudentId, Mark) 
values('C001', 1, 7)

insert into Mark(SubjectId, StudentId, Mark) 
values('C001', 3, 8)

insert into Student values ('Nguyen Van Tiep', 'CNTT', 'CNTT1')

insert into Student values ('Nguyen Van Tuan', 'CK', 'CK1')

select * from Student left join Mark 
on Student.StudentId = Mark.StudentId

select * from Student where StudentName like '%Tiep'

select StudentName, Faculty from Student 
order by StudentName desc

select count(Mark) from Student left join Mark 
on Student.StudentId = Mark.StudentId

Tạo bản sản phẩm Product gồm
(ProductId, ProductName, CategoryId, SupplierId,
UnitPrice, Discontinued)
Tạo bảng Category
(CategoryId, CategoryName)

Tạo bảng Supplier
(SupplierId, CategoryName)

- Khóa chính
- Khóa ngoại CategoryId là khóa ngoại ở bảng Sản phẩm
- Khóa ngoại SupplierId là khóa ngoại ở bảng Sản phẩm

+ Nhập dữ liệu cho 3 bảng
+ Sắp xếp sản phẩm theo thứ tự giảm dần của giá
+ Tìm sản phẩm có tên bắt đầu bằng A
+ Tìm số sản phẩm có giá lớn hơn 10
+ Tìm Tên sản phẩm thuộc danh mục có tên (CategoryName) 
là Tivi 