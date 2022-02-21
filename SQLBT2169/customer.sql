-- Tao bảng customer

create table khachhang(
	cust_no nvarchar(5),
	cust_name nvarchar(30),
	phone_number nvarchar(16)
)

insert into  khachhang (cust_no, cust_name, phone_number)
values
('1', 'David', '0231-5466356'),
('2', 'Prine', '0211-556899')

insert into  khachhang (cust_no, cust_name, phone_number)
values
('3', 'Princesss', '0221-356458')

select * from  khachhang

-- Tao bang Item
create table sanpham(
	item_no  nvarchar(5),
	description text,
	price nvarchar(10)
)

insert into sanpham ( item_no, description, price)
values
('HW1', 'Power Supply', '4000'),
('HW2', 'Keyboard', '2000'),
('HW3', 'Mouse', '800')


insert into sanpham ( item_no, description, price)
values
('SW1', 'Ofice Suite', '15000'),
('SW2', 'Payroll Software', '8000')

select * from sanpham

-- Tao bảng oder_details

create table ord_detail(
	ord_no nvarchar (5),
	item_no nvarchar(5),
	Qty nvarchar(10)
)

insert into ord_detail(ord_no, item_no, Qty)
values
('101', 'HW3', '50' ),
('101', 'SW1', '150'),
('102', 'HW2', '10')

select * from ord_detail


-- Tao bang order agust

create table ord_agust(
	ord_no nvarchar (5),
	ord_date nvarchar(15),
	cust_no nvarchar(5)
)

insert into ord_agust(ord_no, ord_date, cust_no)
values
('101', '02-08-12', '002' ),
('102', '11-08-12', '003' ),
('103', '21-08-12', '003' ),
('104', '28-08-12', '002' )

select * from ord_agust





