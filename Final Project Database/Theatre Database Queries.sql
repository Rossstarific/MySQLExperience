use Theatre;
#A) Queries:




#Select:



#involving one/more conditions in where clause:
#select all ticket numbers where price is greater than or equal to $100 and the seat section says "Orchestra"
select ticket_number from Ticket
where price >= 100 
and seat_section like '%Orchestra%';


#aggregate functions

#SUM and Nested Select
#find the sum of all hourly salaries for all Actors working at the Kreeger Theater.
select sum(salary_per_hour) from Actor
where name in
	(select actor_name from Cast where play_title in
		(select play_title from Season
        where theater_name = 'Kreeger Theater'));

#MIN
#find the job title, theater name, and salary of the staff job with the lowest hourly pay
select job_title, theater_name, min(salary_per_hour) from Staff;

#MAX
#find the full name of the audience member, price, and seat section of the most expensive 
#ticket purchase for any of the productions in the season
select first_name, last_name, max(price), seat_section from Audience_member, Ticket;

#AVG
#find the average price of a ticket at the Eisenhower Theater
select avg(price) from Ticket
where theater_name = 'Eisenhower Theater';

#COUNT and GROUP BY
#find the number of tickets purchase per production.
#Display count, play title, and theater name.
select count(ticket_number), play_title, theater_name from Ticket
group by play_title;

 
#Having and Order By

#Having
#find the jobs, theater names, and salaries associated with staff members with salaries below $40/hr
select job_title, theater_name, salary_per_hour from Staff
having salary_per_hour < 40;

#Order By
#Find the titles of plays grouped by the max seats of the theaters at which they are performed
select play_title, max_seats from Season, Theater
where Season.theater_name = Theater.name
order by max_seats;


#Union Operation
#Find all ticket numbers recorded with audience members. Not all ticket numbers are recorded
#into the audience_member table, so this is a way to double check if all tickets are logged
select ticket_number from Audience_member
union
select ticket_number from Ticket;



#Insert:



#insert one tuple into a table
#Alex Brightman will also be playing the role of Wilson in Harvey, add him to that cast list
insert into Cast values("Wilson", "Alex Brightman", "Harvey");
select * from Cast
where play_title = 'Harvey';


#insert a set of tuples (by using another select statement)/insert involving two tables
#Create a separate table and fill it with only the info about equity actors who are in
#the musical Guys and Dolls. Fill specifically with the equity status and name of the actor
create table if not exists G_and_D_Equity(
	actor_name varchar(50) not null primary key,
    equity_status varchar(10)
);
insert into G_and_D_Equity
select name, equity_status from Actor
where equity_status = 'equity'
and name in
(select actor_name from Cast where play_title = 'Guys and Dolls');
select * from G_and_D_Equity;
#delete from G_and_D_Equity;



#Delete:



#delete one tuple or a set of tuples: from one table, from multiple tables.
#delete all tickets that cost above $100
delete from Ticket 
where price > 100;
select * from Ticket;



#Update:



#update one tuple or a set of tuples: from one table, from multiple tables
#Add a bonus of 5% to actors with salaries below $40/hr.
select * from Actor;
update Actor
set salary_per_hour = (salary_per_hour * .05) + salary_per_hour
where salary_per_hour < 40;
select * from Actor;
delete from Actor;



#Create View:



#create a view of all ticket info with audience member names
create view allTicketInfo
as select Audience_member.ticket_number, confirmation_number, first_name, last_name,
		  seat_number, price, seat_section, theater_name, play_title 
from Audience_member, Ticket
where Audience_member.ticket_number = Ticket.ticket_number;
select * from allTicketInfo;
#drop view allTicketInfo;

#create a new view of just employee IDs and job titles from staff
create view simpleStaff
as select ID, job_title, theater_name from Staff;
select * from simpleStaff;
#drop view simpleStaff;


#operate on View (i.e. select, insert, delete, update...)

#select
#find the names of all audience members who paid under $100 for a ticket
select first_name, last_name, price from allTicketInfo
where price < 100;

