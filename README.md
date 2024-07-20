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

1. **Impact of Lead Time**: Bookings made further in advance tend to have higher cancellation rates, suggesting the need for targeted strategies to incentivize early bookings and reduce cancellations closer to the arrival date.

2. **Customer Segmentation**: Guests from different countries exhibit varying booking behaviors and cancellation rates. Tailoring marketing efforts and pricing strategies based on regional preferences can optimize booking conversion rates.

3. **Booking Channels**: Direct bookings show lower cancellation rates compared to bookings through third-party channels. Promoting direct booking incentives such as discounts or perks could increase revenue and customer loyalty.

4. **Special Requests**: Guests who make special requests during booking tend to have lower cancellation rates, highlighting the importance of personalized customer service and fulfilling guest preferences.

5. **Seasonal Variations**: Analyzing booking patterns reveals that summer and spring have the highest number of room bookings, while winter sees significantly fewer bookings. This suggests opportunities to adjust pricing and marketing strategies dynamically to maximize revenue during peak periods and attract more guests during the winter season.
___
# Recommendations

- Implement targeted marketing campaigns aimed at converting one-time guests into repeat customers through personalized offers and loyalty programs.
- Optimize pricing strategies based on lead time and seasonal demand to balance occupancy rates and revenue.
- Enhance customer service initiatives to meet special requests and preferences, thereby improving guest satisfaction and reducing cancellations.

By implementing these insights and recommendations, the hotel chain can effectively optimize revenue, enhance guest satisfaction, and improve overall operational efficiency.
___
