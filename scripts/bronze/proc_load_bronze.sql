/*
============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
============================================================

Script Purpose :
  This stored procedure loads data into the ' bronze' schema
  from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' command to load data from CSV Files 
  to bronze tables.

  Prameters :
   None
  This Stored Procedure does not accept any parameters or return 
  
 any value.

 Usage example : 
    EXEC bronze.load_bronze;
================================================================

*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME , @end_time DATETIME;

SET @start_time = GETDATE();
	BEGIN TRY
		PRINT '===============================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================';




		PRINT '-------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '<<TRUNCATING TABLE : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '<<INSERTING DATA INTO TABLE : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND';



		SET @start_time = GETDATE();
        PRINT '<<TRUNCATING TABLE: bronze.crm_prd_info';
	    TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '<<INSERTING DATA INTO TABLE: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND';



		
		SET @start_time = GETDATE();
		PRINT '<<TRUNCATING TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '<<INSERTING DATA INTO TABLE: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR=',',
		TABLOCK
		);
	    SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND';


	    
		PRINT '-------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------';


		SET @start_time = GETDATE();
		PRINT '<<TRUNCATING TABLE: bronze.erp_cust_az12';
		tRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '<<INSERTING DATA INTO TABLE: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
        SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND';



		SET @start_time = GETDATE();
		PRINT '<<TRUNCATING TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '<<INSERTING DATA INTO TABLE: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR=',',
		TABLOCK
		);
        SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND';



		SET @start_time = GETDATE();
		PRINT '<<TRUNCATING TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '<<INSERTING DATA INTO TABLE: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\megha\Downloads\sql-data-warehouse-project (3)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + 'SECOND'; 

		END TRY
		BEGIN CATCH
		   PRINT 'oops!! Some  error occurred during executing the bronze layer.'
		END CATCH

	SET @end_time = GETDATE();
	PRINT ' BRONZE LAYER WHOLE BATCH Loading time :' + CAST(DATEDIFF(second ,@start_time, @end_time) AS NVARCHAR) + ' SECOND'; 
END


