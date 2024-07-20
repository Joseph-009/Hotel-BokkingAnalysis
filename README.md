# Project Scenario

I am a junior data analyst at a hotel chain and I have been tasked by my manager, Mona Queen, to analyze hotel booking data for purposes of optimizing revenue and customer retention strategies. The data set consists of very rich booking information where we are able to see a variety of patterns including booking cancellations, lead times, guest demographics, booking patterns across different market segments and distribution channels. 

# Task

I want to get through the data on reservations of hotel rooms to understand better customer behavior and know how cancellations could be reduced and direct bookings improved. Second, I shall work on booking patterns and the impact of the date of booking on the rate of cancellation, and marketing strategies ranked on effectiveness for bringing back customers.
___
--  Counting Total Bookings:
```sql
SELECT COUNT(*) AS total_bookings
FROM Hotel_Bookings;

```

--  Calculating Cancellation Rate:
```sql
SELECT 
    AVG(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100 AS cancellation_rate_percentage
FROM Hotel_Bookings;

```
-- Identifying Booking Channels and Their Counts:
```sql
SELECT 
    distribution_channel,
    COUNT(*) AS booking_count
FROM Hotel_Bookings
GROUP BY distribution_channel
ORDER BY booking_count DESC;

```
-- Analyzing Lead Time Impact on Cancellations:
```sql
SELECT 
    lead_time,
    AVG(is_canceled) AS cancellation_rate
FROM Hotel_Bookings
GROUP BY lead_time
ORDER BY lead_time;

```
--  Understanding Market Segments and Their Booking Trends:
```sql
SELECT 
    market_segment,
    COUNT(*) AS booking_count,
    AVG(is_canceled) AS cancellation_rate
FROM Hotel_Bookings
GROUP BY market_segment
ORDER BY booking_count DESC;

```
-- Monthly Booking Trends:
```sql
SELECT 
    arrival_date_month,
    COUNT(*) AS total_bookings
FROM Hotel_Bookings
GROUP BY arrival_date_month
ORDER BY 
    CASE 
        WHEN arrival_date_month = 'January' THEN 1
        WHEN arrival_date_month = 'February' THEN 2
        WHEN arrival_date_month = 'March' THEN 3
        WHEN arrival_date_month = 'April' THEN 4
        WHEN arrival_date_month = 'May' THEN 5
        WHEN arrival_date_month = 'June' THEN 6
        WHEN arrival_date_month = 'July' THEN 7
        WHEN arrival_date_month = 'August' THEN 8
        WHEN arrival_date_month = 'September' THEN 9
        WHEN arrival_date_month = 'October' THEN 10
        WHEN arrival_date_month = 'November' THEN 11
        WHEN arrival_date_month = 'December' THEN 12
    END;

```
-- Seasonal Booking Trends:
```sql
SELECT 
    CASE 
        WHEN arrival_date_month IN ('December', 'January', 'February') THEN 'Winter'
        WHEN arrival_date_month IN ('March', 'April', 'May') THEN 'Spring'
        WHEN arrival_date_month IN ('June', 'July', 'August') THEN 'Summer'
        WHEN arrival_date_month IN ('September', 'October', 'November') THEN 'Fall'
    END AS season,
    COUNT(*) AS total_bookings
FROM Hotel_Bookings
GROUP BY season
ORDER BY season;

```
-- Monthly Average Daily Rate (ADR):
```sql
SELECT 
    arrival_date_month,
    AVG(adr) AS avg_daily_rate
FROM Hotel_Bookings
GROUP BY arrival_date_month
ORDER BY 
    CASE 
        WHEN arrival_date_month = 'January' THEN 1
        WHEN arrival_date_month = 'February' THEN 2
        WHEN arrival_date_month = 'March' THEN 3
        WHEN arrival_date_month = 'April' THEN 4
        WHEN arrival_date_month = 'May' THEN 5
        WHEN arrival_date_month = 'June' THEN 6
        WHEN arrival_date_month = 'July' THEN 7
        WHEN arrival_date_month = 'August' THEN 8
        WHEN arrival_date_month = 'September' THEN 9
        WHEN arrival_date_month = 'October' THEN 10
        WHEN arrival_date_month = 'November' THEN 11
        WHEN arrival_date_month = 'December' THEN 12
    END;


```
-- Seasonal Average Daily Rate (ADR):
```sql
SELECT 
    CASE 
        WHEN arrival_date_month IN ('December', 'January', 'February') THEN 'Winter'
        WHEN arrival_date_month IN ('March', 'April', 'May') THEN 'Spring'
        WHEN arrival_date_month IN ('June', 'July', 'August') THEN 'Summer'
        WHEN arrival_date_month IN ('September', 'October', 'November') THEN 'Fall'
    END AS season,
    AVG(adr) AS avg_daily_rate
FROM Hotel_Bookings
GROUP BY season
ORDER BY season;
```
-- Finding Average Daily Rate (ADR) by Hotel Type:
```sql
SELECT 
    hotel,
    AVG(adr) AS avg_daily_rate
FROM Hotel_Bookings
GROUP BY hotel;
```
-- Identifying top 10 Countries with Highest Booking Volume:
```sql
SELECT 
    country,
    COUNT(*) AS booking_count
FROM Hotel_Bookings
GROUP BY country
ORDER BY booking_count DESC
LIMIT 10; -- Limiting to top 10 countries for example

```
--  Checking for Guests with Special Requests:
```sql
SELECT 
    CASE 
        WHEN total_of_special_requests > 0 THEN 'Yes'
        ELSE 'No'
    END AS has_special_requests,
    COUNT(*) AS guest_count
FROM Hotel_Bookings
GROUP BY has_special_requests;

```
-- cancellations by special requests and non request
```sql
SELECT 
    has_special_requests,
    COUNT(*) AS guest_count,
    AVG(is_canceled) AS cancellations_rate
FROM (
    SELECT 
        CASE 
            WHEN total_of_special_requests > 0 THEN 'Yes'
            ELSE 'No'
        END AS has_special_requests,
        is_canceled
    FROM Hotel_Bookings
) AS subquery
GROUP BY has_special_requests;
```

