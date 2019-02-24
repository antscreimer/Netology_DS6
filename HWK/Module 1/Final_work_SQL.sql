CREATE TABLE wagon_repair (
  repair_id INTEGER,
  wagon_id INTEGER,
  numb INTEGER,
  detail_id INTEGER,
  detail_number INTEGER,
  depot_id INTEGER,
  repair_type VARCHAR(100),
  price numeric(8,2)
  );

INSERT INTO wagon_repair VALUES
('1', '1', '1o', '1', 2, '1', 'замена', 80000),
('2', '1', '2o', '2', 1, '1', 'замена', 10000),
('3', '1', '3o', '1', 1, '2', 'замена', 40000),
('4', '1', '3o', '3', 1, '2', 'замена', 20000),
('5', '1', '4o', '4', 2, '2', 'замена', 30000),
('6', '1', '5o', '3', 3, '3', 'замена', 60000),
('7', '1', '5o', '1', 2, '3', 'замена', 80000),
  
CREATE TABLE wagon (
  wagon_id INTEGER PRIMARY KEY,
  wagon_type VARCHAR(100)
  );
INSERT INTO wagon VALUES
('1', 'Open wagon'),-- Полувагон
('2', 'Flat wagon'),-- Платформа
('3', 'Covered wagon'),-- Крытый вагон
('4', 'Tank wagon');-- Цистерна

CREATE TABLE detail (
  detail_id INTEGER PRIMARY KEY,
  wagon_id INTEGER,
  detail_name VARCHAR
 );

INSERT INTO detail VALUES
('1', 'wheelset'), -- колесная пара
('2', 'truck bolster'), -- надрессорная балка
('3', 'side frame'), -- боковая рама
('4', 'coupler'); -- тяговый хомут


CREATE TABLE depot_name (
  ID INTEGER,
  depot_name VARCHAR (100)
);

INSERT INTO depot_name VALUES
('1', 'central_depot'),
('2', 'north_depot'),
('3', 'south_depot'),
('4', 'east_depot'),
('5', 'west_depot'),
('6', 'reserve_depot');


CREATE TABLE depot (
  ID INTEGER,
  depot_id INTEGER,
  detail_id INTEGER,
  detail_quantity INTEGER
 );

INSERT INTO depot VALUES
('1', 1, 1, 20),
('2', 1, 2, 40),
('3', 1, 3, 25),
('4', 1, 4, 15),
('5', 2, 1, 15),
('6', 2, 2, 16),
('7', 2, 3, 17),
('8', 3, 1, 18),
('9', 3, 2, 20),
('10', 3, 4, 17),
('11', 4, 3, 21),
('12', 4, 4, 25),
('13', 5, 1, 30),
('14', 5, 2, 15),
('15', 5, 3, 8),
('16', 5, 4, 11), 
('17', 6, 2, 19),
('18', 6, 3, 15),
('19', 6, 4, 14);
