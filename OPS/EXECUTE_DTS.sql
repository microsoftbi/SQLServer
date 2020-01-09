Declare @execution_id bigint

EXEC [SSISDB].[catalog].[create_execution] @package_name=N'Package.dtsx',
	@execution_id=@execution_id OUTPUT,
	@folder_name=N'XXXXDWH',
	@project_name=N'Load2XXXX',
	@use32bitruntime=False,
	@reference_id=Null

exec [SSISDB].catalog.set_execution_parameter_value 
	@execution_id=@execution_id, 
	@object_type= 50, 
	@parameter_name = N'SYNCHRONIZED', 
	@parameter_value = 1;

Declare @retry_count int = 0

EXEC [SSISDB].[catalog].[start_execution] @execution_id , @retry_count=@retry_count


SELECT [STATUS] FROM [SSISDB].[catalog].[executions] WHERE execution_id= @execution_id
