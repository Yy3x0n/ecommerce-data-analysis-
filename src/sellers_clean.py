import pandas as pd
sellers = pd.read_csv("data/raw/olist_sellers_dataset.csv")

# 查看前5行数据
print(sellers.head(5))

# 查看数据类型
print(sellers.dtypes)

# 查看缺失值
print(sellers.isnull().sum())

# 查看重复值
print(sellers.duplicated().sum())

# 检查邮编是否异常
print(sellers[sellers["seller_zip_code_prefix"] <= 0])

# 导出数据
sellers.to_csv("data/processed/sellers.csv", index=False)