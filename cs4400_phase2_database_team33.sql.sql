-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase II: Create Table & Insert Statements [v0] Thursday, October 14, 2021 @ 2:00pm EDT

-- Team 33
-- Team Member Name zwang3311
-- Team Member Name awang77
-- Team Member Name jhe360
-- Team Member Name hpang33

-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

drop database if exists travel;
create database if not exists travel;
use travel;

drop table if exists accountinfo;
create table accountinfo(
	email varchar(30) not null,
    fname varchar(15) not null,
    lname varchar(15) not null,
    psw varchar(20) not null,
    primary key (email)
) engine=InnoDB;
-- Dumping data for table accountinfo
INSERT INTO accountinfo VALUES ('mmoss1@travelagency.com','Mark','Moss','password1'),
								('asmith@travelagency.com','Aviva','Smith','password2'),
								('mscott22@gmail.com','Michael','Scott','password3'),
								('arthurread@gmail.com','Arthur','Read','password4'),
								('jwayne@gmail.com','John','Wayne','password5'),
								('gburdell3@gmail.com','George','Burdell','password6'),
								('mj23@gmail.com','Michael','Jordan','password7'),
								('lebron6@gmail.com','Lebron','James','password8'),
								('msmith5@gmail.com','Michael','Smith','password9'),
								('ellie2@gmail.com','Ellie','Johnson','password10'),
								('scooper3@gmail.com','Sheldon','Cooper','password11'),
								('mgeller5@gmail.com','Monica','Geller','password12'),
								('cbing10@gmail.com','Chandler','Bing','password13'),
								('hwmit@gmail.com','Howard','Wolowitz','password14'),
								('swilson@gmail.com','Samantha','Wilson','password16'),
								('aray@tiktok.com','Addison','Ray','password17'),
								('cdemilio@tiktok.com','Charlie','Demilio','password18'),
								('bshelton@gmail.com','Blake','Shelton','password19'),
								('lbryan@gmail.com','Luke','Bryan','password20'),
								('tswift@gmail.com','Taylor','Swift','password21'),
								('jseinfeld@gmail.com','Jerry','Seinfeld','password22'),
								('maddiesmith@gmail.com','Madison','Smith','password23'),
								('johnthomas@gmail.com','John','Thomas','password24'),
								('boblee15@gmail.com','Bob','Lee','password25');

drop table if exists admins;
create table admins(
	email varchar(30) not null,
    primary key (email),
    CONSTRAINT admins_ibfk_1 FOREIGN KEY (email) REFERENCES accountinfo (email)
) engine=InnoDB;

-- Dumping data for table admins
INSERT INTO admins VALUES ('mmoss1@travelagency.com'),
						('asmith@travelagency.com');


drop table if exists clients;
create table clients(
	email varchar(30) not null,
    phonenum char(10),
    primary key (email), unique(phonenum),
    CONSTRAINT clients_ibfk_1 FOREIGN KEY (email) REFERENCES accountinfo (email)
) engine=InnoDB;
-- Dumping data for table clients
INSERT INTO clients VALUES ('mscott22@gmail.com', 5551234567),
('arthurread@gmail.com', 5552345678),
('jwayne@gmail.com', 5553456789),
('gburdell3@gmail.com', 5554567890),
('mj23@gmail.com', 5555678901),
('lebron6@gmail.com', 5556789012),
('msmith5@gmail.com', 5557890123),
('ellie2@gmail.com', 5558901234),
('scooper3@gmail.com', 6781234567),
('mgeller5@gmail.com', 6782345678),
('cbing10@gmail.com', 6783456789),
('hwmit@gmail.com', 6784567890),
('swilson@gmail.com', 7701234567),
('aray@tiktok.com', 7702345678),
('cdemilio@tiktok.com', 7703456789),
('bshelton@gmail.com', 7704567890),
('lbryan@gmail.com', 7705678901),
('tswift@gmail.com', 7706789012),
('jseinfeld@gmail.com', 7707890123),
('maddiesmith@gmail.com', 7708901234),
('johnthomas@gmail.com', 4047705555),
('boblee15@gmail.com', 4046785555);

drop table if exists owners;
create table owners(
	email varchar(30) not null,
    primary key (email),
    CONSTRAINT owners_ibfk_1 FOREIGN KEY (email) REFERENCES clients (email)
) engine=InnoDB;
-- Dumping data for table owners
INSERT INTO owners VALUES ('mscott22@gmail.com'),
						('arthurread@gmail.com'),
						('jwayne@gmail.com'),
						('gburdell3@gmail.com'),
						('mj23@gmail.com'),
						('lebron6@gmail.com'),
						('msmith5@gmail.com'),
						('ellie2@gmail.com'),
						('scooper3@gmail.com'),
						('mgeller5@gmail.com'),
						('cbing10@gmail.com'),
						('hwmit@gmail.com');

drop table if exists customer;
create table customer(
	email varchar(30) not null,
    ccNum decimal(16,0),
    cvv decimal(3,0),
    expDate date,   -- not know the datatype
    location varchar(10),
    primary key (email), unique(ccNum),
    CONSTRAINT customer_ibfk_1 FOREIGN KEY (email) REFERENCES clients (email)
) engine=InnoDB;

-- Dumping data for table customer
INSERT INTO customer VALUES ('scooper3@gmail.com',6518555974461663, 551, ' 2024-02-00',  NULL),
							('mgeller5@gmail.com',2328567043101965, 644, ' 2024-03-00', NULL),
							('cbing10@gmail.com',8387952398279291, 201, ' 2023-02-00', NULL),
							('hwmit@gmail.com',6558859698525299, 102, ' 2023-04-00', NULL),
							('swilson@gmail.com',9383321241981836, 455, ' 2022-08-00', NULL),
							('aray@tiktok.com',3110266979495605, 744, ' 2022-08-00', NULL),
							('cdemilio@tiktok.com',2272355540784744, 606, ' 2025-02-00', NULL),
							('bshelton@gmail.com',9276763978834273, 862, ' 2023-09-00', NULL),
							('lbryan@gmail.com',4652372688643798, 258, ' 2023-05-00', NULL),
							('tswift@gmail.com',5478842044367471, 857, ' 2024-12-00', NULL),
							('jseinfeld@gmail.com',3616897712963372, 295, ' 2022-06-00', NULL),
							('maddiesmith@gmail.com',9954569863556952, 794, ' 2022-07-00', NULL),
							('johnthomas@gmail.com',7580327437245356, 269, ' 2025-10-00', NULL),
							('boblee15@gmail.com',7907351371614248, 858, '2025-11-00', NULL);

drop table if exists airline;
create table airline(
	airlineName varchar(20) not null,
    rating float(2,1),
    primary key (airlineName)
) engine=InnoDB;
-- Dumping data for table airline
INSERT INTO airline VALUES ('Delta Airlines', 4.7),
							('Southwest Airlines', 4.4),
							('American Airlines', 4.6),
							('United Airlines', 4.2),
							('JetBlue Airways', 3.6),
							('Spirit Airlines', 3.3),
							('WestJet', 3.9),
							('Interjet', 3.7);

drop table if exists airport;
create table airport(
	airportID char(3) not null,
    airportName varchar(50) not null,
    timeZone char(3) not null,
    apStreet varchar(30) not null,
    apCity varchar(12) not null,
    apState char(2) not null,
    apZip decimal(5,0) not null,
    primary key (airportID),
    unique(airportName),
    unique(apStreet, apCity,apState,apZip)
) engine=InnoDB;

-- Dumping data for table airports
INSERT INTO airport VALUES ('ATL', 'Atlanta Hartsfield Jackson Airport','EST', '6000 N Terminal Pkwy', 'Atlanta', 'GA',30320),
							('JFK', 'John F Kennedy International Airport','EST', '455 Airport Ave', 'Queens', 'NY',11430),
							('LGA', 'Laguardia Airport','EST', '790 Airport St', 'Queens', 'NY',11371),
							('LAX', 'Lost Angeles International Airport','PST', '1 World Way', 'Los Angeles', 'CA',90045),
							('SJC', 'Norman Y. Mineta San Jose International Airport','PST', '1702 Airport Blvd', 'San Jose', 'CA',95110),
							('ORD', "O'Hare International Airport",'CST', "10000 W O'Hare Ave", 'Chicago', 'IL',60666),
							('MIA', 'Miami International Airport','EST', '2100 NW 42nd Ave', 'Miami', 'FL',33126),
							('DFW', 'Dallas International Airport','CST', '2400 Aviation DR', 'Dallas', 'TX',75261);

drop table if exists attraction;
create table attraction(
	airportID char(3) not null,
    attractionName varchar(32) not null,
    primary key (airportID,attractionName),
    CONSTRAINT attraction_ibfk_1 FOREIGN KEY (airportID) REFERENCES airport (airportID)
) engine=InnoDB;
-- Dumping data for table attraction
INSERT INTO attraction VALUES ('ATL','The Coke Factory'),
								('ATL','The Georgia Aquarium'),
								('JFK','The Statue of Liberty'),
								('JFK','The Empire State Building'),
								('LGA','The Statue of Liberty'),
								('LGA','The Empire State Building'),
								('LAX','Lost Angeles Lakers Stadium'),
								('LAX','Los Angeles Kings Stadium'),
								('SJC','Winchester Mystery House'),
								('SJC','San Jose Earthquakes Soccer Team'),
								('ORD','Chicago Blackhawks Stadium'),
								('ORD','Chicago Bulls Stadium'),
								('MIA','Crandon Park Beach'),
								('MIA','Miami Heat Basketball Stadium'),
								('DFW','Texas Longhorns Stadium'),
								('DFW','The Original Texas Roadhouse');

drop table if exists flight;
create table flight(
	fltName char(20) not null,
    fltNum int not null,
	depTime time not null,  -- Need data type configuration
    arrTime time not null,
    fltDate date not null,
	fltCost int not null,  -- or number datatype?
    fltCapacity int not null,
    toAirport char(3) not null,
    fromAirport char(3) not null,
    primary key (fltName, fltNum), 
    CONSTRAINT flight_ibfk_1 FOREIGN KEY (fltName) REFERENCES airline (airlineName),
    CONSTRAINT flight_ibfk_2 FOREIGN KEY (toAirport) REFERENCES airport (airportID),
    CONSTRAINT flight_ibfk_3 FOREIGN KEY (fromAirport) REFERENCES airport (airportID)
) engine=InnoDB;

-- Dumping data for table flight
INSERT INTO flight VALUES('Delta Airlines', 1, TIME( STR_TO_DATE( ' 10:00 AM', '%h:%i %p' ) ), TIME( STR_TO_DATE(  '12:00 PM', '%h:%i %p')), STR_TO_DATE('10/18/2021','%m/%d/%Y'), 400, 150,'JFK', 'ATL'),
('Southwest Airlines', 2, TIME( STR_TO_DATE( ' 10:30 AM', '%h:%i %p' ) ), TIME( STR_TO_DATE( ' 2:30 PM', '%h:%i %p')), STR_TO_DATE('10/18/2021','%m/%d/%Y'), 350, 125,'MIA', 'ORD'),
('American Airlines', 3, TIME( STR_TO_DATE( ' 1:00 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 4:00 PM', '%h:%i %p')), STR_TO_DATE('10/18/2021','%m/%d/%Y'), 350, 125,'DFW', 'MIA'),
('United Airlines', 4, TIME( STR_TO_DATE( ' 4:30 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 6:30 PM', '%h:%i %p')), STR_TO_DATE('10/18/2021','%m/%d/%Y'), 400, 100,'LGA', 'ATL'),
('JetBlue Airways', 5, TIME( STR_TO_DATE( ' 11:00 AM', '%h:%i %p' ) ), TIME( STR_TO_DATE( ' 1:00 PM', '%h:%i %p')), STR_TO_DATE('10/19/2021','%m/%d/%Y'), 400, 130,'ATL', 'LGA'),
('Spirit Airlines', 6, TIME( STR_TO_DATE(  '12:30 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 9:30 PM', '%h:%i %p')), STR_TO_DATE('10/19/2021','%m/%d/%Y'), 650, 140,'ATL', 'SJC'),
('WestJet', 7, TIME( STR_TO_DATE( ' 1:00 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 4:00 PM', '%h:%i %p')), STR_TO_DATE('10/19/2021','%m/%d/%Y'), 700, 100,'SJC', 'LGA'),
('Interjet', 8, TIME( STR_TO_DATE( ' 7:30 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 9:30 PM', '%h:%i %p')), STR_TO_DATE('10/19/2021','%m/%d/%Y'), 350, 125,'ORD', 'MIA'),
('Delta Airlines', 9,TIME( STR_TO_DATE(  ' 8:00 AM', '%h:%i %p' ) ), TIME( STR_TO_DATE( ' 10:00 AM', '%h:%i %p' ) ), STR_TO_DATE('10/20/2021','%m/%d/%Y'), 375, 150,'ATL', 'JFK'),
('Delta Airlines', 10,TIME( STR_TO_DATE(  ' 9:15 AM', '%h:%i %p' ) ), TIME( STR_TO_DATE( ' 6:15 PM', '%h:%i %p')), STR_TO_DATE('10/20/2021','%m/%d/%Y'), 700, 110,'ATL', 'LAX'),
('Southwest Airlines', 11, TIME( STR_TO_DATE(  '12:07 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 7:07 PM', '%h:%i %p')), STR_TO_DATE('10/20/2021','%m/%d/%Y'), 600, 95,'ORD', 'LAX'),
('United Airlines', 12, TIME( STR_TO_DATE( ' 3:35 PM', '%h:%i %p')), TIME( STR_TO_DATE( ' 5:35 PM', '%h:%i %p')), STR_TO_DATE('10/20/2021','%m/%d/%Y'), 275, 115,'ATL', 'MIA');

drop table if exists property;
create table property(
	email varchar(30) not null,
    pptName varchar(50) not null,
    pptDescription varchar(300),
    pptStreet varchar(30) not null,
    pptCity varchar(10) not null,
    pptState char(2) not null,
    pptZip decimal(5,0) not null,
    pnppCost varchar(5) not null,
    pptCapacity int not null,
    primary key (email, pptName), unique(pptStreet, pptCity, pptState, pptZip),
    CONSTRAINT property_ibfk_1 FOREIGN KEY (email) REFERENCES owners(email)
) engine=InnoDB;

-- Dumping data for table property
INSERT INTO property VALUES ('scooper3@gmail.com', 'Atlanta Great Property', 'This is right in the middle of Atlanta near many attractions!', '2nd St', 'ATL', 'GA',30008, 4, 600),
								('gburdell3@gmail.com', 'House near Georgia Tech', 'Super close to bobby dodde stadium!', 'North Ave', 'ATL', 'GA',30008, 3, 275),
								('cbing10@gmail.com', 'New York City Property', 'A view of the whole city. Great property!', '123 Main St', 'NYC', 'NY',10008, 2, 750),
								('mgeller5@gmail.com', 'Statue of Libery Property', 'You can see the statue of liberty from the porch', '1st St', 'NYC', 'NY',10009, 5, 1000),
								('arthurread@gmail.com', 'Los Angeles Property', Null, '10th St', 'LA', 'CA',90008, 3, 700),
								('arthurread@gmail.com', 'LA Kings House', 'This house is super close to the LA kinds stadium!', 'Kings St', 'La', 'CA',90011, 4, 750),
								('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Huge house that can sleep 12 people. Totally worth it!', 'Golden Bridge Pkwt', 'San Jose', 'CA',90001, 12, 900),
								('lebron6@gmail.com', 'LA Lakers Property', 'This house is right near the LA lakers stadium. You might even meet Lebron James!', 'Lebron Ave', 'LA', 'CA',90011, 4, 850),
								('hwmit@gmail.com', 'Chicago Blackhawks House', 'This is a great property!', 'Blackhawks St', 'Chicago', 'IL',60176, 3, 775),
								('mj23@gmail.com', 'Chicago Romantic Getaway', 'This is a great property!', '23rd Main St', 'Chicago', 'IL',60176, 2, 1050),
								('msmith5@gmail.com', 'Beautiful Beach Property', 'You can walk out of the house and be on the beach!', '456 Beach Ave', 'Miami', 'FL',33101, 2, 975),
								('ellie2@gmail.com', 'Family Beach House', 'You can literally walk onto the beach and see it from the patio!', '1132 Beach Ave', 'Miami', 'FL',33101, 6, 850),
								('mscott22@gmail.com', 'Texas Roadhouse', 'This property is right in the center of Dallas, Texas!', '17th Street', 'Dallas', 'TX',75043, 3, 450),
								('mscott22@gmail.com', 'Texas Longhorns House', 'You can walk to the longhorns stadium from here!', '1125 Longhorns Way', 'Dallas', 'TX',7500, 101, 600);

