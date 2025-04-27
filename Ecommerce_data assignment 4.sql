create database ecommerce;
use ecommerce;

create table products(product_id tinyint unique,
	product_name varchar(255),
    price tinyint);
    
    create table orders(order_id tinyint unique,
	customer_id	tinyint,
    order_date date,
    foreign key(customer_id) references customers(customer_id));


create table order_items(order_id	tinyint,
product_id tinyint,
quantity tinyint,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id));

create table customers(customer_id	tinyint unique,
first_name varchar(255),
	last_name	varchar(255),
    email varchar(255));

select * from products;
select * from orders;
select * from order_items;
select * from customers;

#Which product has the highest price?
select product_name from products
order by price desc
limit 1;

#Which customer has made the most orders?
WITH cte_1 AS (
    SELECT customers.customer_id AS cust_id, customers.first_name, customers.last_name, customers.email, 
           orders.order_id, orders.order_date
    FROM customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    ORDER BY order_id desc
)
SELECT * FROM cte_1
limit 1;

#Which customer has made the most orders?
SELECT customers.customer_id, customers.first_name, customers.last_name, 
       orders.order_id,  
       order_items.product_id, order_items.quantity
       
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
ORDER BY order_id;



#Which product has the highest total revenue?
select product_name,price from products
order by price desc
limit 1;

#  Find the first order (by date) for  customer "John Doe".
WITH cte_1 AS (
    SELECT customers.customer_id AS cust_id, customers.first_name, customers.last_name, customers.email, 
           orders.order_id, orders.order_date
    FROM customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    ORDER BY customers.first_name
)
SELECT * FROM cte_1
WHERE first_name = 'John';

#Find the top customer who have ordered the most distinct products
SELECT customers.customer_id, customers.first_name, customers.last_name, 
       orders.order_id,  
       order_items.product_id, order_items.quantity
       
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
ORDER BY product_id;





















select * from movies
inner join members
on movies.id=members.movieid;






-- retrive unique product bought by cutomer george
select * from customers
inner join orders
using (customer_id)
inner join order_items
using(order_id)
inner join products
using (product_id)
where first_name="George";


-- subquerry in where clasue with multiple tables
select * from products
where product_id in (select product_id from order_items
where order_id in (select order_id from orders
where customer_id=(select  customer_id from customers
where  first_name ="George")));


-- correlated subquery

use learndb;
select * from movies
where exists(select * from memebers
where movies.id=memebers.movieid);


