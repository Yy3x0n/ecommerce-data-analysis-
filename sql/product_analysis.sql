use ecommerce;

select *
from order_items;
select *
from products;
select *
from category_name;

select *
from order_reviews;

# 各商品分类成交件数、订单量、GMV排行
select 
   cn.product_category_name as '商品分类名称',
   count(distinct oi.order_id) as '下单订单数量',
   count(oi.product_id) as '商品成交数量',
   round(sum(oi.price),2) as '分类总销售额'
from order_items oi
join products p
using (product_id)
join category_name cn
using (product_category_name)
group by cn.product_category_name
order by round(sum(oi.price),2) desc;


# 每个分类商品平均售价、平均运费
select 
  cn.product_category_name as '商品分类名称',
  round(avg(oi.price),2) as '商品平均售价',
  round(avg(oi.freight_value),2) as '平均运费'
from order_items oi
join products 
using (product_id)
join category_name cn
using(product_category_name)
group by cn.product_category_name;


# 每个商品分类销售额TOP-5商品排名
SELECT *
FROM (
    SELECT
        cn.product_category_name,
        p.product_id,
        round(sum(oi.price),2) AS GMV,
        COUNT(DISTINCT oi.order_id) AS `下单订单数量`,
        RANK() OVER (PARTITION BY cn.product_category_name ORDER BY SUM(oi.price) DESC) as rk
    FROM order_items oi
    JOIN products p USING (product_id)
    JOIN category_name cn USING (product_category_name)
    GROUP BY cn.product_category_name, p.product_id
) AS sales_top
WHERE rk <= 5;



# 整体销量与评分对比
select 
  cn.product_category_name as '商品分类名称',
  count(distinct oi.order_id) as '分类总订单数',
  count(oi.product_id) as '商品分类总销量',
  round(avg(r.review_score),2) as '商品平均分'
from order_items oi
join products p
using (product_id)
join category_name cn
using (product_category_name)
left join order_reviews r
using (order_id)
group by cn.product_category_name
order by '商品分类总销量' desc;

  