___
[Visualization using Tableau](https://public.tableau.com/views/HotelBookingAnalysis_17208589413710/HotelBookingAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
___

# Conclusion

#### After thorough analysis of the Hotel_Booking dataset, I found several key insights:
* Impact of Lead Time: What is detected also is that bookings made much earlier, are more likely to be cancelled which implies that efforts must be made towards offering incentives for early booking while at the same time decreasing cancellation rates near the time of arrival.

* Customer Segmentation: The booking patterns and the cancellation rates also vary from one country to another among the guests. This capacity is particularly significant since the regional preferences in marketing and pricing of the services can enhance the booking conversion.

* Booking Channels: It has also been found out that direct bookings have to little or no cancellations in comparison to bookings made through third party. Other strategies that may help increase the amount of direct bookings and ensure more loyal customers are offering promotions like a lower price or some other advertising bonus.

* Special Requests: People who make a special request during their bookings are likely to have a low cancellation rate meaning that fulfilling all customers’ requests is vital.

* Seasonal Variations: The study of the booking trends further show that summer and spring season have the highest occupancy rates for the rooms while the situation as far as the winter season is concerned is different all together. This points to possibilities of changing the prices and promotional offers flexibly, to get more bookings during the high demand and increase the occupancy rate during the cold season.
___
# Recommendations

- Conduct promotional strategies that will capture the general public and incline them to visit hotels repeatedly through plan and reward schemes.
- Maintain a balance of the occupancy rates and the revenue through the pricing of services depending on lead time and demand.
- Improve every aspect the customer relations solutions to enable the hotel to satisfy clients with special needs or interests, which would reduce the cases of cancellation.

Incorporating these findings and suggestions in the hotel chain, the necessary changes and strategies can be applied to maximize the revenue, increase the level of guests’ satisfaction and consequently, improve overall organizational performance.
___
