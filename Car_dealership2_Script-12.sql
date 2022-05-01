CREATE TABLE "Salesperson" (
	"salesperson_id" serial NOT NULL,
	"f_name" varchar(50) NOT NULL,
	"l_name" varchar(50) NOT NULL,
	"phone_number" varchar(255) NOT NULL,
	"num_cars_sold" DECIMAL NOT NULL,
	"type_sold" varchar NOT NULL,
	"invoices" varchar NOT NULL,
	"salespersonid" int NOT NULL,
	CONSTRAINT "Salesperson_pk" PRIMARY KEY ("salesperson_id")
) WITH (
  OIDS=FALSE
)

create OR replace FUNCTION addSalesperson(   
_f_name varchar(50),
_l_name varchar(50),
_phone_number varchar(255),
_number_of_cars_sold decimal,
_type_sold varchar(255),
_invoices varchar(255),
_salespersonid int
)
returns void
as $main$
begin
	insert into salesperson(f_name, l_name, phone_number, numcars_sold, type_sold, invoices, salespersonid)
	values (_f_name, _l_name, _phone_number, _num_cars_sold, _type_sold, _invoices, _salespersonid);
end;
$main$
language plpgsql;

select addSalesperson('King', 'TChalla', '214-778-7777',18.0, 'New', '18', 1)
select addSalesperson('Diana', 'Troi', '682-781-5555',19.0, 'New', '19', 2)


select *
from "Salesperson"
where f_name = 'Diana'



CREATE TABLE "customers" (
	"customer_id" serial NOT NULL,
	"f_name" varchar(50) NOT NULL,
	"l_name" varchar(50) NOT NULL,
	"address" varchar(255) NOT NULL,
	"phone_number" varchar(255) NOT NULL,
	"car_purchased" varchar(255) NOT NULL,
	"purchase_date" varchar(255) NOT NULL,
	"car_condition" varchar(255) NOT NULL,
	"purchase_price" DECIMAL NOT NULL,
	"custid" int NOT NULL,
	"service_only" varchar(255) NOT NULL,
	"service_date" varchar(255) NOT NULL,
	CONSTRAINT "customers_pk" PRIMARY KEY ("customer_id")
) WITH (
  OIDS=FALSE
);

create or replace function addCustomer(    
_f_name varchar(50),
_l_name varchar(50),
_address varchar(255),
_car_purchased varchar(255),
_purchase_date varchar(255),
_car_condition varchar(255),
_purchase_price money,
_custid int,
_service_only varchar(255),
_service_date varchar(255)
)
returns void
as $main$
begin
	insert into customer(f_name, l_name, address, car_purchased, purchase_date, car_condition, purchase_price, custid, service_only, service_date)
	values (_f_name, _l_name, _address, _car_purchased, _purchase_date, _car_condition, _purchase_price, _custid, _service_only, _service_date);
--commit;
end;
$main$
language plpgsql;

select addCustomers('Oliver', 'Queen', '4578 Green Arrow St.','Mercedes EQS', '03-09-2022', 'New', 100000.000, 2, 'None','None')
select addCustomers('Bruce', 'Banner', '8977 Big Green Ave.', 'Honda Accord','04-09-2022', 'Used', 21000.000, 2,'None', 'None')

select *
from customers
where car_condition = 'New'


CREATE TABLE "service" (
	"service_id" serial NOT NULL,
	"date_of_service" timestamp with time zone NOT NULL,
	"type_of_service" varchar(255) NOT NULL,
	"service_charge" DECIMAL NOT NULL,
	"service_performed" varchar(255) NOT NULL,
	"parts_ordered" varchar(255) NOT NULL,
	"serviceid" int NOT NULL,
	CONSTRAINT "service_pk" PRIMARY KEY ("service_id")
) WITH (
  OIDS=FALSE
);

create or replace function addService(  
_date_of_service timestamp with time zone,
_type_of_service varchar(255),
_service_charge decimal,
_service_performed varchar(255),
_parts_ordered varchar(255),
_serviceid int
)
returns void
as $main$
begin
	insert into service(date_of_service, type_of_service, service_charge, service_performed, parts_ordered, serviceid)
	values(_date_of_service, _type_of_service, _service_charge, _service_performed, _parts_ordered, _serviceid);
--commit;
end;
$main$
language plpgsql;

select addService(now()::timestamp,'None', 0.00, 'None', 'None', 1)
select addService(now()::timestamp,'Oil Change', 35.99, 'Maintenance', 'Filter', 1)

