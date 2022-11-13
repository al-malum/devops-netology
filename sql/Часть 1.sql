SELECT * FROM customer c LIMIT 1;


-- 1 задание
SELECT DISTINCT(district) 
FROM address AS a 
WHERE LOWER(district) LIKE 'k%a' AND LOWER(district) NOT LIKE ' ';

-- 2 задание
SELECT * FROM payment AS p
WHERE DATE(payment_date) BETWEEN '2005-06-15' AND '2005-06-18';

-- 3 задание
SELECT payment_date from payment 
ORDER BY payment_date 
DESC LIMIT 0, 5;


-- 4 задание
SELECT LOWER(first_name), LOWER(last_name), REPLACE(LOWER(first_name), 'll', 'pp') FROM customer AS c
WHERE LOWER(first_name) = 'kelly' OR LOWER(first_name) = 'willie'

-- 5 задание
SELECT email, 
		SUBSTR(email, 1, (POSITION('@' IN email) - 1)),
		SUBSTR(email, POSITION('@' IN email) + 1)
FROM customer;


