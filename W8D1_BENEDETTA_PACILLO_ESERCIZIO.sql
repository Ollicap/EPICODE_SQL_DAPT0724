/* /* Modificare, eliminare i dati

È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda. 
Uno store è collocato in una precisa area geografica. In unʼarea geografica possono essere collocati store diversi. 
Cosa devi fare: 1. Crea una tabella Store per la gestione degli store ID, nome, data apertura, ecc.) 
2. Crea una tabella Region per la gestione delle aree geografiche ID, città, regione, area geografica, …)
3. Popola le tabelle con pochi record esemplificativi 
4. Esegui operazioni di aggiornamento, modifica ed eliminazione record */

CREATE DATABASE WonderDonutsDB;
USE WonderDonutsDB;

CREATE TABLE store
(Store_id TINYINT NOT NULL,
Name VARCHAR(50) NOT NULL,
Open_date DATE NOT NULL,
Address VARCHAR(70) NOT NULL,
Zipcode INT NOT NULL,
Manager CHAR(50) NOT NULL,
Id_manager SMALLINT NOT NULL,
Region_id SMALLINT NOT NULL,
CONSTRAINT PK_store PRIMARY KEY (Store_id));

CREATE TABLE region
(Region_id SMALLINT NOT NULL,
Region_name VARCHAR(50) NOT NULL,
City VARCHAR(20) NOT NULL,
Area VARCHAR(20) NOT NULL,
Area_manager VARCHAR(50) NOT NULL,
Area_manager_id TINYINT NOT NULL,
CONSTRAINT PK_region PRIMARY KEY (Region_id));

CREATE TABLE employee
(Employee_id SMALLINT NOT NULL,
Fname CHAR(20) NOT NULL,
Mname CHAR(20),
Lname CHAR(40),
Startdate DATE NOT NULL,
Enddate DATE,
Email VARCHAR(30) NOT NULL,
Manager_id SMALLINT NOT NULL,
CONSTRAINT PK_employee PRIMARY KEY (Employee_id));

ALTER TABLE store
ADD CONSTRAINT FK_store_region FOREIGN KEY (Region_id) REFERENCES region (Region_id);

ALTER TABLE employee
MODIFY COLUMN Email VARCHAR(50);


INSERT INTO region (Region_id, Region_name, City, Area, Area_manager, Area_manager_id) VALUES
(15, 'New York', 'New York City', 'East Coast 1', 'David Hillman', 22),
(77, 'LA Bay', 'Los Angeles', 'West Coast 7', 'Shaquila McNamara', 97),
(23, 'Nevada', 'Las Vegas', 'Inner West 3', 'Gil Grissom', 48);

INSERT INTO store (Store_id, Name, Open_date, Address, Zipcode, Manager, Id_manager, Region_id) VALUES
(1, 'Delicious Flying Obect', '2020-01-01', 'Union Square, 45', 123456, 'Joe Schmo', 4, 15),
(2, 'I cannot believe it is a donut', '2020-02-01', 'Times Square, 256', 123456, 'Mary Smith', 65, 15),
(3, 'Donut Fight Club', '2020-03-01', 'Sunset Boulevard, 3458', 90121, 'Alan Bennett', 64, 77),
(4, 'Frying Donut', '2020-05-01', 'Streep, 954', 542163, 'Lily Alderin', 98, 23);

INSERT INTO employee (Employee_id, Fname, Mname, Lname, Startdate, Enddate, Email, Manager_id) VALUES
(1, 'Jack', '', 'Mah', '2019-12-15', '2099-01-01', 'j.mah@wonderdonut.staff.com', 0),
(2, 'Ursula', 'Barbara', 'LeGuin', '2019-12-18', '2099-01-01', 'u.leguin@wonderdonut.staff.com', 1),
(22, 'David', '', 'Hillman', '2019-12-20', '2099-01-01', 'd.hillman@wonderdonut.staff.com',0),
(7, 'Joe', '', 'Schmo', '2019-12-01', '2099-01-01', 'j.schmo@wonderdonut.staff.com',22),
(8, 'Alan', '', 'Bennett', '2019-12-20', '2099-01-01', 'a.bennett@wonderdonut.staff.com', 97),
(65, 'Mary', '', 'Smith', '2019-12-01', '2099-01-01', 'm.smith@wonderdonut.staff.com', 22),
(97, 'Shaquila', '', 'McNamara', '2019-11-20', '2099-01-01', 's.mcnamara@wonderdonut.staff.com', 1),
(48, 'Gil', '', 'Grissom', '2019-10-20', '2099-01-01', 'g.grissom@wonderdonut.staff.com', 1),
(63, 'Lily', '', 'Alderin', '2019-12-20', '2099-01-01', 'l.alderin@wonderdonut.staff.com', 48);


-- Operazioni di modifica, aggiornamento e inserimento

UPDATE employee
SET Enddate = '2025-01-10'
WHERE Employee_id = 2;
