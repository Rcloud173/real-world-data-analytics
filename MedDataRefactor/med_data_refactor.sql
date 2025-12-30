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

select * from patients;

-- INSERT VALUES INTO APPOINTMENT TABLES
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'meddata'  
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'APPOINTMENTS.%';
  
INSERT INTO APPOINTMENTS(AppointmentID, PATIENTID, DOCTORID,AppointmentTime,Status)
SELECT`Appointments.AppointmentID`,`Appointments.PatientID`,
`Appointments.DoctorID`,
STR_TO_DATE(`Appointments.AppointmentTime`,'%d-%m-%Y %H:%i'),
`Appointments.Status`FROM HOSPITAL_DATA;

select * from appointments;


-- INSERTING VALUE INTO PRESCRIPTIONS
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'EHIAS'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'PRESCRIPTIONS.%';

INSERT INTO PRESCRIPTIONS (PRECRIPTIONID,AppointmentID,Medication,Dosage)
SELECT`Prescriptions.PrescriptionID`,`Prescriptions.AppointmentID`,
`Prescriptions.Medication`,`Prescriptions.Dosage`FROM HOSPITAL_DATA 
WHERE `Prescriptions.PrescriptionID` <>'';

SELECT * FROM PRESCRIPTIONS;


--  INSERT DATA INTO LABREPORTS
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'EHIAS'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'LABREPORTS.%';
  
INSERT INTO LABREPORTS(REPORTID, APPOINTMENTID, REPORTDATA, CREATEDAT)
SELECT `LabReports.ReportID`,`LabReports.AppointmentID`,`LabReports.ReportData`,
`LabReports.CreatedAt`FROM HOSPITAL_DATA
WHERE  `LabReports.ReportID`<>'';

SELECT * FROM LABREPORTS;


-- INSERT DATAI INTO BILLS
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'EHIAS'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'BILLS.%';
  
INSERT INTO BILLS( BILLID, APPOINTMENTID, AMOUNT, PAID, BILLDATE)
SELECT`Bills.BillID`,`Bills.AppointmentID`,`Bills.Amount`,`Bills.Paid`,
`Bills.BillDate`FROM HOSPITAL_DATA
WHERE `Bills.BillID`<>'';

SELECT * FROM BILLS;


-- POINT 4
drop trigger CHECK_NEW_APPOINMENT

DELIMITER $$
create trigger CHECK_NEW_APPOINMENT
before insert on APPOINTMENTS
for each row
begin
	if new.APPOINTMENTTIME < now() then
		signal sqlstate '45000'
        set message_text = 'Error: Appointment cannot be in the past.';
	end if;
    
    if exists
    (
		select * from APPOINTMENTS
        where DOCTORID = new.DOCTORID and 
        APPOINTMENTTIME = new.APPOINTMENTTIME
        and status in ('SCHEDULED')
	)
    then
    signal sqlstate '45000'
    set message_text = 'Error: Doctor Already has an aoppintment at this time.';
    end if;
end $$;
DELIMITER;

-- TESTING 
INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10000,1,1,'2025-06-25 10:00:00','Scheduled')

INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10000,1,1,'2025-12-31 10:00:00','Scheduled')


INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10000,1,1,'2025-12-31 10:00:00','Scheduled')



-- POINT 5

DELIMITER $$
CREATE PROCEDURE  VIEW_DOCTOR_DATA(IN INPUT_USERNAME VARCHAR(100), IN INPUT_PASSWORD VARCHAR(100))
BEGIN 
  DECLARE DOC_ROLE VARCHAR(100);
  DECLARE DOC_DEPT INT;
  DECLARE DOC_ID INT;
  
  -- CHECK CREDENTIALS OF THE DOCTOR
  SELECT DOCTOR_ID INTO DOC_ID
  FROM  DOCTOR_CREDENTIALS 
  WHERE USER_NAME=INPUT_USERNAME AND PASSWORD=INPUT_PASSWORD;
  
  -- GET ROLE AND DEPARTMENT  FROM DOCTORS TABLE
  SELECT ROLE , DEPARTMENTID
  INTO DOC_ROLE, DOC_DEPT
  FROM DOCTORS WHERE DOCTORID= DOC_ID;
  
  -- SHOW APPROPRIATE PATIENTS DATA.
  IF DOC_ROLE='senior' THEN
     SELECT D.DOCTORID,P.Patientid, P.name, P.Gender, 
	 A.appointmenttime, PR.MEDICATION,LR.REPORTDATA
	 FROM PATIENTS AS P INNER JOIN
	 APPOINTMENTS AS A ON A.PATIENTID=P.PATIENTID
     JOIN DOCTORS  D ON D.DOCTORID= A.DOCTORID
	 LEFT JOIN prescriptions AS PR ON A.APPOINTMENTID = PR.APPOINTMENTID
	 LEFT JOIN LABREPORTS AS LR ON A.APPOINTMENTID = LR.APPOINTMENTID
     WHERE D.DEPARTMENTID= DOC_DEPT;
  ELSE
    SELECT A.DOCTORID,P.Patientid, P.name, P.Gender, 
	 A.appointmenttime, PR.MEDICATION,LR.REPORTDATA
	 FROM PATIENTS AS P INNER JOIN
	 APPOINTMENTS AS A ON A.PATIENTID=P.PATIENTID
	 LEFT JOIN prescriptions AS PR ON A.APPOINTMENTID = PR.APPOINTMENTID
	 LEFT JOIN LABREPORTS AS LR ON A.APPOINTMENTID = LR.APPOINTMENTID
     WHERE A.DOCTORID=DOC_ID;
   END IF;
END$$;
DELIMITER;

-- TESTING 
CALL VIEW_DOCTOR_DATA('doctor1','W3jzIANG')
CALL VIEW_DOCTOR_DATA('doctor4','ic0pFSn0')


-- POINT 6

DELIMITER //
CREATE PROCEDURE SP_MONTHLYREVENUE(IN P_YEAR INT , IN P_MONTH INT)
BEGIN
 SELECT D1.NAME AS DEPARTMENT,
	SUM(B.AMOUNT) AS TOTAL_REVENUE 
	FROM BILLS AS B 
	INNER JOIN APPOINTMENTS AS A ON A.APPOINTMENTID=B.APPOINTMENTID
	INNER JOIN DOCTORS AS D ON A.DOCTORID=D.DOCTORID
	INNER JOIN DEPARTMENTS AS D1 ON D1.DEPARTMENTID=D.DOCTORID
	WHERE  MONTH(B.BILLDATE)=P_MONTH AND YEAR(B.BILLDATE)=P_YEAR
GROUP BY D1.NAME;
END//;
DELIMITER

CALL SP_MONTHLYREVENUE(2025,5)









