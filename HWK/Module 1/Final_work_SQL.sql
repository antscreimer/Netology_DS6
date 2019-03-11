-- Создание таблицы описания грузового вагона

CREATE TABLE wagon (
  wagon_id INTEGER PRIMARY KEY,
  wagon_type VARCHAR(100)
  );
INSERT INTO wagon VALUES
('1', 'Open wagon'),-- Полувагон
('2', 'Flat wagon'),-- Платформа
('3', 'Covered wagon'),-- Крытый вагон
('4', 'Tank wagon');-- Цистерна

-- Создание таблицы деталей вагона

CREATE TABLE detail (
  detail_id INTEGER PRIMARY KEY,
  -- wagon_id INTEGER,
  detail_name VARCHAR
 );

INSERT INTO detail VALUES
('1', 'wheelset'), -- колесная пара
('2', 'truck bolster'), -- надрессорная балка
('3', 'side frame'), -- боковая рама
('4', 'coupler'); -- тяговый хомут

-- Создание справочника депо

CREATE TABLE depot_name (
  ID INTEGER PRIMARY KEY,
  depot_name VARCHAR (100)
);

INSERT INTO depot_name VALUES
('1', 'central_depot'),
('2', 'north_depot'),
('3', 'south_depot'),
('4', 'east_depot'),
('5', 'west_depot'),
('6', 'reserve_depot');

-- Создание таблицы депо

CREATE TABLE depot_detail (
  ID INTEGER,
  depot_id INTEGER REFERENCES depot_name(id),
  detail_id INTEGER REFERENCES detail(detail_id),
  detail_quantity INTEGER
 );

INSERT INTO depot_detail VALUES
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
('17', 6, 1, 30),
('18', 6, 2, 20),
('19', 6, 3, 30),
('19', 6, 4, 20);

-- Создание таблицы ремонтов

CREATE TABLE wagon_repair (
  repair_id INTEGER,
  wagon_id INTEGER REFERENCES wagon(wagon_id),
  numb VARCHAR(10),
  detail_id INTEGER REFERENCES detail(detail_id),
  detail_quantity INTEGER,
  depot_id INTEGER REFERENCES depot_name(id),
  repair_type VARCHAR(100),
  price numeric
  );

INSERT INTO wagon_repair VALUES
('1', '1', '1o', '1', 2, '1', 'замена', 80000),
('2', '1', '2o', '2', 1, '1', 'замена', 10000),
('3', '1', '3o', '1', 1, '2', 'замена', 40000),
('4', '1', '3o', '3', 1, '2', 'замена', 20000),
('5', '1', '4o', '4', 2, '2', 'замена', 30000),
('6', '1', '5o', '3', 3, '3', 'замена', 60000),
('7', '1', '5o', '1', 2, '3', 'замена', 80000),
('8', '1', '5o', '4', 1, '3', 'замена', 15000),
('9', '2', '1f', '1', 2, '4', 'покупка', 160000),
('10', '2', '2f', '1', 1, '4', 'покупка', 80000),
('11', '2', '3f', '2', 2, '4', 'покупка', 40000),
('12', '2', '3f', '3', 1, '4', 'покупка', 40000),
('13', '2', '3f', '4', 1, '4', 'покупка', 30000),
('14', '2', '4f', '1', 2, '4', 'покупка', 160000),
('15', '3', '1с', '1', 1, '5', 'замена', 40000),
('16', '3', '1с', '4', 2, '5', 'замена', 30000),
('17', '3', '1с', '3', 1, '5', 'замена', 40000),
('18', '3', '2с', '1', 1, '5', 'покупка', 80000),
('19', '3', '2с', '2', 1, '5', 'покупка', 20000),
('20', '3', '3c', '4', 2, '5', 'покупка', 60000),
('21', '3', '4c', '2', 4, '5', 'покупка', 80000),
('22', '4', '1t', '1', 1, '6', 'замена', 40000),
('23', '4', '1t', '2', 1, '6', 'замена', 10000),
('24', '4', '1t', '3', 1, '6', 'замена', 20000),
('25', '4', '1t', '4', 1, '6', 'замена', 15000),
('26', '4', '2t', '2', 2, '6', 'замена', 20000),
('27', '4', '3t', '1', 2, '6', 'замена', 80000),
('28', '4', '4t', '4', 1, '6', 'покупка', 30000),
('29', '4', '5t', '1', 1, '6', 'покупка', 80000),
('30', '4', '6t', '2', 2, '6', 'покупка', 40000),
('31', '4', '7t', '1', 1, '6', 'покупка', 80000),
('32', '4', '7t', '2', 2, '6', 'замена', 20000);

