CREATE DATABASE Libreria_indipendente_gestione;
USE Libreria_indipendente_gestione;
/*Create Tables without FK first*/
CREATE TABLE Newsletter
	(email VARCHAR(50) NOT NULL,
    NomeCognome VARCHAR(50),
    CONSTRAINT PK_Newsletter PRIMARY KEY (email)
    );
CREATE TABLE Clienti
	(IdCliente INT NOT NULL,
    NomeCognome VARCHAR(50) NOT NULL,
    telefono VARCHAR(13) NOT NULL,
    email VARCHAR(50),
    CONSTRAINT PK_Clienti PRIMARY KEY (IdCliente),
    CONSTRAINT FK_Clienti_Newsletter FOREIGN KEY (email) REFERENCES Newsletter (email)
    ); 
CREATE TABLE Ordini
	(IdOrdine INT NOT NULL,
	IdCliente INT NOT NULL,
	Data DATE NOT NULL,
	Titolo VARCHAR(50) NOT NULL,
	ISBN VARCHAR(13) NOT NULL,
	Fornitore VARCHAR(10),
	Disponibilità TINYINT NOT NULL,
    CONSTRAINT PK_Ordini PRIMARY KEY (IdOrdine),
    CONSTRAINT FK_Ordini_Clienti FOREIGN KEY (IdCliente) REFERENCES Clienti (IdCliente)
	);
CREATE TABLE Fornitori
	(CodiceFornitore VARCHAR(10) NOT NULL,
	Nome VARCHAR(25) NOT NULL,
	Sconto DECIMAL (2,2) NOT NULL,
	CUU VARCHAR(10) NOT NULL,
	NCarico INT NOT NULL,
	NResa INT NOT NULL,
	CONSTRAINT PK_Fornitori PRIMARY KEY (CodiceFornitore)
	);
CREATE TABLE Carico
	(NCarico INT NOT NULL,
	CodiceFornitore VARCHAR(10) NOT NULL,
	Data DATE NOT NULL,
	Quantità INT NOT NULL,
	ISBN VARCHAR(13),
	EAN VARCHAR(13),
	CONSTRAINT PK_Carico PRIMARY KEY (NCarico),
	CONSTRAINT FK_Carico_Fornitori FOREIGN KEY (CodiceFornitore) REFERENCES Fornitori (CodiceFornitore)
    );
CREATE TABLE Resa
	(NResa INT NOT NULL,
	Data DATE NOT NULL,
	CodiceFornitore VARCHAR(10) NOT NULL,
	ISBN VARCHAR(13) NOT NULL,
	Quantità INT NOT NULL, 
	CONSTRAINT PK_Resa PRIMARY KEY (NResa),
	CONSTRAINT FK_Resa_Fornitori FOREIGN KEY (CodiceFornitore) REFERENCES Fornitori (CodiceFornitore)
);
CREATE TABLE Libri
	(CodiceID INT NOT NULL,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    Titolo VARCHAR(50) NOT NULL,
    Autore VARCHAR(50) NOT NULL,
    Prezzo DECIMAL(5,2) NOT NULL,
    Editore VARCHAR(25) NOT NULL,
    Tipologia VARCHAR(25),
    Scaffale VARCHAR(25),
    CodiceFornitore VARCHAR(10),
    CONSTRAINT PK_Libri PRIMARY KEY (CodiceId, ISBN),
    constraint FK_Libri_Fornitori FOREIGN KEY (CodiceFornitore) REFERENCES Fornitori (CodiceFornitore)
    );
CREATE TABLE Non_Libri
	(CodiceID INT NOT NULL,
    EAN VARCHAR(13) NOT NULL UNIQUE,
    Nome VARCHAR(50) NOT NULL,
    Prezzo DECIMAL(5,2) NOT NULL,
    CodiceFornitore VARCHAR(10),
    CONSTRAINT PK_Non_Libri PRIMARY KEY (CodiceId, EAN),
    CONSTRAINT FK_Non_Libri_Fornitori FOREIGN KEY (CodiceFornitore) REFERENCES Fornitori (CodiceFornitore)
    );
