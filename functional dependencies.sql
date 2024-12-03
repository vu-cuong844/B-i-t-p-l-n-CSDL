1.Bảng customer
ID → full_name, age, sex, phonenumber, email, date_of_birth, address, create_date

2.Bảng staff
ID → full_name, age, sex, phonenumber, date_of_birth, noID, email, bank_account, image_url, address

3.Bảng position_information
ID → role, department, basic_salary

4.Bảng staff_role
ID_staff, ID_role, create_date → status, note

5.Bảng customer_login
ID_customer → username, password

6.Bảng service
ID → name, category, sale_price, numer_of_session, frequency, description, pt_persentage, gym_persentage

7.Bảng bill
ID → ID_customer, ID_staff, create_date, total_amount, payment_method, status

8.Bảng item_service_bill
ID → ID_bill, ID_service, purchase_price

9.Bảng product
ID → name, purchase_price, sale_price, quantity, entry_date, expiry_date, description, status

10.Bảng item_product_bill
ID → ID_bill, ID_product, purchase_price, quantity, total