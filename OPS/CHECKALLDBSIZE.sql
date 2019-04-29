with fs
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name,
    (select   cast(round(sum(size),2)   as   numeric(15,2))  from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select cast(round(sum(size),2)   as   numeric(15,2))  from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
from sys.databases db order by 2 desc
