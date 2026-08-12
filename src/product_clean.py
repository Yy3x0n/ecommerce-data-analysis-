import pandas as pd
products = pd.read_csv("data/raw/olist_products_dataset.csv")

products.head(5)


# 检查缺失值
products.isnull().sum()

# 商品类目缺失
products["product_category_name"] = products["product_category_name"].fillna("unknown")

# 填充缺失值
col = ['product_name_lenght', 'product_description_lenght', 'product_photos_qty']
for i in col:
    products[i] = products[i].fillna(0)


products[
    products["product_weight_g"].isna()
    | products["product_length_cm"].isna()
    | products["product_height_cm"].isna()
    | products["product_width_cm"].isna()
]

products = products.dropna(
    subset=[
        "product_weight_g",
        "product_length_cm",
        "product_height_cm",
        "product_width_cm"
    ]
)

products.isnull().sum()


# 导出数据
products.to_csv("data/processed/products.csv", index=False)
