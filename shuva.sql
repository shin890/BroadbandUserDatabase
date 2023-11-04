SET PAGESIZE 200;
set linesize 200;


drop table Authentication;
drop table PaymentHistory;
drop table UserList;
drop table Package;




create table Package(
    Package_ID numeric(4,0),
    Package_Name varchar(20) NOT NULL,
    Speed varchar(10) NOT NULL,
    Price numeric(4,0) NOT NULL,
    Timeline varchar(20) NOT NULL,
    primary key(Package_ID)
);

create table UserList(
    User_ID varchar(20),
    Name varchar(10) NOT NULL,
    Address varchar(10) NOT NULL,
    Phone_Number varchar(14) NOT NULL,
    Package_ID numeric(4,0),
    primary key(User_ID),
    foreign key(Package_ID) REFERENCES Package
);

create table Authentication(
    User_ID varchar(20) NOT NULL ,
    Password varchar(20) NOT NULL,
    foreign key(User_ID) REFERENCES UserList
);

create table PaymentHistory(
    User_ID varchar(20) NOT NULL,
    Payment_Date DATE NOT NULL,
    Expiry_Date DATE GENERATED ALWAYS AS (Payment_Date + 30),
    foreign key(User_ID) REFERENCES UserList
);



insert into Package values(1, 'Silver', '20 Mbps', 1000, '30 Days');

insert into Package values(2, 'Gold', '35 Mbps', 1500, '30 Days');

insert into Package values(3, 'Platinum', '50 Mbps', 2000, '30 Days');

insert into Package values(4, 'Diamond', '70 Mbps', 2500, '30 Days');

insert into Package values(5, 'Sapphire', '80 Mbps', 3000, '30 Days');



insert into UserList values('kuet_nahin','Nahin','Dak-Bangla','+8801911000000',5);
insert into UserList values('kuet_taha','Taha','Dak-Bangla','+8801921000000',1);
insert into UserList values('kuet_sanjukta','Sanjukta','Rupsha','+8801921500000',3);
insert into UserList values('kuet_marjan','Marjan','Nirala','+8801922500000',1);
insert into UserList values('kuet_joita','Joita','Sonadanga','+8801822500000',1);
insert into UserList values('kuet_shupto','Shupto','Shibbari','+8801832500000',2);
insert into UserList values('kuet_nabila','Nabila','Daulatpur','+8801823500000',4);
insert into UserList values('kuet_zannat','Zannat','Khalispur','+8801923500000',4);
insert into UserList values('kuet_turna','Turna','Rail-Gate','+8801823510000',2);
insert into UserList values('kuet_senjuty','Senjuty','KUET','+8801623510000',2);


insert into Authentication values('kuet_nahin','ebtcns52');
insert into Authentication values('kuet_taha','UWVBEsxT');
insert into Authentication values('kuet_sanjukta','LW7c7NKq');
insert into Authentication values('kuet_marjan','7mZpUS7P');
insert into Authentication values('kuet_joita','uvt7zTpR');
insert into Authentication values('kuet_shupto','LVKahy9C');
insert into Authentication values('kuet_nabila','KATVK2ZJ');
insert into Authentication values('kuet_zannat','tvkWVd5N');
insert into Authentication values('kuet_turna','j6KGDy2h');
insert into Authentication values('kuet_senjuty','T6f9sQkp');


insert into PaymentHistory(User_ID,Payment_Date) values('kuet_shupto','04-NOV-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_zannat','01-NOV-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_nabila','31-OCT-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_nahin','31-OCT-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_turna','19-NOV-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_marjan','15-NOV-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_shupto','04-OCT-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_zannat','01-OCT-2023');
insert into PaymentHistory(User_ID,Payment_Date) values('kuet_turna','19-OCT-2023');

SELECT * FROM Package;
select * from UserList;
select * from Authentication;
select * from PaymentHistory;

select * from UserList natural join package;

set serveroutput on


declare 
cursor i IS
select * from PaymentHistory;

i2 PaymentHistory%rowtype;

BEGIN


DBMS_OUTPUT.PUT_LINE('User_ID'||'      '||'Payment_Date'||'       '||'Expiry_Date'||'        '||'Active Status ');
DBMS_OUTPUT.NEW_LINE;
DBMS_OUTPUT.PUT_LINE('__________________________________________________________________________________________');
open i;
fetch i into i2;

while i%FOUND LOOP

if (i2.Expiry_Date >= sysdate) THEN
DBMS_OUTPUT.PUT_LINE(i2.User_ID||'      '||i2.Payment_Date||'       '||i2.Expiry_Date||'        '||'Active');
end if;

fetch i into i2;
end loop;
close i;
end;
/



