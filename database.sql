-- tạo database quản lý 
create database gym_management_system

-- tạo bảng customer
CREATE TABLE `gym_management_system`.`customer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(512) NOT NULL,
  `age` INT NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `phonenumber` VARCHAR(16) NOT NULL,
  `email` VARCHAR(64) NOT NULL,
  `date_of_birth` DATE NULL,
  `address` VARCHAR(255) NOT NULL,
  `create_date` DATE NOT NULL,
  PRIMARY KEY (`ID`));


--   tạo bảng staff
CREATE TABLE `gym_management_system`.`staff` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NOT NULL,
  `age` INT NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `phonenumber` VARCHAR(16) NOT NULL,
  `date_of_birth` DATETIME NOT NULL,
  `noID` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `bank_account` VARCHAR(32) NULL,
  `image_url` VARCHAR(256) NOT NULL,
  `address` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `noID_UNIQUE` (`noID` ASC) VISIBLE,
  UNIQUE INDEX `phonenumber_UNIQUE` (`phonenumber` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `image_url_UNIQUE` (`image_url` ASC) VISIBLE);


-- tạo bảng thông tin các vị trí làm việc của nhân viên
CREATE TABLE `gym_management_system`.`position_information` (
  `ID` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `department` VARCHAR(256) NOT NULL,
  `basic_salary` DOUBLE NOT NULL,
  PRIMARY KEY (`ID`));

--   tạo bảng trung gian staff_role
CREATE TABLE `gym_management_system`.`staff_role` (
  `ID_staff` INT NOT NULL,
  `ID_role` INT NOT NULL,
  `create_date` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `note` LONGTEXT NULL,
  PRIMARY KEY (`ID_staff`, `ID_role`, `create_date`),
  INDEX `FK_role_idx` (`ID_role` ASC) VISIBLE,
  CONSTRAINT `FK_staff`
    FOREIGN KEY (`ID_staff`)
    REFERENCES `gym_management_system`.`staff` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_role`
    FOREIGN KEY (`ID_role`)
    REFERENCES `gym_management_system`.`position_information` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- tạo bảng customer_login
CREATE TABLE `gym_management_system`.`customer_login` (
  `ID_customer` INT NOT NULL,
  `usename` VARCHAR(256) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`ID_customer`),
  UNIQUE INDEX `usename_UNIQUE` (`usename` ASC) VISIBLE,
  CONSTRAINT `FK_customer_login`
    FOREIGN KEY (`ID_customer`)
    REFERENCES `gym_management_system`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- tạo bảng staff_login
CREATE TABLE `gym_management_system`.`staff_login` (
  `ID_staff` INT NOT NULL,
  `username` VARCHAR(64) NOT NULL,
  `pasword` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`ID_staff`),
  CONSTRAINT `FK_staff_login`
    FOREIGN KEY (`ID_staff`)
    REFERENCES `gym_management_system`.`staff` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- tạo bảng thiết bị
CREATE TABLE `gym_management_system`.`equipment` (
  `ID` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `brand` VARCHAR(128) NOT NULL,
  `position` VARCHAR(256) NOT NULL,
  `buy_date` DATE NOT NULL,
  `purchase_price` DOUBLE NOT NULL,
  `warranty` INT NULL,
  `status` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`ID`));

-- tạo bảng quản lsy PT
CREATE TABLE `gym_management_system`.`personal_trainer` (
  `ID` INT NOT NULL,
  `ID_staff` INT NOT NULL,
  `field` VARCHAR(45) NOT NULL,
  `category` INT NOT NULL,
  `min` INT NOT NULL,
  `max` INT NOT NULL,
  `description` LONGTEXT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_staff_UNIQUE` (`ID_staff` ASC) VISIBLE,
  CONSTRAINT `FK_staff_PT`
    FOREIGN KEY (`ID_staff`)
    REFERENCES `gym_management_system`.`staff` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

 -- tạo bảng gói tập 
 CREATE TABLE `gym_management_system`.`service` (
  `ID` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `category` VARCHAR(256) NOT NULL,
  `sale_price` DOUBLE NOT NULL,
  `numer_of_session` INT NOT NULL,
  `frequency` INT NOT NULL,
  `description` LONGTEXT NULL,
  `pt_persentage` DOUBLE NOT NULL,
  `gym_persentage` DOUBLE NOT NULL,
  PRIMARY KEY (`ID`));

-- tạo bảng pt_service
CREATE TABLE `gym_management_system`.`personal_trainer_service` (
  `ID_PT` INT NOT NULL,
  `ID_service` INT NOT NULL,
  PRIMARY KEY (`ID_PT`, `ID_service`),
  INDEX `FK_servie_PT_idx` (`ID_service` ASC) VISIBLE,
  CONSTRAINT `FK_PT`
    FOREIGN KEY (`ID_PT`)
    REFERENCES `gym_management_system`.`personal_trainer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_servie_PT`
    FOREIGN KEY (`ID_service`)
    REFERENCES `gym_management_system`.`service` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- tạo bảng customer_service
CREATE TABLE `gym_management_system`.`customer_service` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_customer` INT NOT NULL,
  `ID_service` INT NOT NULL,
  `purchase_price` DOUBLE NOT NULL,
  `purchase_date` DATETIME NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_customer_service_idx` (`ID_customer` ASC) VISIBLE,
  INDEX `FK_servicer_customer_idx` (`ID_service` ASC) VISIBLE,
  CONSTRAINT `FK_customer_service`
    FOREIGN KEY (`ID_customer`)
    REFERENCES `gym_management_system`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_servicer_customer`
    FOREIGN KEY (`ID_service`)
    REFERENCES `gym_management_system`.`service` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- tạo bảng mặt hàng
CREATE TABLE `gym_management_system`.`product` (
  `ID` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `purchase_price` DOUBLE NOT NULL,
  `sale_price` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  `entry_date` DATE NOT NULL,
  `expiry_date` DATE NOT NULL,
  `description` LONGTEXT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));

