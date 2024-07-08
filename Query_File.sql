/* 
Query 1:
This query is constructed to find the patient details who have been assigned to particular specialist.
Uses IN and LIKE.
*/

SELECT p.PatientID, p.FullName, v.VisitDate, e.Description 
FROM Patient p
JOIN Visit v ON p.PatientID = v.PatientID
JOIN EmergencyLevel e ON v.EmergencyLevelID = e.EmergencyLevelID
WHERE v.VisitID IN (
    SELECT pa.VisitID
    FROM PatientAssignment pa
    WHERE pa.SpecialistID = 
    (SELECT SpecialistID 
	 FROM MedicalSpecialist 
     WHERE Name LIKE '%nobis%')
	);

/*
Query 2:
This query is constructed to find the details of all visits that were assigned to specific medical specialist from specific department.
Uses EXISTS and LIKE.
*/

SELECT v.VisitID, v.VisitDate, m.Name as Specialist
FROM Visit v
JOIN PatientAssignment pa ON v.VisitID = pa.VisitID
JOIN MedicalSpecialist m ON pa.SpecialistID = m.SpecialistID
WHERE EXISTS (
    SELECT *
    FROM Department d
    WHERE d.DepartmentID = m.DepartmentID AND d.Name LIKE '%Cardiology%'
	);

/*
View: It is created for dashboard analytics which will be used for calculating the load of each department.
It keeps up to date data and calculates the total patient count and the average priority score.
*/

DROP VIEW IF EXISTS DashboardAnalytics;
CREATE VIEW DashboardAnalytic AS
SELECT 
    d.Name as Department, 
    COUNT(DISTINCT v.PatientID) as TotalPatients,
    AVG(e.PriorityScore) as AverageEmergencyScore
FROM Department d
JOIN MedicalSpecialist m ON d.DepartmentID = m.DepartmentID
JOIN PatientAssignment pa ON m.SpecialistID = pa.SpecialistID
JOIN Visit v ON pa.VisitID = v.VisitID
JOIN EmergencyLevel e ON v.EmergencyLevelID = e.EmergencyLevelID
GROUP BY d.Name;

/* 
Trigger 1: 
It updates the patient count of each department when a new visit happens. It finds the SpecialistID from the PatientAssignment and 
from the MedicalSpecialist table, finds the DepartmentID and update the patient count. 
*/

DELIMITER $$

DROP TRIGGER IF EXISTS UpdatePatientCount;
CREATE TRIGGER UpdatePatientCount
AFTER INSERT ON PatientAssignment
FOR EACH ROW
BEGIN
    DECLARE deptID INT;
    SELECT DepartmentID INTO deptID FROM MedicalSpecialist WHERE SpecialistID = NEW.SpecialistID;
    UPDATE Department
    SET PatientCount = PatientCount + 1
    WHERE DepartmentID = deptID;
END$$

DELIMITER ;

/* 
Control Query 1: 
First, obtain all rows in Department table, check the PatientCount attribute.
Insert a new row in PatientAssignments table. 
Obtain all rows in Department table, check the PatientCount attribute.
*/
SELECT * FROM emre_cakmakyurdu.Department;
INSERT INTO `emre_cakmakyurdu`.`PatientAssignment` (`AssignmentID`, `VisitID`, `SpecialistID`, `AssignmnetDate`) VALUES ('34', '30', '1', '1972-03-15 14:11:58');
SELECT * FROM emre_cakmakyurdu.Department;

/*
Trigger 2: 
This trigger limits the number of visits of a patient to 11. 
*/

DELIMITER $$

DROP TRIGGER IF EXISTS CheckVisitCardinality;
CREATE TRIGGER CheckVisitCardinality
BEFORE INSERT ON Visit
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM Visit WHERE PatientID = NEW.PatientID) >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeds maximum allowed visits per patient';
    END IF;
END$$

DELIMITER ;

/* 
Control Query 2:
Patient 31 has a visit in the database. If 10 more visits are to be inserted, system gives an error and it outputs:
'Exceeds maximum allowed visits per patient' message.
*/

INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('63', '31', '1990-01-06 01:56:12', 'adfdsg', '2');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('64', '31', '1990-01-06 01:56:12', 'adfdsg', '2');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('65', '31', '1990-01-06 01:56:12', 'adfdsg', '3');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('66', '31', '1990-01-06 01:56:12', 'adfdsg', '4');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('67', '31', '1990-01-06 01:56:12', 'adfdsg', '5');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('68', '31', '1990-01-06 01:56:12', 'adfdsg', '1');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('69', '31', '1990-01-06 01:56:12', 'adfdsg', '2');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('70', '31', '1990-01-06 01:56:12', 'adfdsg', '3');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('71', '31', '1990-01-06 01:56:12', 'adfdsg', '3');
INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('72', '31', '1990-01-06 01:56:12', 'adfdsg', '4');

/*
Trigger 3:
This trigger calculates the average priority score of each patient based on their visit history.
*/

DELIMITER $$

DROP TRIGGER IF EXISTS UpdatePatientAvgPriorityAfterVisitInsert;
CREATE TRIGGER UpdatePatientAvgPriorityAfterVisitInsert
AFTER INSERT ON Visit
FOR EACH ROW
BEGIN
    UPDATE Patient
    SET AvgPriorityScore = (
        SELECT AVG(EmergencyLevel.PriorityScore)
        FROM Visit
        INNER JOIN EmergencyLevel ON Visit.EmergencyLevelID = EmergencyLevel.EmergencyLevelID
        WHERE Visit.PatientID = NEW.PatientID
    )
    WHERE Patient.PatientID = NEW.PatientID;
END$$

DELIMITER ;

/*
Control Query 3:
First get the Patient table of which the PatientID is 2. Observe AvgPriorityScore attribute.
Insert a new row to Visit table where PatientID is 2.
Get the Patient table of which the PatientID is 2. Observe AvgPriorityScore attribute.
*/
SELECT * 
FROM emre_cakmakyurdu.Patient
WHERE PatientID=2;

INSERT INTO `emre_cakmakyurdu`.`Visit` (`VisitID`, `PatientID`, `VisitDate`, `Purpose`, `EmergencyLevelID`) VALUES ('63', '2', '1990-01-06 01:56:12', 'dgsgs', '4');

SELECT * 
FROM emre_cakmakyurdu.Patient
WHERE PatientID=2;