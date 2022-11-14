-- Марченко А.А.


-- Задание 1.
-- Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей и выведите в результат следующую информацию:

-- фамилия и имя сотрудника из этого магазина,
-- город нахождения магазина,
-- количество пользователей, закрепленных в этом магазине.



SELECT s.store_id, a.address, s.manager_staff_id, CONCAT_WS(' ',st.first_name, st.last_name) AS employee, COUNT(c.customer_id) AS customer
FROM store AS s
JOIN customer AS c ON s.store_id = c.store_id
JOIN staff AS st ON s.manager_staff_id = st.staff_id
JOIN address AS a ON s.address_id = a.address_id
GROUP BY store_id
HAVING customer > 300


-- Задание 2.
-- Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.


SELECT f.title, f.`length`
FROM film AS f 
WHERE f.`length` > (SELECT AVG(f2.`length`) FROM film AS f2)


-- Задание 3.
-- Получите информацию, за какой месяц была получена наибольшая сумма платежей и добавьте информацию по количеству аренд за этот месяц..


SELECT SUM(p.amount) AS summary, MONTH(p.payment_date) AS mon, COUNT(r.rental_id) AS cnt_transaction
FROM payment AS p
JOIN rental AS r ON r.rental_id = p.rental_id 
GROUP BY mon
HAVING summary = (SELECT SUM(p2.amount) AS smr FROM payment p2 GROUP BY MONTH(p2.payment_date) ORDER BY smr DESC LIMIT 1)


-- Задание 4.
-- Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия».
-- Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».


SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS name,
	   COUNT(r.rental_id) AS cnt_rental,
	   (CASE
	   	WHEN COUNT(r.rental_id) > 8000 THEN 'yes'
	   END) AS 'Premium'
FROM staff AS s
JOIN rental AS r ON s.staff_id = r.staff_id
GROUP BY name


