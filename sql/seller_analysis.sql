use ecommerce;
select *
from sellers;
select *
from order_items;
select *
from order_reviews;

# 卖家销售额TOP排行
select    
    s.seller_id,   
    count(distinct oi.order_id) as `订单数`,   
    count(oi.product_id) as `商品售出总数`,   
    round(sum(oi.price),2) as `GMV`,   
    round(sum(oi.freight_value),2) as `总运费收入`,   
    round(avg(oi.price),2) as `商品平均售价` 
from sellers s 
join order_items oi using (seller_id) 
group by s.seller_id 
order by `GMV` desc;

# 卖家GMV与梯队分层
select    
    s.seller_id,
    round(sum(oi.price),2) as `总GMV`,
    rank() over (order by round(sum(oi.price),2) desc) as `销量排名`,
    case
        when sum(oi.price) >100000 then '头部卖家'
        when sum(oi.price) >30000 then '腰部卖家'
        else '长尾卖家'
    end as `卖家梯队`
from sellers s 
join order_items oi using(seller_id)
group by s.seller_id
order by `总GMV` desc;


# 卖家口碑分析
select 
  s.seller_id,
  count(distinct o.order_id) as `订单数`,
  round(avg(r.review_score),2) as `平均评分`,
  sum(case when r.review_score <=2 then 1 else 0 end) as `差评数量`,
  round(sum(case when r.review_score <=2 then 1 else 0 end)/count(*)*100,2) as `差评率` 
from sellers s
join order_items oi
using (seller_id)
join orders o
using (order_id)
join order_reviews r
using(order_id)
group by s.seller_id
order by `平均评分` desc;

