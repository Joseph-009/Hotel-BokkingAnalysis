  
  use hotel_booking;
  
  # Importing data 
           load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\Hotel_Booking\\hotel_bookings.csv' into table hotel_bookings
fields terminated by ','
enclosed by '"'  
lines terminated by '\n'
ignore 1 lines;


# Counting Total Bookings:
SELECT COUNT(*) AS total_bookings
FROM Hotel_Bookings;


# Calculating Cancellation Rate:
SELECT 
    AVG(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100 AS cancellation_rate_percentage
FROM Hotel_Bookings;


# Identifying Booking Channels and Their Counts:
SELECT 
    distribution_channel,
    COUNT(*) AS booking_count
FROM Hotel_Bookings
GROUP BY distribution_channel
ORDER BY booking_count DESC;


#  Analyzing Lead Time Impact on Cancellations:
SELECT 
    lead_time,
    AVG(is_canceled) AS cancellation_rate
FROM Hotel_Bookings
GROUP BY lead_time
ORDER BY lead_time;


# Understanding Market Segments and Their Booking Trends:
SELECT 
    market_segment,
    COUNT(*) AS booking_count,
    AVG(is_canceled) AS cancellation_rate
FROM Hotel_Bookings
GROUP BY market_segment
ORDER BY booking_count DESC;


# Monthly Booking Trends:
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



# Seasonal Booking Trends:
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


# Monthly Average Daily Rate (ADR):
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



# Seasonal Average Daily Rate (ADR):
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



# Finding Average Daily Rate (ADR) by Hotel Type:
SELECT 
    hotel,
    AVG(adr) AS avg_daily_rate
FROM Hotel_Bookings
GROUP BY hotel;





# Identifying top 10 Countries with Highest Booking Volume:
SELECT 
    country,
    COUNT(*) AS booking_count
FROM Hotel_Bookings
GROUP BY country
ORDER BY booking_count DESC
LIMIT 10; -- Limiting to top 10 countries for example



#  Checking for Guests with Special Requests:
SELECT 
    CASE 
        WHEN total_of_special_requests > 0 THEN 'Yes'
        ELSE 'No'
    END AS has_special_requests,
    COUNT(*) AS guest_count
FROM Hotel_Bookings
GROUP BY has_special_requests;


# cancellations by special requests
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
















