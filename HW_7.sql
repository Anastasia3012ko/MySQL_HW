/*
Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для каждого продукта таблица order_details.
*/
 -- 1
SELECT 
    p.product_name,
    quantity_product_in_orders.product_id,
    quantity_product_in_orders.sum_quantity
FROM
    products p
        LEFT JOIN
    (SELECT 
        product_id, SUM(quantity) AS sum_quantity
    FROM
        order_details
    GROUP BY product_id) AS quantity_product_in_orders ON p.id = quantity_product_in_orders.product_id;
    
    
-- 2 CTE
WITH cte_task1 AS (SELECT 
        product_id, SUM(quantity) AS sum_quantity
    FROM
        order_details
    GROUP BY product_id)

SELECT 
    p.product_name,
    cte1.product_id,
    cte1.sum_quantity
FROM
    products p
        LEFT JOIN cte_task1 cte1
     ON p.id = cte1.product_id;
     
/*
Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers.
*/

-- 1
SELECT 
    *
FROM
    orders
WHERE
    order_date > (SELECT 
            MIN(o.order_date)
        FROM
            orders o
                JOIN
            customers c ON c.id = o.customer_id
        WHERE
            last_name = 'Lee');

  -- 2(CTE)
WITH cte_task2 AS (SELECT 
            MIN(o.order_date) AS min_date
        FROM
            orders o
                JOIN
            customers c ON c.id = o.customer_id
        WHERE
            last_name = 'Lee')
SELECT 
    *
FROM
    orders
WHERE
    order_date > (SELECT min_date FROM cte_task2);
    
/*
Найти все продукты таблицы  products c максимальным target_level
*/

-- 1
SELECT 
    *
FROM
    products
WHERE
    target_level = (SELECT 
            MAX(target_level)
        FROM
            products);

-- 2 (CTE)
WITH  cte_task3 AS (SELECT 
            MAX(target_level) AS max_target_level
        FROM
            products)

SELECT 
    *
FROM
    products
WHERE
    target_level = (SELECT max_target_level FROM cte_task3);

    


