-- Create Database
CREATE DATABASE IF NOT EXISTS task8_demo;
USE task8_demo;

-- Create Sample Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO Employees (emp_name, department, salary) VALUES
('Alice', 'HR', 50000),
('Bob', 'IT', 60000),
('Charlie', 'Finance', 55000),
('David', 'IT', 65000),
('Eva', 'HR', 52000);

-- 1. STORED PROCEDURE EXAMPLE
-- Procedure: Get employees by department

DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
    SELECT emp_id, emp_name, salary
    FROM Employees
    WHERE department = dept_name;
END //
DELIMITER ;

-- Call Procedure
CALL GetEmployeesByDept('IT');

-- 2. FUNCTION EXAMPLE
-- Function: Calculate Bonus (10% of salary)

DELIMITER //
CREATE FUNCTION CalculateBonus(empSalary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);
    SET bonus = empSalary * 0.10;
    RETURN bonus;
END //
DELIMITER ;

-- Use Function
SELECT emp_name, salary, CalculateBonus(salary) AS Bonus
FROM Employees;

-- 3. PROCEDURE WITH OUT PARAMETER
-- Procedure: Get total salary of a department

DELIMITER //
CREATE PROCEDURE GetDeptTotalSalary(
    IN dept_name VARCHAR(50),
    OUT totalSalary DECIMAL(10,2)
)
BEGIN
    SELECT SUM(salary) INTO totalSalary
    FROM Employees
    WHERE department = dept_name;
END //
DELIMITER ;

-- Call Procedure with OUT parameter
SET @total = 0;
CALL GetDeptTotalSalary('HR', @total);
SELECT @total AS Total_Salary_HR;
