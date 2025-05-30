/*1 
Таблица order_details
Для каждого product_id выведите inventory_id а также предыдущий и последующей inventory_id по убыванию quantity
*/
SELECT 
    product_id, inventory_id, quantity,
    LEAD(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS lead_inventory_id,
    LAG(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS lag_inventory_id
FROM
    order_details;


/*
2 Выведите максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST VALUE  Вывести order_id и полученные значения
*/
SELECT
  order_id,
  unit_price,

  FIRST_VALUE(unit_price) OVER (
    PARTITION BY order_id
    ORDER BY unit_price
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS min_unit_price_by_orderID,

  LAST_VALUE(unit_price) OVER (
    PARTITION BY order_id
    ORDER BY unit_price
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS max_unit_price_by_orderID

FROM order_details;

/*
3 Выведите order_id и столбец с разнице между  unit_price для каждой заказа и минимальным unit_price в рамках одного заказа Задачу решить двумя способами - с помощью First VAlue и MIN
*/
-- 1

SELECT
  order_id,
  unit_price,
  FIRST_VALUE(unit_price) OVER (
    PARTITION BY order_id
    ORDER BY unit_price
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS min_unit_price_by_order,
  unit_price - FIRST_VALUE(unit_price) OVER (
    PARTITION BY order_id
    ORDER BY unit_price
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS diff_unit_price_and_min_unit_price
FROM
  order_details;

-- 2 
SELECT
  order_id,
  unit_price,
  MIN(unit_price) OVER (PARTITION BY order_id) AS min_unit_price_by_order,
  unit_price - MIN(unit_price) OVER (PARTITION BY order_id) AS diff_unit_price_and_min_unit_price
FROM
  order_details;


/*
4 Присвойте ранг каждой строке используя RANK по убыванию quantity
*/
select 
	order_id,
	quantity,
	RANK() OVER (ORDER BY quantity DESC) AS rank_by_quantity
from order_details; 

/*
5  Из предыдущего запроса выберите только строки с рангом до 10 включительно
*/
WITH cte_rank AS (
  SELECT
    order_id,
    quantity,
    RANK() OVER (ORDER BY quantity DESC) AS rank_by_quantity
  FROM order_details
)
SELECT *
FROM cte_rank
WHERE rank_by_quantity <= 10;