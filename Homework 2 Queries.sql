use bank;

#Retrieval Queries
#1. Find all loan number for loans made at the Perryridge branch with loan amounts 
#greater than $1100.
select loan_number from loan where amount > 1100
and branch_name = 'Perryridge';

#2. Find the loan number of those loans with loan amounts between $1,000 and $1,500
#(that is, >=$1,000 and <=$1,500).
select loan_number from loan where amount between 1000 and 1500;

#3. Find the names of all branches that have greater assets than some branch located in
#Brooklyn.
select distinct branch_name from branch 
where assets > some
(select assets from branch where branch_city = 'Brooklyn');

#4. Find the customer names and their loan numbers for all customers having a loan at
#some branch.
select borrower.* from borrower, loan
where borrower.loan_number = loan.loan_number;

#5. Find all customers who have a loan, an account, or both.
select customer_name from depositor
union
select customer_name from borrower;

#6. Find all customers who have an account but no loan.
select distinct customer_name from depositor
where customer_name not in
(select customer_name from borrower);

#7. Find the number of depositors for each branch.
select branch_name, count(customer_name) from account, depositor
where depositor.account_number = account.account_number
group by branch_name;

#8. Find the names of all branches where the average account balance is more than $500.
select branch_name, avg(balance) from account
group by branch_name
having avg(balance) > 500;

#9. Find all customers who have both an account and a loan at the bank.
select customer_name from borrower
where customer_name in
(select customer_name from depositor);

#10. Find all customers who have a loan at the bank but do not have an account at the
#bank
select customer_name from borrower
where customer_name not in
(select customer_name from depositor);

#11. Find the names of all branches that have greater assets than all branches located in
#Horseneck. (using both non-nested and nested select statement)
#Nested
select distinct branch_name from branch
where assets > all
(select assets from branch where branch_city = 'Horseneck');

#12. Find the name of the borrower with the lowest balance in their account
select borrower.customer_name, min(balance) from borrower, account, depositor
where depositor.account_number = account.account_number
and depositor.customer_name = borrower.customer_name;

#13. For each city, find the number of customers that live there.
select customer_city, count(customer_name) from customer
group by customer_city; 


#Insert Queries
#1. Create a HighLoan table with loan amount >=1500.
create table if not exists HighLoan as
select * from loan where amount >= 1500;
select * from HighLoan;

#2. Create a HighSalaryEmployee table with employee having salary more than 2000.
create table if not exists HighSalaryEmployee as
select * from employee where salary > 2000;
select * from HighSalaryEmployee;

#3. 1 more query (meaningful) of your choice on any table. Create a HighBalance table of
#account holders with balances >= 700
create table if not exists HighBalance as
select * from account where balance >= 700;
select * from HighBalance;


#Update Queries
#1. Increase all accounts with balances over $800 by 7%, all other accounts receive 8%.
select * from account;
update account
set balance = balance + (balance * .07)
where balance > 800;
update account
set balance = balance + (balance * .08)
where balance <= 800;
select * from account;
delete from account;

#2. Do 2 update queries, each involving 2 tables.
#(1) Change all A-101 account numbers of acccount holders and depositors to A-103
select * from account;
select * from depositor;
update account
set account_number = 'A-103'
where account_number = 'A-102';
update depositor
set account_number = 'A-103'
where account_number = 'A-102';
select * from account;
select * from depositor;
delete from account;
delete from depositor; 

#(2) All accounts and employees at the Downtown branch were moved to the Brighton branch.
#This is because the Downtown branch is under maintenance, 
#making the Brighton branch the only available branch in Brooklyn.
select * from account;
select * from employee;
update account
set branch_name = 'Brighton'
where branch_name = 'Downtown';
update employee
set branch_name = 'Brighton'
where branch_name = 'Downtown';
select * from account;
select * from employee;
delete from employee;
delete from account;

#3. 1 more update query of your choice on any table.
#Decrease all assets by 4%
select * from branch;
update branch
set assets = assets - (assets * .04);
select * from branch;
delete from branch;


#Delete Queries
#1. Delete the record of all accounts with balances below the average at the bank.
select * from account;
delete from account
where balance < (select * from
(select avg(balance) from account) as t);
select * from account;

#2. Do 2 update queries, each involving 2 tables.
#(1) Delete the first account that has one of the most frequently 
#occuring branch names in employee.
select * from account;
delete from account
where branch_name = 
(select branch_name from
(select max(num), branch_name from 
(select count(branch_name) as num, branch_name from account) as a) as b);
select * from account;

#(2) Delete all customers who do not live in a city with a branch
select * from customer;
delete from customer
where customer_city not in
(select branch_city from branch);
select * from customer;

#3. 1 more delete query of your choice from any table.
# Delete all loans with transactions made at Perryridge
select * from loan;
delete from loan
where branch_name = 'Perryridge';
select * from loan;


#Views Queries
#1. A view consisting of branches and their customers
create view branchAndCustomer as
select branch_name, customer_name from customer, branch
where customer_city = branch_city;
select * from branchAndCustomer;
drop view branchAndCustomer;

#2. Create a view of HQEmployee who work in downtown branch
create view HQEmployee as 
select * from employee
where branch_name = 'Downtown';
select * from HQEmployee;


#3. Do one insert, delete, update, and select queries on HQEmployee view.
#Insert. Insert a new HQ employee with name 'Bollinger' and salary 2400.
insert into HQEmployee values('Bollinger', 'Downtown', 2400);
select * from HQEmployee;

#Delete. Delete all HQ employees who have a salary that is less than 2000.
delete from employee;
delete from HQEmployee
where salary < 2000;
select * from HQEmployee;

#Update. Increase all salaries of HQ employees with salaries less than 2000 by 10%.
update HQEmployee
set salary = salary + (salary * .1)
where salary < 2000;
select * from HQEmployee;

#Select. Select all HQ employees who have a loan.
select distinct HQEmployee.* from HQEmployee, depositor
where employee_name = customer_name;

drop view HQEmployee;


#Complex Queries: provide results
#1. 1 select query involving 3 tables
#Find the names of all customers who are employees and have a loan
select distinct customer.customer_name from customer, employee, depositor
where customer.customer_name = employee.employee_name
and customer.customer_name = depositor.customer_name;

#2. 1 Delete query involving 3 tables
#Delete all branches that do not have an account of a customer that also has a loan
select * from branch;
delete from branch
where branch_name not in 
(select branch_name from account
where account_number in 
(select account_number from depositor));
select * from branch;

#3. 1 Update query involving 3 tables
#Increase the salary of all employees with loans greater than 1000 by 20%'
select * from employee;
update employee
set salary = salary + (salary * .2)
where employee_name in 
(select customer_name from borrower 
where loan_number in
(select loan_number from loan 
where amount > 1000));
select * from employee;
delete from employee;