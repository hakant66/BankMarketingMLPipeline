@echo off
REM Set correct Python version for both driver and worker
set PYSPARK_DRIVER_PYTHON=C:\apps\Python\Python311\python.exe
set PYSPARK_PYTHON=C:\apps\Python\Python311\python.exe

REM Run the Spark script
C:\apps\Python\Python311\python.exe C:\apps\TestCode\BankTestData\BankMarketingMLWithCategorical.py

pause