-- tạo bill
CREATE TABLE `gym_management_system`.`bill` (
  `ID` INT NOT NULL,
  `ID_customer` INT NOT NULL,
  `ID_staff` INT NOT NULL,
  `create_date` DATETIME NOT NULL,
  `total_amount` DOUBLE NOT NULL,
  `payment_method` VARCHAR(128) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));

-- tạo itemBillservice
CREATE TABLE `gym_management_system`.`item_service_bill` (
  `ID` INT NOT NULL,
  `ID_bill` INT NOT NULL,
  `ID_service` INT NOT NULL,
  `purchase_price` DOUBLE NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_bill_idx` (`ID_bill` ASC) VISIBLE,
  INDEX `FK_service_idx` (`ID_service` ASC) VISIBLE,
  CONSTRAINT `FK_bill`
    FOREIGN KEY (`ID_bill`)
    REFERENCES `gym_management_system`.`bill` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service`
    FOREIGN KEY (`ID_service`)
    REFERENCES `gym_management_system`.`service` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  -- thêm tự tăng cho cột ID
    ALTER TABLE `gym_management_system`.`item_service_bill` 
    CHANGE COLUMN `ID` `ID` INT NOT NULL AUTO_INCREMENT ;

-- tạo item product
CREATE TABLE `gym_management_system`.`item_product_bill` (
  `ID` INT NOT NULL,
  `ID_bill` INT NOT NULL,
  `ID_product` INT NOT NULL,
  `purchase_price` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  `total` DOUBLE NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_bill_product_idx` (`ID_bill` ASC) VISIBLE,
  INDEX `FK_product_idx` (`ID_product` ASC) VISIBLE,
  CONSTRAINT `FK_bill_product`
    FOREIGN KEY (`ID_bill`)
    REFERENCES `gym_management_system`.`bill` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_product`
    FOREIGN KEY (`ID_product`)
    REFERENCES `gym_management_system`.`product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  -- thêm tự tăng cho cột ID
  ALTER TABLE `gym_management_system`.`item_product_bill` 
      CHANGE COLUMN `ID` `ID` INT NOT NULL AUTO_INCREMENT ;


  -- thêm ràng buộc cho bảng customer
  ALTER TABLE `gym_management_system`.`customer` 
  CHANGE COLUMN `email` `email` VARCHAR(64) NULL ,
  ADD UNIQUE INDEX `phonenumber_UNIQUE` (`phonenumber` ASC) VISIBLE,
  ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE;

  -- thêm thông tin cho bảng customer
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Perter Parker', '24', 'Nam', '0978654321', 'peterparker@gmail.com', '2000-08-20', '20 Ingram Street, Forest Hills, Queens, New York', '2024-12-01');
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Steve Rogers', '30', 'Nam', '0987456321', 'steve@gmail.com', '1994-07-04', 'Brooklyn, New York, Hoa Kỳ', '2024-12-01');
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Clint Barton', '53', 'Nam', '0331265478', 'clintbarrton@gmail.com', '1971-06-07', 'Missouri, Hoa Kỳ', '2024-12-01');
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Natasha Romanoff', '40', 'Nữ', '0156324789', 'natasha@gmail.com', '1984-11-22', '23rd Street, Manhattan, New York, Hoa Kỳ', '2024-12-01');
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Stephen Strange', '45', 'Nam', '0564231751', 'drstephen@gmail.com', '1989-11-11', 'Sanctum Sanctorum, 177A Bleecker Street, Greenwich Village, Manhattan, New York, Hoa Kỳ', '2024-12-01');
  INSERT INTO `gym_management_system`.`customer` (`full_name`, `age`, `sex`, `phonenumber`, `email`, `date_of_birth`, `address`, `create_date`) VALUES ('Wanda Maximoff', '30', 'Nữ', '0987836542', 'wanda@gmail.com', '1994-01-01', 'Westview, New Jersey', '2024-12-01');
  -- thêm thông tin cho bảng staff
  INSERT INTO `gym_management_system`.`staff` (`full_name`, `age`, `sex`, `phonenumber`, `date_of_birth`, `noID`, `email`, `bank_account`, `image_url`, `address`) VALUES ('Bruce Banner', '45', 'Nam', '0321465789', '1979-12-18', '034204003291', 'hulk@gmail.com', '012345678910', 'ảnh 1', 'New York, Hoa Kỳ');
  INSERT INTO `gym_management_system`.`staff` (`full_name`, `age`, `sex`, `phonenumber`, `date_of_birth`, `noID`, `email`, `bank_account`, `image_url`, `address`) VALUES ('Scott Lang', '45', 'Nam', '0654123789', '1979-04-17', '034204001235', 'antman@gmail.com', '015324698715', 'ảnh 2', 'San Francisco, California, Hoa Kỳ');
  INSERT INTO `gym_management_system`.`staff` (`full_name`, `age`, `sex`, `phonenumber`, `date_of_birth`, `noID`, `email`, `bank_account`, `image_url`, `address`) VALUES ('Carol Danvers', '40', 'Nữ', '0648979816', '1984-07-24', '034204001254', 'captain@gmail.com', '016981494899', 'ảnh 3', 'Hà Nội');


