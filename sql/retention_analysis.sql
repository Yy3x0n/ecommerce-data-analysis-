USE ecommerce;
select *
from orders;
select *
from customers;

# 用户留存与复购分析


# 用户首次购买时间
select 
  c.customer_unique_id,
  min(o.order_purchase_timestamp) as `首次下单时间` 
from customers c
join orders o
using(customer_id)
group by c.customer_unique_id;

# 每月新增用户
SELECT
    first_purchase_month AS `首次购买月份`,
    COUNT(*) AS `新增用户数`
FROM (
    SELECT
        c.customer_unique_id,
        DATE_FORMAT(
            MIN(o.order_purchase_timestamp),
            '%Y-%m'
        ) AS first_purchase_month
    FROM customers c
    JOIN orders o
        USING (customer_id)
    GROUP BY c.customer_unique_id
) t
GROUP BY first_purchase_month
ORDER BY first_purchase_month;



# 用户复购间隔
SELECT
    c.customer_unique_id AS `用户ID`,
    COUNT(DISTINCT o.order_id) AS `订单次数`,
    MIN(o.order_purchase_timestamp) AS `首次购买日期`,
    MAX(o.order_purchase_timestamp) AS `最后购买日期`,
    DATEDIFF(
        MAX(o.order_purchase_timestamp),
        MIN(o.order_purchase_timestamp)
    ) AS `复购间隔天数`
FROM customers c
JOIN orders o
    USING (customer_id)
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY `复购间隔天数` DESC;


# 月留存

SELECT
    t.first_purchase_month AS `首购月份`,
    t.purchase_month AS `购买月份`,
    COUNT(DISTINCT t.customer_unique_id) AS `留存用户数`
FROM (
    SELECT DISTINCT
        c.customer_unique_id,
        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        ) AS purchase_month,
        MIN(
            DATE_FORMAT(
                o.order_purchase_timestamp,
                '%Y-%m'
            )
        ) OVER (
            PARTITION BY c.customer_unique_id
        ) AS first_purchase_month
    FROM customers c
    JOIN orders o USING (customer_id)
) t
GROUP BY
    t.first_purchase_month,
    t.purchase_month
ORDER BY
    t.first_purchase_month,
    t.purchase_month