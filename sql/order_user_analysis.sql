USE ecommerce;

#查看数据表
SELECT *
FROM customers;
SELECT *
FROM orders;
SELECT *
FROM order_items;

# 每个真实用户的下单次数
SELECT 
    customer_unique_id,
    COUNT(DISTINCT o.order_id) AS 下单次数
FROM customers c
LEFT JOIN orders o 
USING (customer_id)
GROUP BY c.customer_unique_id
ORDER BY 下单次数 DESC
LIMIT 10;



# 各州的订单总量、平均商品价格、平均运费
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS 订单总量,
    ROUND(AVG(oi.price), 2) AS 平均商品价格,
    ROUND(AVG(oi.freight_value), 2) AS 平均运费
FROM customers c
left JOIN orders o
USING (customer_id)
LEFT JOIN order_items oi
USING (order_id)
GROUP BY c.customer_state
ORDER BY 订单总量 DESC;

# 卖家销量排行
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS 成交订单数,
    AVG(price) AS 商品均价
FROM order_items
GROUP BY seller_id
ORDER BY 成交订单数 DESC
LIMIT 10;


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