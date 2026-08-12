import pandas as pd

#读取数据集
customers = pd.read_csv("data/raw/olist_customers_dataset.csv")

# 检查缺失值
customers.isnull().sum()

# 检查id字段是否有重复值
customers["customer_id"].duplicated().sum()

# 真实用户唯一id重复数量（多人多订单）
print(customers["customer_unique_id"].duplicated().sum())

# 每个州的订单数量
print(customers["customer_state"].value_counts())