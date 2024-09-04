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