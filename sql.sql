select * from blinkit_data;


SELECT DISTINCT Item_Fat_Content FROM blinkit_data;

update blinkit_data
set item_fat_content =
case 
when  item_fat_content in ('LF', 'low fat') then 'Low Fat'
when  item_fat_content = 'reg' then 'Regular'
else  item_fat_content
enD

-- total_sales
select cast(sum(sales)/1000000 as DECIMAL(10,2)) as total_sales_millions
from blinkit_data

 -- avg_sales
 
select ROUND(avg(sales):: numeric) as avg_sales 
from blinkit_data;

-- number of items
select  count(item_identifier) as no_of_item
from blinkit_data


-- avg rating
select ROUND(avg(rating):: numeric , 1) as avg_rating
from blinkit_data

-- total sales by fat concent

select item_fat_content ,ROUND(sum(sales)::numeric, 2) as total_sales_by_fatcontent
from blinkit_data
group by item_fat_content;

-- total sales by item type
select item_type, cast(sum(sales) as decimal(10,2)) as total_sales_by_item
from blinkit_data
group by item_type
order by total_sales_by_item desc

-- fat content by outlet of total sales

SELECT 
    outlet_location_type,

    round(SUM(CASE 
            WHEN item_fat_content = 'Low Fat' 
            THEN sales ELSE 0 
        END):: numeric ,2) AS low_fat,

    round(SUM(CASE 
            WHEN item_fat_content = 'Regular' 
            THEN sales ELSE 0 
        END)::numeric, 2) AS regular

FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY outlet_location_type;



-- total sales by outlet estlabishment with all the metric

select outlet_establishment_year, ROUND(sum(sales)::numeric,2) as total_sales,
CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(item_visibility) AS DECIMAL(10,2)) AS Item_Visibility
from blinkit_data
group by outlet_establishment_year
order by outlet_establishment_year

-- F. Percentage of Sales by Outlet Size
select outlet_size, 
cast(sum(sales) as decimal(10,2)) as total_sales,
cast(sum(sales) * 100.0 /
(select sum(sales) from blinkit_data) as decimal(10,2)) as percentages_sales
from blinkit_data
group by outlet_size
order by total_sales DESC;

-- G. Sales by Outlet Location with all metric
select outlet_location_type,
cast(sum(sales)as decimal(10,2)) as total_sales_as_location,
CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(item_visibility) AS DECIMAL(10,2)) AS Item_Visibility,
		cast(sum(sales) * 100.0 /
(select sum(sales) from blinkit_data) as decimal(10,2)) as percentages_sales
from blinkit_data
group by outlet_location_type
order by total_sales_as_location DESC;

 -- All Metrics by Outlet Type:
 SELECT Outlet_Type, 
CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(item_visibility) AS DECIMAL(10,2)) AS Item_Visibility,
		cast(sum(sales) * 100.0 /
(select sum(sales) from blinkit_data) as decimal(10,2)) as percentages_sales

FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC






