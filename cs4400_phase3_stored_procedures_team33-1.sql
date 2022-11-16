-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team __
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.


-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin
-- TODO: Implement your solution here
	if i_email in (select Email from customer) 
    or i_cc_number in (Select CcNumber from customer)
    or i_phone_number in (select Phone_Number from customer cu join clients cl on cu.Email = cl.Email)
    then leave sp_main; end if;
 if i_email in (select Email from accounts)
    and i_email in (select Email from clients)
    and i_email not in (select Email from customer)
    then
        insert into customer(Email, CcNumber, Cvv, Exp_Date, Location) values (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
    end if;
    insert into accounts(Email, First_Name, Last_Name, Pass) values (i_email, i_first_name, i_last_name, i_password);
    insert into clients(Email, Phone_Number) values (i_email, i_phone_number);
    insert into customer(Email, CcNumber, Cvv, Exp_Date, Location) values (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
end //
delimiter ;


-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin
-- TODO: Implement your solution here
	if i_email in (select Email from owners)
 or i_phone_number in (select Phone_Number from owners ow join clients cl on ow.Email = cl.Email)
    then leave sp_main; end if;
    if i_email in (select Email from clients)
    and i_email in (select Email from accounts) 
    and i_email not in (select Email from owners) then
  insert into owners(Email) values (i_email);
 end if;
    insert into accounts(Email, First_Name, Last_Name, Pass) values (i_email, i_first_name, i_last_name, i_password);
    insert into clients(Email, Phone_Number) values (i_email, i_phone_number);
    insert into owners(Email) values (i_email);
end //
delimiter ;


-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
-- TODO: Implement your solution here
	if i_owner_email not in (select Owner_Email from property) then
		delete from owners_rate_customers where Owner_Email = i_owner_email;
		delete from customers_rate_owners where Owner_Email = i_owner_email;
		delete from owners where Email = i_owner_email;
	if i_owner_email not in (select Email from customer) then
		delete from clients where Email = i_owner_email;
		delete from accounts where Email = i_owner_email;
        end if;
    end if;
end //
delimiter ;


-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
	if concat(i_flight_num, i_airline_name) not in (select concat(Flight_Num, Airline_Name) from flight)
    and i_from_airport != i_to_airport
    and i_flight_date > i_current_date then
		insert into flight(Flight_Num, Airline_Name, From_Airport, To_Airport, Departure_Time, Arrival_Time, Flight_Date, Cost, Capacity)
		values (i_flight_num, i_airline_name, i_from_airport, i_to_airport, i_departure_time, i_arrival_time, i_flight_date, i_cost, i_capacity);
    end if;
end //
delimiter ;


-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin
-- TODO: Implement your solution here
	if i_current_date < (select Flight_Date from flight where i_flight_num = Flight_Num and i_airline_name = Airline_Name) then
		delete from book where Flight_Num = i_flight_num and AirLine_Name = i_airline_name;
		delete from flight where Flight_Num = i_flight_num and AirLine_Name = i_airline_name;
	end if;
end //
delimiter ;


-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
	if i_num_seats <= (with t as (select Flight_Num, sum(Num_Seats) as booked from Book where Was_Cancelled = 0 group by Flight_Num) select Capacity-booked from Flight f join t on f.Flight_Num = t.Flight_Num where f.Flight_Num = i_flight_num)
	and i_current_date <= (select Flight_Date from Flight where Flight_Num = i_flight_num)
    -- and (i_customer_email,i_flight_num,i_airline_name) not in (select b.customer_email, f.Flight_Num, f.from Book b join Flight f on b.Flight_Num = f.Flight_Num)
    -- and concat(i_customer_email, i_flight_num, i_airline_name) not in (select concat(Customer, Flight_Num, Airline_Name) from book)
    -- and (select Was_Cancelled from book) <= 1 then
		then insert into book(Customer, Flight_Num, Airline_Name, Num_Seats, Was_Cancelled)
		values (i_customer_email, i_flight_num, i_airline_name, i_num_seats, 0);
	end if;
    -- if concat(i_customer_email, i_flight_num, i_airline_name) in (select concat(Customer, Flight_Num, Airline_Name) from book) then
-- 		update book
--         set Num_Seats = i_num_seats + Num_Seats
--         where Was_Cancelled = 0;
-- 	end if;
end //
delimiter ;

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here

update book
join flight
on flight.airline_name = book.airline_name and flight.flight_num = book.flight_num
set was_cancelled = 1
where customer = i_customer_email and flight.flight_num = i_flight_num
and flight.airline_name = i_airline_name and flight_date > i_current_date;
end //
delimiter ;


-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as
-- TODO: replace this select query with your solution
-- select 'col1', 'col2', 'col3', 'col4', 'col5', 'col6', 'col7' from flight;
SELECT f.Flight_Num as flight_id, Flight_Date as flight_date, Airline_Name as airline, To_Airport as destination, 
Cost as seat_cost, Capacity - ifnull(seats,0) as num_empty_seats, Cost*ifnull(seats,0) + Cost*ifnull(c_seats,0)*0.2as total_spent 
FROM Flight f
left join (SELECT Flight_Num, sum(Num_Seats) as seats
FROM travel_reservation_service.Book
where Was_Cancelled = 0
group by Flight_Num) a
on f.Flight_Num = a.Flight_Num
left join (SELECT Flight_Num, sum(Num_Seats) as c_seats
FROM travel_reservation_service.Book
where Was_Cancelled = 1
group by Flight_Num) b
on f.Flight_Num = b.Flight_Num;

-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin
-- TODO: Implement your solution here
-- if pptName+email is unique and 
IF (i_street, i_city, i_state, i_zip) not in (select Street, City, State, Zip from property)
-- concat(i_street, " ", i_city, " ", i_state, " ", i_zip)   
-- concat(pptStreet, " ", pptCity, " ", pptState, " ", pptZip) 
AND
-- (concat(i_owner_email, " ", i_property_name)
(i_owner_email, i_property_name)
not in (select Owner_Email, Property_Name from property)
-- select concat(Owner_Email, " ", Property_Name) from property)
THEN
 INSERT INTO property (Property_Name,
      Owner_Email,
                        Descr,
                        Capacity,
                        Cost,
                        Street,
                        City,
                        State,
                        Zip)
VALUES     (i_property_name, 
   i_owner_email, 
   i_description, 
   i_capacity,
   i_cost, 
   i_street, 
   i_city, 
   i_state, 
   i_zip);
End IF;
IF ( i_nearest_airport_id is not null) 
-- and (i_dist_to_airport is not null )
AND
(i_nearest_airport_id in (select Airport_Id from airport))
-- AND
-- (i_owner_email , i_property_name)
-- not in (select Owner_Email, Property_Name from property)
THEN
INSERT INTO is_close_to ( Property_Name,
      Owner_Email,
                        Airport,
                        Distance)
VALUES (    i_property_name, 
      i_owner_email,
                        i_nearest_airport_id, 
      i_dist_to_airport);
END IF;
end //
delimiter ;


-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
IF
concat(i_owner_email, " ", i_property_name) 
not in(select concat(pptEmail, " ", pptName) from reserve where i_cuurent_date >= startDate and i_cuurent_date <= endDate) 
AND 
concat(i_owner_email, " ", i_property_name) in 
(select concat(pptEmail, " ", pptName) from reserve where i_cuurent_date >= startDate and i_cuurent_date <= endDate and was_cancelled =1)
THEN
DELETE FROM property where concat(i_owner_email, " ", i_property_name)  = concat(email, " ", pptName) ;
END IF;
DELETE FROM reserve where concat(i_owner_email, " ", i_property_name)  = concat(email, " ", pptName);
DELETE FROM review where concat(i_owner_email, " ", i_property_name) = concat(pptEmail, " ", pptName);
DELETE FROM amenity where concat(i_owner_email, " ", i_property_name)  = concat(email, " ", pptName);
DELETE FROM closeto where concat(i_owner_email, " ", i_property_name) = concat(pptEmail, " ", pptName);
end //
delimiter ;


-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
-- The combination of property_name, owner_email, and customer_email should be unique in the system
--  The start date of the reservation should be in the future (use current date for comparison)
IF (i_owner_email,  i_property_name, i_customer_email)
not in (select Owner_Email, Property_Name, Customer from reserve)
AND 
(i_start_date > i_current_date)
AND 
exists(select 1 from reserve where i_start_date <= End_Date and i_end_Date >= Start_Date and i_customer_email = Customer)
AND
(i_num_guests <= (select Capacity from property where i_property_name = Property_Name and i_owner_email = Owner_Email) - 
(select sum(Num_Guests) from reserve 
where i_propertyName = Property_Name and i_owner_email = Owner_Email and i_start_date <= End_Date and i_end_date >= Start_Date))
THEN
INSERT INTO reserve
VALUES (i_property_name,
  i_owner_email,
  i_customer_email,
  i_start_date,
  i_end_date,
  i_num_guests);
END IF;
end //
delimiter ;


-- ID: 5b
-- Name: cancel_property_reservation
drop procedure if exists cancel_property_reservation;
delimiter //
create procedure cancel_property_reservation (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
update reserve
set was_cancelled = 1
where property_name = i_property_name and owner_email = i_owner_email
and customer = i_customer_email and start_date > i_current_date;
end //
delimiter ;


-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_content varchar(500),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if i_current_date > (select start_date from reserve where i_property_name = property_name
	and i_owner_email = owner_email and i_customer_email = customer and was_cancelled = 0) then
		insert into review(property_name, owner_email, customer, content,score)
		value (i_property_name, i_owner_email, i_customer_email, i_content,i_score);
	end if;    
end //
delimiter ;


-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
-- TODO: replace this select query with your solution
-- select 'col1', 'col2', 'col3', 'col4', 'col5', 'col6' from property;
SELECT t.Property_Name as property_name, a.score as average_rating_score, Descr as 'description', 
concat(Street,', ',City,', ',State,', ',Zip) as address, Capacity as capacity, Cost as cost_per_night
FROM travel_reservation_service.Property t
left join (SELECT Property_Name, avg(Score) as score
FROM travel_reservation_service.Review
group by Property_Name) a
on t.Property_Name = a.Property_Name;

-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50)
)
sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations (
        property_name varchar(50),
        start_date date,
        end_date date,
        customer_email varchar(50),
        customer_phone_num char(12),
        total_booking_cost decimal(6,2),
        rating_score int,
        review varchar(500)
    ) as
    -- TODO: replace this select query with your solution
    -- select 'col1', 'col2', 'col3', 'col4', 'col5', 'col6', 'col7', 'col8' from reserve;
	select R.property_name, R.start_date, R.end_date, R.customer as customer_email, C.phn as customer_phone_num, 
	case 
		when (select was_cancelled from reserve where property_name = i_property_name and owner_email = i_owner_email and customer = R.customer) = 0 then P.cst * (end_date - start_date + 1)
        when (select was_cancelled from reserve where property_name = i_property_name and owner_email = i_owner_email and customer = R.customer) = 1 then P.cst * (end_date - start_date + 1) * 0.2
	end as total_booking_cost,
 	RV.scr as rating_score, RV.revw as review from reserve as R
    join (select email, phone_number as phn from clients) as C
    on R.customer = C.email
    join (select property_name, owner_email, cost as cst from property
    where property_name = i_property_name and owner_email = i_owner_email) as P
    on P.property_name = R.property_name and P.owner_email = R.owner_email
	left outer join (select property_name, owner_email, customer, score as scr, content as revw from review 
    where property_name = i_property_name and owner_email = i_owner_email) as RV
    on RV.property_name = R.property_name and RV.owner_email = R.owner_email and R.customer = RV.customer;
    select * from view_individual_property_reservations;
end //
delimiter ;


-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here

-- The customer has stayed at a property owned by the owner at some point in the past (use current date for comparison) 
-- and the reservation was not cancelled
-- The customer and owner must both exist in the database
if i_customer_email in (select Customer from Reserve where Was_Cancelled = 0) 
    and i_owner_email in (select Email from Owners)
    and (i_owner_email,i_customer_email) in (select Owner_Email, Customer from Reserve)
    and i_current_date >= (select Start_Date from Reserve where Owner_Email = i_owner_email and Customer = i_customer_email)
    then insert Customers_Rate_Owners(Owner_Email,Customer,Score)
    value(i_owner_email,i_customer_email,i_score);
	end if;
end //
delimiter ;


-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //
create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if i_customer_email in (select Customer from Reserve where Was_Cancelled = 0) 
    and i_owner_email in (select Email from Owners)
    and (i_owner_email,i_customer_email) in (select Owner_Email, Customer from Reserve)
    and i_current_date >= (select Start_Date from Reserve where Owner_Email = i_owner_email and Customer = i_customer_email)
    then insert Owners_Rate_Customers(Owner_Email,Customer,Score)
    value(i_owner_email,i_customer_email,i_score);
	end if;
end //
delimiter ;


-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as
-- TODO: replace this select query with your solution    
-- select 'col1', 'col2', 'col3', 'col4', 'col5', 'col6' from airport;
SELECT t.Airport_Id as airport_id, Airport_Name as airport_name, Time_Zone as time_zone, 
ifnull(a.cnt,0) as total_arriving_flights, ifnull(b.cnt,0) as total_departing_flights, b.acost as avg_departing_flight_cost
FROM travel_reservation_service.Airport t
left join (SELECT To_Airport, count(*) as cnt
FROM travel_reservation_service.Flight
group by To_Airport) a
on t.airport_id = a.To_Airport
left join (SELECT From_Airport, count(*) as cnt, avg(cost) as acost
FROM travel_reservation_service.Flight
group by From_Airport) b
on t.airport_id = b.From_Airport;
-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 
    total_flights, 
    min_flight_cost
) as
-- TODO: replace this select query with your solution
-- select 'col1', 'col2', 'col3', 'col4' from airline;
select a.Airline_Name as airline_name, Rating as rating, b.cnt as total_flights, b.cst as min_flight_cost
from Airline a
left join (SELECT Airline_Name, count(*) as cnt, min(Cost) as cst
FROM travel_reservation_service.Flight
group by Airline_Name) b
on a.Airline_Name = b.Airline_Name;


