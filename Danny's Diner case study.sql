drop database if exists Case_Study_1_DannyS_Diner;
create database Case_Study_1_DannyS_Diner;
use Case_Study_1_DannyS_Diner;


CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  
/* Case Study Questions
Each of the following case study questions can be answered using a single SQL statement:

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?*/

select * from sales;
-- 1. What is the total amount each customer spent at the restaurant?
select customer_id,sum(price) total_amount from menu m inner join sales s using (product_id)
group by customer_id;

-- 2. How many days has each customer visited the restaurant?
select * from sales;
select customer_id,count(distinct order_date) as no_of_days from sales group by customer_id;

-- 3. What was the first item from the menu purchased by each customer?
select * from sales;

select customer_id,min(order_date),product_id from sales group by customer_id,product_id;

with sales_info as (
select customer_id,product_id,order_date,rank() over(partition by customer_id order by 
order_date) as rk from sales)
select s.*,m.product_name from sales_info s inner join menu m using (product_id) where rk=1;
-- or --
select * from sales;
select customer_id,order_date, m.product_name from sales s inner join menu m using (product_id) 
where (customer_id,order_date) in (
select customer_id,min(order_date) from sales group by customer_id);

-- 4. What is the most purchased item on the menu and how many times was 
-- it purchased by all customers?

select * from sales;
select product_id from 
(select  product_id,count(product_id) no_purchased_item from sales group by product_id)t
;
select * from menu;
select product_id,product_name,no_of_purchased_item from (
select product_id,count(product_id) no_of_purchased_item from sales group by product_id order by count(product_id) desc limit 1) t
inner join menu m using (product_id) ;

# 5. Which item was the most popular for each customer?

select * from sales;
with cust_info as (
select customer_id,product_id,count(customer_id) as repeated from sales group by customer_id,product_id),
detailed as (select *,rank() over(partition by customer_id order by repeated desc) as rn from cust_info)
select d.*, product_name from detailed d inner join menu using (product_id) where rn=1;

-- 6. Which item was purchased first by the customer after they became a member?

SELECT s.customer_id, m.product_name, MIN(s.order_date) AS first_purchase_date
FROM sales s JOIN
 members b ON s.customer_id = b.customer_id AND s.order_date >= b.join_date
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
ORDER BY s.customer_id, first_purchase_date;

# 7. Which item was purchased just before the customer became a member?
SELECT s.customer_id, m.product_name, MAX(s.order_date) AS last_purchase_date_before_membership
FROM sales s JOIN members b ON s.customer_id = b.customer_id AND s.order_date < b.join_date
JOIN menu m ON s.product_id = m.product_id GROUP BY s.customer_id, m.product_name
ORDER BY s.customer_id, last_purchase_date_before_membership;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id,  COUNT(*) AS total_items, SUM(m.price) AS total_spent
FROM sales s JOIN members b ON s.customer_id = b.customer_id AND s.order_date < b.join_date
JOIN menu m ON s.product_id = m.product_id GROUP BY s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
-- how many points would each customer have?
SELECT s.customer_id, SUM(CASE WHEN m.product_name = 'sushi' THEN m.price * 20
ELSE m.price * 10 END) AS total_points FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- 10. In the first week after a customer joins the program 
-- (including their join date) they earn 2x points on all items,
--  not just sushi - how many points do customer A and B have at the end of January?*/

SELECT s.customer_id, SUM(CASE WHEN s.order_date BETWEEN b.join_date AND 
DATE_ADD(b.join_date, INTERVAL 6 DAY) THEN m.price * 20 WHEN m.product_name = 'sushi' 
THEN m.price * 20 ELSE m.price * 10 END) AS total_points
FROM sales s JOIN menu m ON s.product_id = m.product_id
JOIN members b ON s.customer_id = b.customer_id
WHERE s.order_date <= '2021-01-31' GROUP BY s.customer_id
HAVING s.customer_id IN ('A', 'B');













