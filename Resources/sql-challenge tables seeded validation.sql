--Validating that database 'sql-challenge' tables properly seeded and filled using starter query provided 'all_tables_seed.sql',
--by cross-referencing tables created against raw individual csv files.
--Create or Replace View tables_creation_and_seed_validation as
Select *
From cardholder;		/*ok, matches raw csv file*/
--From merchant;		/*ok, matches raw csv file*/
--From credit_card;		/*ok, matches raw csv file*/
--From merchant_cat;	/*ok, matches raw csv file*/
--From transaction;		/*ok, matches raw csv file*/