# Hospital Management System SQL PROJECT
![HOSPITAL MANAGEMENT SYSTEM](https://github.com/AgasthiDoshi/Hospital_Management_Database_SQL_PROJECT/blob/main/logos.png)
## Overview
This project presents a comprehensive SQL-based Hospital Management System designed to simulate real-world healthcare data operations. It demonstrates key database design principles and showcases complex SQL usage for managing and analyzing patient health records. The database handles crucial patient details like name, gender, allergies, height, weight, date of birth, and doctors and their specialities, reflecting a robust foundation for medical data systems.
## Objectives
- Build a centralized patient database to help healthcare professionals access critical patient information quickly.
- Assist doctors in identifying high-risk patients based on allergy types, age, weight, or height irregularities.
- Enable analysis of age and gender distributions for better demographic insights in clinical research.
- Support region-specific healthcare planning by analyzing patient data across cities and provinces.
- Provide a foundation for developing digital health dashboards and predictive models using SQL.
- Help clinics and hospitals maintain structured and scalable patient records efficiently.
- My learnings in SQL
## Schema
```sql
#Schemas of hospital management system

CREATE TABLE province_names
(
    province_id   char(2) PRIMARY KEY,
    province_name text
);

CREATE TABLE patients
(
    patient_id  integer PRIMARY KEY,
    first_name  text,
    last_name   text,
    gender      varchar(1),
    birth_date  DATE,
    city        text,
    allergies   text,
    height      integer,
    weight      integer,
    province_id char(2) REFERENCES province_names (province_id)
);

CREATE TABLE admissions
(
    patient_id          integer REFERENCES patients (patient_id),
    admission_date      date,
    discharge_date      date,
    diagnosis           text,
    attending_doctor_id integer REFERENCES doctors (doctor_id)
);


CREATE TABLE doctors
(
    doctor_id  integer PRIMARY KEY,
    first_name text,
    last_name  text,
    speciality text
);
```
