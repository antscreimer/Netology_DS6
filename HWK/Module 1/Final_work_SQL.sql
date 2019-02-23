CREATE TABLE wagon_repair (
  repair_id INTEGER PRIMARY KEY,
  wagon_id INTEGER,
  depot_id INTEGER,
  repair_type VARCHAR(100),
  cost numeric(8,2)
  );
  
CREATE TABLE wagon (
  wagon_id INTEGER PRIMARY KEY,
  wagon_type VARCHAR(100)
  );
INSERT INTO wagon VALUES
(1, 'Open wagon'),-- Полувагон
(2, 'Flat wagon'),-- Платформа
(3, 'Covered wagon'),-- Крытый вагон
(4, 'Tank wagon');-- Цистерна

CREATE TABLE detail (
  detail_id INTEGER PRIMARY KEY,
  wagon_id INTEGER,
  detail_name VARCHAR
 );

INSERT INTO detail VALUES
(1, 'wheelset'), -- колесная пара
(2, 'truck bolster'), -- надрессорная балка
(3, 'side frame'), -- боковая рама
(4, 'coupler'); -- тяговый хомут

CREATE TABLE depot (
  ID INTEGER,
  depot_id INTEGER,
  detail_id INTEGER,
  depot_name VARCHAR(100),
  detail_quantity INTEGER
 );
