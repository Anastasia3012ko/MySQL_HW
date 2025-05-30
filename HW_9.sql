/*1. Для каждого заказа order_id выведите минимальный, максмальный и средний unit_cost*/
SELECT
	purchase_order_id, unit_cost,
	MIN(unit_cost) OVER (partition by purchase_order_id) min_unit_cost_in_order,
	MAX(unit_cost) OVER (partition by purchase_order_id) max_unit_cost_in_order,
	AVG(unit_cost) OVER (partition by purchase_order_id) average_unit_cost_in_order
FROM purchase_order_details;


/*2  Оставьте только уникальные строки из предыдущего запроса */
SELECT 
    purchase_order_id,
    MIN(unit_cost) min_unit_cost_in_order,
    MAX(unit_cost) max_unit_cost_in_order,
    AVG(unit_cost) average_unit_cost_in_order
FROM
    purchase_order_details
GROUP BY purchase_order_id;


/*3 Посчитайте стоимость продукта в заказе как quantity*unit_cost Выведите суммарную стоимость продуктов с помощью оконной функции Сделайте то же самое с помощью GROUP BY */

-- window_function
SELECT 
	purchase_order_id, 
    product_id, 
    quantity * unit_cost AS product_price,
	SUM(quantity * unit_cost) OVER (PARTITION BY purchase_order_id, product_id) AS sum_product_price_in_order
FROM purchase_order_details;

-- group by
SELECT 
    purchase_order_id,
    product_id,
    SUM(quantity * unit_cost) AS sum_product_price_in_order
FROM
    purchase_order_details
GROUP BY purchase_order_id, product_id
ORDER BY purchase_order_id;


/*4 Посчитайте количество заказов по дате получения и posted_to_inventory Если оно превышает 1 то выведите '>1' в противном случае '=1'
Выведите purchase_order_id, date_received и вычисленный столбец */

SELECT id,
	date_received,
    posted_to_inventory,
    COUNT(*) OVER (PARTITION BY date_received, posted_to_inventory ORDER BY date_received) AS number_of_orders_per_date,
    IF((COUNT(*) over (PARTITION BY date_received, posted_to_inventory ORDER BY date_received)) >1 ,'>1', '=1') AS quantity_relative_one
FROM purchase_order_details;

-- group by

SELECT 
    id,
    date_received,
    posted_to_inventory,
    COUNT(*) AS number_of_orders_per_date,
    IF(COUNT(*) > 1, '>1', '=1') AS quantity_relative_one
FROM
    purchase_order_details
GROUP BY date_received , posted_to_inventory
ORDER BY date_received;