select *
from service
where type_of_service = 'Oil Change'


CREATE TABLE "cars" (
	"car_vin" serial NOT NULL,
	"car_make" varchar(255) NOT NULL,
	"car_model" varchar(255) NOT NULL,
	"car_year" varchar(255) NOT NULL,
	"car_condition" varchar(255) NOT NULL,
	"MSRP" DECIMAL NOT NULL,
	"sold_price" DECIMAL NOT NULL,
	"car_serial" int NOT NULL,
	CONSTRAINT "cars_pk" PRIMARY KEY ("car_vin")
) WITH (
  OIDS=FALSE
);

create or replace function addCars(
car_make varchar(50),
car_model varchar(50),
car_year varchar(255),
car_condition varchar(255),
MSRP float8,
sold_price float8,
car_serial int
)
returns void
as $main$
begin
	insert into cars(car_make, car_model, car_year, car_condidtion, MSRP, sold_price, car_serial)
	values (car_make, car_model, car_year, car_condidtion, mileage, MSRP, sold_price, car_serial);
end;
$main$
language plpgsql;

select addCars('Lexus', 'ES350', '2022', 'New', 75000.00, 75990.00,'1')
select addCars('Honda', 'Civic', '2017', 'Used', 21000.00, 15000.00,'2');

select *
from cars
where car_make = 'Lexus'


CREATE TABLE "mechanic" (
	"mechanic_id" serial NOT NULL,
	"f_name" varchar(255) NOT NULL,
	"l_name" varchar(255) NOT NULL,
	"mechanicid" int NOT NULL,
	CONSTRAINT "mechanic_pk" PRIMARY KEY ("mechanic_id")
) WITH (
  OIDS=FALSE
);

create OR replace FUNCTION addMechanic(  
f_name varchar(255),
l_name varchar(255),
mechanicid int
)
returns void
as $main$
begin
	insert into mechanic(f_name, l_name, mechanicid)
	values (f_name, l_name, mechanicid);
end;
$main$
language plpgsql;

select addMechanic('Luke', 'Cage', 1)
select addMechanic('Liu', 'Kang', 2)

select *
from mechanic
where f_name = 'Luke'


CREATE TABLE "transactions" (
	"salespersonid" serial NOT NULL,
	"customerid" int NOT NULL,
	"purchase_price" DECIMAL NOT NULL,
	"commission" DECIMAL NOT NULL,
	"service_charge" DECIMAL NOT NULL,
	"purchase_invoice" varchar(255) NOT NULL,
	"service_invoice" varchar(255) NOT NULL
) WITH (
  OIDS=FALSE
);

create or replace function addTransactions( 
salespersonid int,
customerid int,
purchase_price decimal,
commission decimal,
service_charge decimal,
purchase_invoice varchar(255),
service_invoice varchar(255)
)
returns void
as $$
begin
	insert into transactions(customerid, salespersonid, purchase_price, commission, service_charge, purchase_invoice, service_invoice)
	values (customerid, salespersonid, purchase_price, commission, service_charge, purchase_invoice, service_invoice);
end;
$$
language plpgsql;

select addtransactions(2, 2, 75999.00, 17.0, 0.00, '75,999', 'None')
select addtransactions(1, 1, 75000.00, 20.0, 35.99, '75,000', '35.99')


select *
from transactions
where commission = 17.0

ALTER TABLE "Salesperson" ADD CONSTRAINT "Salesperson_fk0" FOREIGN KEY ("invoices") REFERENCES "customers"("car_purchased");
ALTER TABLE "Salesperson" ADD CONSTRAINT "Salesperson_fk1" FOREIGN KEY ("salespersonid") REFERENCES "customers"("customer_id");

ALTER TABLE "customers" ADD CONSTRAINT "customers_fk0" FOREIGN KEY ("service_date") REFERENCES "transactions"("service_invoice");

ALTER TABLE "service" ADD CONSTRAINT "service_fk0" FOREIGN KEY ("serviceid") REFERENCES "customers"("customer_id");

ALTER TABLE "cars" ADD CONSTRAINT "cars_fk0" FOREIGN KEY ("car_serial") REFERENCES "customers"("customer_id");

ALTER TABLE "mechanic" ADD CONSTRAINT "mechanic_fk0" FOREIGN KEY ("mechanicid") REFERENCES "service"("service_id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk0" FOREIGN KEY ("purchase_invoice") REFERENCES "Salesperson"("salesperson_id");












