select * from financial_loan;

  -- 1.	Total Loan Applications
  select COUNT(id) AS total_applicants from financial_loan;

  select COUNT(distinct id) AS total_applicants from financial_loan where MONTH(issue_date) = 12;

   select COUNT(distinct id) AS total_applicants from financial_loan where MONTH(issue_date) = 11;

  -- 2.	Total Funded Amount
  select SUM(loan_amount) AS total_funded_amount from financial_loan;

  select SUM(loan_amount) AS total_funded_amount from financial_loan where MONTH(issue_date) = 12;

  select SUM(loan_amount) AS total_funded_amount from financial_loan where MONTH(issue_date) = 11;

  -- 3.	Total Amount Received
  select SUM(total_payment) AS total_amount_received from financial_loan;

  select SUM(total_payment) AS MTD_total_amount_received from financial_loan where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

  select SUM(total_payment) AS PMTD_total_amount_received from financial_loan where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

  -- 4.	Average Interest Rate
  select ROUND(AVG(int_rate), 4)*100 AS avg_int_rate from financial_loan;

  select ROUND(AVG(int_rate), 4)*100 AS avg_int_rate from financial_loan where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

   select ROUND(AVG(int_rate), 4)*100 AS avg_int_rate from financial_loan where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

  -- 5.	Average Debt-to-Income Ratio (DTI)
  select AVG(dti) AS avg_dti from financial_loan;

  -- Good Loan KPIs

  -- 1.	Good Loan Application Percentage
  select(select COUNT(id) from financial_loan where loan_status = 'Current' OR loan_status = 'Fully Paid')*100 / 
  (select COUNT(id) from financial_loan) AS good_loan_app_percent;

  -- 2.	Good Loan Applications
select COUNT(id) from financial_loan where loan_status = 'Current' OR loan_status = 'Fully Paid';

-- 3.	Good Loan Funded Amount
select SUM(loan_amount) from financial_loan where loan_status = 'Current' OR loan_status = 'Fully Paid';

-- 4.	Good Loan Total Received Amount
select SUM(total_payment) from financial_loan where loan_status = 'Current' OR loan_status = 'Fully Paid';


-- Bad Loan KPIs

 -- 1.	Bad Loan Application Percentage
  select(select COUNT(id) from financial_loan where loan_status = 'Charged Off')*100 / 
  (select COUNT(id) from financial_loan) AS good_loan_app_percent;

  -- 2.	Bad Loan Applications
select COUNT(id) from financial_loan where loan_status = 'Charged Off';

-- 3.	Bad Loan Funded Amount
select SUM(loan_amount) from financial_loan where loan_status = 'Charged Off';

-- 4.	Bad Loan Total Received Amount
select SUM(total_payment) from financial_loan where loan_status = 'Charged Off';


-- Loan Status Grid View
select loan_status, COUNT(id), SUM(loan_amount), SUM(total_payment), ROUND(AVG(int_rate),4)*100, ROUND(AVG(dti), 4)*100 
from financial_loan
group by loan_status;

-- MTD Amounts
select loan_status, SUM(loan_amount) AS MTD_Amount_Funded, SUM(total_payment) AS MTD_Amount_Recieved
from financial_loan
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
group by loan_status;


-- Section 2: Overview

-- 1. Monthly Trends by Issue Date
select MONTH(issue_date), DATENAME(MONTH, issue_date) AS Month, COUNT(id) AS Applicants, SUM(loan_amount) AS Amount_Funded, SUM(total_payment) AS Amount_Recieved
from financial_loan
group by MONTH(issue_date), DATENAME(MONTH, issue_date)
order by MONTH(issue_date);

-- 2. Regional Analysis by State 
select address_state AS State, COUNT(id) AS Applicants, SUM(loan_amount) AS Amount_Funded, SUM(total_payment) AS Amount_Recieved
from financial_loan
group by address_state;

-- 3. Loan Term Analysis
select term AS loan_term, COUNT(id) AS Applicants, SUM(loan_amount) AS Amount_Funded, SUM(total_payment) AS Amount_Recieved
from financial_loan
group by term;

-- 4. Employee Length Analysis 
select emp_length AS employee_length, COUNT(id) AS Applicants, SUM(loan_amount) AS Amount_Funded, SUM(total_payment) AS Amount_Recieved
from financial_loan
group by emp_length;

-- Similarly for 5 & 6 Just change the first columns

