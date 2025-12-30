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
)


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



