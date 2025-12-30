-- Create Database
create database meddata;
use meddata;

-- CREATING DEPARTMENT TABLE
create table departments
(
	departmentID int auto_increment primary key,
    name varchar(50) not null
);

-- CREATING TABLE DOCTORS
