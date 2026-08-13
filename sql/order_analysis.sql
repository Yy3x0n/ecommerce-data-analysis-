USE ecommerce;
SELECT *
FROM orders;
SELECT *
FROM order_items;


# 总订单量、GMV、整体客单价
SELECT
  COUNT(DISTINCT o.order_id) AS `总订单量`,
  ROUND(SUM(oi.price),2) AS `总GMV`,
  ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id),2) AS `整体客单价`
FROM orders o
JOIN order_items oi 
USING (order_id);


#按月：订单数量、销售额、客单价趋势 
SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS `下单年月`,
    COUNT(DISTINCT o.order_id) AS `当月订单数`,
    ROUND(SUM(oi.price),2) AS `当月GMV`,
    ROUND(SUM(oi.price)/COUNT(DISTINCT o.order_id),2) AS `当月客单价`
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY `下单年月`
ORDER BY `下单年月`;