CREATE TABLE Vendite
	(NumeroVendita INT NOT NULL,
    Data DATE NOT NULL,
    CodiceId INT NOT NULL,
    ISBN VARCHAR(13),
    EAN VARCHAR(13),
    IdCliente INT,
    Quantità INT NOT NULL,
    Totale DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Vendite PRIMARY KEY (NumeroVendita),
    CONSTRAINT FK_Vendite_Libri FOREIGN KEY (CodiceId) REFERENCES Libri (CodiceID),
    CONSTRAINT FK_Vendite_Non_Libri FOREIGN KEY (CodiceID) REFERENCES Non_Libri (CodiceID)
    );
/*Populate tables with data*/

INSERT INTO Newsletter (email, NomeCognome) VALUES
('mariorossi@example.com', 'Mario Rossi'),
('annarossi@example.com', 'Anna Rossi'),
('lucabianchi@example.com', 'Luca Bianchi'),
('giovanniverdi@example.com', 'Giovanni Verdi'),
('silviagialli@example.com', 'Silvia Gialli'),
('carlogiallo@example.com', 'Carlo Giallo'),
('elenabianchi@example.com', 'Elena Bianchi'),
('paologreco@example.com', 'Paolo Greco'),
('federicapozzi@example.com', 'Federica Pozzi'),
('giorgiomarrone@example.com', 'Giorgio Marrone');

INSERT INTO Clienti (IdCliente, NomeCognome, telefono, email) VALUES
(1, 'Mario Rossi', '1234567890', 'mariorossi@example.com'),
(2, 'Anna Rossi', '0987654321', 'annarossi@example.com'),
(3, 'Luca Bianchi', '1112223333', 'lucabianchi@example.com'),
(4, 'Giovanni Verdi', '4445556666', 'giovanniverdi@example.com'),
(5, 'Silvia Gialli', '7778889999', 'silviagialli@example.com'),
(6, 'Carlo Giallo', '0001112222', 'carlogiallo@example.com'),
(7, 'Elena Bianchi', '3334445555', 'elenabianchi@example.com'),
(8, 'Paolo Greco', '6667778888', 'paologreco@example.com'),
(9, 'Federica Pozzi', '9990001111', 'federicapozzi@example.com'),
(10, 'Giorgio Marrone', '2223334444', 'giorgiomarrone@example.com');

INSERT INTO Ordini (IdOrdine, IdCliente, Data, Titolo, ISBN, Fornitore, Disponibilità) VALUES
(1, 1, '2024-01-15', 'Libro Avventura', '9781234567897', 'Fornitore1', 1),
(2, 2, '2024-02-20', 'Guida di Viaggio', '9782345678901', 'Fornitore2', 1),
(3, 3, '2024-03-05', 'Romanzo Storico', '9783456789012', 'Fornitore3', 0),
(4, 4, '2024-04-18', 'Manuale Cucina', '9784567890123', 'Fornitore1', 1),
(5, 5, '2024-05-22', 'Biografia', '9785678901234', 'Fornitore2', 1),
(6, 6, '2024-06-30', 'Libro Tecnico', '9786789012345', 'Fornitore3', 0),
(7, 7, '2024-07-10', 'Raccolta Poesie', '9787890123456', 'Fornitore1', 1),
(8, 8, '2024-08-25', 'Enciclopedia', '9788901234567', 'Fornitore2', 1),
(9, 9, '2024-09-14', 'Saggio Filosofico', '9789012345678', 'Fornitore3', 0),
(10, 10, '2024-10-01', 'Thriller', '9780123456789', 'Fornitore1', 1);

INSERT INTO Fornitori (CodiceFornitore, Nome, Sconto, CUU, NCarico, NResa) VALUES
('F001', 'Fornitore1', 0.10, 'CUU001', 150, 10),
('F002', 'Fornitore2', 0.15, 'CUU002', 200, 20),
('F003', 'Fornitore3', 0.12, 'CUU003', 180, 15),
('F004', 'Fornitore4', 0.08, 'CUU004', 220, 25),
('F005', 'Fornitore5', 0.20, 'CUU005', 170, 5),
('F006', 'Fornitore6', 0.18, 'CUU006', 160, 12),
('F007', 'Fornitore7', 0.10, 'CUU007', 210, 22),
('F008', 'Fornitore8', 0.14, 'CUU008', 190, 18),
('F009', 'Fornitore9', 0.16, 'CUU009', 230, 30),
('F010', 'Fornitore10', 0.05, 'CUU010', 140, 8);

