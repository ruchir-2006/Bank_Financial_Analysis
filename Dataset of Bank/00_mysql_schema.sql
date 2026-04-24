-- ============================================================
--  FINANCE BANK — MySQL Schema + Import Guide
--  Data range: 2020-01-01 to 2025-03-31
--  8 Tables | Indian Banking Context
--  Compatible: MySQL 8.0+ / MariaDB 10.5+
-- ============================================================

CREATE DATABASE IF NOT EXISTS FINANCE_BANK;
USE FINANCE_BANK;

-- ─── 1. BRANCHES ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS branches (
    branch_id       INT PRIMARY KEY,
    branch_name     VARCHAR(100),
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(30),
    branch_type     VARCHAR(30),
    open_date       DATE,
    manager_name    VARCHAR(100),
    contact_number  VARCHAR(20)
);

-- ─── 2. CUSTOMERS ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS customers (
    customer_id     INT PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    email           VARCHAR(100),
    phone           VARCHAR(20),
    date_of_birth   DATE,
    gender          CHAR(1),
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(30),
    occupation      VARCHAR(60),
    annual_income   DECIMAL(12,2),
    credit_score    INT,
    kyc_status      VARCHAR(20),
    join_date       DATE
);

-- ─── 3. ACCOUNTS ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS accounts (
    account_id      INT PRIMARY KEY,
    customer_id     INT,
    branch_id       INT,
    account_number  VARCHAR(20) UNIQUE,
    account_type    VARCHAR(30),
    balance         DECIMAL(15,2),
    currency        VARCHAR(5),
    status          VARCHAR(20),
    open_date       DATE,
    close_date      DATE,
    interest_rate   DECIMAL(5,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id)   REFERENCES branches(branch_id)
);

-- ─── 4. CARDS ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS cards (
    card_id              INT PRIMARY KEY,
    customer_id          INT,
    card_type            VARCHAR(20),
    card_network         VARCHAR(20),
    card_number_masked   VARCHAR(25),
    credit_limit         DECIMAL(12,2),
    outstanding_balance  DECIMAL(12,2),
    issue_date           DATE,
    expiry_date          DATE,
    status               VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ─── 5. TRANSACTIONS ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id      INT PRIMARY KEY,
    account_id          INT,
    transaction_date    DATE,
    transaction_type    VARCHAR(30),
    amount              DECIMAL(15,2),
    currency            VARCHAR(5),
    merchant_category   VARCHAR(40),
    description         VARCHAR(100),
    channel             VARCHAR(30),
    status              VARCHAR(20),
    reference_number    VARCHAR(30),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- ─── 6. LOANS ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS loans (
    loan_id             INT PRIMARY KEY,
    customer_id         INT,
    branch_id           INT,
    loan_type           VARCHAR(40),
    purpose             VARCHAR(60),
    principal_amount    DECIMAL(15,2),
    outstanding_amount  DECIMAL(15,2),
    interest_rate       DECIMAL(5,2),
    tenure_months       INT,
    emi_amount          DECIMAL(12,2),
    start_date          DATE,
    end_date            DATE,
    status              VARCHAR(20),
    collateral          VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id)   REFERENCES branches(branch_id)
);

-- ─── 7. LOAN_PAYMENTS ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS loan_payments (
    payment_id      INT PRIMARY KEY,
    loan_id         INT,
    payment_date    DATE,
    amount_paid     DECIMAL(12,2),
    principal_paid  DECIMAL(12,2),
    interest_paid   DECIMAL(12,2),
    late_fee        DECIMAL(8,2),
    payment_method  VARCHAR(30),
    status          VARCHAR(20),
    remarks         VARCHAR(100),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- ─── 8. INVESTMENTS ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS investments (
    investment_id   INT PRIMARY KEY,
    customer_id     INT,
    investment_type VARCHAR(40),
    product_name    VARCHAR(80),
    invested_amount DECIMAL(15,2),
    current_value   DECIMAL(15,2),
    returns_percent DECIMAL(6,2),
    start_date      DATE,
    maturity_date   DATE,
    status          VARCHAR(30),
    risk_rating     VARCHAR(15),
    fund_manager    VARCHAR(60),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
--  HOW TO IMPORT CSVs ON MAC (MySQL Workbench / Terminal)
-- ============================================================
-- Option A — MySQL Workbench Table Data Import Wizard
--   Right-click each table → Table Data Import Wizard → select CSV
--
-- Option B — Terminal (run after placing CSVs in /tmp/banking/)
--   mysql -u root -p FINANCE_BANK < 00_mysql_schema.sql
--   Then use LOAD DATA LOCAL INFILE for each CSV (see below)
--
-- LOAD DATA LOCAL INFILE '/tmp/banking/branches.csv'
-- INTO TABLE branches FIELDS TERMINATED BY ','
-- ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
--
-- LOAD ORDER (respect foreign keys):
--  1. branches  2. customers  3. accounts  4. cards
--  5. loans     6. transactions  7. loan_payments  8. investments
-- ============================================================