#insert
#insert a new item into the view
insert into simpleStaff values ("2587213", "Set Painter", "Sydney Harman Hall");
select * from simpleStaff;

#delete
#delete all staff info of workers at Kreeger Theater
delete from Staff;
delete from simpleStaff
where theater_name = 'Kreeger Theater';
select * from simpleStaff;
#drop view simpleStaff;

#update
#All employees at the Studio Theater are getting laid off. They moved to the Eisenhower Theater
select * from simpleStaff;
update simpleStaff
set theater_name = 'Eisenhower Theater'
where theater_name = 'Studio Theater';
select * from simpleStaff; 
delete from Staff;




#B) Triggers




#referential integriry
#create a trigger that ensures that no duplicate entries will be inserted or updated on Cast
delimiter $$
create trigger no_Cast_Duplicates
before insert on Cast
for each row
begin
	if (exists(select 1 from Cast where role = new.role 
			   and actor_name = new.actor_name
               and play_title = new.play_title))
	then signal sqlstate value '45000' set message_text = 'INSERT failed due to duplicate entry';
    end if;
end$$
delimiter ;
insert into Cast values("Elwood", "Paul Schneider", "Harvey");

#enforcing attribute domain constraints
#create 3 triggers that all ensure that all inserts on Ticket, Audience_member, and Staff follow the number of digits per key
delimiter $$
create trigger ticket_Num_Limit
before insert on Ticket
for each row
begin
	if (exists(select 1 from Ticket where length(ticket_number) <> length(new.ticket_number)))
    then signal sqlstate value '45000' set message_text = 'INSERT failed due to incorrect length of ticket number';
	end if;
end$$
delimiter ;
insert into Ticket values("T655329268", "G107", 102, "Orchestra", "Kreeger Theater", "Harvey");

delimiter $$
create trigger aud_Num_Limit
before insert on Audience_member
for each row
begin
	if (exists(select 1 from Audience_member where length(ticket_number) <> length(new.ticket_number)))
    then signal sqlstate value '45000' set message_text = 'INSERT failed due to incorrect length of ticket number';
	end if;
end$$
delimiter ;
insert into Audience_member values("T655329268", "11I1AYJNWDMXL", "Tyson", "Bristol");

delimiter $$
create trigger staff_Num_Limit
before insert on Staff
for each row
begin
	if (exists(select 1 from Staff where length(ID) <> length(new.ID)))
    then signal sqlstate value '45000' set message_text = 'INSERT failed due to incorrect length of ID number';
	end if;
end$$
delimiter ;
insert into Staff values("678486", "Edward", "Hope", "Lighting Coordinator", 50, "Sidney Harman Hall");


#creating a database log
#create a trigger that keeps track of which seats (number, section, and theater) are filled in each theater on insert into ticket
create table if not exists Seat_log (seat_number varchar(5), seat_section varchar(50), theater_name varchar(50));
delimiter $$
create trigger seat_Logger
after insert on Ticket
for each row
begin
	insert into seat_Log values(new.seat_number, new.seat_section, new.theater_name);
end$$;
delimiter ;
delete from Ticket;
select * from Seat_log;
delete from Seat_log;


#gathering statistics
#create a trigger that keeps track of the average staff member salary after insert into Staff
create table if not exists Staff_sal_avg (theater_name varchar(50), avg_salary integer(4));
insert into Staff_sal_avg values("Eisenhower Theater", 0);
insert into Staff_sal_avg values("Kreeger Theater", 0);
insert into Staff_sal_avg values("Studio Theater", 0);
insert into Staff_sal_avg values("Sidney Harman Hall", 0);
delimiter $$
create Trigger salary_Averager
after insert on Staff
for each row
begin
	update Staff_sal_avg
    set avg_salary = (select avg(salary_per_hour) from Staff
					  where Staff.theater_name = new.theater_name)
	where theater_name = new.theater_name;
    end$$
delimiter ;
select * from Staff_sal_avg;                      