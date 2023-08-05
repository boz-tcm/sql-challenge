Create or Replace View cardholder_small_cc_txns_daily_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, cast(transaction.transaction_dt as date), count(transaction.transaction_amt) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
--Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id 
--Group By cardholder.cardholder_nm;
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm, transaction.transaction_dt
--Where transaction.transaction_amt < 2.00
Order By txns_count_less_than_$2 desc;

Create or Replace View cardholder_small_cc_txns_aggregate_frequency as
Select credit_card.cardholder_id, cardholder.cardholder_nm, count(transaction.transaction_amt) as txns_count_less_than_$2
From transaction
Inner Join credit_card on transaction.credit_card_nbr = credit_card.credit_card_nbr
Inner Join cardholder on credit_card.cardholder_id = cardholder.cardholder_id
Where transaction.transaction_amt < 2.00
Group By credit_card.cardholder_id, cardholder.cardholder_nm
Order By txns_count_less_than_$2 desc;

Select *
From transaction;