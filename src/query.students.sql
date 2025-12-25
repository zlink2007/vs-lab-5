CREATE TABLE IF NOT EXISTS institutes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(1024) NOT NULL
);

INSERT INTO institutes (name) 
VALUES ('Институт математики и информатики')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(2048) NOT NULL,
    short_name VARCHAR(64) NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    institute_id INTEGER NOT NULL,
    FOREIGN KEY (institute_id) REFERENCES institutes(id)
);

INSERT INTO groups (name, short_name, year, institute_id) VALUES
('Информатика и вычислительная техника', 'Б-ИВТ-25-1', 2025, 1),
('Информатика и вычислительная техника', 'Б-ИВТ-25-2', 2025, 1),
('Фундаментальная информатика и информационные технологии', 'Б-ФИИТ-25', 2025, 1),
('Прикладная информатика', 'Б-ПИ-25-1', 2025, 1)
ON CONFLICT (short_name) DO NOTHING;

SELECT 'Институты:' as table_name;
SELECT * FROM institutes;

SELECT 'Группы:' as table_name;
SELECT * FROM groups;


CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    surname VARCHAR(512) NOT NULL,
    name VARCHAR(512) NOT NULL,
    father_name VARCHAR(512),
    short_name VARCHAR(64) NOT NULL,
    group_id INTEGER NOT NULL,
    FOREIGN KEY (group_id) REFERENCES groups(id)
);

INSERT INTO students (surname, name, father_name, short_name, group_id) VALUES
('Константинов', 'Вячеслав', 'Александрович', 'konstantinov_va', 1),

('Третьяков', 'Антон', 'Петрович', 'tretyakov_ap', 1),
('Захарова', 'Сантейя', 'Сергеевна', 'zakharova_ss', 1),
('Михайлов', 'Василий', NULL, 'mikhailov_v', 1),
('Соловьев', 'Дмитрий', 'Александрович', 'soloviev_da', 1),
('Семенов', 'Альвар', NULL, 'semenov_a', 1),
('Попов', 'Сергей', 'Викторович', 'popov_sv', 1),
('Орлов', 'Илья', 'Олегович', 'orlov_io', 1),
('Николаев', 'Андрей', NULL, 'nikolaev_a', 1),
('Ся', 'Анастасия', 'Игоревна', 'sya_ai', 1);

SELECT 'Студенты:' as table_name;
SELECT * FROM students ORDER BY surname;

SELECT 
    s.surname,
    s.name,
    s.father_name,
    s.short_name,
    g.short_name as group_name
FROM students s
JOIN groups g ON s.group_id = g.id
ORDER BY s.surname;

SELECT id, name FROM institutes ORDER BY id;

SELECT 
    g.id,
    g.name as group_name,
    g.short_name,
    g.year,
    i.name as institute_name
FROM groups g
JOIN institutes i ON g.institute_id = i.id
ORDER BY g.year DESC, g.short_name;

SELECT 
    s.id,
    s.surname,
    s.name,
    s.father_name,
    s.short_name,
    g.short_name as group_name,
    g.year
FROM students s
JOIN groups g ON s.group_id = g.id
ORDER BY s.surname, s.name;

SELECT 
    g.short_name as group_name,
    COUNT(s.id) as student_count
FROM groups g
LEFT JOIN students s ON g.id = s.group_id
GROUP BY g.id, g.short_name
ORDER BY g.short_name;

SELECT 
    (SELECT COUNT(*) FROM institutes) as total_institutes,
    (SELECT COUNT(*) FROM groups) as total_groups,
    (SELECT COUNT(*) FROM students) as total_students;