-- Марченко А.А.;


-- 1 задание
-- Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a”, и не содержат пробелов.
SELECT DISTINCT(district) 
FROM address AS a 
WHERE LOWER(district) LIKE 'k%a' AND LOWER(district) NOT LIKE ' ';

-- 2 задание
-- Получите из таблицы платежей за прокат фильмов информацию по платежам,
-- оторые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года включительно, 
-- и стоимость которых превышает 10.00.
SELECT * FROM payment AS p
WHERE DATE(payment_date) BETWEEN '2005-06-15' AND '2005-06-18' AND amount > 10;

-- 3 задание
-- Получите последние 5 аренд фильмов.
SELECT payment_date from payment 
ORDER BY payment_date 
DESC LIMIT 0, 5;


-- 4 задание
-- Одним запросом получите активных покупателей, имена которых Kelly или Willie.
-- Сформируйте вывод в результат таким образом:
-- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
-- замените буквы 'll' в именах на 'pp'
SELECT LOWER(first_name), LOWER(last_name), REPLACE(LOWER(first_name), 'll', 'pp') FROM customer AS c
WHERE LOWER(first_name) = 'kelly' OR LOWER(first_name) = 'willie'

-- 5 задание
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
-- в первой колонке должно быть значение, указанное до @, во второй значение, указанное после @.
SELECT email, 
		SUBSTR(email, 1, (POSITION('@' IN email) - 1)),
		SUBSTR(email, POSITION('@' IN email) + 1)
FROM customer;


