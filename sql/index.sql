-- Марченко А.А.


-- Задание 1
-- Напишите запрос к учебной базе данных, который вернет процентное отношение общего размера всех индексов к общему размеру всех таблиц.

SELECT TABLE_NAME, DATA_LENGTH, INDEX_LENGTH, (INDEX_LENGTH /(DATA_LENGTH/100))   
FROM information_schema.TABLES
WHERE DATA_LENGTH <> 0 AND INDEX_LENGTH <> 0



-- Задание 2
-- Выполните explain analyze следующего запроса:

select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id

EXPLAIN
-> Limit: 200 row(s)  (cost=0.00..0.00 rows=0) (actual time=5945.555..5945.588 rows=200 loops=1)
    -> Table scan on <temporary>  (cost=2.50..2.50 rows=0) (actual time=5945.553..5945.576 rows=200 loops=1)
        -> Temporary table with deduplication  (cost=0.00..0.00 rows=0) (actual time=5945.550..5945.550 rows=391 loops=1)
            -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=2308.504..5728.935 rows=642000 loops=1)
                -> Sort: c.customer_id, f.title  (actual time=2308.447..2382.480 rows=642000 loops=1)
                    -> Stream results  (cost=10523191.71 rows=16282307) (actual time=0.439..1824.959 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=10523191.71 rows=16282307) (actual time=0.434..1573.906 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=8890890.46 rows=16282307) (actual time=0.429..1393.220 rows=642000 loops=1)
                                -> Nested loop inner join  (cost=7258589.22 rows=16282307) (actual time=0.423..1193.368 rows=642000 loops=1)
                                    -> Inner hash join (no condition)  (cost=1608774.80 rows=16086000) (actual time=0.413..54.660 rows=634000 loops=1)
                                        -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.68 rows=16086) (actual time=0.031..5.686 rows=634 loops=1)
                                            -> Table scan on p  (cost=1.68 rows=16086) (actual time=0.022..4.012 rows=16044 loops=1)
                                        -> Hash
                                            -> Covering index scan on f using idx_title  (cost=103.00 rows=1000) (actual time=0.039..0.297 rows=1000 loops=1)
                                    -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.25 rows=1) (actual time=0.001..0.002 rows=1 loops=634000)
                                -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.00 rows=1) (actual time=0.000..0.000 rows=1 loops=642000)
                            -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.00 rows=1) (actual time=0.000..0.000 rows=1 loops=642000)

-- Узкие места запроса:
-- Использование оконных функций
-- Длительная сортировка
-- Перечисление таблиц вместо их объединения (join)                            
                            
                            
                            
                            