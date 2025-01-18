# DataBase18.01

00
SELECT * FROM person WHERE adress ='Kazan'

01
SELECT * FROM person WHERE adress = 'Kazan' and gender = 'female' order by name

02
SELECT * FROM pezeria WHERE rating >= 3.5 and rating <= 5order by rating

03
SELECT * FROM person_visits WHERE (visit_date >= '2022-01-06' and visit_date <= '2022-01-09') or person_id = 2 order by pizzeria_id

04
SELECT 
    CONCAT(
        name,
        ' (age:',
        age,
        ',gender:''',
        gender,
        '''',
        ',adress:''',
        adress,
        ''')'
    )AS person_information
FROM person
ORDER BY person_information ASC;

05
SELECT
    (SELECT p.name
    FROM person p
    WHERE p.id = po.person_id
    ) AS name
FROM person_order po
WHERE po.menu_id IN (13, 14, 18) AND po.order_date = '2022-01-07';

06
SELECT
    p.name AS name,
    CASE
        WHEN EXISTS (SELECT 1 FROM person p2 WHERE p2.id = po.person_id AND p2.name = 'Denis') THEN TRUE
        ELSE FALSE
    END AS check_name
FROM person_order po
JOIN person p ON p.id = po.person_id
WHERE po.menu_id IN (13,14,18) AND po.order_date = '2022-01-07';

07
SELECT
    id,
    name,
    CASE
        WHEN age >= 10 AND age <= 20 THEN 'interval #1'
        WHEN age > 20 AND age < 24 THEN 'interval #2'
        ELSE 'interval #3'
    END AS interval_info
FROM person
ORDER BY interval_info ASC;

08
SELECT id, menu_id, order_date, person_id FROM person_order WHERE (id % 2) = 0 and (person_id % 2) = 0 and (menu_id % 2) = 0 order by id;

09
SELECT
    (SELECT p.name FROM person p WHERE p.id = pv.person_id) AS person_name,
    (SElECT piz.name FROM pizzeria piz WHERE piz.id = pv.pizzeria_id) AS pizzeria_name
FROM
    (SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv
ORDER BY person_name ASC, pizzeria_name DESC;





