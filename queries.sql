with cte as(
select
a.Product,a.Category,a.Brand,a.Description,a.Sale_Price,a.Cost_Price,a.Image_url,
b.date_converted,b.Customer_Type,b.Discount_Band,b.Units_Sold,
(Sale_Price*Units_Sold) as Revenue,
(Cost_Price*Units_Sold) as Total_cost,
date_format(b.date_converted,'%M') as Month,
date_format(b.date_converted,'%Y') as Year
from product_data a
inner join product_sales b on a.Product_ID=b.Product)

select 
*,
(1-discount*1.0/100)* revenue as discount_revenue
from cte a
join discount_data b on trim(lower(a.Discount_Band))=trim(lower(b.Discount_Band)) and trim(lower(a.Month))=trim(lower(b.Month));