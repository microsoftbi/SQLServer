select 
		session_id as SPID, 
		command, 
		a.text AS Query, 
		start_time, 
		percent_complete, 
		dateadd(MINUTE, estimated_completion_time/1000/60 ,GETDATE()) estimated_completion_time
	from sys.dm_exec_requests r Cross apply sys.dm_exec_sql_text (r.sql_handle) a
where r.command in ('BACKUP DATABASE', 'RESTORE DATABASE') 