CREATE TABLE institutes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(1024) NOT NULL
);
CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(2048) NOT NULL,
    short_name VARCHAR(64) NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    institute_id INTEGER NOT NULL,
    FOREIGN KEY (institute_id) REFERENCES institutes(id)
);
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    surname VARCHAR(512) NOT NULL,
    name VARCHAR(512) NOT NULL,
    father_name VARCHAR(512),
    short_name VARCHAR(64) NOT NULL,
    group_id INTEGER NOT NULL,
    FOREIGN KEY (group_id) REFERENCES groups(id)
);