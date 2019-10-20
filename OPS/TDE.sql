--Create master key
USE Master;
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='Password input here';
GO
 
--Create cert
CREATE CERTIFICATE TDE_Cert
WITH
SUBJECT='DWH_Encryption';
GO
 
--Create DB encryption key
USE BIIC_STAGE
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE_Cert;
GO
 
--Enable encryption
ALTER DATABASE BIIC_STAGE
SET ENCRYPTION ON;
GO
 
 
 
 
--Backup cert
BACKUP SERVICE MASTER KEY
TO FILE = 'J:\CERT\SvcMasterKey.key'
ENCRYPTION BY PASSWORD='Password input here';
 
BACKUP MASTER KEY
TO FILE = 'J:\CERT\DbMasterKey.key'
ENCRYPTION BY PASSWORD = 'Password input here'
 
 
BACKUP CERTIFICATE TDE_Cert
TO FILE = 'J:\CERT\TdeCert.cer'
WITH PRIVATE KEY(
FILE = 'J:\CERT\TdeCert.key',
ENCRYPTION BY PASSWORD = 'Password input here'
 
 
 
--Then to another server for restore cert and dbs.
--If cert key is not restored, the restore from encrypted db backup will be failed.
--Restore cert
USE Master;
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='Password input here';
GO
 
 
USE MASTER
GO
CREATE CERTIFICATE TDECert
FROM FILE = 'J:\CERT\TdeCert.cer'
WITH PRIVATE KEY (FILE = 'J:\CERT\TDECert.key',
DECRYPTION BY PASSWORD = 'Password input here' );
 
--Then we can proceed the encrypted db restore.