-- DROP TABLE employees;

-- Создайте таблицу “workers” с полями (“id”, “birthday”, “name”, “salary”).
CREATE TABLE workers(
  id SERIAL PRIMARY KEY,
  birthday DATE,
  "name" VARCHAR(64),
  salary NUMERIC
);
--
-- Задачи на ALTER TABLE
-- К уже созданной таблице добавте поля "is_male", "email" и "department".
ALTER TABLE workers
ADD COLUMN is_male BOOLEAN,
  ADD COLUMN email VARCHAR (120),
  ADD COLUMN department VARCHAR (200);
-- Столбцу email добавте ограничение UNIQUE;
ALTER TABLE workers
ADD UNIQUE(email);
-- Затем удалите поле "department" отдельной командой.
ALTER TABLE workers DROP COLUMN department;
-- Добавте столбцу salary значение по умолчанию в 150$;
ALTER TABLE workers
ALTER COLUMN salary
SET DEFAULT 150;
-- Добвате столбцу salary ограничение NOT NULL;
ALTER TABLE workers
ALTER COLUMN salary
SET NOT NULL;
-- Переименуйте таблицу в employees;
ALTER TABLE workers
  RENAME TO employees;
--
-- Задачи на INSERT
-- Добавьте нового работника Никиту, 90го года, зарплата 300$.
INSERT INTO employees ("name", salary)
VALUES ('Никитa', 200);
-- Добавьте нового работника Светлану с зарплатой 1200$.
INSERT INTO employees ("name", salary)
VALUES ('Светланa', 1200);
-- Добавьте двух новых работников одним запросом: Ярослава с зарплатой 1200$ и годом 80го, Петра с зарплатой 1000$ и 93 года.
INSERT INTO employees ("name", salary, birthday)
VALUES ('Ярослав', 1200, '1980-01-01'),
  ('Петр', 1000, '1993-01-01');
-- (Так же добавте еще несколько пользователей чтобы раздуть табличку и иметь возможность делать задачки из следующего блока)
INSERT INTO employees ("name", salary, birthday)
VALUES ('Ярослав2', 1200, '1980-01-01'),
  ('ЖенЯ', 410, '1998-01-01'),
  ('Петр2', 1000, '1993-01-01');
--
-- Задачи на SELECT
-- Выбрать работника с id = 3.
SELECT *
FROM employees
WHERE id = 3;
-- Выбрать работников с зарплатой более 400$.
SELECT *
FROM employees
WHERE salary > 400;
-- Выбрать работников с зарплатой НЕ равной 500$.
SELECT *
FROM employees
WHERE salary != 400;
-- Выбрать работников с именем Петя.
SELECT *
FROM employees
WHERE "name" ~ 'Петр';
-- Выбрать всех, кроме работников с именем Петя.
SELECT *
FROM employees
WHERE "name" !~ 'Петр';
-- Узнайте зарплату и возраст Жени.
SELECT salary,
  age(birthday) AS age
FROM employees
WHERE "name" ~ 'Жен';
-- Выбрать всех работников в возрасте 27 лет или с зарплатой 1000$.
SELECT *
FROM employees
WHERE age(birthday) >= interval '27 year'
  OR salary = 1000;
-- Выбрать работников в возрасте от 25 (не включительно) до 28 лет (включительно).
SELECT *
FROM employees
WHERE age(birthday) > interval '25 year'
  AND age(birthday) <= interval '28 year';
-- Выбрать всех работников в возрасте от 23 лет до 27 лет или с зарплатой от 400$ до 1000$.
SELECT *
FROM employees
WHERE age(birthday) BETWEEN interval '23 year'
  AND interval '27 year'
  OR salary BETWEEN 400 AND 1000;
-- Выбрать всех работников в возрасте 27 лет или с зарплатой не равной 400$.
SELECT *
FROM employees
WHERE age(birthday) >= interval '27 year'
  OR salary != 400;
--
-- Задачи на UPDATE
-- Поставьте Никите зарплату в 425$.
UPDATE employees
SET salary = 425
WHERE "name" = 'Никитa';
-- Работнику с id=4 измените дату рождения так, чтобы год рождения стал 75-ым.
UPDATE employees
SET birthday = to_date(
    '1975' || to_char(
      EXTRACT(
        MONTH
        FROM birthday
      ),
      '-99-'
    ) || to_char(
      EXTRACT(
        DAY
        FROM birthday
      ),
      '99'
    ),
    'YYYY-MM-DD'
  )
WHERE id = 4;
-- Работникам-женщинам с id больше 2 и меньше 5 включительно установите заплату в 600$.
UPDATE employees
SET salary = 600
WHERE is_male = false
  AND id BETWEEN 2 AND 5;
-- Поменяйте Васю на Женю и поменяйте почту.
UPDATE employees
SET "name" = 'Женя',
  email = 'email@.com'
WHERE "name" = 'Вася';
--
-- Задачи на DELETE
-- Удалите работника с id=2.
DELETE FROM employees
WHERE id = 2;
-- Удалите всех Николаев.
DELETE FROM employees
WHERE "name" = 'Николай';
-- Удалите всех работников, у которых зарплата меньше 200$.
DELETE FROM employees
WHERE salary < 200;