-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as
-- TODO: replace this select query with your solution
-- view customers
-- select 'col1', 'col2', 'col3', 'col4', 'col5' from customer;
select concat(a.First_Name,' ',a.Last_Name) as customer_name, o.avgr as avg_rating, Location as location,
case when c.Email in (select * from Owners) then 1 else 0 end as is_owner, ifnull(b.seats,0) as total_seats_purchased
from Customer c
left join Accounts a
on c.Email = a.Email
left join (select Customer, avg(Score) as avgr
from Owners_Rate_Customers
group by Customer) o
on c.Email = o.Customer
left join (SELECT Customer, sum(Num_Seats) as seats
FROM travel_reservation_service.Book
group by Customer) b
on c.Email = b.Customer
order by c.Email;

-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as
-- TODO: replace this select query with your solution
-- select 'col1', 'col2', 'col3', 'col4' from owners;
select concat(First_Name,' ',Last_Name) as owner_name, b.avgr as avg_rating, ifnull(d.cnt,0) as num_properties_owned, 
e.avgr as avg_property_rating
from Owners o
left join Accounts a
on o.Email = a.Email
left join (SELECT Owner_Email, avg(Score) as avgr
FROM travel_reservation_service.Customers_Rate_Owners
group by Owner_Email) b
on o.Email = b.Owner_Email
left join (SELECT Owner_Email, count(*) as cnt
FROM travel_reservation_service.Property
group by Owner_Email) d
on o.Email = d.Owner_Email
left join (SELECT Owner_Email, avg(Score) as avgr
FROM travel_reservation_service.Review
group by Owner_Email) e
on o.Email = e.Owner_Email
order by o.Email;


-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
 update customer
    left outer join book on customer.email = book.customer
    left outer join flight on flight.flight_num = book.flight_num and flight.airline_name = book.airline_name
    left outer join airport on airport.airport_ID = flight.to_airport
    set location = state
    where i_current_date = flight.flight_date and was_cancelled != 1;
    drop table if exists process_date;
    create table process_date(
  customer_email varchar(50),
        location varchar(50)) as
 select email as customer_email, location
    from customer
    left outer join book on customer.email = book.customer
    left outer join flight on flight.flight_num = book.flight_num and flight.airline_name = book.airline_name
    left outer join airport on airport.airport_ID = flight.to_airport
 where i_current_date = flight.flight_date and was_cancelled != 1;   
end //
delimiter ;
