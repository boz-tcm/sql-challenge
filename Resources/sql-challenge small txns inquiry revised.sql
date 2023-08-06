Create or Replace View cardholder_small_cc_txns_aggregate_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, count(transaction.transaction_amt) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm
Order By txns_count_less_than_$2 desc;

Create or Replace View cardholder_small_cc_txns_daily_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, cast(transaction.transaction_dt as date), count(transaction.transaction_amt) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm, transaction.transaction_dt
Order By txns_count_less_than_$2 desc;

Create or Replace View cardholder_credit_card_small_txns_aggregate_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, count(transaction.transaction_id) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr
Order By txns_count_less_than_$2 desc;

Create or Replace View cardholder_credit_card_small_txns_daily_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr,cast(transaction.transaction_dt as date), count(transaction.transaction_id) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, transaction.transaction_dt
Order By txns_count_less_than_$2 desc;

Create or Replace View small_txns_7am_9am_aggregrate_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm,
count(transaction.transaction_amt) as top_100_small_txns_type_7_9
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Inner Join merchant on transaction.merchant_id = merchant.merchant_id
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Where transaction.transaction_amt < 2.00 and extract(hour from cast(transaction.transaction_dt as time)) >= 7 and extract(hour from cast(transaction.transaction_dt as time)) <= 9
Group By credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By top_100_small_txns_type_7_9 desc;

Create or Replace View top_100_largest_txns_7am_9am as
Select transaction.transaction_id, credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm,
transaction.transaction_amt as txn_amt
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Inner Join merchant on transaction.merchant_id = merchant.merchant_id
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Where extract(hour from transaction.transaction_dt) >= 7 and extract(hour from transaction.transaction_dt) <= 9
Group By transaction.transaction_id, credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By txn_amt desc
Limit 100;

Create or Replace View top_100_largest_txns_rest_of_day_not_7am_9am as
Select transaction.transaction_id, credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm,
transaction.transaction_amt as txn_amt
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Inner Join merchant on transaction.merchant_id = merchant.merchant_id
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Where extract(hour from transaction.transaction_dt) < 7 or extract(hour from transaction.transaction_dt) > 9
Group By transaction.transaction_id, credit_card.cardholder_id, cardholder.cardholder_nm, credit_card.credit_card_nbr, merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By txn_amt desc
Limit 100;

Create or Replace View top_merchants_prone_to_small_txns_aggregate_frequency as
Select merchant.merchant_nm, merchant_cat.merchant_cat_nm, count(transaction.transaction_id) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Inner Join merchant on transaction.merchant_id = merchant.merchant_id
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Where transaction.transaction_amt < 2.00
Group By merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By txns_count_less_than_$2 desc
Limit 100;

Create or Replace View top_merchants_prone_to_small_txns_aggregate_frequency as
Select merchant.merchant_nm, merchant_cat.merchant_cat_nm, count(transaction.transaction_id) as txns_count_less_than_$2
From merchant
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Inner Join transaction on merchant.merchant_id = transaction.merchant_id
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By txns_count_less_than_$2 desc
Limit 15;

Create or Replace View top_merchants_prone_to_small_txns_7am_9am_aggregate_frequency as
Select merchant.merchant_nm, merchant_cat.merchant_cat_nm, count(transaction.transaction_id) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Inner Join merchant on transaction.merchant_id = merchant.merchant_id
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Where transaction.transaction_amt < 2.00 and extract(hour from cast(transaction.transaction_dt as time)) >= 7 and extract(hour from cast(transaction.transaction_dt as time)) <= 9
Group By merchant.merchant_nm, merchant_cat.merchant_cat_nm
Order By txns_count_less_than_$2 desc;
--Limit 100;

--Confirm single merchant category is associated with a merchant, one-to-many, not many-to-many where merchant associated with more than one merchant
--category, as is also evident from noting merchant_id appearing as primary key (or unique) in merchant tbl.
Select merchant.merchant_nm, count(merchant_cat.merchant_cat_id) as cat_count
From merchant
Inner Join merchant_cat on merchant.merchant_cat_id = merchant_cat.merchant_cat_id
Group By merchant.merchant_nm
Order By cat_count desc;

Select *
From merchant

Select *
From merchant_cat