drop table if exists amenity;
create table amenity(
	email varchar(30) not null,
    pptName varchar(50) not null,
    amnName varchar(50) not null,
    primary key (email, pptName, amnName),
    CONSTRAINT amenty_ibfk_1 FOREIGN KEY (email, pptName) REFERENCES property(email, pptName)
) engine=InnoDB;
-- Dumping data for table amenity
INSERT INTO amenity VALUES ('scooper3@gmail.com', 'Atlanta Great Property', 'A/C & Heating'),
							('scooper3@gmail.com', 'Atlanta Great Property', 'Pets allowed'),
							('scooper3@gmail.com', 'Atlanta Great Property', 'Wifi & TV'),
							('scooper3@gmail.com', 'Atlanta Great Property', 'Washer and Dryer'),
							('gburdell3@gmail.com', 'House near Georgia Tech', 'Wifi & TV'),
							('gburdell3@gmail.com', 'House near Georgia Tech', 'Washer and Dryer'),
							('gburdell3@gmail.com', 'House near Georgia Tech', 'Full Kitchen'),
							('cbing10@gmail.com', 'New York City Property', 'A/C & Heating'),
							('cbing10@gmail.com', 'New York City Property', 'Wifi & TV'),
							('mgeller5@gmail.com', 'Statue of Libery Property', 'A/C & Heating'),
							('mgeller5@gmail.com', 'Statue of Libery Property', 'Wifi & TV'),
							('arthurread@gmail.com', 'Los Angeles Property', 'A/C & Heating'),
							('arthurread@gmail.com', 'Los Angeles Property', 'Pets allowed'),
							('arthurread@gmail.com', 'Los Angeles Property', 'Wifi & TV'),
							('arthurread@gmail.com', 'LA Kings House', 'A/C & Heating'),
							('arthurread@gmail.com', 'LA Kings House', 'Wifi & TV'),
							('arthurread@gmail.com', 'LA Kings House', 'Washer and Dryer'),
							('arthurread@gmail.com', 'LA Kings House', 'Full Kitchen'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'A/C & Heating'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Pets allowed'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Wifi & TV'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Washer and Dryer'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Full Kitchen'),
							('lebron6@gmail.com', 'LA Lakers Property', 'A/C & Heating'),
							('lebron6@gmail.com', 'LA Lakers Property', 'Wifi & TV'),
							('lebron6@gmail.com', 'LA Lakers Property', 'Washer and Dryer'),
							('lebron6@gmail.com', 'LA Lakers Property', 'Full Kitchen'),
							('hwmit@gmail.com', 'Chicago Blackhawks House', 'A/C & Heating'),
							('hwmit@gmail.com', 'Chicago Blackhawks House', 'Wifi & TV'),
							('hwmit@gmail.com', 'Chicago Blackhawks House', 'Washer and Dryer'),
							('hwmit@gmail.com', 'Chicago Blackhawks House', 'Full Kitchen'),
							('mj23@gmail.com', 'Chicago Romantic Getaway', 'A/C & Heating'),
							('mj23@gmail.com', 'Chicago Romantic Getaway', 'Wifi & TV'),
							('msmith5@gmail.com', 'Beautiful Beach Property', 'A/C & Heating'),
							('msmith5@gmail.com', 'Beautiful Beach Property', 'Wifi & TV'),
							('msmith5@gmail.com', 'Beautiful Beach Property', 'Washer and Dryer'),
							('ellie2@gmail.com', 'Family Beach House', 'A/C & Heating'),
							('ellie2@gmail.com', 'Family Beach House', 'Pets allowed'),
							('ellie2@gmail.com', 'Family Beach House', 'Wifi & TV'),
							('ellie2@gmail.com', 'Family Beach House', 'Washer and Dryer'),
							('ellie2@gmail.com', 'Family Beach House', 'Full Kitchen'),
							('mscott22@gmail.com', 'Texas Roadhouse', 'A/C & Heating'),
							('mscott22@gmail.com', 'Texas Roadhouse', 'Pets allowed'),
							('mscott22@gmail.com', 'Texas Roadhouse', 'Wifi & TV'),
							('mscott22@gmail.com', 'Texas Roadhouse', 'Washer and Dryer'),
							('mscott22@gmail.com', 'Texas Longhorns House', 'A/C & Heating'),
							('mscott22@gmail.com', 'Texas Longhorns House', 'Pets allowed'),
							('mscott22@gmail.com', 'Texas Longhorns House', 'Wifi & TV'),
							('mscott22@gmail.com', 'Texas Longhorns House', 'Washer and Dryer'),
							('mscott22@gmail.com', 'Texas Longhorns House', 'Full Kitchen');
