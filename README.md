<h1 align="center">CREATE THE OLIST DATABASE ON DATABRICKS, SQLITE3, MICROSOFT SQL SERVER, AND MYSQL</h1>

<br />

## Table of contents

1. [Project description](#project-description)
2. [Databricks implementation](#olist-database-on-databricks)
3. [Sqlite3 implementation](#olist-database-on-sqlite3)
4. [Microsoft SQL Server implementation](#olist-database-on-sql-server)
5. [MySQL implementation](#olist-database-on-mysql)

## Project description

The Olist dataset is available on [this Kaggle page](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) as a group of nine csv files. With more than 1.7 million rows, this data from the Brazilian e-commerce company Olist can be used for many different projects, including learning and practicing SQL coding skills.

This GitHub repository aims to provide files and scripts that will make possible to load the Olist dataset on some of the most used Database Management Systems (DBMS): Sqlite3, Microsoft SQL Server, and MySQL. One will find instructions below for each one of these option.

So, make your choice and let's start running SQL queries locally on the Olist database.

## Olist database on Databricks

Import the file `databricks_olist.dbc` to your Databricks Workspace. Then, open the `olist_database` notebook and run its first cell. After the cell finishes running, the olist tables should all be created in the `default` database.

## Olist database on Sqlite3

> Having sqlite3 installed locally, unzip the [olist_sqlite3_database.zip](./sqlite3/olist_sqlite3_database.zip) file and connect to the `olist.db` database file using the command `sqlite3 olist.db`. 

## Olist database on SQL Server

> Use the Microsoft SSMS (SQL Server Management Studio) software to restore the `olistdb.bak` file, which can be extracted from [olistdb_bak_file.zip](./ms_sql_server/olistdb_bak_file.zip).

> [Follow this tutorial](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver16#restore-a-backup) on how to restore a Microsoft SQL Server database from a `.bak` file using SSMS.

## Olist database on MySQL 

> You will need to have MySQL installed on your machine, with a user with `CREATE` privileges.
> On the terminal, run the commands below:

```shell
# save locally the ./mysql/mysql_dump_script.zip file and unzip it
unzip mysql_dump_script.zip

# login on MySQL shell. Change the root user for one of yours, if necessary
sudo mysql -u root -p

# on the MySQL interactive shell, run the following commands:
CREATE DATABASE olistdb;
quit

# run the command below to populate the olistdb with its tables;
# the mysql_dump_script.sql file is the one extracted from the previous zipped file
sudo mysql -u root -p olistdb < mysql_dump_script.sql

# now, login again on mysql and run some queries
sudo mysql -u root -p olistdb
SELECT * FROM sellers LIMIT 10;
```
