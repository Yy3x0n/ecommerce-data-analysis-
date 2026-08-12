import pandas as pd

# 读取数据集
orders = pd.read_csv("data/raw/olist_orders_dataset.csv")

# 转换时间字段
time_cols = [
    "order_purchase_timestamp",
    "order_approved_at",
    "order_delivered_carrier_date",
    "order_delivered_customer_date",
    "order_estimated_delivery_date"
]

for col in time_cols:
    orders[col] = pd.to_datetime(orders[col], errors="coerce")


# 统计订单状态
print(orders['order_status'].value_counts())

# 查看前5行数据
print(orders.head(5))

# 查询缺失值
print(orders.isnull().sum())
# 查询重复值
print("重复订单：", orders["order_id"].duplicated().sum())