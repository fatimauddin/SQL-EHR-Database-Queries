USE sample_EHR_data
-- check
select top 5 * from dbo.encounter
select top 5 * from dbo.encounterdx
select top 5 * from dbo.lookupadmitsource
select top 5 * from dbo.lookupdiagnosis
select top 5 * from dbo.lookupdisposition
select top 5 * from dbo.lookuphospital
select top 5 * from dbo.lookuprace
select top 5 * from dbo.lookupsex
select top 5 * from dbo.lookupstate
select top 5 * from dbo.patient

-- 1) Display all the patient demographics information for every patient that is stored in the database
select * from dbo.patient

-- 2) Show only first name, last name, and date of birth
select fname
	, lname
	, dob
from dbo.patient

-- 3) Show the encounter ID number and only the first diagnosis code of every encounter
select * from dbo.encounter

select a.encounterid, b.dxcode
from dbo.encounter a
join dbo.encounterdx b
on a.encounterid = b.encounterid
where b.seq = 1

-- 4) Display a list of the patient's states (without duplicates) that have a city called Dover
select * from dbo.patient

select distinct st
	, city
from dbo.patient
where city = 'Dover'

-- 5) List the patient IDs and the encounter admit dates for encounters where length of stay was 5 or more days and the patient was discharged (dispid) with a code of 20
USE sample_EHR_data
select top 10 * from dbo.encounter

select patientid
	, adate 
from dbo.encounter
where los >= 5
and dispid = 20;

-- 6) Show the patient id, last name, first name, and date of birth for patients in CA. Sort by last name and then by birth date in reverse chronological order
select top 20 * from dbo.patient

select patientid
, lname
, fname
, dob
from dbo.patient
where st = 'CA'
order by lname asc, dob desc;

-- 7) Show all encounter information where the length of stay was between one to three months (los currently in days). Rename the columns in your result so that they are more readable
select top 5 * from dbo.encounter

select encounterid as EncounterID
	, hospid as HospitalID
	, adate as AdmitDate
	, los as LengthOfStay
	, dispid as DischargeID
	, patientid as PatientID
	, asourceid as AdmissionSourceID
from dbo.encounter
where los between 30 and 90;

-- 8) List all the primary diagnosis codes (sequence of 1) for visits that were admitted from the emergency department and that occurred after 3/25/2009.
select top 5 * from dbo.encounter
select top 5 * from dbo.encounterdx

select * from dbo.lookupadmitsource

select dxcode
from dbo.encounter
join dbo.encounterdx
on dbo.encounter.encounterid = dbo.encounterdx.encounterid
where seq = 1
and asourceid = 1
and adate > '2009-03-25';

-- 9) Show the combined total count, the average, minimum and maximum length of stay for these visits.
select top 10 * from dbo.encounter

select count(*) as TotalVisits
	, avg(los) as AverageStay
	, min(los) as MinimumStay
	, max(los) as MaximumStay
from dbo.encounter
where asourceid = 1
and adate > '2009-03-25';

-- 10) Combine answers from questions 6 to 9 into one cohesive report that joins the patient information with the encounter information: 
select top 5 * from dbo.encounter
select top 5 * from dbo.encounterdx

select a.patientid, a.lname, a.fname, a.dob, b.los, c.dxcode
from dbo.patient a
join dbo.encounter b
on a.patientid = b.patientid
join dbo.encounterdx c
on b.encounterid = c.encounterid
where a.st = 'CA'
and b.los between 30 and 90
and (c.dxcode like 'V%' or c.dxcode like 'E%')
order by c.dxcode asc, a.dob desc;




