	-- Database creation

	CREATE DATABASE IF NOT EXISTS fifa21;

	-- Activate the database before using it everytime opening the hive shell.

	USE fifa21;
	------------------------""""""""""

	CREATE EXTERNAL TABLE IF NOT EXISTS attributes (
												
	    Name STRING,
	    Attacking INT,
	    Crossing INT,
	    Finishing INT,
	    Heading_Accuracy INT,
	    Short_Passing INT,
	    Volleys INT,
	    Skill INT,
	    Dribbling INT,
	    Curve INT,
	    FK_Accuracy INT,
	    Long_Passing INT,
	    Ball_Control INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/attributes'
	TBLPROPERTIES ("skip.header.line.count"="1");
	------------------------------------------------------------
	CREATE EXTERNAL TABLE IF NOT EXISTS basic_info (
												
	   Name STRING,
	    Nationality STRING,
	    Age INT,
	    Overall INT,
	    Potential INT,
	    Club STRING
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/basicInfo'
	TBLPROPERTIES ("skip.header.line.count"="1");
	-----------------------------------------------------
	CREATE EXTERNAL TABLE IF NOT EXISTS contract_info (
												
	    Name STRING,
	    Contract STRING
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/contractInfo'
	TBLPROPERTIES ("skip.header.line.count"="1");
	-----------------------------------------------------------
				

	CREATE EXTERNAL TABLE IF NOT EXISTS defensive (
												
	    Name STRING,
	    Defending INT,
		Marking INT,
		StandingTackle INT,
		SlidingTackle INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/defensive'
	TBLPROPERTIES ("skip.header.line.count"="1");
	-----------------------------------------------------
	CREATE EXTERNAL TABLE IF NOT EXISTS goalkeeper (
						

												
	    Name STRING,
	    Goalkeeping INT,
	    GKDiving INT,
	    GKHandling INT,
	    GKKicking INT,
	    GKPositioning INT,
	    GKReflexes INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/goalkeeper'
	TBLPROPERTIES ("skip.header.line.count"="1");
	---------------------------------------------------------
	CREATE EXTERNAL TABLE IF NOT EXISTS market_values (
								
						
	    Name STRING,
	    Value STRING,
		Wage STRING
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/market_values'
	TBLPROPERTIES ("skip.header.line.count"="1");
	-----------------------------------------------------
	----------------------------------------------------
	CREATE EXTERNAL TABLE IF NOT EXISTS mental (
						
	    Name STRING,
	    Mentality INT,
	    Aggression INT,
	    Interceptions INT,
	    Positioning INT,
	    Vision INT,
	    Penalties INT,
	    Composure INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/mental'
	TBLPROPERTIES ("skip.header.line.count"="1");
	----------------------------====================
	CREATE EXTERNAL TABLE IF NOT EXISTS physical (
						
											 		

																
			
	    Name STRING,
	    Movement INT,
	    Acceleration INT,
	    Sprint_Speed INT,
	    Agility INT,
	    Reactions INT,
	    Balance INT,
	    Power INT,
	    Shot_Power INT,
	    Jumping INT,
	    Stamina INT,	
	    Strength INT,
	    Long_Shots INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/physical'
	TBLPROPERTIES ("skip.header.line.count"="1");
	-===================================================
	CREATE EXTERNAL TABLE IF NOT EXISTS physical_market (
						
	    Name STRING,
	    Height INT,
	    Weight INT,
	    Preferred_Foot STRING,
	    Value STRING,
	    Wage STRING

	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/hive/warehouse/fifa21_data/pysical_market'
	TBLPROPERTIES ("skip.header.line.count"="1");

	-- Create the fact table

	CREATE EXTERNAL TABLE IF NOT EXISTS fact_players (

	    Name STRING,
	    Attacking INT,
	    Crossing INT,
	    Finishing INT,
	    Heading_Accuracy INT,
	    Short_Passing INT,
	    Volleys INT,
	    Skill INT,
	    Dribbling INT,
	    Curve INT,
	    FK_Accuracy INT,
	    Long_Passing INT,
	    Ball_Control INT,
	    Nationality STRING,
	    Age INT,
	    Overall INT,
	    Potential INT,
	    Club STRING,
	    Contract STRING,
	    Defending INT,
	    Marking INT,
	    StandingTackle INT,
	    SlidingTackle INT,
	    Goalkeeping INT,
	    GKDiving INT,
	    GKHandling INT,
	    GKKicking INT,
	    GKPositioning INT,
	    GKReflexes INT,
	    Value STRING,
	    Wage STRING,
	    Mentality INT,
	    Aggression INT,
	    Interceptions INT,
	    Positioning INT,
	    Vision INT,
	    Penalties INT,
	    Composure INT,
	    Movement INT,
	    Acceleration INT,
	    Sprint_Speed INT,
	    Agility INT,
	    Reactions INT,
	    Balance INT,
	    Power INT,
	    Shot_Power INT,
	    Jumping INT,
	    Stamina INT,	
	    Strength INT,	
	    Long_Shots INT,
	    Height INT,
	    Weight INT,
	    Preferred_Foot STRING
	);
	PARTITIONED BY (Name STRING, Overall INT);


	-- Enables dynamic partitioning, which means partitions are determined dynamically based on the data being inserted
	SET hive.exec.dynamic.partition.mode=nonstrict;

	-- Load the data into the fact table using the raw_sales_data table and products dimension table

INSERT INTO fact_players
SELECT
a.Name,
a.Attacking,
a.Crossing,
a.Finishing,
a.Heading_Accuracy,
a.Short_Passing,
a.Volleys,
a.Skill,
a.Dribbling,
a.Curve,
a.FK_Accuracy,
a.Long_Passing,
a.Ball_Control,
b.Nationality,
b.Age,
b.Overall,
b.Potential,
b.Club,
c.Contract,
d.Defending,
d.g,
d.dingTackle,
d.gTackle,
g.Goalkeeping,
g.GKDiving,
g.GKHandling,
g.GKKicking,
g.GKPositioning,
g.GKReflexes,
m.Value,
m.Wage,
n.Mentality,
n.Aggression,
n.Interceptions,
n.Positioning,
n.Vision,
n.Penalties,
n.Composure,
p.Movement,
p.Acceleration,
p.Sprint_Speed,
p.Agility,
p.Reactions,
p.Balance,
p.Power,
p.Shot_Power,
p.Jumping,
p.Stamina,
p.Strength,
p.Long_Shots,
pm.Height,
pm.Weight,
pm.Preferred_Foot
FROM
attributes a
JOIN basic_info b ON a.Name = b.Name
JOIN contract_info c ON a.Name = c.Name
JOIN defensive d ON a.Name = d.Name
JOIN goalkeeper g ON a.Name = g.Name
JOIN market_values m ON a.Name = m.Name
JOIN mental n ON a.Name = n.Name
JOIN physical p ON a.Name = p.Name
JOIN physical_market pm ON a.Name = pm.Name;

-- Analytical Queries to test the solution

-- E1:
FROM fact_players
ORDER BY Overall DESC
LIMIT 5;



