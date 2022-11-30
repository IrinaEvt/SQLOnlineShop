
drop table Categories;
drop table CustomerProduct;
drop table Products;
drop table Customers;

create table Customers (
    Id integer primary key not null identity(1,1),
    FirstName varchar(50),
    LastName varchar (50),
	Email varchar (50) not null unique,
	Gender varchar (10) check (gender in ('Female','Male')),
	Country varchar (50),
	City varchar (50),
	Phone varchar (12) not null unique,
	Birthdate date
);

create table Categories(
	Id integer primary key not null identity(1,1),
	Name varchar(50) not null unique
);

create table Products(
	Id integer primary key not null identity(1,1),
	Name varchar(50) not null ,
	Fk_Category integer FOREIGN KEY REFERENCES Categories(Id) on delete cascade,
	Price decimal (10,2),
	Quantity integer check (Quantity >= 0)
);

create table CustomerProduct(
	CustomerId integer references Customers(Id) on delete cascade,
	ProductId integer references Products(Id) on delete cascade,
	primary key(CustomerId,ProductId)
);

insert into Customers(FirstName, LastName, Email, Gender, Country, City, Phone, Birthdate)
select FirstName, LastName, Email, Gender, Country, City, Phone, Birthday
from Demo.dbo.Custommers;

insert into Categories(Name)
values
('Apparel and accessories'),
('Electronics'),
('Books, movies, music, and games'),
('Health, personal care, and beauty'),
('Food and beverage'),
('Furniture and decor'),
('Auto and parts');

insert into Products(Name, Fk_Category, Price, Quantity)
values
('Outdoor Movie Projector', 2, 55.99, 56),
('Women Office Handbag', 1, 44.99, 105 ),
('Conair Hair Dryer', 4, 11.50, 8),
('Microfiber Reusable Cleaning Cloths', 7, 11.36, 203),
('Cotton Pillow Cover', 6, 15.19, 100),
('Fairy Tale-Stephen King, A Novel', 3, 16.25, 68),
('Leather Magnetic Card Case', 1, 23.63, 6),
('Dog Car Seat Cover', 1, 27.99, 160 )
;

insert into CustomerProduct(CustomerId, ProductId)
values
(1,2),
(2,2),
(2,1),
(3,1),
(3,3),
(4,5),
(5,6),
(6,8),
(7,4),
(8,7);

select Products.Name,Categories.Name 
from Products 
inner join Categories on Categories.Id = Products.Fk_Category
where Categories.Name = 'Apparel and accessories';

select Customers.FirstName + ' ' + Customers.LastName as 'Customer Name',
Products.Name as 'Product',
Categories.Name as 'Category'
from Customers
left join
CustomerProduct on Customers.Id = CustomerProduct.CustomerId
left join
Products on CustomerProduct.ProductId = Products.Id
left join
Categories on Products.Fk_Category = Categories.Id;

select top 3
    Name,
	count(ProductId) as 'Orders count'
from Products
left join 
CustomerProduct on Products.Id = CustomerProduct.ProductId
left join
Customers on CustomerProduct.CustomerId = Customers.Id
group by Products.Name
order by count(ProductId)
desc
;