-- rating from owner to customers
drop table if exists rates;
create table rates(
	ownEmail varchar(30) not null,
    cstmEmail varchar(30) not null,
    score decimal(1,0) not null,
    primary key (ownEmail, cstmEmail),
    CONSTRAINT rates_ibfk_1 FOREIGN KEY (ownEmail) REFERENCES owners(email),
	CONSTRAINT rates_ibfk_2 FOREIGN KEY (cstmEmail) REFERENCES customer(email)
) engine=InnoDB;
-- Dumping data for table rates
INSERT INTO rates VALUES ('gburdell3@gmail.com', 'swilson@gmail.com', 5),
							('cbing10@gmail.com', 'aray@tiktok.com', 5),
							('mgeller5@gmail.com', 'bshelton@gmail.com', 3),
							('arthurread@gmail.com', 'lbryan@gmail.com', 4),
							('arthurread@gmail.com', 'tswift@gmail.com', 4),
							('lebron6@gmail.com', 'jseinfeld@gmail.com', 1),
							('hwmit@gmail.com', 'maddiesmith@gmail.com', 2);

-- rating from customers to owner
drop table if exists rated_by;
create table rated_by(
	ownEmail varchar(30) not null,
    cstmEmail varchar(30) not null,
    score decimal(1,0) not null,
    primary key (ownEmail, cstmEmail),
    CONSTRAINT rated_by_ibfk_1 FOREIGN KEY (ownEmail) REFERENCES owners(email),
    CONSTRAINT rated_by_ibfk_2 FOREIGN KEY (cstmEmail) REFERENCES customer(email)
) engine=InnoDB;
-- Dumping data for table rated_by

INSERT INTO rated_by VALUES('gburdell3@gmail.com', 'swilson@gmail.com', 5),
							('cbing10@gmail.com', 'aray@tiktok.com', 5),
							('mgeller5@gmail.com', 'bshelton@gmail.com', 4),
							('arthurread@gmail.com', 'lbryan@gmail.com', 4),
							('arthurread@gmail.com', 'tswift@gmail.com', 3),
							('lebron6@gmail.com', 'jseinfeld@gmail.com', 2),
							('hwmit@gmail.com', 'maddiesmith@gmail.com', 5);

