
--Amortization Calculation
-- M= P(r(1+r)^n/((1+r)^n -1))

DECLARE
    P NUMBER := &Principal;
    R NUMBER := &Interest;
    Y NUMBER := &Year;
    interest_paid float(10,0);
    principle_paid float(10,0);
    mortgage_balance float(10,0);
    month_s NUMBER; --Declare variable for Total Months
    monthly_rate FLOAT; --Declare variable for Monthly interest rate
    power_rate FLOAT;  
    monthly_p NUMBER(10,2);  -- Declare variable for Monthly principal and Interest
    m NUMBER;
    old_mortgage Number := P;
BEGIN
    dbms_output.put_line('Amortization Calculator');
    dbms_output.put_line('Loan Amount: $'||old_mortgage);
    dbms_output.put_line('Interest Rate: '||R);
    dbms_output.put_line('Number of Years: '||Y);

    month_s := Y*12; --Total Months
    monthly_rate := R/(100*12);   --Monthly Interest Rate
    power_rate := power((1+monthly_rate), month_s);  --Value of (1+r)^n 
    monthly_p := old_mortgage*(monthly_rate*power_rate/(power_rate - 1)); --Monthly principal and Interest

    dbms_output.put_line('Monthly Principal and Interest: $' || monthly_p);
    dbms_output.put_line('Number of Payments: ' || month_s);
    dbms_output.put_line('Total Payments: $' || (monthly_p * month_s));
    dbms_output.put_line('Original Loan Amount: $' || old_mortgage);
    
    for i in 1..month_s
    loop
            interest_paid := old_mortgage * monthly_rate;
            principle_paid := monthly_p - interest_paid;
            mortgage_balance := (old_mortgage - principle_paid); 
            
            dbms_output.put_line('Paymment-Amount ' || ' Interest-Paid '|| ' Principle-Paid '||' Mortgage-Balance');
            dbms_output.put_line(monthly_p ||'               '|| interest_paid ||'           '|| principle_paid ||'             '|| mortgage_balance);
            old_mortgage := mortgage_balance;
    end loop;
END;
/


