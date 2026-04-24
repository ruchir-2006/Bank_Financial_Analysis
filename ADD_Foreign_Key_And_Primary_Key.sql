USE finance_bank;


 -- ------------------------------------ ASSIGNING PRIMARY KEY --------------------------------------------------- --

-- ALTER TABLE customers 
-- ADD PRIMARY KEY ( customer_id ) ;

-- ALTER TABLE accounts 
-- ADD PRIMARY KEY ( account_id ) ;

-- ALTER TABLE branches 
-- ADD PRIMARY KEY ( branch_id ) ;

-- ALTER TABLE cards 
-- ADD PRIMARY KEY ( card_id ) ;

-- ALTER TABLE transactions 
-- ADD PRIMARY KEY ( transaction_id ) ;

-- ALTER TABLE loans 
-- ADD PRIMARY KEY ( loan_id ) ;

-- ALTER TABLE loan_payments 
-- ADD PRIMARY KEY ( payment_id ) ;

-- ALTER TABLE investments 
-- ADD PRIMARY KEY ( investment_id ) ;

-- ---------------------------------- ASSIGNING FOREIGN KEY ----------------------------------------------------- -- 

-- ALTER TABLE accounts 
-- ADD constraint fk_customer_id
-- FOREIGN KEY ( customer_id )
-- REFERENCES customers( customer_id );

-- ALTER TABLE accounts 
-- ADD constraint fk_branch_id
-- FOREIGN KEY ( branch_id )
-- REFERENCES branches( branch_id );

-- ALTER TABLE cards 
-- ADD constraint fk3_customer_id
-- FOREIGN KEY ( customer_id )
-- REFERENCES customers( customer_id );

-- ALTER TABLE transactions 
-- ADD constraint fk_account_id
-- FOREIGN KEY ( account_id )
-- REFERENCES accounts( account_id );

-- ALTER TABLE loans 
-- ADD constraint fk1_branch_id
-- FOREIGN KEY ( branch_id )
-- REFERENCES branches( branch_id );

-- ALTER TABLE loan_payments  
-- ADD constraint fk_loan_id
-- FOREIGN KEY ( loan_id )
-- REFERENCES loans( loan_id );

-- ALTER TABLE investments 
-- ADD constraint fk2_customer_id
-- FOREIGN KEY ( customer_id )
-- REFERENCES customers( customer_id );

