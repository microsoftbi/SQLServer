SELECT bus.server_name AS 'server',
       rh.restore_date,
       bus.database_name AS 'database',
       CAST(bus.first_lsn AS VARCHAR(50)) asLSN_First,
       CAST(bus.last_lsn AS VARCHAR(50)) asLSN_Last,
       CASE rh.[restore_type]
           WHEN 'D' THEN
               'Database'
           WHEN 'F' THEN
               'File'
           WHEN 'G' THEN
               'Filegroup'
           WHEN 'I' THEN
               'Differential'
           WHEN 'L' THEN
               'Log'
           WHEN 'V' THEN
               'Verifyonly'
       END ASrhType
FROM msdb.dbo.backupset bus
    INNER JOIN msdb.dbo.restorehistory rh
        ON rh.backup_set_id = bus.backup_set_id;
