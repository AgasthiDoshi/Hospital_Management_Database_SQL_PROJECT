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