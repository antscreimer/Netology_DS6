CREATE TABLE wagon_repair (
  repair_id INTEGER PRIMARY KEY,
  wagon_id INTEGER,
  depot_id INTEGER,
  repair_type VARCHAR(100),
  cost
  );
  
CREATE TABLE wagon (
  wagon_id INTEGER PRIMARY KEY,
  wagon_type VARCHAR(100)
  );
  
CREATE TABLE detail (
  detail_id INTEGER PRIMARY KEY,
  wagon_id INTEGER,
  detail_name
 );
 
CREATE TABLE depot (
  ID INTEGER,
  depot_id INTEGER,
  detail_id INTEGER,
  depot_name VARCHAR(100),
  detail_quantity INTEGER
 );

CREATE TABLE warehousing (
  detail_id
  depot
