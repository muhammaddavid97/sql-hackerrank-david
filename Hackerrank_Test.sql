USE Employee;

-- soal nomor satu 

SELECT first_name + last_name AS 'Nama lengkap', pos.name, DATEDIFF(YEAR, bio.dob, CURRENT_TIMESTAMP) AS 'Usia', COUNT(fam.biodata_id) AS Anak
FROM biodata AS bio INNER JOIN employee AS emp ON bio.id = emp.biodata_id
INNER JOIN employee_position AS emp_pos ON emp.id = emp_pos.employee_id
INNER JOIN pozsition AS pos ON emp_pos.position_id = pos.id
INNER JOIN family AS fam ON bio.id = fam.biodata_id
WHERE fam.status = 'Anak' GROUP BY first_name + last_name, pos.name, DATEDIFF(YEAR, bio.dob, CURRENT_TIMESTAMP)


-- soal nomor dua

SELECT bio.first_name + bio.last_name AS 'Nama lengkap', SUM(DATEDIFF(DAY, leave_req.start_date, leave_req.end_date)) AS 'Cuti hari'
FROM biodata AS bio INNER JOIN employee AS emp ON bio.id = emp.biodata_id
INNER JOIN leave_request AS leave_req ON emp.id = leave_req.employee_id
GROUP BY bio.first_name + bio.last_name

-- soal nomor tiga 

SELECT TOP 3 bio.first_name + bio.last_name AS 'Nama Lengkap', pos.name AS 'Jabatan', DATEDIFF(YEAR, bio.dob, CURRENT_TIMESTAMP) AS usia
FROM biodata AS bio INNER JOIN employee AS emp ON bio.id = emp.biodata_id 
INNER JOIN employee_position AS emp_pos ON emp.id = emp_pos.employee_id
INNER JOIN position AS pos ON emp_pos.position_id = pos.id
ORDER BY bio.dob ASC 

-- soal nomor empat

SELECT CONCAT(first_name,' ', last_name) AS 'Nama'
FROM biodata AS bio WHERE (bio.id not in (SELECT biodata_id FROM employee));

-- soal nomor lima

SELECT AVG(emp.salary) AS 'Gaji rata rata karyawan'
FROM employee AS emp INNER JOIN employee_position AS emp_pos ON emp.id = emp_pos.employee_id
INNER JOIN position AS pos ON emp_pos.position_id = pos.id
WHERE pos.name = 'Staff'

-- soal nomor enam

SELECT CONCAT(bio.first_name, bio.last_name) AS ' Nama Lengkap', trav_type.name, travel_req.start_date, SUM(travel_set.item_cost) AS 'Total Pengeluaran'
FROM biodata AS bio INNER JOIN employee AS emp ON bio.id = emp.biodata_id
INNER JOIN travel_request AS travel_req ON emp.id = travel_req.employee_id 
INNER JOIN travel_type AS trav_type ON travel_req.travel_type_id = trav_type.id
INNER JOIN travel_settlement AS travel_set ON travel_req.id = travel_set.travel_request_id
GROUP BY CONCAT(bio.first_name, bio.last_name), trav_type.name, travel_req.start_date

-- soal nomor tujuh

SELECT emp_leave.regular_quota
FROM employee AS emp INNER JOIN employee_leave AS emp_leave ON emp.id = emp_leave.employee_id
WHERE period = 2020

-- soal nomor delapan

SELECT AVG(emp.salary) AS 'Gaji rata rata'
FROM employee AS emp INNER JOIN employee_position AS emp_pos ON emp.id = emp_pos.employee_id 
INNER JOIN position AS pos ON emp_pos.position_id = pos.id WHERE pos.name != 'Staff'

-- soal nomor sembilan

SELECT COUNT(marital_status) AS 'Jumlah orang',
	CASE
	when marital_status = 1 then 'menikah'
	else 
	'belum menikah' 
	END
	AS status
FROM biodata
GROUP BY CASE
	when marital_status = 1 then 'menikah'
	else 
	'belum menikah' 
	END