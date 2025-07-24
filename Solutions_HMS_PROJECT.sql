use main;
#1. Show first name, last name, and gender of patientss whose gender is 'M'
select first_name,last_name,gender from patientss where gender = "M";

#2. Show first name and last name of patients who does not have allergies. (null)
select first_name,last_name,allergies from patientss where allergies = "None";

#3. Show first name of patients that start with the letter 'C'
select first_name from patientss where first_name like "c%";

#4. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
select first_name,last_name,birth_date from patientss where height > 160 and weight > 70;

#6. Show all columns for patients who have one of the following patient_ids: 1,45,500
select * from patientss where patient_id in (1,45,500);

#7. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patientss set allergies = "NKA" where allergies = "NONE";

#8. Show the total amount of male patients and the total amount of female patients in the patients table.Display the two results in the same row.
select gender,count(*) from patientss group by gender;

#9. Show unique first names from the patients table which only occurs once in the list. For example, if two
    #or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select distinct(first_name) from patientss;

#10. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions
select day(admission_date) as ADMISSION_DAY, count(*) as number_of_admissions from admissionss group by ADMISSION_DAY order by count(*) desc;

#11. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select pa.first_name,pa.last_name,ad.diagnosis,do.first_name,do.last_name from patientss as pa inner join 
admissionss as ad on pa.patient_id=ad.patient_id inner join doctorss as do on ad.attending_doctor_id=do.doctor_id;

#12. Display the total amount of patients for each province. Order by descending.
select pr.province_name,count(*) as total from province_namess as pr inner join patientss as pa 
on pr.province_id = pa.province_id group by pr.province_name order by total desc;

#13. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.Primary diagnosis is stored in the admissions table.
select pa.first_name,pa.last_name,pa.patient_id from patientss as pa inner join admissionss as ad on pa.patient_id = ad.patient_id where diagnosis = "dementia";

#14. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.
#For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECt COUNT(*) AS patients_in_group, FLOOR(weight / 10) * 10 AS weight_group FROM patientss GROUP BY weight_group ORDER BY weight_group DESC;


#15. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Dementia' and the doctor's first name is 'Lisa'
#Check patients, admissions, and doctors tables for required information.
select pa.patient_id,pa.first_name,pa.last_name,do.speciality from patientss as pa 
inner join admissionss as ad on pa.patient_id=ad.patient_id inner join doctorss as do on ad.attending_doctor_id=do.doctor_id 
where diagnosis = "Dementia" and do.first_name = "Jenny";


#16. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
     #- First_name contains an 'r' after the first two letters.
     #- Identifies their gender as 'm'
     #- Born in February, May, or september
     #- Their weight would be between 40kg and 80kg
     #- Their patient_id is an EVEN number
     #- They are from the city 'nEW DANIEL'
select * from patientss where first_name like "__r%" and gender = "M" and 
month(birth_date) in (2,11,9) and weight between 40 and 80 and patient_id%2 = 0 and city = "NEW DANIEL"; 

#17. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
select admission_date,count(admission_date) as admission_day, count(admission_date) - lag(count(admission_date)) 
over( order by admission_date asc) as admission_count_change from admissionss group by admission_date;

#18. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_nam
select pr.province_name from patientss as pa inner join province_namess as pr on pa.province_id=pr.province_id 
GROUP BY pr.province_name HAVING COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

#19. Show the first_name, last_name, and the total number of admissions handled by each doctor.
select do.first_name,do.last_name,count(ad.admission_date) as total_count from doctorss as do inner join admissionss as ad on do.doctor_id = ad.attending_doctor_id 
group by do.doctor_id,do.first_name,do.last_name;

#20. Show all allergies ordered by popularity. Exclude 'NKA' and NULL values from the result.
select allergies,count(*) as popular_allergies from patientss where allergies != "NKA" group by allergies order by count(*) desc;

#21. Display the total number of patients in each province. Order the results in descending order.
select pr.province_name,count(*) from patientss as pa inner join province_namess as pr on pa.province_id = pr.province_id group by pr.province_name order by count(*) desc;

#22. Show patient_id, weight, height, and isObese from the patients table.
SELECT patient_id,weight,height,
    CASE 
        WHEN weight / POWER(height / 100, 2) >= 30 THEN 'Yes'
        ELSE 'No'
    END AS isObese
FROM patientss;

#23. Show patient_id, first_name, last_name, and the attending doctor's specialty.
select pa.patient_id,pa.first_name,pa.last_name,do.speciality from patientss as  pa 
inner join admissionss as ad on pa.patient_id = ad.patient_id inner join doctorss as do on do.doctor_id = ad.attending_doctor_id;

#24. Only include patients diagnosed with 'Epilepsy' and whose attending doctor's first name is 'Lisa'.
select pa.allergies,do.first_name from patientss as pa inner join admissionss as ad on pa.patient_id = ad.patient_id
inner join doctorss as do on ad.attending_doctor_id = do.doctor_id where do.first_name = "Lisa" and pa.allergies = "Epilepsy";

#25. Show the first_name, last_name, and role of every person who is either a patient or a doctor.
# The role should be listed as either "Patient" or "Doctor".
SELECT first_name,last_name,'Patient' AS role FROM patientss
UNION ALL
SELECT first_name,last_name,'Doctor' AS role FROM doctorss;

#26. For patients who have gone through admissions, display their patient_id and a temporary password.
     # The password must be a combination of:
     # 1. patient_id
     # 2. the length of the patient’s last_name (numerical)
     # 3. the year of their birth_date
     # in that exact order.
select pa.patient_id,concat(pa.patient_id,length(pa.last_name),year(pa.birth_date)) as temporarypassword from patientss as pa 
inner join admissionss as ad on pa.patient_id = ad.patient_id group by pa.patient_id,pa.first_name,pa.last_name;


#27. Show province_id(s) where the total sum of the patients' height is greater than or equal to 7,000. Display the sum of heights for each matching province.
SELECT province_id,SUM(height) AS total_height
FROM patientss GROUP BY province_id HAVING SUM(height) >= 7000;