INSERT INTO Carico (NCarico, CodiceFornitore, Data, Quantità, ISBN, EAN) VALUES
(1, 'F001', '2024-01-10', 100, '9781234567897', '1234567890123'),
(2, 'F002', '2024-02-15', 150, '9782345678901', '2345678901234'),
(3, 'F003', '2024-03-20', 200, '9783456789012', '3456789012345'),
(4, 'F004', '2024-04-25', 120, '9784567890123', '4567890123456'),
(5, 'F005', '2024-05-30', 180, '9785678901234', '5678901234567'),
(6, 'F006', '2024-06-05', 130, '9786789012345', '6789012345678'),
(7, 'F007', '2024-07-10', 170, '9787890123456', '7890123456789'),
(8, 'F008', '2024-08-15', 160, '9788901234567', '8901234567890'),
(9, 'F009', '2024-09-20', 140, '9789012345678', '9012345678901'),
(10, 'F010', '2024-10-25', 190, '9780123456789', '0123456789012');

INSERT INTO Resa (NResa, Data, CodiceFornitore, ISBN, Quantità) VALUES
(1, '2024-01-12', 'F001', '9781234567897', 5),
(2, '2024-02-18', 'F002', '9782345678901', 10),
(3, '2024-03-23', 'F003', '9783456789012', 8),
(4, '2024-04-28', 'F004', '9784567890123', 12),
(5, '2024-05-03', 'F005', '9785678901234', 4),
(6, '2024-06-08', 'F006', '9786789012345', 6),
(7, '2024-07-13', 'F007', '9787890123456', 9),
(8, '2024-08-18', 'F008', '9788901234567', 11),
(9, '2024-09-23', 'F009', '9789012345678', 7),
(10, '2024-10-28', 'F010', '9780123456789', 3);

INSERT INTO Libri (CodiceID, ISBN, Titolo, Autore, Prezzo, Editore, Tipologia, Scaffale, CodiceFornitore) VALUES
(1, '9781234567897', 'Libro Avventura', 'Mario Bianchi', 15.99, 'Editore1', 'Romanzo', 'A1', 'F001'),
(2, '9782345678901', 'Guida di Viaggio', 'Anna Verdi', 25.50, 'Editore2', 'Guida', 'B2', 'F002'),
(3, '9783456789012', 'Romanzo Storico', 'Giovanni Neri', 19.75, 'Editore3', 'Romanzo', 'C3', 'F003'),
(4, '9784567890123', 'Manuale Cucina', 'Silvia Rossi', 30.00, 'Editore4', 'Manuale', 'D4', 'F004'),
(5, '9785678901234', 'Biografia', 'Carlo Gialli', 20.25, 'Editore5', 'Biografia', 'E5', 'F005'),
(6, '9786789012345', 'Libro Tecnico', 'Elena Blu', 45.00, 'Editore6', 'Tecnico', 'F6', 'F006'),
(7, '9787890123456', 'Raccolta Poesie', 'Paolo Viola', 12.50, 'Editore7', 'Poesia', 'G7', 'F007'),
(8, '9788901234567', 'Enciclopedia', 'Federica Marrone', 60.00, 'Editore8', 'Enciclopedia', 'H8', 'F008'),
(9, '9789012345678', 'Saggio Filosofico', 'Giorgio Arancio', 22.99, 'Editore9', 'Saggio', 'I9', 'F009'),
(10, '9780123456789', 'Thriller', 'Luca Verde', 18.75, 'Editore10', 'Thriller', 'J10', 'F010'),
(11, '9781098765432', 'Romanzo Giallo', 'Franco Nero', 16.80, 'Editore1', 'Romanzo', 'K11', 'F001'),
(12, '9782109876543', 'Fantasy', 'Sara Rosa', 21.95, 'Editore2', 'Fantasy', 'L12', 'F002'),
(13, '9783210987654', 'Storia Antica', 'Marco Bianco', 28.40, 'Editore3', 'Storia', 'M13', 'F003'),
(14, '9784321098765', 'Guida Sportiva', 'Alessia Verde', 19.99, 'Editore4', 'Sport', 'N14', 'F004'),
(15, '9785432109876', 'Ricettario', 'Giulia Gialli', 34.50, 'Editore5', 'Ricette', 'O15', 'F005'),
(16, '9786543210987', 'Manuale Tecnico', 'Andrea Blu', 50.75, 'Editore6', 'Tecnico', 'P16', 'F006'),
(17, '9787654321098', 'Racconti Brevi', 'Simone Viola', 14.20, 'Editore7', 'Racconti', 'Q17', 'F007'),
(18, '9788765432109', 'Enciclopedia Medica', 'Luca Marrone', 70.00, 'Editore8', 'Medico', 'R18', 'F008'),
(19, '9789876543210', 'Filosofia Moderna', 'Roberta Arancio', 25.99, 'Editore9', 'Filosofia', 'S19', 'F009'),
(20, '9780987654321', 'Romanzo Fantascienza', 'Davide Verde', 23.75, 'Editore10', 'Fantascienza', 'T20', 'F010');

