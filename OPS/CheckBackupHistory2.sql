use msdb
GO
DECLARE
	@database_name sysname
;

SELECT
	@database_name = N'DV'
;

SELECT
	bs.server_name,
	bs.user_name,
	database_name = bs.database_name,
	start_time = bs.backup_start_date,
	finish_time = bs.backup_finish_date,
	time_cost_sec = DATEDIFF(SECOND, bs.backup_start_date, bs.backup_finish_date),
	back_file = bmf.physical_device_name,
	backup_type = 
	CASE 
		WHEN bs.[type] = 'D' THEN 'Full Backup' 
		WHEN bs.[type] = 'I' THEN 'Differential Database' 
		WHEN bs.[type] = 'L' THEN 'Log' 
		WHEN bs.[type] = 'F' THEN 'File/Filegroup' 
		WHEN bs.[type] = 'G' THEN 'Differential File'
		WHEN bs.[type] = 'P' THEN 'Partial'  
		WHEN bs.[type] = 'Q' THEN 'Differential partial' 
	END,
	backup_size_mb = ROUND(((bs.backup_size/1024)/1024),2),
	compressed_size_mb = ROUND(((bs.compressed_backup_size/1024)/1024),2),
	bs.first_lsn,
	bs.last_lsn,
	bs.checkpoint_lsn,
	bs.database_backup_lsn,
	bs.software_major_version,
	bs.software_minor_version,
	bs.software_build_version,
	bs.recovery_model,
	bs.collation_name,
	bs.database_version
FROM msdb.dbo.backupmediafamily bmf WITH(NOLOCK)
	INNER JOIN msdb.dbo.backupset bs WITH(NOLOCK)
	ON bmf.media_set_id = bs.media_set_id
WHERE bs.database_name = @database_name
ORDER BY bs.backup_start_date DESC
