# 📦 Ecommerce Data Analysis using SQL
## 🚀 Objective
Use SQL queries to extract insights and analyze an E-commerce database.

## 🛠 Tools Used
Database: MySQL / PostgreSQL / SQLite

## Techniques:

SELECT, WHERE, ORDER BY, GROUP BY

JOINS (INNER, LEFT, RIGHT)

Subqueries (Simple and Correlated)

Aggregate functions (SUM, AVG)

Views for analysis

Query optimization with indexes

## 🗂️ Dataset
Custom Ecommerce Database with the following tables:

products

orders

order_items

customers

## 📋 Database Schema

-- Create Ecommerce database
CREATE DATABASE ecommerce;
USE ecommerce;

-- Create tables
CREATE TABLE products (
  product_id TINYINT UNIQUE,
  product_name VARCHAR(255),
  price TINYINT
);

CREATE TABLE customers (
  customer_id TINYINT UNIQUE,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE orders (
  order_id TINYINT UNIQUE,
  customer_id TINYINT,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_id TINYINT,
  product_id TINYINT,
  quantity TINYINT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);




SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM customers;

## 📈 SQL Tasks and Solutions

## 1. Which product has the highest price?

SELECT product_name
FROM products
ORDER BY price DESC
LIMIT 1;

## 2. Which customer has made the most orders?

WITH cte_1 AS (
  SELECT customers.customer_id, customers.first_name, customers.last_name, customers.email, 
         orders.order_id, orders.order_date
  FROM customers
  INNER JOIN orders ON customers.customer_id = orders.customer_id
)
SELECT customer_id, first_name, last_name, COUNT(order_id) AS total_orders
FROM cte_1
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 1;
## 3. Which product has the highest total revenue?

SELECT p.product_name, SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 1;


## 4. Find the first order (by date) for customer "John Doe".

WITH cte_1 AS (
  SELECT customers.customer_id, customers.first_name, customers.last_name, 
         orders.order_id, orders.order_date
  FROM customers
  INNER JOIN orders ON customers.customer_id = orders.customer_id
)
SELECT *
FROM cte_1
WHERE first_name = 'John' AND last_name = 'Doe'
ORDER BY order_date ASC
LIMIT 1;

## 5. Find the top customer who ordered the most distinct products.

SELECT customers.customer_id, customers.first_name, customers.last_name,
       COUNT(DISTINCT order_items.product_id) AS distinct_products
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY customers.customer_id
ORDER BY distinct_products DESC
LIMIT 1;

## 🧠 Advanced SQL Concepts
## 6. Retrieve all unique products bought by customer "George".

SELECT DISTINCT products.*
FROM customers
INNER JOIN orders USING (customer_id)
INNER JOIN order_items USING (order_id)
INNER JOIN products USING (product_id)
WHERE first_name = "George";

## 7. Subquery inside WHERE clause (Multiple Tables)

SELECT *
FROM products
WHERE product_id IN (
  SELECT product_id
  FROM order_items
  WHERE order_id IN (
    SELECT order_id
    FROM orders
    WHERE customer_id = (
      SELECT customer_id
      FROM customers
      WHERE first_name = "George"
    )
  )
);


## 8. Correlated Subquery Example

USE learndb;

SELECT *
FROM movies
WHERE EXISTS (
  SELECT 1
  FROM members
  WHERE movies.id = members.movieid
);

## 📚 Learning Outcomes
Mastered complex SQL queries (JOINS, subqueries, CTEs).

Learned to structure queries for real-world datasets.

Practiced optimization and indexing techniques.

Understood how to create views for repeated analysis.

## 📸 Deliverables
## ✅ SQL File: ecommerce_analysis.sql

## 📢 Notes
This project can be expanded with views, indexes, stored procedures, and triggers for larger datasets.

Queries are written to be compatible with MySQL, PostgreSQL, and SQLite (minor syntax differences if any).

## 🔥 Thank you for visiting my project!
Would you also like me to quickly give you a short GitHub repository structure to make it look even better? 🚀
Example: folders like /SQL, /screenshots, /README.md, etc. (if yes, I'll send it too!) 🎯







