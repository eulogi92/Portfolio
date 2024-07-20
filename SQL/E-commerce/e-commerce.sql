--Inspect orders table
select *
from bigquery-public-data.thelook_ecommerce.orders;

--Inspect users table
select *
from bigquery-public-data.thelook_ecommerce.users;

--return all variables from both tables (orders table, users table)
SELECT 
orders.*,
users.*
from bigquery-public-data.thelook_ecommerce.orders as orders
left join bigquery-public-data.thelook_ecommerce.users as users
on orders.user_id = users.id;

-- table containing all the customers' full names in the first column and the count of how many orders they made in their history in the second column. 
SELECT 
concat(users.first_name, " ", users.last_name) as fullname,
count(orders.order_id) as counter
from bigquery-public-data.thelook_ecommerce.orders as orders
left join bigquery-public-data.thelook_ecommerce.users as users
on orders.user_id = users.id
group by concat(users.first_name, " ", users.last_name)
order by counter DESC;

--show only the customers that made more than ten orders
SELECT 
concat(users.first_name, " ", users.last_name) as fullname,
count(orders.order_id) as counter
from bigquery-public-data.thelook_ecommerce.orders as orders
left join bigquery-public-data.thelook_ecommerce.users as users
on orders.user_id = users.id
group by concat(users.first_name, " ", users.last_name)
having count(orders.order_id)>10
order by counter DESC;

--pivot table showing the order status by row and four age brackets as separate columns
SELECT 
orders.status,
sum(CASE WHEN users.age<20 THEN 1 else 0 END) as under20,
sum(CASE WHEN users.age between 20 and 39 THEN 1 else 0 END) as age20_39,
sum(CASE WHEN users.age between 40 and 59 THEN 1 else 0 END) as age40_59,
sum(CASE WHEN users.age between 60 and 79 THEN 1 else 0 END) as age60_79,
sum(CASE WHEN users.age>80 THEN 1 else 0 END) as over80
from bigquery-public-data.thelook_ecommerce.orders as orders
join bigquery-public-data.thelook_ecommerce.users as users
on orders.user_id = users.id
group by orders.status
having orders.status  in("Complete","Returned","Cancelled")