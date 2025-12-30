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
create table doctors
(
  doctorid int auto_increment primary key,
  name varchar(50),
  specialization varchar(100),
  role varchar(50),
  departmentid int,
  foreign key (departmentid) references departments(departmentid)
);


-- CREATE PATIENTS
create table PATIENTS
(
	Patientid int auto_increment primary key,
    name varchar(50),
    DateofBirth date,
    Gender varchar(1),
    phone varchar(15),
    check (gender in('m','f','o'))
);


-- CREATE APPOINTMENT
create table APPOINTMENTS
(
	appointmentid int auto_increment primary key,
    patientid int,
    doctorid int,
    appointmenttime datetime,
    status varchar(50),
    foreign key (patientid) references patients(patientid),
    foreign key (doctorid) references doctors(doctorid),
    check (status in ('Scheduled','Completed', 'Cancelled'))
);

-- PRESCRIPTION TABLE
create table PRESCRIPTIONS
(
	PRESCRIPTIONNID int auto_increment primary key,
    appointmentid int,
    MEDICATION varchar(100),
    DOSAGE varchar(100),
    foreign key (appointmentid) references APPOINTMENTS(appointmentid)
);

-- BILLS TABLE
create table BILLS
(
	BILLID int auto_increment primary key,
    appointmentid int,
    AMOUNT decimal(10,2),
    PAID tinyint(1),
    BILLDATE DATETIME default current_timestamp,
	foreign key (appointmentid) references APPOINTMENTS(appointmentid)
 );  


-- LABREPORT TABLES
create table LABREPORTS
(
	REPORTID int auto_increment primary key,
    appointmentid int,
    REPORTDATA text,
    CREATEDATE datetime default current_timestamp,
    foreign key (appointmentid) references APPOINTMENTS(appointmentid)
);


-- INSERTION IN DATABASE

-- INSERTING VALUES INTO DEPARTMENT TABLE
SELECT * FROM HOSPITAL_DATA;

SELECT `Departments.DepartmentID` FROM HOSPITAL_DATA;


SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA='meddata'
AND TABLE_NAME='HOSPITAL_DATA'
and COLUMN_NAME LIKE 'Departments.%';
insert into departments(departmentID,name) 
select`Departments.DepartmentID`,`Departments.Name`from hospital_data
where `Departments.DepartmentID`<>'';

select * from departments;

-- INSERTING VALUES INTO DOCTORS TABLE
select concat('select', group_concat(concat('`',COLUMN_NAME,'`')), 'form hospital_data')
from INFORMATION_SCHEMA.COLUMNS
where
table_schema = 'meddata'
AND table_name = 'hospital_data'
and column_name like 'doctors.%';

INSERT INTO DOCTORS( DepartmentID, DoctorID,Name,Role, Specialization)
select`Doctors.DepartmentID`,`Doctors.DoctorID`,`Doctors.Name`,
`Doctors.Role`,`Doctors.Specialization`from hospital_data
WHERE `Doctors.DepartmentID`<>'';

select * from DOCTORS;


-- PATIENT 
SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA='meddata'
AND TABLE_NAME='HOSPITAL_DATA'
and COLUMN_NAME LIKE 'PATIENTS.%';

INSERT INTO PATIENTS (PatientID, NAME, DATEOFBIRTH, GENDER, PHONE)
SELECT 
  `Patients.PatientID`,
  `Patients.Name`,
  STR_TO_DATE(`Patients.DateOfBirth`, '%d-%m-%Y'),  -- Correct format
  `Patients.Gender`,
  `Patients.Phone`
FROM HOSPITAL_DATA
WHERE `Patients.PatientID` <> '';

select * from patients



























