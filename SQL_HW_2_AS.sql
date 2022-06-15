/*������� ������� employees
- id. serial,  primary key,
- employee_name. Varchar(50), not null
��������� ������� employee 70 ��������.*/


CREATE TABLE employees (id serial PRIMARY KEY, employee_name VARCHAR(50) NOT NULL);
INSERT INTO employees(employee_name)
VALUES ('�������'),
	   ('�����'),
       ('�����'),
       ('����'),
       ('�������'),
       ('�������'),
       ('������'),
       ('��������'),
       ('ϸ��'),
       ('�������'),
       ('�������'),
       ('�����'),
       ('����'),
       ('����������'),
       ('���������'),
       ('�������'),
       ('�������'),
       ('����'),
       ('���������'),
       ('�����'),
       ('�����'),
       ('�������'),
       ('������'),
       ('����'),
       ('��������'),
       ('�������'),
       ('��������'),
       ('���������'),
       ('����'),
       ('������'),
       ('������'),
       ('�����'),
       ('�������'),
       ('�������'),
       ('������'),
       ('������'),
       ('�����'),
       ('�������'),
       ('�������'),
       ('�����'),
       ('������'),
       ('������'),
       ('��������'),
       ('�����'),
       ('�����'),
       ('����'),
       ('����'),
       ('�������'),
       ('����'),
       ('�����'),
       ('�������'),
       ('������'),
       ('�������'),
       ('����'),
       ('������'),
       ('�����'),
       ('��'),
       ('��������'),
       ('�����'),
       ('������'),
       ('����'),
       ('���������'),
       ('��������'),
       ('������'),
       ('���������'),
       ('�������'),
       ('�����'),
       ('Ը���'),
       ('������'),
       ('���');
       

/*������� ������� salary
- id. Serial  primary key,
- monthly_salary. Int, not null
��������� ������� salary 16 ��������:
- 1000
- 1100
- 1200
- 1300
- 1400
- 1500
- 1600
- 1700
- 1800
- 1900
- 2000
- 2100
- 2200
- 2300
- 2400
- 2500*/

CREATE TABLE salary (id serial PRIMARY KEY, monthly_salary INT NOT NULL);
INSERT INTO salary (monthly_salary)
VALUES (1000),
       (1100),
	   (1200),
	   (1300),
	   (1400),
	   (1500),
	   (1600),
	   (1700),
	   (1800),
	   (1900),
	   (2000),
	   (2100),
	   (2200),
	   (2300),
	   (2400),
       (2500);
       

/*������� ������� employee_salary
- id. Serial  primary key,
- employee_id. Int, not null, unique
- salary_id. Int, not null
��������� ������� employee_salary 40 ��������:
- � 10 ����� �� 40 �������� �������������� employee_id*/

CREATE TABLE employee_salary (id serial PRIMARY KEY, employee_id INT UNIQUE NOT NULL, salary_id INT NOT NULL);
INSERT INTO employee_salary (employee_id, salary_id)
VALUES (1,3),
	   (71, 10),
	   (2, 16),
	   (3, 15),
	   (72, 2),
	   (12, 4),
	   (4, 7),
	   (73, 13),
	   (22, 2),
	   (45, 14),
	   (74, 3),
	   (55, 11),
	   (75, 9),
	   (42, 8),
	   (76, 5),
	   (33, 3),
	   (77, 13),
	   (44, 7),
	   (25, 6),
	   (78, 12),
	   (67, 5),
	   (11, 11),
	   (79, 2),
	   (80, 10),
	   (66, 7),
	   (70, 15),
	   (7, 7),
	   (9, 15),
	   (10, 10),
	   (34, 14),
	   (20, 2),
	   (30, 3),
	   (40, 14),
	   (50, 15),
	   (60, 5),
	   (14, 14),
	   (18, 7),
	   (21, 12),
	   (32, 16),
	   (57, 5);
	
    
/*������� ������� roles
- id. Serial  primary key,
- role_name. int, not null, unique
�������� ��� ������ role_name � int �� varchar(30)
��������� ������� roles 20 ��������:

role_name:
Junior Python developer
Middle Python developer
Senior Python developer
Junior Java developer
Middle Java developer
Senior Java developer
Junior JavaScript developer
Middle JavaScript developer
Senior JavaScript developer
Junior Manual QA engineer
Middle Manual QA engineer
Senior Manual QA engineer
Project Manager
Designer
HR
CEO
Sales manager
Junior Automation QA engineer
Middle Automation QA engineer
Senior Automation QA engineer*/

CREATE TABLE roles (id serial PRIMARY KEY, role_name INT UNIQUE NOT NULL);
ALTER TABLE roles
ALTER COLUMN role_name type VARCHAR (30);
INSERT INTO roles(role_name)
VALUES ('Junior Python developer'),
       ('Middle Python developer'),
       ('Senior Python developer'),
       ('Junior Java developer'),
       ('Middle Java developer'),
       ('Senior Java developer'),
       ('Junior JavaScript developer'),
       ('Middle JavaScript developer'),
       ('Senior JavaScript developer'),
       ('Junior Manual QA engineer'),
       ('Middle Manual QA engineer'),
       ('Senior Manual QA engineer'),
       ('Project Manager'),
       ('Designer'),
       ('HR'),
       ('CEO'),
       ('Sales manager'),
       ('Junior Automation QA engineer'),
       ('Middle Automation QA engineer'),
       ('Senior Automation QA engineer');

/*������� ������� roles_employee
- id. Serial  primary key,
- employee_id. Int, not null, unique (������� ���� ��� ������� employees, ���� id)
- role_id. Int, not null (������� ���� ��� ������� roles, ���� id)
��������� ������� roles_employee 40 ��������.*/

CREATE TABLE roles_employee 
(id serial PRIMARY KEY, employee_id INT UNIQUE NOT NULL, role_id INT NOT NULL, 
FOREIGN KEY (employee_id) REFERENCES employees (id), 
FOREIGN KEY (role_id) REFERENCES roles (id));
INSERT INTO roles_employee (employee_id, role_id)
VALUES (2, 16),
	   (3, 20),
	   (1, 18),
	   (10, 10),
	   (20, 1),
	   (30, 4),
	   (40, 14),
	   (50, 4),
	   (60, 15),
	   (70, 7),
	   (5, 5),
	   (15, 1),
	   (25, 3),
	   (35, 2),
	   (45, 19),
	   (55, 17),
	   (65, 6),
	   (7, 8),
	   (17, 13),
	   (27, 9),
	   (37, 11),
	   (47, 12),
	   (56, 1),
	   (64, 4),
	   (33, 3),
	   (22, 20),
	   (44, 12),
	   (6, 7),
	   (9, 9),
	   (8, 12),
	   (18, 1),
	   (59, 19),
	   (28, 8),
	   (39, 18),
	   (58, 7),
	   (34, 5),
	   (14, 10),
	   (61, 1),
	   (38, 18),
	   (43, 9);
	   
	 