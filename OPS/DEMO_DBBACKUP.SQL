USE TEST

--ALTER DATABASE TEST SET RECOVERY FULL;  

TRUNCATE TABLE TB_TEST
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (1, N'A')
backup database TEST to disk = 'D:\TEST\FULL.bak' with compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (2, N'B')
backup database TEST to disk='D:\TEST\DIF.bak' with differential,compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (3, N'C')
backup log TEST to disk = 'D:\TEST\LOG1.bak' with compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (4, N'D')
backup log TEST to disk = 'D:\TEST\LOG2.bak' with compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (5, N'E')
backup log TEST to disk = 'D:\TEST\LOG3.bak' with compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (6, N'F')
backup log TEST to disk = 'D:\TEST\LOG4.bak' with compression;
--
INSERT [dbo].[TB_TEST] ([ID], [DESC]) VALUES (7, N'G')
backup log TEST to disk = 'D:\TEST\LOG5.bak' with compression;



--Below restore scripts are not correct, issue is that when restore finish, data is not the latest.
--But no issue that if restore in GUI tool.
restore database TEST from disk ='D:\TEST\FULL.bak' with norecovery;
restore database TEST from disk ='D:\TEST\DIF.bak' with norecovery;
restore log TEST from disk ='D:\TEST\LOG1.bak' with norecovery;
restore log TEST from disk ='D:\TEST\LOG2.bak' with norecovery;
restore log TEST from disk ='D:\TEST\LOG3.bak' with norecovery;
restore log TEST from disk ='D:\TEST\LOG4.bak' with norecovery;
restore log TEST from disk ='D:\TEST\LOG5.bak' with norecovery;
restore database TEST with recovery;
