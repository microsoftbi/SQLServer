Declare @execution_id bigint
EXEC [SSISDB].[catalog].[create_execution] @package_name=N'<packge name>',
       @execution_id=@execution_id OUTPUT,
       @folder_name=N'<folder name>',
       @project_name=N'<project name>',
     @use32bitruntime=False,
       @reference_id=Null
Declare @retry_count int = 5
EXEC [SSISDB].[catalog].[start_execution] @execution_id ,
       @retry_count=@retry_count