drop table if exists review;
create table review(
	pptEmail varchar(30) not null,
    pptName varchar(50) not null,
    cstmEmail varchar(30) not null,
    score decimal(1,0) not null,
    content varchar(300),
    primary key (pptEmail, pptName, cstmEmail),
    CONSTRAINT review_ibfk_1 FOREIGN KEY (pptEmail, pptName) REFERENCES property(email, pptName),
    CONSTRAINT review_ibfk_2 FOREIGN KEY (cstmEmail) REFERENCES customer(email)
) engine=InnoDB;
-- Dumping data for table review
INSERT INTO review VALUES ('gburdell3@gmail.com', 'House near Georgia Tech', 'swilson@gmail.com', 5, 'This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!'),
							('cbing10@gmail.com', 'New York City Property', 'aray@tiktok.com', 5, 'This was the best 5 days ever! I saw so much of NYC!'),
							('mgeller5@gmail.com', 'Statue of Libery Property', 'bshelton@gmail.com', 4, 'This was truly an excellent experience. I really could see the Statue of Liberty from the property!'),
							('arthurread@gmail.com', 'Los Angeles Property', 'lbryan@gmail.com', 4, 'I had an excellent time!'),
							('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'tswift@gmail.com', 3, "We had a great time, but the house wasn't fully cleaned when we arrived"),
							('lebron6@gmail.com', 'LA Lakers Property', 'jseinfeld@gmail.com', 2, 'I was disappointed that I did not meet lebron james'),
							('hwmit@gmail.com', 'Chicago Blackhawks House', 'maddiesmith@gmail.com', 5, 'This was awesome! I met one player on the chicago blackhawks!');

drop table if exists reserve;
create table reserve(
	pptEmail varchar(30) not null,
    pptName varchar(50) not null,
    cstmEmail varchar(30) not null,
    startDate date not null,
    endDate date not null,
    guestNum int not null,
    primary key (pptEmail, pptName, cstmEmail),
    CONSTRAINT reserve_ibfk_1 FOREIGN KEY (pptEmail, pptName) REFERENCES property(email,pptName),
    CONSTRAINT reserve_ibfk_2 FOREIGN KEY (cstmEmail) REFERENCES customer(email)
) engine=InnoDB;
-- Dumping data for table reserve
INSERT INTO reserve VALUES ('gburdell3@gmail.com','House near Georgia Tech', 'swilson@gmail.com', STR_TO_DATE('10/19/2021', "%m/%d/%Y"), STR_TO_DATE('10/25/2021', "%m/%d/%Y"), 3),
							('cbing10@gmail.com','New York City Property', 'aray@tiktok.com', STR_TO_DATE('10/18/2021', "%m/%d/%Y"), STR_TO_DATE('10/23/2021', "%m/%d/%Y"), 2),
							('cbing10@gmail.com','New York City Property', 'cdemilio@tiktok.com', STR_TO_DATE('10/24/2021', "%m/%d/%Y"), STR_TO_DATE('10/30/2021', "%m/%d/%Y"), 2),
							('mgeller5@gmail.com','Statue of Libery Property', 'bshelton@gmail.com', STR_TO_DATE('10/18/2021', "%m/%d/%Y"), STR_TO_DATE('10/22/2021', "%m/%d/%Y"), 4),
							('arthurread@gmail.com','Los Angeles Property', 'lbryan@gmail.com', STR_TO_DATE('10/19/2021', "%m/%d/%Y"), STR_TO_DATE('10/25/2021', "%m/%d/%Y"), 2),
							('arthurread@gmail.com','Beautiful San Jose Mansion', 'tswift@gmail.com', STR_TO_DATE('10/19/2021', "%m/%d/%Y"), STR_TO_DATE('10/22/2021', "%m/%d/%Y"), 10),
							('lebron6@gmail.com','LA Lakers Property', 'jseinfeld@gmail.com', STR_TO_DATE('10/19/2021', "%m/%d/%Y"), STR_TO_DATE('10/24/2021', "%m/%d/%Y"), 4),
							('hwmit@gmail.com','Chicago Blackhawks House', 'maddiesmith@gmail.com', STR_TO_DATE('10/19/2021', "%m/%d/%Y"), STR_TO_DATE('10/23/2021', "%m/%d/%Y"), 2),
							('mj23@gmail.com','Chicago Romantic Getaway', 'aray@tiktok.com', STR_TO_DATE('11/1/2021', "%m/%d/%Y"), STR_TO_DATE('11/7/2021', "%m/%d/%Y"), 2),
							('msmith5@gmail.com','Beautiful Beach Property', 'cbing10@gmail.com', STR_TO_DATE('10/18/2021', "%m/%d/%Y"), STR_TO_DATE('10/25/2021', "%m/%d/%Y"), 2),
							('ellie2@gmail.com','Family Beach House', 'hwmit@gmail.com', STR_TO_DATE('10/18/2021', "%m/%d/%Y"), STR_TO_DATE('10/28/2021', "%m/%d/%Y"), 5);

-- if a property close to airport 
drop table if exists closeTo;
create table closeTo(
	pptEmail varchar(30) not null,
    pptName varchar(50) not null,
    airportID char(3) not null,
    distance int not null,
    primary key (pptEmail, pptName, airportID),
    CONSTRAINT closeTo_ibfk_1 FOREIGN KEY (pptEmail, pptName) REFERENCES property(email,pptName),
    CONSTRAINT closeTo_ibfk_2 FOREIGN KEY (airportID) REFERENCES airport(airportID)
) engine=InnoDB;
-- Dumping data for table closeTo
INSERT INTO closeTo VALUES ('scooper3@gmail.com', 'Atlanta Great Property', 'ATL',12),
('gburdell3@gmail.com', 'House near Georgia Tech', 'ATL',7),
('cbing10@gmail.com', 'New York City Property', 'JFK',10),
('mgeller5@gmail.com', 'Statue of Libery Property', 'JFK',8),
('cbing10@gmail.com', 'New York City Property', 'LGA',25),
('mgeller5@gmail.com', 'Statue of Libery Property', 'LGA',19),
('arthurread@gmail.com', 'Los Angeles Property', 'LAX',9),
('arthurread@gmail.com', 'LA Kings House', 'LAX',12),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'SJC',8),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'LAX',30),
('lebron6@gmail.com', 'LA Lakers Property', 'LAX',6),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'ORD',11),
('mj23@gmail.com', 'Chicago Romantic Getaway', 'ORD',13),
('msmith5@gmail.com', 'Beautiful Beach Property', 'MIA',21),
('ellie2@gmail.com', 'Family Beach House', 'MIA',19),
('mscott22@gmail.com', 'Texas Roadhouse', 'DFW',8),
('mscott22@gmail.com', 'Texas Longhorns House', 'DFW',17);

drop table if exists book;
create table book(
	cstmEmail varchar(30) not null,
    fltName char(20) not null,
    fltNum int not null,
    seatNum int not null,
    primary key (cstmEmail, fltName, fltNum),
    CONSTRAINT book_ibfk_1 FOREIGN KEY (cstmEmail) REFERENCES customer(email),
    CONSTRAINT book_ibfk_2 FOREIGN KEY (fltName, fltNum) REFERENCES flight(fltName,fltNum)
) engine=InnoDB;
-- Dumping data for table book
INSERT INTO book VALUES('swilson@gmail.com','JetBlue Airways', 5,3),
						('aray@tiktok.com','Delta Airlines', 1,2),
						('bshelton@gmail.com','United Airlines', 4,4),
						('lbryan@gmail.com','WestJet', 7,2),
						('tswift@gmail.com','WestJet', 7,2),
						('jseinfeld@gmail.com','WestJet', 7,4),
						('maddiesmith@gmail.com','Interjet', 8,2),
						('cbing10@gmail.com','Southwest Airlines', 2,2),
						('hwmit@gmail.com','Southwest Airlines', 2,5);