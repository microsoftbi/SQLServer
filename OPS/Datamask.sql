--Add mask

ALTER TABLE
Membership  

ALTER COLUMN
LastName ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",0)');  
 
--Modify mask
ALTER TABLE Membership  
ALTER COLUMN LastName varchar(100) MASKED WITH (FUNCTION = 'default()'); 


--Remove mask
ALTER TABLE Membership   
ALTER COLUMN LastName DROP MASKED; 

--Check in one db,which column is masked.
SELECT c.name,
tbl.name as table_name, c.is_masked, c.masking_function  
FROM
sys.masked_columns AS c  
JOIN sys.tables AS
tbl   
    ON c.[object_id] = tbl.[object_id]  
WHERE is_masked =1;  


--User testing.
CREATE USER TestUser
WITHOUT LOGIN;  

GRANT SELECT ON
Membership TO TestUser;  


EXECUTE AS USER =
'TestUser';  

SELECT * FROM
Membership;  

REVERT;


--UNMASK
Grant UNMASK TO
TestMask


--Get all masked fields
select object_name(object_id),name,masking_function from sys.masked_columns
