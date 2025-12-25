CREATE TABLE cathedrals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(1024) NOT NULL,
    chief VARCHAR(512) NOT NULL
);

ALTER TABLE groups ADD COLUMN cathedral_id INTEGER;
ALTER TABLE groups ADD FOREIGN KEY (cathedral_id) REFERENCES cathedrals(id);

INSERT INTO cathedrals (name, chief) VALUES
('Кафедра информационных технологий', 'Васильева Наталья Васильевна'),
('Математическая экономика и прикладная информатика', 'Матвеева Нюргуяна Николаевна');

SELECT * FROM cathedrals;
SELECT g.short_name, c.name as cathedral FROM groups g LEFT JOIN cathedrals c ON g.cathedral_id = c.id;


SELECT 
    id,
    name as cathedral_name,
    chief as head_of_cathedral
FROM cathedrals 
ORDER BY name;

UPDATE groups 
SET cathedral_id = (
    SELECT id FROM cathedrals 
    WHERE name = 'Кафедра информационных технологий'
)
WHERE short_name IN ('Б-ИВТ-25-1', 'Б-ИВТ-25-2', 'Б-ФИИТ-25');

UPDATE groups 
SET cathedral_id = (
    SELECT id FROM cathedrals 
    WHERE name = 'Математическая экономика и прикладная информатика'
)
WHERE short_name = 'Б-ПИ-25-1';

SELECT 
    g.short_name as group_code,
    g.name as group_full_name,
    g.year as admission_year,
    c.name as cathedral,
    c.chief as head_of_cathedral
FROM groups g
INNER JOIN cathedrals c ON g.cathedral_id = c.id
WHERE c.name = 'Кафедра информационных технологий'
ORDER BY g.short_name;

SELECT 
    g.short_name,
    g.name,
    COUNT(s.id) as student_count,
    c.name as cathedral
FROM groups g
JOIN cathedrals c ON g.cathedral_id = c.id
LEFT JOIN students s ON g.id = s.group_id
WHERE c.name = 'Кафедра информационных технологий'
GROUP BY g.id, g.short_name, g.name, c.name
ORDER BY g.short_name;

