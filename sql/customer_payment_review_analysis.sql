use ecommerce;
select *
from orders;
select *
from order_payments;
select *
from customers;
select *
from order_reviews;

# 不同地区用户的支付方式偏好
SELECT
    c.customer_state AS '用户所在州',
    op.payment_type AS '支付方式',
    COUNT(DISTINCT o.order_id) AS '订单数量',
    ROUND(SUM(op.payment_value),2) AS '总支付金额',
    ROUND(AVG(op.payment_value),2) AS '单笔支付均价'
FROM orders o
JOIN order_payments op USING (order_id)
JOIN customers c USING (customer_id)
GROUP BY c.customer_state, op.payment_type
ORDER BY c.customer_state, ROUND(SUM(op.payment_value),2) DESC;


# 不同支付方式的用户平均评分差异

select 
  op.payment_type as '支付方式',
  count(distinct o.order_id) as '订单数量',
  round(avg(r.review_score),2) as '平均评分',
  sum(case when r.review_score <=2 then 1 else 0 end) as '差评数量'
from orders o
join order_payments op using (order_id)
join order_reviews r using (order_id)
group by op.payment_type
order by round(avg(r.review_score),2);
  
