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