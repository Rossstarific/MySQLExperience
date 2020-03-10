create database if not exists Theatre;
use Theatre;

create table if not exists Season
(
	play_title varchar(50) not null primary key,
    playwright_name varchar(50),
    opening_date date,
    closing_date date,
    theater_name varchar(50) not null
);

create table if not exists Theater
(
	name varchar(50) not null primary key,
    street varchar(15),
    max_seats integer(4)
);

create table if not exists Audience_member
(
	ticket_number varchar(12) not null primary key,
    confirmation_number varchar(13) not null,
    first_name varchar(25),
    last_name varchar(25)
);

create table if not exists Ticket
(
	ticket_number varchar(12) not null primary key,
    seat_number varchar(5),
    price integer(3),
    seat_section varchar(50),
    theater_name varchar(50) not null,
    play_title varchar(50) not null
);

create table if not exists Creative_team
(
	name varchar(50) not null,
    job_title varchar(50),
    salary_per_hour integer(5),
    play_title varchar(50) not null
);

create table if not exists Cast
(
	role varchar(50) not null,
    actor_name varchar(50) not null,
    play_title varchar(50) not null
);

create table if not exists Actor
(
	name varchar(50) not null primary key,
    salary_per_hour integer(5),
    equity_status varchar(10)
);

create table if not exists Staff
(
	ID varchar(7) not null primary key,
    first_name varchar(25),
    last_name varchar(25),
    job_title varchar(50),
    salary_per_hour integer(5),
    theater_name varchar(50) not null
);

insert into Season values("Guys and Dolls", "Frank Loesser", '2018-08-30', '2018-11-04', "Eisenhower Theater");
insert into Season values("Harvey", "Mary Chase", '2018-10-25', '2018-12-09', "Kreeger Theater");
insert into Season values("Hand to God", "Robert Askins", '2019-01-17', '2019-03-17', "Studio Theater");
insert into Season values("Cat on a Hot Tin Roof", "Tennessee Williams", '2019-05-02', '2019-05-29', "Sidney Harman Hall");
select * from Season;

insert into Theater values("Eisenhower Theater", "F Street", 1161);
insert into Theater values("Kreeger Theater", "Sixth", 514);
insert into Theater values("Studio Theater", "Fourteenth", 200);
insert into Theater values("Sidney Harman Hall", "F Street", 774);
select * from Theater;

insert into Audience_member values("T65532926857", "11I1AYJNWDMXL", "Tyson", "Bristol");
insert into Audience_member values("T12194953219", "K82ATILX5JEPI", "Bettie", "Mann");
insert into Audience_member values("T53466048953", "HDV7QRFTNXU0A", "Kimmie", "Burnham");
insert into Audience_member values("T52583813549", "V9YXB5GLG3706", "Jordana", "York");
insert into Audience_member values("T60301255854", "2OQ1RC6UOLT00", "Allana", "Brook");
insert into Audience_member values("T42925458325", "W5KJEBIJQGDEB", "Judi", "Larson");
insert into Audience_member values("T11878498645", "K0ULD7N2C1RCM", "John", "Groves");
select * from Audience_member;

insert into Ticket values("T65532926857", "G107", 102, "Orchestra", "Kreeger Theater", "Harvey");
insert into Ticket values("T60596108598", "H101", 179, "Orchestra", "Eisenhower Theater", "Guys and Dolls");
insert into Ticket values("T12194953219", "R110", 92, "Orchestra Grand Tier", "Sidney Harman Hall", "Cat on a Hot Tin Roof");
insert into Ticket values("T53466048953", "A13", 109, "Balcony", "Eisenhower Theater", "Guys and Dolls");
insert into Ticket values("T52583813549", "M20", 179, "Orchestra", "Eisenhower Theater", "Guys and Dolls");
insert into Ticket values("T45050502323", "AA202", 45, "Premium", "Studio Theater", "Hand to God");
insert into Ticket values("T60301255854", "C104", 20, "Zone A", "Studio Theater", "Hand to God");
insert into Ticket values("T42925458325", "AA12", 102, "Balcony", "Kreeger Theater", "Harvey");
insert into Ticket values("T11878498645", "D121", 92, "Orchestra Front", "Sidney Harman Hall", "Cat on a Hot Tin Roof");
select * from Ticket;

insert into Creative_team values("Holly Stevens", "Director", 30, "Hand to God");
insert into Creative_team values("Mel Caulfield", "Costume Designer", 20, "Guys and Dolls");
insert into Creative_team values("Peter Blakeley", "Director", 50, "Cat on a Hot Tin Roof");
insert into Creative_team values("Caleigh Glass", "Lighting Designer", 46, "Guys and Dolls");
insert into Creative_team values("Milo Sanders", "Set Designer", 25, "Harvey");
select * from Creative_team;

insert into Cast values("Nathan", "Alex Brightman", "Guys and Dolls");
insert into Cast values("Sky", "Armie Hammer", "Guys and Dolls");
insert into Cast values("Elwood", "Paul Schneider", "Harvey");
insert into Cast values("Veta", "Janet McTeer", "Harvey");
insert into Cast values("Jason", "Steven Boyer", "Hand to God");
insert into Cast values("Margery", "Geneva Carr", "Hand to God");
insert into Cast values("Brick", "Jack O'Connell", "Cat on a Hot Tin Roof");
insert into Cast values("Maggie", "Sienna Miller", "Cat on a Hot Tin Roof");
select * from Cast;
delete from Cast;

insert into Actor values("Alex Brightman", 42, "equity");
insert into Actor values("Armie Hammer", 42, "equity");
insert into Actor values("Paul Schneider", 35, "nonequity");
insert into Actor values("Janet McTeer", 35, "nonequity");
insert into Actor values("Steven Boyer", 35, "equity");
insert into Actor values("Geneva Carr", 35, "nonequity");
insert into Actor values("Jack O'Connell", 37, "equity");
insert into Actor values("Sienna Miller", 37, "nonequity");
select * from Actor;

insert into Staff values("4874979", "John", "Starr", "Set Builder", 30, "Eisenhower Theater");
insert into Staff values("1600277", "Peter", "Mikhail", "Set Painter", 30, "Kreeger Theater");
insert into Staff values("3016914", "Alex", "Damman", "Master Electrician", 60, "Eisenhower Theater");
insert into Staff values("5881833", "Erin", "Sullivan", "Lighting Coordinator", 45, "Studio Theater");
insert into Staff values("9784995", "Jack", "Johnson", "Set Builder", 33, "Sidney Harman Hall");
insert into Staff values("4397949", "Zack", "Jordan", "Usher", 9, "Studio Theater");
insert into Staff values("6784866", "Edward", "Hope", "Lighting Coordinator", 50, "Sidney Harman Hall");
insert into Staff values("1201393", "Randy", "Howenstein", "Assistant Electrician", 46, "Kreeger Theater");
select * from Staff;