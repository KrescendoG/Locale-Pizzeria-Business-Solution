SELECT
	sch.date,
	e.first_name,
	e.last_name,
	e.hourly_wage,
	s.start_time,
	s.end_time,
	cast(datediff(MINUTE, s.start_time, s.end_time ) as decimal(10, 2)) / 60 AS total_shift_hours,
	cast(datediff(MINUTE, s.start_time, s.end_time ) as decimal(10, 2)) / 60 * e.hourly_wage AS staff_cost 
FROM
	Schedule sch
	LEFT JOIN Employees e ON sch.emp_id = e.emp_id
	LEFT JOIN Shifts s ON sch.shift_id = s.shift_id