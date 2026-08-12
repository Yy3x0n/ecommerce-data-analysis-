import pandas as pd


# 读取数据集
order_reviews = pd.read_csv("data/raw/olist_order_reviews_dataset.csv")

# 查看数据集的前几行
order_reviews.head()

# 查看数据类型
print(order_reviews.dtypes)

# 查看缺失值
print(order_reviews.isnull().sum())

# 查看重复值
print(order_reviews.duplicated().sum())

# 查看评价用户id是否重复
print(order_reviews["review_id"].duplicated().sum())

# 删除重复的评价用户id
order_reviews = order_reviews.drop_duplicates(subset=["review_id"], keep="first")

# 查看删除重复值后的数据集
print(order_reviews["review_id"].duplicated().sum())

# 转换时间字段
order_reviews["review_creation_date"] = pd.to_datetime(order_reviews["review_creation_date"])
order_reviews["review_answer_timestamp"] = pd.to_datetime(order_reviews["review_answer_timestamp"])

# 查看转换后的时间字段
print(order_reviews.dtypes)

# 查看评分是否有异常值
print(order_reviews[(order_reviews["review_score"] < 0) | (order_reviews["review_score"] > 5)])




