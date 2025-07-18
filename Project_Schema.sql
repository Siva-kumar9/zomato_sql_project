-- Explore Data


select * from customers;
select * from restaurants;
select * from orders;
select * from riders;
select * from deliveries;


-- import datasets

-----------------------
-- analysis & reports
-----------------------


-- Q-1
/* Write a query to find the  top 5 most frequently ordered dishes by customer 
   called "Tara Walia" in the last 1 year */

-- join customers and orders
-- filter for 1 year
-- only customer 9
-- group by cid, dishes, count


SELECT c.customer_id,
c.customer_name,
o.order_item as dishes,
count(*) as total_orders,
dense_rank() over(order by count(*) desc) as rank
FROM orders AS o
JOIN
customers AS c
ON c.customer_id=o.customer_id
where o.order_date >= current_date - interval '1 year'
and
c.customer_name ='Tara Walia'
group by 1,2,3
order by 1,4 desc;




/* Q-2 Popular Time Slots
Identify the time slots during which the most orders are placed based on 2 hours intervals
*/

select
  case
     when extract(hour from order_time) between 0 and 1 then '00:00  -  02:00'
	 when extract(hour from order_time) between 2 and 3 then '02:00  -  04:00'
	 when extract(hour from order_time) between 4 and 5 then '04:00  -  06:00'
	 when extract(hour from order_time) between 6 and 7 then '06:00  -  08:00'
	 when extract(hour from order_time) between 8 and 9 then '08:00  -  10:00'
	 when extract(hour from order_time) between 10 and 11 then '10:00  -  12:00'
	 when extract(hour from order_time) between 12 and 13 then '12:00  -  14:00'
	 when extract(hour from order_time) between 14 and 15 then '14:00  -  16:00'
	 when extract(hour from order_time) between 16 and 17 then '16:00  -  18:00'
	 when extract(hour from order_time) between 18 and 19 then '18:00  -  20:00'
	 when extract(hour from order_time) between 20 and 21 then '20:00  -  22:00'
	 when extract(hour from order_time) between 22 and 23 then '22:00  -  00:00'
End as time_slot,
count(order_id) as order_count
from orders
group by time_slot
order by order_count desc;







/* Q-3 Order without deliver
Write a query to find orders that were placed but not deliverd
return each restaurant name and number of not deliverd orders
*/


select r.restaurant_name,
count(o.order_id) as count_not_delivery_orders
from orders as o
left join
restaurants as r
on r.restarunt_id=o.restarunt_id
left join
deliveries as d
on d.order_id=o.order_id
where d.delivery_id is NULL
group by 1
order by 2 desc;
