import pyhive
from pyhive import hive

conn_hive = hive.Connection(host="localhost", port=10000, username=None, password=None)
cursor_hive = conn_hive.cursor()

import psycopg2


cursor_pg.execute("CREATE DATABASE fifa21")

# Connect to the existing database 
conn = psycopg2.connect("host=172.23.0.2 dbname=fifa21 user=postgres password=postgres")
conn.set_session(autocommit=True)
cursor_pg = conn.cursor()

# Activate the database

cursor_hive.execute("USE fifa21")

hive_tables = [
    "attributes",
    "basic_info",
    "contract_info",
    "defensive",
    "goalkeeper",
    "market_values",
    "mental",
    "physical",
    "physical_market"
]

# Table schema dictionary 
table_schemas = {
    "attributes": """attributes (
        name VARCHAR(255) ,
        attacking INT,
        crossing INT,
        finishing INT,
        heading_accuracy INT,
        short_passing INT,
        volleys INT,
        skill INT,
        dribbling INT,
        curve INT,
        fk_accuracy INT,
        long_passing INT,
        ball_control INT
    )""",
    "basic_info": """basic_info (
        name VARCHAR(255) ,
        nationality VARCHAR(255),
        age INT,
        overall INT,
        potential INT,
        club VARCHAR(255)
    )""",
    "contract_info": """contract_info (
        name VARCHAR(255) ,
        contract VARCHAR(255)
    )""",
    "defensive": """defensive (
        name VARCHAR(255) ,
        defending INT,
        marking INT,
        standing_tackle INT,
        sliding_tackle INT
    )""",
    "goalkeeper": """goalkeeper (
        name VARCHAR(255) ,
        goalkeeping INT,
        gk_diving INT,
        gk_handling INT,
        gk_kicking INT,
        gk_positioning INT,
        gk_reflexes INT
    )""",
    "market_values": """market_values (
        name VARCHAR(255) ,
        value VARCHAR(255),
        wage VARCHAR(255)
    )""",
    "mental": """mental (
        name VARCHAR(255) ,
        mentality INT,
        aggression INT,
        interceptions INT,
        positioning INT,
        vision INT,
        penalties INT,
        composure INT
    )""",
    "physical": """physical (
        name VARCHAR(255),
        movement INT,
        acceleration INT,
        sprint_speed INT,
        agility INT,
        reactions INT,
        balance INT,
        power INT,
        shot_power INT,
        jumping INT,
        stamina INT,
        strength INT,
        long_shots INT
    )""",
    "physical_market": """physical_market (
        name VARCHAR(255) ,
        height INT,
        weight INT,
        preferred_foot VARCHAR(255),
        value VARCHAR(255),
        wage VARCHAR(255)
    )""",
}

# Create tables in PostgreSQL
for table_name in hive_tables:
    # Fetch data from Hive
    cursor_hive.execute(f"SELECT * FROM {table_name}")
    rows = cursor_hive.fetchall()

    # Get the corresponding PostgreSQL table schema
    table_schema = table_schemas.get(table_name, None)
    if not table_schema:
        print(f"Schema not defined for table: {table_name}")
        continue

    # Create corresponding PostgreSQL table with schema
    cursor_pg.execute(f"CREATE TABLE IF NOT EXISTS {table_schema}")

    # Insert data into PostgreSQL table
    cursor_pg.executemany(f"INSERT INTO {table_name} VALUES (%s, %s, %s, %s, %s, %s)", rows)


conn.commit()
cursor_pg.close()
conn.close()
cursor_hive.close()
conn_hive.close()
