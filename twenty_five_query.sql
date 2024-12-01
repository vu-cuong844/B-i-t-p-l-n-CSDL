--1. Lấy thông tin khách hàng
SELECT * FROM gym_management_system.customer;

--2. Lấy thông tin khách hàng theo id
SELECT * FROM gym_management_system.customer WHERE id = 1;

--3. Lấy thông tin dịch vụ
SELECT * FROM gym_management_system.service;

--4. Lấy thông tin các huấn luyện viên hiện tại
select staff.full_name as name, age , phonenumber, field, description, create_date
from gym_management_system.staff staff
join gym_management_system.staff_role sr on sr.ID_staff = staff.ID
join gym_management_system.position_information pi on pi.ID = sr.ID_role
join gym_management_system.personal_trainer pt on pt.ID_staff = staff.ID
where sr.status = "Active";

--5. Lấy thông tin các sản phẩm chăm sóc sức khỏe đi kèm
SELECT * FROM gym_management_system.product;

--6 Lấy thông tin nhân viên đang làm việc và vị trí hiện tại
select full_name, age, sex, phonenumber, role, create_date
from gym_management_system.staff staff
join gym_management_system.staff_role sr on sr.ID_staff = staff.ID
join gym_management_system.position_information pi on pi.ID = sr.ID_role
where sr.status = "Active";

--7. Lấy thông tin các trang thiết bị hiện có 
SELECT * FROM gym_management_system.equipment;

--8. Lấy thông tin các gói tập mà người dùng tên Peter Parker đã đăng ký
select full_name, s.name, cs.purchase_date, numer_of_session, cs.status, description
from gym_management_system.customer c
join gym_management_system.customer_service cs on c.ID = cs.ID_customer
join gym_management_system.service s on s.ID = cs.ID_service
where full_name = "Peter Parker";

--9.Lấy thông tin về gói tập tên "Weight Loss Program"
 select s.ID as MaGoiTap, name as service,full_name as PT, s.description, s.numer_of_session , s.sale_price as price, s.frequency
 from gym_management_system.personal_trainer pt
 join gym_management_system.personal_trainer_service ps on ps.ID_PT = pt.ID
 join gym_management_system.service s on s.ID = ps.ID_service
 join gym_management_system.staff staff on staff.ID = pt.ID_staff
 where s.name = "Weight Loss Program"

--10. Tính mỗi người dùng đã và đang sử dụng bao nhiêu gói tập
 select full_name, count(s.name) as number_of_service
 from gym_management_system.customer c
 join gym_management_system.customer_service cs on c.ID = cs.ID_customer
 join gym_management_system.service s on s.ID = cs.ID_service
 group by full_name;

--11. Tính mỗi gói tập có bao nhiêu người đăng ký
 select s.name as service, count(c.full_name) as number_of_customer
 from gym_management_system.customer c
 join gym_management_system.customer_service cs on c.ID = cs.ID_customer
 join gym_management_system.service s on s.ID = cs.ID_service
 group by s.name;

--12. Liệt kê các gói tập mà phòng tập đang duy trì hàng tháng
 select s.ID as MaGoiTap, s.name as service, c.full_name as customer, cs.remaining_sessions 
 from gym_management_system.customer c
 join gym_management_system.customer_service cs on c.ID = cs.ID_customer
 join gym_management_system.service s on s.ID = cs.ID_service
 where cs.status = "Incomplete";

--13. Lấy thông tin của người quản lý
 select staff.full_name as name, age, sex, date_of_birth, phonenumber, email, address, role, create_date as inauguration_day, department
 from gym_management_system.staff staff
 join gym_management_system.staff_role sr on sr.ID_staff = staff.ID
 join gym_management_system.position_information pi on pi.ID = sr.ID_role
 where pi.role = "Gym Manager";

--14. Liệt kê các nhân viên vào làm năm 2023
 select staff.full_name as name, age, sex, date_of_birth, phonenumber, email, address, create_date as inauguration_day, create_date as join_date
 from gym_management_system.staff staff
 join gym_management_system.staff_role sr on sr.ID_staff = staff.ID
 where year(sr.create_date)  = 2023;

