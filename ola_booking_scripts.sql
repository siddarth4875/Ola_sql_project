create database ola;
use ola;
select count(*) from bookings;

-- 1. Retrieve all successful bookings:
select * 
from bookings
where booking_status= 'Success';

-- 2. Find the average ride distance for each vehicle type:
select vehicle_type, avg(ride_distance)
from bookings
group by 1;

-- 3. Get the total number of cancelled rides by customers:
select count(booking_status)
from bookings
where booking_status ='Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides:
select customer_id,count(booking_id) as number_of_rides
from bookings
group by 1
order by 2 desc
limit 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(booking_id)
from bookings
where booking_status = 'Canceled by Driver' and canceled_rides_by_driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
select min(driver_ratings),max(driver_ratings)
from bookings
where vehicle_type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI
select * from bookings
where payment_method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
Select Vehicle_type, avg(customer_rating)
from bookings
group by 1;

-- 9. Calculate the total booking value of rides completed successfully:
select sum(booking_value) as total_booking_value
from bookings
where booking_status ='Success';

-- 10. List all incomplete rides along with the reason:
select incomplete_rides,incomplete_rides_reason
from bookings
where incomplete_rides = 'Yes';

-- 11.Find the total booking value generated from each payment method.
select payment_method,sum(booking_value) as total_booking_val
from bookings
group by 1;

-- 12.Calculate the monthly cancellation rate 
-- (total cancelled rides by customers and drivers ÷ total bookings).
select extract(year from date) as year,
       extract(month from date) as month,
       cast(sum(case when booking_status like 'Canceled %' then 1 else 0 end)as float)/count(booking_id) as cancellation_rate
from bookings
group by 1,2
order by 1,2;

-- 13.List the top 3 most popular pickup and drop location pairs based on successful rides.
select pickup_location,drop_location,
       sum(case when booking_status ='Success' then 1 else 0 end) as total_ride
from bookings
group by 1,2
order by 3 desc
limit 3;