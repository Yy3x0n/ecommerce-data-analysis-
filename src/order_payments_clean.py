import pandas as pd

# 读取数据集
order_payments = pd.read_csv("data/raw/olist_order_payments_dataset.csv")

# 查看数据集的前几行
print(order_payments.head())


# 统计支付方式的数量
print(order_payments['payment_type'].value_counts())

# 查询缺失值
print(order_payments.isnull().sum())

# 查看重复值
print(order_payments.duplicated().sum())

# 付款金额校验，排查负数、0异常
print(order_payments["payment_value"].describe())
print("异常(金额<0)条数：",(order_payments["payment_value"] < 0).sum())

# 统计每笔订单的支付次数
print("每笔订单的支付次数：", order_payments.groupby("order_id")["payment_sequential"].max().value_counts())



# 导出数据
order_payments.to_csv("data/processed/order_payments.csv", index=False)