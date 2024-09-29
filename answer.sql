USE hospital_db -- QUESTION 2.1: Creating patients' table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(50) NOT NULL,
    language VARCHAR(255) NOT NULL
);
-- Question 2.2 : To create providers' table
CREATE TABLE providers (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    provider_speciality VARCHAR(255) NOT NULL,
    email_address VARCHAR (255),
    phone_number VARCHAR(255),
    date_joined DATE NOT NULL
);
-- question 2.3 : visits table
CREATE TABLE visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    provider_id INT,
    date_of_visit DATE NOT NULL,
    date_scheduled DATE NOT NULL,
    visit_department_id INT NOT NULL,
    visit_type VARCHAR(255) NOT NULL,
    blood_pressure_systollic INT,
    blood_pressure_diastollic DECIMAL(5, 2),
    pulse DECIMAL(5, 2),
    visit_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);
-- Question 2.4  visits table
CREATE TABLE ed_visits (
    ed_visit_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    patient_id INT,
    acuity INT NOT NULL,
    reason_for_visit VARCHAR(255) NOT NULL,
    disposition VARCHAR(255) NOT NULL,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- Question 2.5 admission table 
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    admission_date DATE NOT NULL,
    discharge_date DATE NOT NULL,
    discharge_disposition VARCHAR(255) NOT NULL,
    service VARCHAR(255) NOT NULL,
    primary_diagnosis VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- Question 2.6 discharges table
CREATE TABLE discharges(
    discharge_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    patient_id INT,
    discharge_date DATE NOT NULL,
    discharge_disposition VARCHAR(255) NOT NULL,
    FOREIGN KEY(admission_id) REFERENCES admissions(admission_id),
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
);
-- WEEK 2 ASSIGNMENT ---- 
--Essential Data Retrieval & Filtering (Focus on Project Data)--
-- Part 1: Basic Data Retrieval--
-- QUESTION 1.1 
-- to retrieve the first_name, last_name and date_of_birth of all patients.
SELECT first_name,
    last_name,
    date_of_birth
from patients;
-- QUESTION 1.2 --
-- To provider_id, first_name and provider_specialty from the providers table. --
SELECT provider_id,
    first_name,
    provider_specialty
FROM providers;
-- Question 2.1 --
-- to retrieve all patients whose first names start with "Ab".
SELECT *
FROM patients
WHERE first_name like 'Ab%';
-- Question 2.2 
-- to retrieve all providers whose specialties end with the letter "y".
SELECT *
FROM providers
WHERE provider_specialty LIKE '%y';
-- Question 3.1 
-- To find all patients born after 1st January 1980.
SELECT *
FROM patients
WHERE DATE(date_of_birth) > '1980-01-01';
-- Question 3.2 
-- To retrieve visits where the acuity level is 2 or higher.
SELECT *
FROM ed_visits
WHERE acuity >= 2;
-- Question  4.1
-- To find patients who speak Spanish.
SELECT *
FROM patients
WHERE language = 'Spanish';
-- question 4.2 
-- To retrieve visits where the reason is "Migraine" and the disposition is "Admitted".
SELECT *
FROM ed_visits
WHERE reason_for_visit = 'Migraine'
    AND ed_disposition = 'Admitted';
--  Question 4.3
--  To find patients born between 1975 and 1980. --
SELECT *
FROM patients
WHERE YEAR(date_of_birth) BETWEEN 1975 AND 1980;
--  Question 5.1
-- To retrieve patient names and sort them in alphabetical order by last name.
SELECT first_name,
    last_name
FROM patients
ORDER BY last_name ASC;
-- Question 5.2 
-- To list all visits sorted by the date of the visit, starting from the most recent.
SELECT *
FROM visits
ORDER BY date_of_visit DESC;
-- Question 6.1
-- To retrieve all admissions where the primary diagnosis is "Stroke" and the discharge disposition is "Home".
SELECT *
FROM admissions a
    join discharges d on a.patient_id = d.patient_id
WHERE a.primary_diagnosis = 'Stroke'
    AND d.discharge_disposition = 'Home';
-- Question 6.2. 
-- To find providers who joined after 1995 and specialize in either Pediatrics or Cardiology.
SELECT *
FROM providers
WHERE YEAR(date_joined) > '1995'
    AND provider_specialty IN ('Pediatrics', 'Cardiology');
-- Bonus Challenge (optional)
-- Write a query that lists all discharges where the patient was discharged home and
--  the discharge date is within the first week of March 2018.
SELECT *
FROM discharges
WHERE discharge_disposition = 'Home'
    AND discharge_date BETWEEN '2018-03-01' AND '2018-03-07';
-- WEEK 3 ASSIGNMENT
-- QUESTION 1.1 
SELECT COUNT(*) AS TOTAL_NUMBER_OF_PATIENTS
FROM admissions;
-- QUESTION 1.2 
SELECT AVG(
        discharges.discharge_date - admissions.admission_date
    ) AS average_length_of_stay
FROM admissions
    INNER JOIN discharges ON discharges.patient_id = admissions.patient_id;
-- QUESTION 2.1
SELECT primary_diagnosis,
    count(admission_id) as Number_of_Admissions
FROM admissions
group by primary_diagnosis -- Question 2.2
SELECT admissions.service,
    avg(
        discharges.discharge_date - admissions.admission_date
    ) as Average_length_of_stay_by_service
FROM admissions
    inner join discharges on admissions.admission_id = discharges.admission_id
group by service -- Question 2.3
SELECT discharge_disposition,
    count(discharge_disposition) as Discharges_by_category
FROM discharges
group by discharge_disposition;
-- QUESTION 3.1
SELECT service,
    count(service) as Number_admission
FROM admissions
GROUP BY service
HAVING Number_admission > 5;
-- QUESTION 3.2
SELECT AVG(
        discharges.discharge_date - admissions.admission_date
    ) as average_length_of_stay_Stroke_for_patient
FROM admissions
    join discharges on discharges.admission_id = admissions.admission_id;
-- 4.1  QUESTION 
SELECT acuity,
    count(visit_id)
FROM ed_visits
group by acuity;
-- QUESTION 4.2 
SELECT primary_diagnosis,
    service,
    COUNT(admission_id) AS total_admissions
FROM admissions
GROUP BY primary_diagnosis,
    service;
--  QUESTION 5.1
SELECT MONTH(admission_date) as Admssion_month,
    count(admission_id) as admission_per_month
FROM admissions
group by Admssion_month;
-- QUESTION 5.3
SELECT admissions.primary_diagnosis,
    MAX(
        discharges.discharge_date - admissions.admission_date
    ) AS max_length_of_stay
FROM admissions
    JOIN discharges ON admissions.admission_id = discharges.admission_id
GROUP BY admissions.primary_diagnosis
ORDER BY max_length_of_stay DESC;
-- BONUS
SELECT admissions.service,
    SUM(
        discharges.discharge_date - admissions.admission_date
    ) AS total_length_of_stay,
    AVG(
        discharges.discharge_date - admissions.admission_date
    ) AS average_length_of_stay
FROM admissions
    JOIN discharges ON admissions.admission_id = discharges.admission_id
GROUP BY admissions.service
ORDER BY average_length_of_stay DESC;