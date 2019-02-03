-- POLICJANT i NAGRODA


SELECT * 
FROM policjant;

SELECT * 
FROM nagroda;

-- INNER JOIN 
SELECT *
FROM policjant p JOIN nagroda n ON p.policjant_id = n.policjant_id;

-- LEFT JOIN
SELECT *
FROM policjant p LEFT JOIN nagroda n ON p.policjant_id = n.policjant_id;

-- LEFT JOIN
SELECT *
FROM policjant p RIGHT JOIN nagroda n ON p.policjant_id = n.policjant_id;

-- LEFT JOIN (bez części wspólnej)
SELECT *
FROM policjant p LEFT JOIN nagroda n ON p.policjant_id = n.policjant_id
WHERE n.policjant_id IS NULL;

-- RIGHT JOIN (bez części wspólnej)
SELECT *
FROM policjant p RIGHT JOIN nagroda n ON p.policjant_id = n.policjant_id
WHERE p.policjant_id IS NULL;

-- FULL OUTER JOIN
SELECT *
FROM policjant p LEFT JOIN nagroda n ON p.policjant_id = n.policjant_id
UNION
SELECT *
FROM policjant p RIGHT JOIN nagroda n ON p.policjant_id = n.policjant_id;


-- FULL OUTER JOIN (bez części wspólnej
SELECT *
FROM policjant p LEFT JOIN nagroda n ON p.policjant_id = n.policjant_id
WHERE n.policjant_id IS NULL
UNION
SELECT *
FROM policjant p RIGHT JOIN nagroda n ON p.policjant_id = n.policjant_id
WHERE p.policjant_id IS NULL;
