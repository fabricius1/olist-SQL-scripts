<h1 align="center">SQL SCRIPTS AND FILES TO CREATE THE OLIST DATABASE ON MYSQL, SQLITE3, AND MICROSOFT SQL SERVER</h1>

<br />

## Table of contents

1. [Project description](#project-description)
2. [MySQL implementation](#olist-database-on-mysql)
3. [Sqlite3 implementation](#olist-database-on-sqlite3)
4. [Microsoft SQL Server implementation](#olist-database-on-sql-server)

## Project description

The Olist dataset is available on [this Kaggle page](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) as a group of nine csv files. With more than 1.7 million rows, this data from a Brazilian e-commerce company can be used for many different projects, including learning and practicing SQL coding skills.

This repository aims to provide files and scripts that will make possible to load the Olist dataset on some of the most used Database Management Systems (DBMS): MySQL, Sqlite3, and Microsoft SQL Server. One will find below instructions for each one of these option.

So, make your choice and let's start running SQL queries locally on the Olist database!

## Olist database on MySQL 

> You will need to have MySQL installed on your machine, with a user with CREATE privileges.
> On the terminal, run the commands below:

```shell
# save locally the mysql/mysql_dump_script.zip file and unzip it
unzip mysql_dump_script.zip

# login on MySQL shell. Change the "root" user for yours, if necessary
sudo mysql -u root -p

# on the MySQL interactive shell, run the following commands:
CREATE DATABASE olistdb;
quit

# run the command below to populate the olistdb with its tables;
# the mysql_dump_script.sql file is the one extracted from the previous zipped file
sudo mysql -u root -p olistdb < mysql_dump_script.sql

# now, login again on mysql and run some queries
sudo mysql -u root -p olistdb
.mode table
SELECT * FROM sellers LIMIT 10;
```

## Olist database on sqlite3

## Olist database on SQL Server