--15.Tính tổng doanh thu từ tất cả các hóa đơn đã hoàn thành
 select sum(bill.total_amount) as total
 from gym_management_system.bill
 where bill.status = "Completed"

--16. Thông tin khách hàng chi tiêu nhiều nhất
 select c.full_name as customer, age, sex, phonenumber, address, total_amount as total
 from gym_management_system.customer c
 join gym_management_system.bill b on b.ID_customer = c.ID
 where total_amount = (
 						select max(gym_management_system.bill.total_amount)
                          from gym_management_system.bill
                        where gym_management_system.bill.status = "Completed"
 					    )

--17. Tính số lượng thiết bị đã được thêm vào trong mỗi năm
 select year(e.buy_date)as year, count(e.name) as quantity
 from gym_management_system.equipment e
 group by year(e.buy_date)

--18. Liệt kê các nhân viên đã từng trải qua nhiều một vai trò trong phòng gym
 select s.full_name as name
 from gym_management_system.staff s
 join gym_management_system.staff_role sr on sr.ID_staff = s.ID
 group by s.full_name
 having count(sr.ID_role) > 1

--19. Liệt kê tất cả các sản phẩm đã được bán kèm theo thông tin về số lượng đã bán và tổng doanh thu
 select p.name as product, sum(i.quantity) as quantity, sum(i.total) as total
 from gym_management_system.item_product_bill i
 join gym_management_system.product p on i.ID_product = p.ID
 group by p.name

--20.Tính doanh thu hàng tháng từ hóa đơn
 select year(b.create_date) as year, month(b.create_date) as month, sum(total_amount) as total
 from gym_management_system.bill b
 group by year(b.create_date), month(b.create_date)
--21. Danh sách hóa đơn có giá trị lớn hơn 500
 select *
 from gym_management_system.bill b
 where b.total_amount > 500
 
--22. Liệt kê các dịch vụ có giá cao nhất
 select * 
 from gym_management_system.service
 where sale_price = (
 					select max(gym_management_system.service.sale_price)
                     from gym_management_system.service
 					)
            
--23. Số lượng gói tập đã được bán ra đối với mối sản phẩm
 select s.name as service, count(cs.ID) as quantity
 from gym_management_system.service s
 join gym_management_system.customer_service cs on s.ID = cs.ID_service
 group by s.name
 order by count(cs.ID) desc;
 
--24. Tính tổng hóa đơn của hóa đơn có id = 1,
 select sum(bill.total)
 from (
 	(
        select `customer_service`.ID_service as item, `service`.`name` as item_name, `service`.sale_price as price, 1 as quantity,  `service`.sale_price * 1 as total
        from `gym_management_system`.`customer_service`
        join `gym_management_system`.`service` on `service`.ID =  `customer_service`.ID_service
        where `ID_bill` = 1
    )
     union
    (
        select `item_product_bill`.ID_product as item, `product`.`name` as item_name, `item_product_bill`.purchase_price as price, `item_product_bill`.quantity as quantity, `item_product_bill`.purchase_price * `item_product_bill`.quantity as total
        from `gym_management_system`.`item_product_bill`
        join `gym_management_system`.`product` on `product`.ID = `item_product_bill`.ID_product
        where `ID_bill` = 1
    )  
 ) as bill

--25 Lấy thông tin nội dung của hó đơn với id = 1
 (  
    select `customer_service`.ID_service as item, `service`.`name` as item_name, `service`.sale_price as price, 1 as quantity
    from `gym_management_system`.`customer_service`
    join `gym_management_system`.`service` on `service`.ID =  `customer_service`.ID_service
    where `ID_bill` = 1
 )
 union
 (  
    select `item_product_bill`.ID_product as item, `product`.`name` as item_name, `item_product_bill`.purchase_price as price, `item_product_bill`.quantity as quantity
    from `gym_management_system`.`item_product_bill`
    join `gym_management_system`.`product` on `product`.ID = `item_product_bill`.ID_product
    where `ID_bill` = 1
 );