--**********************************************

--Вывести номера, тип вагонов и тип деталей, требующих покупку деталей

SELECT DISTINCT

	wagon_repair.numb as wagon_number, 
	wagon.wagon_type as wagon_type, 
	wagon_repair.repair_type as wagon_repair_type,
	detail.detail_name as detail_name
    
FROM wagon_repair

LEFT JOIN wagon ON wagon_repair.wagon_id = wagon.wagon_id

LEFT JOIN detail ON wagon_repair.detail_id = detail.detail_id

WHERE wagon_repair.repair_type = 'покупка';

-- Вывести сумма счета, который выставит каждый депо в рамках ремонта 
-- вагонов. Упорядочить по возрастанию

SELECT

	wagon_repair.depot_id as depot_id, 
	depot_name.depot_name as depot_name,
	SUM(wagon_repair.price) as facture_amount
    
FROM wagon_repair

JOIN depot_name ON wagon_repair.depot_id = depot_name.id

GROUP BY depot_id, depot_name

ORDER BY facture_amount ASC;

-- Вывести депо или список депо (если больше 1), 
-- у которых больше количества деталей на складе

WITH temp_table AS (
  
  SELECT 
  depot_detail.depot_id as depot_id,
  depot_name.depot_name as depot_name,
  SUM(detail_quantity) as total_detail_quantity
  
  FROM depot_detail
  
  JOIN depot_name ON depot_detail.depot_id = depot_name.id
  
  GROUP BY depot_id, depot_name
  
  ORDER BY total_detail_quantity DESC
)

SELECT * FROM temp_table

WHERE total_detail_quantity = (
  
  SELECT MAX(total_detail_quantity) FROM temp_table);

-- Вывести сумму ремонта за каждый номерной вагон (Вывести также тип вагона)

WITH temp_table AS (
  
  SELECT
 
    wagon_repair.wagon_id as wagon_id,
    wagon_repair.numb as number,
    SUM(price) as wagon_repair_price

FROM wagon_repair

GROUP BY wagon_repair.wagon_id, wagon_repair.numb
)
SELECT

temp_table.wagon_id,
number,
wagon_repair_price,
wagon.wagon_type

FROM temp_table

LEFT JOIN wagon ON temp_table.wagon_id = wagon.wagon_id;

-- Вывести сумму затрат на ремонт по типу вагона

SELECT 

wagon_repair.wagon_id as wagon_id,
wagon.wagon_type,
SUM(price) as price_by_wagon_type

FROM wagon_repair

JOIN wagon ON wagon_repair.wagon_id = wagon.wagon_id

GROUP BY wagon_repair.wagon_id, wagon.wagon_type

ORDER BY price_by_wagon_type DESC;

-- Вывести список деталей с минимальным количеством в рамках депо

WITH temp_table AS (
  
  SELECT 
  
  depot_detail.depot_id,
  depot_name.depot_name,
  depot_detail.detail_id,
  detail.detail_name,
  MIN(detail_quantity) OVER (PARTITION BY depot_detail.depot_id) as    min_detail_qty,
  depot_detail.detail_quantity
  
  FROM depot_detail
  
  JOIN depot_name ON depot_detail.depot_id = depot_name.id
  
  JOIN detail ON detail.detail_id = depot_detail.detail_id
  
)
 
 SELECT * FROM temp_table
 
 WHERE min_detail_qty = detail_quantity;
 
-- Вывести остаток деталей в депо по итогам выполнения всех ремонтов
-- Условимся, что при замене, старая деталь не считается как актив депо

WITH temp_table AS (

SELECT 

depot_detail.depot_id,
depot_name.depot_name,
SUM(detail_quantity) as detail_total

FROM depot_detail

JOIN depot_name ON depot_detail.depot_id = depot_name.id

GROUP BY depot_detail.depot_id, depot_name.depot_name

ORDER BY depot_id
  
)
SELECT 

depot_detail.depot_id,
depot_name.depot_name,