INSERT INTO Non_Libri (CodiceID, EAN, Nome, Prezzo, CodiceFornitore) VALUES
(1, '1234567890123', 'Penna a Sfera', 1.20, 'F001'),
(2, '2345678901234', 'Matita HB', 0.50, 'F002'),
(3, '3456789012345', 'Gomma per Cancellare', 0.75, 'F003'),
(4, '4567890123456', 'Righello 30 cm', 2.00, 'F004'),
(5, '5678901234567', 'Evidenziatore Giallo', 1.50, 'F005'),
(6, '6789012345678', 'Quaderno A4 a Righe', 2.50, 'F006'),
(7, '7890123456789', 'Cartellina Porta Documenti', 3.00, 'F007'),
(8, '8901234567890', 'Block Notes', 1.75, 'F008'),
(9, '9012345678901', 'Pennarelli Colorati', 4.50, 'F009'),
(10, '0123456789012', 'Colla Stick', 1.00, 'F010');

INSERT INTO Vendite (NumeroVendita, Data, CodiceId, ISBN, EAN, IdCliente, Quantità, Totale) VALUES
(1, '2024-01-05', 1, '9781234567897', NULL, 1, 2, 31.98),
(2, '2024-01-06', 2, '9782345678901', NULL, 2, 1, 25.50),
(3, '2024-01-07', 3, '9783456789012', NULL, 3, 3, 59.25),
(4, '2024-01-08', 4, '9784567890123', NULL, 4, 1, 30.00),
(5, '2024-01-09', 5, '9785678901234', NULL, 5, 2, 40.50),
(6, '2024-01-10', 6, '9786789012345', NULL, 6, 1, 45.00),
(7, '2024-01-11', 7, '9787890123456', NULL, 7, 4, 50.00),
(8, '2024-01-12', 8, '9788901234567', NULL, 8, 1, 60.00),
(9, '2024-01-13', 9, '9789012345678', NULL, 9, 2, 45.98),
(10, '2024-01-14', 10, '9780123456789', NULL, 10, 1, 18.75),
(11, '2024-01-15', 1, NULL, '1234567890123', 1, 10, 12.00),
(12, '2024-01-16', 2, NULL, '2345678901234', 2, 20, 10.00),
(13, '2024-01-17', 3, NULL, '3456789012345', 3, 5, 3.75),
(14, '2024-01-18', 4, NULL, '4567890123456', 4, 15, 30.00),
(15, '2024-01-19', 5, NULL, '5678901234567', 5, 8, 12.00),
(16, '2024-01-20', 6, NULL, '6789012345678', 6, 12, 30.00),
(17, '2024-01-21', 7, NULL, '7890123456789', 7, 10, 30.00),
(18, '2024-01-22', 8, NULL, '8901234567890', 8, 6, 10.50),
(19, '2024-01-23', 9, NULL, '9012345678901', 9, 4, 10.00),
(20, '2024-01-24', 10, NULL, '0123456789012', 10, 20, 20.00),
(21, '2024-01-25', 1, '9781098765432', NULL, 1, 1, 16.80),
(22, '2024-01-26', 2, '9782109876543', NULL, 2, 2, 43.90),
(23, '2024-01-27', 3, '9783210987654', NULL, 3, 1, 28.40),
(24, '2024-01-28', 4, '9784321098765', NULL, 4, 3, 59.97),
(25, '2024-01-29', 5, '9785432109876', NULL, 5, 1, 34.50),
(26, '2024-01-30', 6, '9786543210987', NULL, 6, 2, 101.50),
(27, '2024-01-31', 7, '9787654321098', NULL, 7, 5, 71.00),
(28, '2024-02-01', 8, '9788765432109', NULL, 8, 1, 70.00),
(29, '2024-02-02', 9, '9789876543210', NULL, 9, 1, 25.99),
(30, '2024-02-03', 10, '9780987654321', NULL, 10, 3, 71.25);




