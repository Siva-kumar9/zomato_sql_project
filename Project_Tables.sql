-- Zomato project

-- customer table (1st child table)

create table customers
( customer_id int primary key,
customer_name varchar(100),
reg_date date);

-- resturant table 2nd child

create table restaurants
(restarunt_id int primary key,
restaurant_name varchar(100),
opening_hours varchar(100));

-- order table parent for customer and restarunts

create table orders
(order_id int primary key,
customer_id int,
restarunt_id int,
order_item varchar(100),
order_date date,
order_time time,
order_status varchar(100),
total_time float);

-- rider table parent for delivery table

create table riders
(rider_id int primary key,
rider_name varchar(55),
sign_up date);

-- deliveries table

create table deliveries
(delivery_id int primary key,
order_id int,
delivery_status varchar(100),
delivery_time time,
rider_id int,
foreign key(order_id) references orders(order_id),
foreign key(rider_id) references riders(rider_id)
);

-- adding fk's 

alter table orders add constraint fk_customers
foreign key (customer_id) references customers(customer_id);

-- adding fk's 

alter table orders add constraint fk_restaurants
foreign key(restarunt_id) references restaurants(restarunt_id);

show tables;

