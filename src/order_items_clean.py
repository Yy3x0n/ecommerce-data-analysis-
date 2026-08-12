import pandas as pd

# 读取数据集
order_items = pd.read_csv("data/raw/olist_order_items_dataset.csv")

#查询是否有空值
order_items.isnull().sum()

#查询重复值
order_items.duplicated().sum()

#转换时间字段
order_items["shipping_limit_date"] = pd.to_datetime(order_items["shipping_limit_date"])

order_items["shipping_limit_date"].head(5)


#查询价格和运费是否有负值
print(order_items[order_items["price"] < 0])
print(order_items[order_items["freight_value"] < 0])

#查看金额类型
print(order_items["price"].dtype)
print(order_items["freight_value"].dtype)

#查看主键是否有重复值
print(order_items.head(6))