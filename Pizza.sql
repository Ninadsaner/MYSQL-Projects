create database Pizza;
use Pizza;

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;
-- select total no of orders placed
select count(order_id) from orders;

-- Calculate the total revenue generated from pizza sales.

select * from order_details;
select * from pizzas;

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


-- Identify the highest-priced pizza.

select * from pizza_types;
select * from pizzas;

SELECT 
    pt.name,pz.price
FROM
    pizza_types pt
        JOIN
    pizzas pz ON pz.pizza_type_id = pt.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
            
-- Alternate way

SELECT 
    pt.name,pz.price
FROM
    pizza_types pt
        JOIN
    pizzas pz ON pz.pizza_type_id = pt.pizza_type_id
order by pz.price desc limit 1;

-- Identify the most common pizza size ordered.

select * from pizzas;
select * from order_details;


select pz.size, count(od.quantity) as count from order_details od
join pizzas pz on pz.pizza_id = od.pizza_id
group by pz.size order by count desc limit 1;


-- List the top 5 most ordered pizza types along with their quantities.

select * from pizzas;
select * from pizza_types;
select * from order_details;

select pizza_types.name, 
sum(order_details.quantity) as no_o_orders
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by no_o_orders desc limit 5 ;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select * from order_details;
select * from pizza_types;
select * from pizzas;

select category, sum(quantity) from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by category; 


-- Determine the distribution of orders by hour of the day.
select * from order_details;
select * from orders;

select hour(time) as order_per_hour, count(order_id)
from orders group by order_per_hour;

select avg(order_id) from orders;
select hour(time) as order_per_hour, count(order_id) as cot
from orders group by order_per_hour;


-- Join relevant tables to find the category-wise distribution of pizzas.

select * from pizza_types;

select category, count(name)
from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.

select * from orders;
select * from order_details;


select avg(quantity) from 
(select day(date), sum(quantity) as quantity from orders
join order_details on order_details.order_id = orders.order_id 
group by date) as order_quantity;



-- Determine the top 3 most ordered pizza types based on revenue.

select * from orders;
select * from order_details;
select * from pizzas;
select * from pizza_types;

select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by name order by revenue desc limit 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category, (sum(order_details.quantity * pizzas.price) / (SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id) ) *100 as revenue
from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by category order by revenue desc;

-- Analyze the cumulative revenue generated over time.
select * from orders;

select date,
sum(revenue) over(order by date) as cumalative_revenue
from
(select orders.date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select * from pizza_types;
select * from order_details;
select * from pizzas;

select name, revenue from 
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name, sum((order_details.quantity) * pizzas.price) as revenue 
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details on order_details.pizza_id  = pizzas.pizza_id
group by  pizza_types.category, pizza_types.name) as a) as b
where rn <= 3;
