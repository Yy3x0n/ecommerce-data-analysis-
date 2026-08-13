use ecommerce;
select *
from orders;

select *
from customers;

# 配送超时分析
select 
  case 
      when timestampdiff(day,order_estimated_delivery_date,order_delivered_customer_date) <=0 then '准时/提前送达'
      when timestampdiff(day,order_estimated_delivery_date,order_delivered_customer_date) <=3 then '超时1-3天'
      when timestampdiff(day,order_estimated_delivery_date,order_delivered_customer_date) <=7 then '超时4-7天'
      else '超时7天以上'
  end as '配送时效分区',
  count(order_id) as '订单数量'
from orders
where order_delivered_customer_date is not null
  and order_estimated_delivery_date is not null
group by `配送时效分区`
order by  count(order_id) desc;




# 查看各个地区的订单超时率
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS 地区总订单,
    SUM(CASE
        WHEN TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date)
        > TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_estimated_delivery_date)
        THEN 1 ELSE 0 END) AS 超时订单数,
    ROUND(
        SUM(CASE
            WHEN TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date)
            > TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_estimated_delivery_date)
            THEN 1 ELSE 0 END)
        / COUNT(DISTINCT o.order_id)*100,2
    ) AS 超时率
FROM customers c
LEFT JOIN orders o USING (customer_id)
GROUP BY c.customer_state
ORDER BY 超时率 DESC;


