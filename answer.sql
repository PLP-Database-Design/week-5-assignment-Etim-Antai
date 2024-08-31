USE hospital_db
-- QUESTION 2.1: Creating patients' table

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(50) NOT NULL,
    language VARCHAR(255) NOT NULL
);

-- Question 2.2 : providers' table
CREATE TABLE providers (
provider_id	INT	PRIMARY KEY AUTO_INCREMENT,
first_name	VARCHAR (255)	NOT NULL,
last_name	VARCHAR(255)	NOT NULL,
provider_speciality	VARCHAR(255)	NOT NULL,
email_address	VARCHAR	(255),
phone_number	VARCHAR(255),
date_joined	DATE	NOT NULL);


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
	discharge_id	INT	PRIMARY KEY AUTO_INCREMENT,
	admission_id	INT,
	patient_id	INT,
	discharge_date	DATE	NOT NULL,
	discharge_disposition	VARCHAR(255)	NOT NULL,
	 FOREIGN KEY(admission_id) REFERENCES admissions(admission_id),
	 FOREIGN KEY(patient_id) REFERENCES patients(patient_id)

);