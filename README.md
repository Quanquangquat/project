# Vietnamese Administrative Divisions Importer
acong
This repository contains tools to import Vietnamese administrative divisions (provinces, districts, wards) into the `Areas` table of your Household Management database.

## Data Source

The data is sourced from the [DiaGioiHanhChinhVN](https://github.com/kenzouno1/DiaGioiHanhChinhVN) repository, which provides a comprehensive JSON file containing all Vietnamese administrative divisions.

## Available Tools

We provide multiple options to import the data, depending on your preferred technology:

### 1. Direct PowerShell Import (Recommended for Vietnamese Character Support)

A PowerShell script that directly connects to your database and imports the data with proper UTF-8 encoding for Vietnamese characters.

**Requirements:**

- PowerShell 5.0 or later
- SQL Server with the HouseholdManagement database

**Usage:**

1. Double-click on `RunDirectImport.bat` to run the script
2. The script will:
   - Prompt you to confirm database connection settings
   - Download the JSON data
   - Create the Areas table if it doesn't exist
   - Insert all administrative divisions with proper Vietnamese character support

### 2. C# Console Application

A .NET console application that downloads the JSON data and inserts it directly into your SQL Server database.

**Requirements:**

- .NET SDK (5.0 or later)
- SQL Server with the HouseholdManagement database

**Usage:**

1. Double-click on `RunImportAreas.bat` to compile and run the application
2. The application will automatically:
   - Create a temporary project
   - Add the required SQL Client package
   - Compile and run the code
   - Insert all administrative divisions into your database

### 3. Java Application

A Java application that performs the same task using JDBC.

**Requirements:**

- Java JDK (8 or later)
- SQL Server with the HouseholdManagement database

**Usage:**

1. Double-click on `RunJavaImport.bat` to set up and run the application
2. The batch file will:
   - Download the required JSON library and SQL Server JDBC driver
   - Compile the Java code
   - Run the application to insert all administrative divisions

### 4. PowerShell Script (SQL Generation)

A PowerShell script that generates a SQL script with INSERT statements.

**Requirements:**

- PowerShell 5.0 or later
- SQL Server Management Studio (to run the generated SQL script)

**Usage:**

1. Run `generate_areas_sql.ps1` in PowerShell
2. The script will:
   - Download the JSON data
   - Generate a SQL script named `insert_all_areas.sql`
3. Open the generated SQL script in SQL Server Management Studio
4. Execute the script against your database

### 5. Vietnamese Data Viewer

A simple HTML viewer to verify the Vietnamese data is being processed correctly.

**Usage:**

1. Double-click on `ViewVietnameseData.bat` to open the viewer in your default browser
2. The viewer will:
   - Download the JSON data directly from the source
   - Display all provinces, districts, and wards with proper Vietnamese characters
   - Allow you to browse through the data

## Troubleshooting Vietnamese Character Issues

If you're experiencing issues with Vietnamese characters displaying as question marks or incorrect symbols:

1. **Console Encoding**: Make sure your console is set to use UTF-8 encoding. All batch files include `chcp 65001` to set this automatically.

2. **PowerShell Encoding**: For PowerShell scripts, we've added explicit UTF-8 encoding settings:

   ```powershell
   $OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   ```

3. **File Encoding**: Ensure all files are saved with UTF-8 encoding.

4. **Database Collation**: Make sure your SQL Server database uses a collation that supports Vietnamese characters, such as `SQL_Latin1_General_CP1_CI_AS`.

5. **Font Support**: Use a console font that supports Vietnamese characters, such as Consolas or Lucida Console.

## Customization

Before running any of these tools, you may want to customize:

- **Connection String**: Update the connection string in the code to match your SQL Server instance
- **Table Structure**: If your `Areas` table has a different structure, modify the INSERT statements in the code

## Troubleshooting

If you encounter any issues:

1. **Database Connection**: Ensure your SQL Server instance is running and accessible
2. **Table Structure**: Verify that the `Areas` table exists with the expected columns
3. **Permissions**: Make sure the user running the application has permission to insert data into the database

## After Import

After successfully importing the data, you should have approximately 11,000+ records in your `Areas` table, representing all wards, districts, and cities in Vietnam. This data can be used for address selection in your application.
