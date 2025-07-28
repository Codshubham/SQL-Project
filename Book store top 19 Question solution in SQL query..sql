  create database bookstore;
  use bookstore ;
  create table Books (
   Book_ID serial  primary key,
   Title  varchar(100),
   Author varchar(100),
   Gence varchar(50),
   Publishead_year int ,
   Price numeric (10,2),
   Stock int 
	);
     create table Customers (
    Customer_ID serial primary key
    ,Name   varchar(100),
    Email varchar (100),
    Phone varchar(15),
    City varchar (50),
    Country varchar(150)
    );
    
     create table  Orders (
    Order_ID serial primary key 
     ,Customer_ID int references Customers(Customer_ID)
     ,Book_ID int references Books(BOOK_ID),
     Order_Date date ,Quantity  int 
     ,Total_Amount numeric(10,2)
    );
    select *from Books;
    select * from Customers;
    select * from Orders;
      
    -- (1)  List all the books from the Books table.
    select * from Books;
    
    -- (2) Show the names and emails of all customers.
            
		select name , Email
         from Customers ;
         
	-- (3) Retrieve all orders placed in the year 2024.
         select * from Orders 
         where year(order_Date) = 2024;
         
	-- (4) Display all books whose price is greater than 500.
            select * from Books 
            where Price >500;
     -- (5) Find the list of customers from the city 'Lake Robert'.
           
           select * from  Customers
            where city = 'Lake Robert'
            
            -- (Joins)
	 -- (6)  Find the names of customers who ordered more than 2 units of any book.
             
             select  c.Name , o.Quantity 
             from Customers as c 
             join Orders as o 
             on c.Customer_id = o.Customer_id 
             and Quantity > 2;
             
	     -- (7) List each book and the total number of times it has been ordered.
                 
                 select b.Title as Booktitle , sum(o.Quantity) as orderbooks 
                 from Books as b
                 join Orders as o
                 on b.Book_id = o.Book_id 
                 group by b.title;
		-- (8)  Display the title and customer name for all orders made after '2023-01-01'.
                     
			    Select b.Title as BookTitle,
                c.Name as CustomerName
				from Orders o
				join Books b on o.Book_ID = b.Book_ID
               join Customers c on o.Customer_ID = c.Customer_ID
                where o.Order_Date > '2023-01-01';
 
		 -- (10)  Count the total number of books available in the catalog.
					select count(stock) as Totalbook 
                    from Books ;
                    
         -- (11)   What is the average price of all books?
				
                select avg(price) as averageprice 
                from books ;
                
            -- (12)  How many customers are there in each country?
                 
                 select  country,count(*) as customercount 
                 from Customers 
                 group by  country
                 order by customercount desc;
				
			-- (13) Find the top 3 most sold books based on quantity.
            
                                 
	                   select  b.title,sum( o.Quantity) as totalsold 
					   from  Books as b
                      join Orders as o 
                      on b.book_id = o.book_id 
                      group by b.title
                      order by totalsold desc
                      limit 3 ;         
          
             -- (14)  Find all books in the gecre 'Fiction'.
  
                       select * from Books
                       where gence = 'fiction';
			
            -- (15) Retrieve the top 5 most expensive books.
                    
                    select * from books 
                    where price 
                    order by  price desc 
                    limit 5 ;
			
            -- (16) Show all customers who placed orders in January 2024.
                       
					select c. name , o. order_date 
                    from Customers as c
                    join orders as o 
                    on c.customer_id = o.customer_id
                    where o.order_date  Between '2024-01-01' and '2024-01-31';
                    
                 -- (17)   List all books that have never been ordered.
                 
							select b.title
                            from Books as b
                            left join Orders as o 
                            on b.book_id = o.book_id 
                            where o.book_id is null ;
                            
                   -- (18) Calculate the total revenue generated from each country.
							select c.country , sum(b.price*o.quantity) as totalrevenue
                              from Customers as c
                              join Orders as o
                              on c.customer_id = o.customer_id 
                              join Books as b 
                              on o.book_id = b.book_id 
                              group by c.country;
                 
                 -- (19)  Get the number of orders placed each month.
                         
                             Select   (DATE_FORMAT(o.Order_Date, '%Y-%m')) as OrderMonth, COUNT(*)  as OrderCount
                             from  Orders o
                             group   by OrderMonth
                              order by  OrderMonth  desc ;
		
     