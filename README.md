# Hive-PostgreSQL-ETL
Warehousing data to Hive applying ETL to use PostgreSQL, and create a Superset dashboard.
## Data 
The used data is [Fifa 21 Dataset](https://www.kaggle.com/datasets/kumudini77/cleaned-fifa-21-player-dataset)       
Data have 12 tables, only used 10.
## Hadoop HDFS
At first, every .csv file was saved to a directory in the HDFS system, in /user/hive/warehouse.
## Hive Warehouse
Designed a dimensional model for the data warehouse, a hive code to save every .csv file to a table in the created **fifa21** database.
## PostgreSQL ETL
Utilized a Python script to aplly ETL into created PostgreSQL tables schema, and analysis queries. 
### used libraries
+ `pyhive` to connect to hive data warehouse.
+ `psycopg2` to connect to PostgreSQL, and use its queries in Python script.
## Superset Dashboard
+ Connected Superset to the database from PostgreSQL 
![{943D587A-49B6-4F37-97D4-60800F04E67D}](https://github.com/user-attachments/assets/e51dd34f-1fac-48c7-8376-c8a93d41ad37)

