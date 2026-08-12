import pandas as pd

category_name = pd.read_csv("data/raw/product_category_name_translation.csv")


# 查看前5行数据
print(category_name.head())

# 查看数据类型
print(category_name.dtypes)

# 查看数据缺失情况
print(category_name.isnull().sum())

# 查看数据重复情况
print(category_name.duplicated().sum())

# 查看数据基本信息
print(category_name.info())

# 导出数据
category_name.to_csv("data/processed/category_name.csv", index=False)