# Columbia Engineering FinTech Bootcamp 2023-06

> Project: Module 7 SQL challenge assignment

> Purpose: In this activity, we used our newfound SQL and Python skills to analyze historical credit card transactions and consumption patterns with the goal of identifying possible fraudulent transactions.

## Technologies Used
- pgAdmin 7.2 with PostgreSQL 15 Database `sql-challenge_db`
- Python Version 3.10.12
- VS Code IDE for both Jupyter Notebook `visual_data_analysis.ipynb` and a README markdown file.

## Setup
- GitHub Repository
    - name: 'sql-challenge'
    - location: uploaded to Bootcamp homework submission online portal, and available publicly at:
        - [GitHub Repository](https://github.com/boz-tcm/sql-challenge): `github.com/boz-tcm/sql-challenge`
- Python Standard Library (Version 3.10.12)
- Python Modules:
    - pandas
    - sqlalchemy 1.4.49
    - calendar
    - hvplot.pandas
    - holoviews
- Jupyter Notebook(s):
    - name: `visual_data_analysis.ipynb`
    - location: `sql-challenge/`
- Data
    - location: 'pyviz-challenge/Instructions/Starter_Code/Resources/'
    - includes: 
        1. `sql-challenge_db` schema:
            >`QuickDBD_schema_sql-challenge.sql`
        2. `sql-challenge_db` seed data:
            >`all_tables_seed.sql`
        3. `sql-challenge_db` seeded tables validation:
            >`sql-challenge tables seeded validation.sql`
        4. `sql-challenge_db` core SQL queries alogn with Views and Jupyter Notebook SQL query code:
            >`sql-challenge small txns inquiry.sql`
- Images
    - location: `sql-challenge/Images`
    - includes:
        1. Entity Relationship Diagram for `sql-challenge_db`:
            >`QuickDBD-sql-challenge ERD.png`
        2. `sql-challenge_db` graph visualizers for various queries


## Data Analysis Report

### <u>Part 1</u>

- Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders.

    - How can you isolate (or group) the transactions of each cardholder?
    
        `We can create an SQL select query where we group on cardholder_id and cardholder name, and count the number of credit card transactions by cardholder that are less than $2 each.  As a result, we observed many cardholders with numerous transactions less than $2 each, and therefore further refined and investigated the grouping in the following two ways:`

        `1. Because each cardholder (defined by cardholder_id along with associated cardholder name) could hold more than one credit card, we added credit card number to the grouping to investigate whether there were any particular card(s) potentially associated with fraud.  This reflected our belief that consumer fraud can occur on multiple levels, including both general identify theft and cases of individual credit card theft, e.g. gas station and retail outlets card skimming.`
        
        `2. We added transaction grouping by date to the 1-year period covered by the data to investigate whether there were small transaction spikes on any given day associated with the cardholder.`

    - Count the transactions that are less than $2.00 per cardholder.
        
        `Over the 2018 transaction period of 1 year, we observed the following number of transactions below $2 by cardholder:`

        ![2018 annual small transactions by cardholder.](Images/graph_visualiser-1691099181250.png)

        `Over the 2018 transaction period, we observed the following number of transactions below $2 by cardholder credit card:`

        ![2018 annual small transactions by cardholder and credit card.](Images/graph_visualiser-1691217177999.png)

        `On days when a transaction was made, we did not observe any cardholder with more than one transaction per day below $2:`

        ![2018 daily small transactions by cardholder.](Images/graph_visualiser-1691099683465.png)

    - Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

        `While we don't see any unusual spikes in small transactions on a daily basis, over the one year period we do see TEN OR MORE small transactions for SIX credit cards associated with six different cardholders, and which may be worthy of further investigation.  There are a further 47 credit cards associated with small transactions over the year ranging in count from 2 to 9, which may also be associated with fraud, but may also be legitimate small transactions such as coffee, parking meters, and convenience store items.`

- Take your investigation a step further by considering the time period in which potentially fraudulent transactions are made.

    - What are the top 100 highest transactions made between 7:00 am and 9:00 am?

        `This question was initially confusing.  But ultimately interpreted as meaning the top 100 'largest' transactions, as 'highest', in contrast, connoted frequency which was tested and didn't comport with or make sense within our use of the SQL 'LIMIT 100' transactions condition.  The top 100 largest individual transactions between 7 am and 9 am were characterized by bar and pub activity dominating the top 5 transactions, as illustrated below:`

        ![2018 annual small transactions by cardholder credit card.](Images/graph_visualiser-1691227513449.png)

        `We interpret this investigation so far as exploring a) small transactions less than $2 each, which are more likely than other transactions to go undetected by the cardholder throughout the day, regardless of time of day; and b) separately this latest step to explore all transaction types and amounts that occur within a limited timeframe (7 am - 9 am, before many cardholders have started their busy days legitimately transacting normal business), we interpret as another opportunity for fraudulent activity to go undetected by cardholders, regardless of transaction size.`

    - Do you see any anomalous transactions that could be fraudulent?

        `We see unusual and unexpected bar and pub activity, both in terms of the type of activity and the size of the individual transaction amounts, occurring between 7 am and 9 am.`

    - Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?

        `Out of 275 transactions that took place between 7 am to 9 am, nine of them were over $100, and five of those were unusual, potentially fraudulent bar and pub activity for this time of day.`
        
        `Outside of the 7 am - 9 am time period, we naturally observed a far higher number of transactions throughout the rest of the day, totaling 3225 transactions.  Of these 3225 transactions, 99 of them were over $100, and we saw around four unusually large coffee shop transactions occurring after 7 pm, including two around 11 pm and another after midnight.`

        `The relative frequency of transactions over $100 in both periods was around 3%, however, of those $100+ transactions, the relative frequency of what we flagged as potentially unusual activity related to bars and pubs in the 7 am - 9 am period was around 55% (5/9), while the relative frequency of potentially fraudulent coffee transactions between 7:30 pm and 12:30 am was around 4% (4/99).  Although we think a more thorough investigation of the 99 100+ transactions occurring outside of 7 am - 9 am could potentially reveal additional fraudulent activity, we don't believe it would come anywhere close to the 55% frequency estimated in the  7 am - 9 am period.`

    - If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.

        `People engaged in fraud may be more motivated to do so at the start of the day and when targeted businesses, consumers, and fraudulent monitoring services may be less active and vigilant.`

- What are the top 5 merchants prone to being hacked using small transactions?

    `Small transactions of 5 or more were observed across 15 merchants.  Of these 15 merchants, 5 were associated with bars and pubs: Wood-Ramirez (7 transactions), Hood-Phillips (6), Atkinson Ltd (5), Greene-Wood (5), and Jarvis-Turner (5).  Top small transaction merchants are shown below where 5 or more small transactions were observed.  Note a number of merchants tied with 5 transactions, and there order appears below based on transaction date and time:`

    ![2018 annual small transactions by cardholder credit card.](Images/graph_visualiser-1691361766454.png)

- Create a view for each of your queries.

    `Views created:`
    - Cardholder small transactions:    `cardholder_small_cc_txns_aggregate_frequency`
    - Cardholder credit card small transactions:    `cardholder_credit_card_small_txns_aggregate_frequency`
    - Cardholder small daily transactions:  `cardholder_small_cc_txns_daily_frequency`
    - Cardholder credit card small daily transactions:  `cardholder_credit_card_small_txns_daily_frequency`
    - 100 largest individual credit card transactions 7 am - 9 am:  `top_100_largest_txns_7am_9am`
    - 100 largest individual credit card transactions remainder of day (outside 7 am - 9 am period):     `top_100_largest_txns_rest_of_day_not_7am_9am`
    - Top 5+ merchants prone to small transactions: `top_merchants_prone_to_small_txns_aggregate_frequency`
    - Data Analysis Question 1 for Jupyter Notebook **visual_data_analysis.ipynb**: `data_analysis_question_1_cid_02_cid_18`
    - Data Analysis Question 2 for Jupyter Notebook **visual_data_analysis.ipynb**: `data_analysis_question_2_cid_25_h1_2018`

### <u>Part 2</U>

- The two most important customers of the firm may have been hacked. Verify if there are any fraudulent transactions in their history. For privacy reasons, you only know that their cardholder IDs are 2 and 18.

    - Using hvPlot, create a line plot representing the time series of transactions over the course of the year for each cardholder separately.

        `Please refer to Jupyter Notebook for code and plots:` ['visual_data_analysis.ipynb'](visual_data_analysis.ipynb)

    - Next, to better compare their patterns, create a single line plot that contains both card holders' trend data.

        `Please refer to Jupyter Notebook for code and plot:` ['visual_data_analysis.ipynb'](visual_data_analysis.ipynb)

    - What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale.

        `We observed a relatively random, but tight range of transactions centered around $1 - $20 for cardholder #2.  From our plot, we did not observe a pattern of systematic purchase behavior readily indicative of fraud, however, there were a number of sub-$2 transactions which could trigger further review of transaction type (i.e., merchant and merchant category) along with time of day.`

        `For cardholder #18, in contrast, we observed regular lower dollar activity that might be indicative of normal daily activity, mixed with irregular and relatively infrequent spikes of large dollar activity over $500, which occurred around 7 times throughout the year, most notably four large transactions that occurred from around 10 pm to 5:30 am, which due to time of day (overnight) and seemingly random, infrequent frequency may be a sign of fraudulent activity worthy of further quantitative and qualitative investigation.`

- The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. Again, for privacy reasons, you know only that the cardholder ID in question is 25.

    - Using hvPlot, create a box plot, representing the expenditure data from January 2018 to June 2018 for cardholder ID 25.
        
        `Two box plot views were created using hvplot for all cardholder ID 25 transactions in the first-half of 2018: 1) A single box plot for all cardholder ID 25 transaction activity occurring in the first-half of 2018; and 2) a monthly box plot for each month of activity in the first-half of 2018.  Please refer to Jupyter Notebook` ['visual_data_analysis.ipynb'](visual_data_analysis.ipynb) `for these two plots.`

    - Are there any outliers for cardholder ID 25? How many outliers are there per month?
        
        `Both views demonstrate outliers, defined as individual points plotted outside the box-and-whisker upper and lower boundaries.`
        
        `1. The H1 2018 aggregate box plot reveals three transaction outliers of around (estimated from graph): a) $269; b) $748; and c) $1180.  This would correspond to an outlier transaction roughly once every other month.`
        
        `2. The monthly box plots reveal an outlier in June 2018 at around $748.  Therefore, out of six monthly box plots, based on this interpretation, there was observed an outlier once every six months.  Because of the low frequency of transactional data for cardholder ID 25 on a monthly basis, and therefore low credibility, the other two outliers observed in the 6-month box plot were not detected, or picked up, as outliers in the monthly box plots for example, January had only two transactions, and therefore the large January transaction of $1177 did not occur within a sufficient context to detect it solely based on a monthly box plot, and similarly the other 6-month outlier of $279 in April was the only transaction in April and also lacked sufficient context to place it within the monthly box plot.`

    - Do you notice any anomalies? Describe your observations and conclusions.

        `The aggregate 6-month box plot for the first-half of 2018 did the best job revealing anomalous restaurant transactions of $1177, $269, and $749 occurring in January, April, and June, respectively, and corroborate the CEO customer's concerns that her corporate credit card was used without authorization in the first-half of 2018 to pay unusually expensive restaurant bills inconsistent with her typical restaurant activity.`

## Project Status
Project is: _complete

## Room for Improvement
To do: Time permitting, will circle back to outlier-detection-challenge employing interquartile range nd standard deviation custom functions.

## Contact
Created by Todd C. Meier, tmeier@bozcompany.com - feel free to contact me!

<!-- ## License --> All rights reserved.