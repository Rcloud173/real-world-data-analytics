select * from products
select * from reorders
select * from shipments
select * from stock_entries
select * from suppliers


-- 1 Total suppliers
select count(*) as total_suppliers from suppliers

-- 2 Total products
select count(*) as total_products from products

-- 3 Total categories dealing
select count(distinct category) from products

-- 4 Total sales value made in 3 months (quantities * price)
select round(sum(abs(se.change_quantity)*price),2) as total_sales_value_in_last_3_months
from stock_entries as se
join products as p
on p.product_id= se.product_id
where se.change_type = "Sale"
and
se.entry_date>=
	(
		select date_sub(max(entry_date),interval 3 month) from stock_entries
	)
    
-- 5 Total Restock value made in 3 months (quantities * price)
select round(sum(abs(se.change_quantity)*price),2) as total_restock_value_in_last_3_months
from stock_entries as se
join products as p
on p.product_id= se.product_id
where se.change_type = "Restock"
and
se.entry_date>=
	(
		select date_sub(max(entry_date),interval 3 month) from stock_entries
	)
    
-- 6
select count(*) from products as p where p.stock_quantity < p.reorder_level
and product_id NOT IN
(
select distinct product_id from reorders where status="Pending"
)

