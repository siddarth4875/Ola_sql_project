
# OLA Cab Ride Data Analysis using SQL
![](https://github.com/Saswati-18/ola_Sql_project/blob/main/ola%20logo%20-3.png)

# Overview
This project involves a comprehensive analysis of OLA's cab ride data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

# Objectives
1.Retrieve all successful bookings.
2. Find the average ride distance for each vehicle type.
3. Get the total number of cancelled rides by customers.
4. List the top 5 customers who booked the highest number of rides.
5. Get the number of rides cancelled by drivers due to personal and car-related issues.
6. Find the maximum and minimum driver ratings for Prime Sedan bookings.
7. Retrieve all rides where payment was made using UPI.
8. Find the average customer rating per vehicle type.
9. Calculate the total booking value of rides completed successfully.
10. List all incomplete rides along with the reason.
11.Find the total booking value generated from each payment method.
12.Calculate the monthly cancellation rate.
13.List the top 3 most popular pickup and drop location pairs based on successful rides.
# Dataset
The data for this project is sourced from the Kaggle dataset:

# Schema
```sql
create database ola;
use ola;
```
Business Problems and Solutions
# 1. Retrieve all successful bookings
```sql
select * 
from bookings
where booking_status= 'Success';
```
Objective: Determine the number of successful booking

# 2. Find the average ride distance for each vehicle type
```sql
select vehicle_type, avg(ride_distance)
from bookings
group by 1;
```
Objective: Identify every month average how much km each vehicle is travelling.

# 3. Get the total number of cancelled rides by customers
```sql
select count(booking_status)
from bookings
where booking_status ='Canceled by Customer';
```
Objective: Retrieve the number of cabs cancelled by customers.

# 4. List the top 5 customers who booked the highest number of rides
```sql
select customer_id,count(booking_id) as number_of_rides
from bookings
group by 1
order by 2 desc
limit 5;
```
Objective: Identify the top 5 customers with the highest number of booked rides.

# 5. Get the number of rides cancelled by drivers due to personal and car-related issues
```sql
select count(booking_id)
from bookings
where booking_status = 'Canceled by Driver' and canceled_rides_by_driver = 'Personal & Car related issue';
```
Objective: Find the number of driver cancelled rides due to personal & Vehicle related issue.
# 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
```sql
select min(driver_ratings),max(driver_ratings)
from bookings
where vehicle_type = 'Prime Sedan';
```
Objective: Indentify the minimum and maximum ratings for Prime Sedan.
# 7. Retrieve all rides where payment was made using UPI
```sql
select * from bookings
where payment_method = 'UPI';
```
Objective: Numbers of payment done through UPI.

# 8. Find the average customer rating per vehicle type
```sql
Select Vehicle_type, avg(customer_rating)
from bookings
group by 1;
```
Objective: Identify average customer rating for each vehicle type.

# 9. Calculate the total booking value of rides completed successfully
```sql
select sum(booking_value) as total_booking_value
from bookings
where booking_status ='Success';
```
Objective: Total booking vaule for all successful rides.
# 10. List all incomplete rides along with the reason
```sql
select incomplete_rides,incomplete_rides_reason
from bookings
where incomplete_rides = 'Yes';
```
Objective: Identify all incomplete rides and the reason.

# 11. Find the total booking value generated from each payment method.
```sql
select payment_method,sum(booking_value) as total_booking_val
from bookings
group by 1;
```
Objective: Retrieve total booking value from all payment method  .

# 12. Calculate the monthly cancellation rate 
```sql
select extract(year from date) as year,
       extract(month from date) as month,
       cast(sum(case when booking_status like 'Canceled %' then 1 else 0 end)as float)/count(booking_id) as cancellation_rate
from bookings
group by 1,2
order by 1,2;
```
Objective: Calculate monthly calculation rate.
# 13. List the top 3 most popular pickup and drop location pairs based on successful rides
```sql
select pickup_location,drop_location,
       sum(case when booking_status ='Success' then 1 else 0 end) as total_ride
from bookings
group by 1,2
order by 3 desc
limit 3;
```
Objective: Retrive top 3 most popular pickup & drop location pairs based on successful rides

# Findings and Conclusion
* Booking Performance and Success Rate:Total booking value for successful rides is a crucial revenue indicator also indicating a stable demand for the service.
* Ride Distance and Vehicle Performance:The average ride distance per vehicle type varies, showing which vehicles are used for long or short-distance travel.
* Customer and Driver Cancellations: Customer-initiated cancellations are higher than driver cancellations, which suggests customer indecision or fare issues.The primary reason for driver 
  cancellations is personal and car-related issues, highlighting a need for vehicle maintenance and driver availability improvements.
* Customer Behavior & Revenue Trends:Top 5 customers contribute a significant number of rides, indicating loyal users who should be targeted with rewards or loyalty programs.Most popular pickup 
 and drop locations reveal high-demand routes, which can help in strategic driver deployment.
* Payment Trends:A substantial number of transactions were made via UPI, indicating a shift towards digital payments.
* Ride Completion & Quality:Incomplete rides and their reasons can help improve service quality and customer satisfaction.


