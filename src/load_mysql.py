import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "mysql+pymysql://root:041001@localhost:3306/ecommerce"
)

tables = {
    "customers": "data/processed/customers.csv",
    "orders": "data/processed/orders.csv",
    "order_items": "data/processed/order_items.csv",
    "order_payments": "data/processed/order_payments.csv",
    "order_reviews": "data/processed/order_reviews.csv",
    "products": "data/processed/products.csv",
    "sellers": "data/processed/sellers.csv",
    "category_name": "data/processed/category_name.csv"
}

for table_name, file_path in tables.items():

    df = pd.read_csv(file_path)

    df.to_sql(
        table_name,
        con=engine,
        if_exists="replace",
        index=False
    )

    print(f"{table_name} 导入完成，共 {len(df)} 行")