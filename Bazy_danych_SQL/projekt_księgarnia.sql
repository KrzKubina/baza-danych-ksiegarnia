show databases;

create database projekt26;

use projekt26;

show tables;

create or replace table klienci(
id_klient INT AUTO_INCREMENT primary key,
imie varchar(50) not null,
nazwisko varchar(50) not null,
email varchar(100) not null,
data_rejestracji timestamp DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);

create or replace table status_dostawy(
id_status int primary key auto_increment,
status varchar(50)
);

create or replace table logowanie(
id_logowanie int auto_increment primary key,
login varchar(250) unique not null,
haslo varchar(30) not null,
id_klient int,
foreign key(id_klient) references klienci(id_klient)
);

create or replace table ksiazki_info(
id_ksiazki int auto_increment primary key,
autor varchar(250),
tytul varchar(250),
rok_wydania int,
isbn varchar(50),
epoka varchar(50)
);

create or replace table ksiazki_oceny(
id int auto_increment primary key,
id_ksiazki int,
ocena float(3,2),
liczba_ocen int,
1_gwiazdka int,
2_gwiazdki int,
3_gwiazdki int,
4_gwiazdki int,
5_gwiazdek int,
foreign key(id_ksiazki) references ksiazki_info(id_ksiazki)
);

create or replace table zamowienia(
id_zamowienia int auto_increment primary key,
id_klient int,
data_zamowienia timestamp DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP,
id_status int,
foreign key(id_klient) references klienci(id_klient),
foreign key(id_status) references status_dostawy(id_status)
);

create or replace table ceny(
id_ksiazki int,
cena float(4,2) primary key,
foreign key(id_ksiazki) references ksiazki_info(id_ksiazki)
);

create or replace table koszyk(
id_zamowienia int,
id_ksiazki int,
tytul varchar(250),
cena float(4,2),
foreign key(id_zamowienia) references zamowienia(id_zamowienia),
foreign key(id_ksiazki) references ksiazki_info(id_ksiazki),
foreign key(cena) references ceny(cena)
);

create or replace table magazyn(
id_magazyn int auto_increment primary key,
id_ksiazki int,
stan_magazynowy int,
hurtownia int,
data_aktualizacji timestamp,
foreign key(id_ksiazki) references ksiazki_info(id_ksiazki)
);



create or replace table klienci_kurier(
id_kurier INT AUTO_INCREMENT primary key,
id_klient int,
id_zamowienia int,
data_zamowienia timestamp DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP,
adres_ulica varchar(50) default 'brak',
adres_numer_domu_mieszkania varchar(10) not null,
adres_miasto varchar(50) not null,
adres_kod varchar(6) not null,
telefon varchar(9),
id_status int,
foreign key(id_klient) references klienci(id_klient),
foreign key(id_zamowienia) references zamowienia(id_zamowienia),
foreign key(id_status) references status_dostawy(id_status)
);


create or replace table epoki(
id_epoki int,
nazwa_epoki varchar(100),
poczatek_epoki int primary key,
koniec_epoki int
)
PARTITION BY RANGE (poczatek_epoki) (
    PARTITION p_przed_renesansem VALUES LESS THAN (1493),
    PARTITION p_renesans VALUES LESS THAN (1521),
    PARTITION p_barok VALUES LESS THAN (1681),
    PARTITION p_oswiecenie VALUES LESS THAN (1789),
    PARTITION p_romantyzm VALUES LESS THAN (1851),
    PARTITION p_pozytywizm VALUES LESS THAN (1881),
    PARTITION p_modernizm VALUES LESS THAN (1919),
    PARTITION p_miedzywojenna VALUES LESS THAN (1939),
    PARTITION p_wspolczesnosc VALUES LESS THAN MAXVALUE
);

show tables;

-- Dodanie wartości

INSERT INTO ksiazki_info(autor, tytul, rok_wydania, isbn)
values
('Kathryn Stockett', 'The Help', 2009, '399155341'),
('John Green', 'The Fault in Our Stars', 2012, '525478817'),
('William Shakespeare', 'An Excellent conceited Tragedie of Romeo and Juliet', 1595, '743477111'),
('Joanne Rowling', 'Harry Potter and the Half-Blood Prince', 2005, '439785960'),
('Jane Austen', 'Pride and Prejudice', 1813, '679783261'),
('Lewis Carroll', 'Alice in Wonderland', 1865, '517223627'),
('Lois Lowry', 'The Giver', 1993, '385732554'),
('Emily Bronte', 'Wuthering Heights', 1847, '393978893'),
('Gillian Flynn', 'Gone Girl', 2012, '297859382'),
('Suzanne Collins', 'Catching Fire', 2009, '439023491'),
('Ray Bradbury', 'Fahrenheit 451', 1953, '307347974'),
('Khaled Hosseini', 'The Kite Runner', 2003, '1594480001'),
('Stephen King', 'The Stand', 1990, '385199570'),
('Jon Krakauer', 'Into the Wild', 1996, '385486804'),
('Elwyn White', "Charlotte's Web", 1952, '64410935'),
('John Tolkien', 'The Fellowship of the Ring', 1954, '618346252'),
('Jeannette Walls', 'The Glass Castle', 2005, '074324754X'),
('Philip Pullman', 'The Golden Compass', 1995, '679879242'),
('Louis Sachar', 'Holes', 1998, '439244196'),
('Alice Sebold', 'The Lovely Bones', 2002, '316166685'),
('John Steinbeck', 'Of Mice and Men', 1937, '142000671'),
('Markus Zusak', 'The Book Thief', 2005, '375831002'),
('Nicholas Sparks', 'The Notebook', 1996, '553816713'),
('Charles Dickens', 'A Tale of Two Cities', 1859, '141439602'),
('George Orwell', 'Animal Farm', 1945, '452284244'),
('Shel Silverstein', 'Where the Sidewalk Ends', 1974, '60513039'),
('Mark Haddon', 'The Curious Incident of the Dog in the Night-Time', 2003, '1400032717'),
('William Golding', 'Lord of the Flies', 1954, '140283331'),
('Erika Leonard', 'Fifty Shades Darker', 2011, '1612130585'),
('Dmitry Glukhovsky', 'Metro 2033', 2013, '1481845705'),
('Erika Leonard', 'Fifty Shades Freed', 2012, '345803507'),
('Veronica Roth', 'Insurgent', 2012, '7442912'),
('Paulo Coelho', 'O Alquimista', 1988, '61122416'),
('Jodi Picoult', "My Sister's Keeper", 2004, '743454537'),
('Cassandra Clare', 'City of Bones', 2007, '1416914285'),
('Stephenie Meyer', 'Eclipse', 2007, '316160202'),
('Dan Brown', 'Angels & Demons', 2000, '1416524797'),
('Roald Dahl', 'Charlie and the Chocolate Factory', 1964, '142403881'),
('Douglas Adams', "The Hitchhiker's Guide to the Galaxy", 1979, '345391802'),
('Steven Levitt', 'Freakonomics: A Rogue Economist Explores the Hidden Side of Everything', 2005, '61234001'),
('Shel Silverstein', 'The Giving Tree', 1964, '60256656'),
('Mary Shelley', 'Frankenstein', 1818, '141439475'),
('Stephen King', 'The Shining', 1977, '450040186'),
('Elizabeth Gilbert', 'Eat, pray, love', 2006, '143038419'),
('Sara Gruen', 'Water for Elephants', 2006, '1565125606'),
('Stephenie Meyer', 'Breaking Dawn', 2008, '031606792X'),
('Joanne Rowling', 'Harry Potter and the Goblet of Fire', 2000, '439139600'),
('Francis Fitzgerald', 'The Great Gatsby', 1925, '743273567'),
('George Orwell', '1984', 1949, '451524934'),
('Michael Crichton', 'Jurassic Park', 1990, '030734813X'),
('Harper Lee', 'To Kill a Mockingbird', 1960, '61120081'),
('Erika Leonard', 'Fifty Shades of Grey', 2011, '1612130291'),
('Susan Hinton', 'The Outsiders', 1967, '014038572X'),
('Arthur Golden', 'Memoirs of a Geisha', 1997, '739326228'),
('Jerome Salinger', 'The Catcher in the Rye', 1951, '316769177'),
('Paula Hawkins', 'The Girl on the Train', 2015, '1594633665'),
('Stephen Chbosky', 'The Perks of Being a Wallflower', 1999, '671027344'),
('Audrey Niffenegger', "The Time Traveler's Wife", 2003, '965818675'),
('William Goldman', 'The Princess Bride', 1973, '345418263'),
('Joanne Rowling', 'Harry Potter and the Prisoner of Azkaban', 1999, '043965548X'),
('Mark Twain', 'The Adventures of Huckleberry Finn', 1884, '142437174'),
('Veronica Roth', 'Divergent', 2011, '62024035'),
('Alex Haley', 'Roots', 1976, '440174643'),
('Christopher Paolini', 'Eragon', 2002, '375826696'),
('Frances Burnett', 'The Secret Garden', 1911, '517189607'),
('Aldous Huxley', 'Brave New World', 1932, '60929871'),
('John Tolkien', 'The Return of the King', 1955, '261102370'),
('George Martin', 'A Game of Thrones', 1996, '553588486'),
('Joanne Rowling', 'Harry Potter and the Deathly Hallows', 2007, '545010225'),
('Frank Herbert', 'Dune', 1965, '059309932X'),
('Orson Card', "Ender's Game", 1985, '812550706'),
('John Tolkien', 'The Hobbit or There and Back Again', 1937, '618260307'),
('Joanne Rowling', 'Harry Potter and the Chamber of Secrets', 1998, '439064864'),
('Jane Austen', 'Sense and Sensibility', 1811, '141439661'),
('Suzanne Collins', 'The Hunger Games', 2008, '439023483'),
('John Green', 'Looking for Alaska', 2005, '142402516'),
('Lauren Weisberger', 'The Devil Wears Prada', 2003, '307275558'),
('Kurt Vonnegut', "Slaughterhouse-Five, or The Children's Crusade: A Duty-Dance with Death", 1969, '385333846'),
('Margaret Mitchell', 'Gone with the Wind', 1936, '446675539'),
('James Dashner', 'The Maze Runner', 2009, '385737947'),
('Nora Roberts', 'Northern Lights', 1999, '515139742'),
('Stephenie Meyer', 'Twilight', 2005, '316015849'),
('Dan Brown', 'The Da Vinci Code', 2003, '307277674'),
('John Green', 'Paper Towns', 2008, '014241493X'),
('Stephenie Meyer', 'New Moon', 2006, '316160199'),
('Charlotte Bronte','Jane Eyre', 1847, '142437204'),
('Louisa Alcott', 'Little Women', 1868, '451529308'),
('Oscar Wilde', 'The Picture of Dorian Gray', 1891, '375751513'),
('Sue Kidd', 'The Secret Life of Bees', 2001, '142001740'),
('Suzanne Collins', 'Mockingjay', 2010, '439023513'),
('Bram Stoker', 'Dracula', 1897, '393970124'),
('Khaled Hosseini', 'A Thousand Splendid Suns', 2007, '1594489505'),
('John Tolkien', 'The Two Towers', 1954, '618346260'),
('Yann Martel', 'Life of Pi', 2001, '770430074'),
('Clive Lewis', 'The Lion, the Witch and the Wardrobe', 1950, '60764899'),
('Joanne Rowling', "Harry Potter and the Sorcerer's Stone", 1997, '439554934'),
('John Grisham', 'A Time to Kill', 1989, '385338600'),
('Stephenie Meyer', 'The Host', 2008, '316068047'),
('Joanne Rowling', "Harry Potter and the Order of the Phoenix", 2003, '439358078'),
('Rick Riordan', 'The Lightning Thief', 2005, '786838655');


select * from ksiazki_info;
select * from ksiazki_oceny;

INSERT INTO ksiazki_oceny(id_ksiazki,ocena, liczba_ocen, 1_gwiazdka, 2_gwiazdki, 3_gwiazdki, 4_gwiazdki, 5_gwiazdek)
values
(1, 4.47, 2040610, 14091, 31722, 165747, 604217, 1224833),
(2, 4.22, 3317781, 73091, 136590, 769162, 951874, 1687064),
(3,3.74, 1970483, 69655, 177994, 525794, 609758, 587282),
(4, 4.57, 2287969, 9852, 25247, 159495, 554679, 1538696),
(5, 4.26, 2806893, 71970, 107812, 353090, 768052, 1505969),
(6, 4.03, 366869, 8157, 19353, 74612, 117034, 147713),
(7 ,4.13, 1674068, 32553, 72807, 276342, 556544, 735822),
(8 ,3.85, 1264907, 56617, 102322, 265314, 388707, 451947),
(9, 4.07, 2181149, 57133, 101340, 352391, 794463, 875822),
(10,4.29, 2352459, 14145, 58139, 313051, 810752, 1156372),
(11,3.99, 1565023, 36888, 84354, 309931, 565154, 568696),
(12, 4.29, 2304297, 38753, 67971, 259321, 747805, 1190447),
(13 ,4.34, 580948, 7454, 16826, 68274, 164275, 324119),
(14, 3.98, 836420, 23152, 42414, 162360, 307915, 300579),
(15, 4.17, 1341342, 24662, 49547, 224986, 416285, 625862),
(16,4.36, 2247457, 45717, 65003, 235889, 591487, 1309361),
(17,4.27, 851885, 10745, 23709, 105616, 295133, 416682),
(18,3.98, 1225785, 43349, 73584, 234382, 387510, 486960),
(19, 3.96, 921676, 18772, 50862, 204416, 320826, 326800),
(20,3.81, 1936846, 69274, 145317, 457841, 680597, 583817),
(21,3.87, 1850459, 53896, 128264, 419864, 649113, 599322),
(22, 4.37, 1718502, 24218, 45801, 175394, 493139, 979950),
(23,4.1, 1264747, 45747, 70783, 200329, 346869, 602019),
(24, 3.84, 780062, 32056, 61340, 171623, 249569, 265474),
(25, 3.93, 2559312, 80006, 157557, 518938, 897194, 905617),
(26, 4.3, 1139622, 19132,	33734,	149307,	318063,	619386),
(27, 3.88, 1133421, 25753, 68956, 262014, 437202, 339496),
(28,3.68, 2155359, 116084, 197122, 530902, 726508, 584743),
(29, 3.85, 710914, 44574, 68391, 132874, 170401, 294674),
(30,3.99, 37539, 692, 2240, 7029, 14272, 13306),
(31,3.86, 683390, 45528, 63796, 125570, 156264, 292232),
(32, 4.04, 1107679, 14822, 57359, 221099, 393801, 420598),
(33, 3.87, 1942685, 96135, 160781, 385087, 566556, 734126),
(34, 4.07, 1022824, 19558, 47555, 183012, 360627, 412072),
(35, 4.1, 1537808, 44160, 82793, 256565, 440526, 713764),
(36, 3.69, 1352211, 95078, 143691, 303362, 352880, 457200),
(37, 3.89, 2549101, 91613, 167318, 538273, 872039, 879858),
(38,4.13, 620193, 8907, 21092, 110876, 216761, 262557),
(39,4.22, 1344427, 28528, 53973, 187488, 394658, 679780),
(40,3.97, 669972, 17242, 31019, 133940, 259183, 228588),
(41, 4.37, 863180, 20678, 26234, 90775, 196755, 528738),
(42, 3.8, 1102313, 34539, 86045, 275719, 378205, 327805),
(43, 4.22, 1058003, 21352, 33624, 145281, 345902, 511844),
(44, 3.55, 1409983, 109430, 165788, 355522, 391793, 387450),
(45, 4.09, 1323060, 19494, 57174, 233212, 492867, 520313),
(46, 3.69, 1257319, 112747, 131384, 247108, 303653, 462427),
(47, 4.56, 2413650, 9327, 24166, 177662, 603754, 1598741),
(48,3.92, 3560225, 106482, 240664, 757025, 1195428, 1260626),
(49,4.18, 2899352, 59238, 113544, 424300, 951257, 1351013),
(50,4.02, 770920, 16665, 36446, 152008, 272796, 293005),
(51,4.27, 4251252, 76234, 142880, 546172, 1261267, 2224699),
(52,3.66, 1820882, 213322, 191569, 321278, 371139, 723574),
(53,4.09, 880150, 13236, 41859, 164547, 290739, 369769),
(54,4.11, 1653003, 26097, 64838, 287496, 594946, 679626),
(55, 3.8, 2600257, 132745, 224130, 551411, 805052, 886919),
(56,3.92, 1939979, 46300, 114128, 412020, 742005, 625526),
(57,4.2, 1185573, 18473, 48109, 178200, 371069, 569722),
(58,3.97, 1518075, 49477, 95109, 292608, 494117, 586764),
(59,4.26, 748834, 14716, 24574, 99932, 222039, 387573),
(60,4.56, 2589065, 10014, 24721, 193911, 626825, 1733594),
(61,3.82, 1115115, 30909, 83208, 280425, 384920, 335653),
(62,4.2, 2760845, 52126, 114515, 408067, 838414, 1347723),
(63,4.44, 140440, 933, 2165, 14025, 40942, 82375),
(64, 3.9, 1371186, 57413, 102069, 283333, 410912, 517459),
(65,4.13, 841790, 11018, 30668, 151102, 291201, 357801),
(66,3.99, 1358188, 32487, 73734, 268519, 487803, 495645),
(67,4.53, 639893, 3432, 9433, 50282, 159089, 417657),
(68,4.45, 1903419, 29501, 38866, 147992, 515087, 1171973),
(69,4.62, 2648878, 21722, 32899, 154062, 522915, 1917280),
(70, 4.23, 684346, 15618, 27801, 92232, 199818, 348877),
(71,4.3, 1076745, 18777, 33546, 125777, 323842, 574803),
(72,4.27, 2735537, 56500, 70607, 342380, 811152, 1434898),
(73,4.42, 2547100, 11832, 49212, 287849, 702931, 1495276),
(74,4.07, 914529, 21366, 39643, 163323, 318433, 371764),
(75,4.33, 6071901, 87585, 163367, 709698, 1830853, 3280398),
(76,4.04, 1052383, 25384, 62658, 196045, 331869, 436427),
(77, 3.74, 765920, 26177, 62254, 208401, 255206, 213882),
(78,4.08, 1078930, 28564, 53296, 180183, 363042, 453845),
(79,4.3, 1039175, 23192, 37588, 129812, 267245, 581338),
(80,4.02, 976024, 19748, 54400, 188138, 333399, 380339),
(81,4, 38593, 367, 1679, 8900, 14217, 13430),
(82,3.59, 4714195, 529431, 518745, 957692, 1054704, 1653623),
(83,3.84, 1836400, 76663, 137764, 384344, 635774, 601855),
(84,3.82, 851270, 22594, 69325, 211542, 283138, 264671),
(85,3.53, 1385502, 116906, 184302, 341177, 333632, 409485),
(86,4.12, 1542288, 41301, 73921, 246212, 476730, 704124),
(87,4.07, 1588618, 36512, 79227, 287589, 512128, 673162),
(88,4.08, 896785, 13413, 39363, 165214, 325712, 353083),
(89,4.05, 1080809, 18774, 48940, 204651, 398344, 410100),
(90,4.04, 2210713, 36010, 128149, 436450, 728949, 881155),
(91,3.99, 881765, 16426, 45788, 187203, 309895, 322453),
(92,4.37, 1083177, 7978, 20911, 115002, 357887, 581399),
(93,4.44, 672498, 3982, 12192, 65473, 191281, 399570),
(94,3.91, 1274918, 44761, 84450, 253560, 453328, 438819),
(95,4.21, 2022894, 25914, 68179, 319300, 641395, 968106),
(96,4.47, 6554842, 107541, 129841, 565727, 1507374, 4244359),
(97,4.07, 682305, 12664, 27124, 130479, 243538, 268500),
(98,3.84, 862713, 48334, 69480, 173084, 252184, 319631),
(99,4.5, 2347062, 12391, 36906, 211027, 601936, 1484802),
(100,4.25, 1856227, 25994, 60676, 274534, 565437, 930586);



INSERT INTO epoki(id_epoki, nazwa_epoki, poczatek_epoki, koniec_epoki)
values
(1, "sredniowiecze",476, 1492),
(2, "renesans", 1493, 1520),
(3, "barok", 1521, 1680),
(4, "oswiecenie", 1681, 1789),
(5, "romantyzm", 1790, 1850),
(6, "pozytywizm", 1851, 1880),
(7, "modernizm", 1881, 1918),
(8, "20-lecie miedzywojenne", 1919, 1939),
(9, "wspolczesnosc", 1940,2050);

select * from epoki;

select * from logowanie;
insert INTO logowanie(haslo, id_klient)
values
('HidhHn', 1);

('OneUngf', 2),
('llRwwvO', 3),
('Lobwt0Rya', 4),
('O99BoEg', 5),
('PPPojsyh', 6),
('Abcd123',  7),
('OllllWE', 8),
('XYZabc', 9),
('kotkipieski', 10),
('12345', 11),
('WoneuyEbb', 12),
('Trudnehaslo', 13),
('Maslo', 14),
('DMmoQfbL', 15),
('00000', 16),
('JedenDwaTrzy', 17),
('OqyBfr', 18),
('QUinBFD', 19),
('AsDfGhJkL', 20),
('ABCDEFG', 21),
('FvbbbbEW', 22),
('IiIiIiIi', 23),
('0101010', 24),
('SuLprfbE', 25);


INSERT INTO status_dostawy (status)
VALUES 
    ('przyjete'),
    ('wyslane'),
    ('dostarczone');
   
INSERT INTO klienci(imie, nazwisko, email)
values
('Jan', 'Kowalski', 'JanKowalski@gmail.com'),
('Adam', 'Nowak', 'AdamNowak@onet.pl'),
('Anna', 'Kowalska', 'AnnaKowalska@wp.pl'),
('Magdalena', 'Nowak', 'MagdalenaNowak@o2.pl'),
('Jadwiga', 'Grabowska', 'JadziaGrabowska@gmail.com'),
('Barbara', 'Ryba', 'BarbaraRyba@gmail.com'),
('Amadei',	'Kozlowski', 'AmadeiKozlowski@onet.pl'),
('Gabrys', 'Wysocki', 'GabrysWysocki@wp.pl'),
('Tekla', 'Pawlak', 'TeklaPawlak@gmail.com'),
('Kinga', 'Grabowska', 'KingaGrabowska@tlen.pl'),
('Kornelia', 'Kalinowska', 'KorneliaKalinowska@gmail.com'),
('Lucyna', 'Krol', 'LucynaKrol@o2.pl'),
('Marek', 'Wisniewski', 'MarekWisniewski@onet.pl'),
('Weronika', 'Kalinowska', 'WeronikaKalinowska@onet.pl'),
('Danuta', 'Dudek', 'DanutaDudek@gamil.com'),
('Mikolaj', 'Dabrowski', 'MikolajDabrowski@gmail.com'),
('Jaroslawa', 'Wojciechowska', 'JaroslawaWojciechowska@wp.pl'),
('Lidia', 'Czarnecka', 'LidiaCzarnecka@gmail.com'),
('Tymoteusz', 'Kowalczyk', 'TymoteuszKowalczyk@tlen.pl'),
('Dariusz', 'Majewski', 'DariuszMajewski@wp.pl'),
('Krzys', 'Walczak', 'KrzysWalczak@wp.pl'),
('Kazia', 'Chmielewska', 'KaziaChmielewska@gmail.com'),
('Radzimierz', 'Kalinowski', 'RadzimierzKalinowski@wp.pl'),
('Slawomira', 'Kowalska', 'SlawomiraKowalska@tlen.pl'),
('Emeryk', 'Wisniewski', 'EmerykWisniewski@onet.pl');

select * from klienci;
select * from ceny;

insert into ceny(id_ksiazki,cena)
values
(1,25.99),
(2,34.99),
(3,54.99),
(4,23.99),
(5,66.99),
(6,45.99),
(7,87.99),
(8,43.99),
(9,45.98),
(10,34.89),
(11,22.99),
(12,24.79),
(13,56.99),
(14,43.89),
(15,24.99),
(16,26.99),
(17,95.99),
(18,65.99),
(19,55.99),
(20,74.99),
(21, 58.99),
(22,93.99),
(23,37.99),
(24,82.99),
(25,55.89),
(26, 33.99),
(27, 22.69),
(28,27.99),
(29,99.99),
(30,50.99),
(31,66.69),
(32,77.99),
(33,46.99),
(34,53.99),
(35, 83.99),
(36, 36.99),
(37,54.09),
(38,32.99),
(39,67.99),
(40,60.99),
(41,29.99),
(42,78.99),
(43,93.69),
(44,25.97),
(45,32.59),
(46, 75.99),
(47, 37.97),
(48,46.98),
(49,18.99),
(50, 55.19),
(51, 67.29),
(52, 67.21),
(53, 34.33),
(54, 36.98),
(55, 32.45),
(56, 47.23),
(57, 28.12),
(58, 99.56),
(59, 54.98),
(60, 43.39),
(61, 72.98),
(62, 45.87),
(63, 42.90),
(64, 54.89),
(65, 56.23),
(66, 34.56),
(67, 56.12),
(68, 54.78),
(69, 49.00),
(70, 31.56),
(71, 22.56),
(72, 34.69),
(73, 32.67),
(74, 66.19),
(75, 23.78),
(76, 55.94),
(77, 34.65),
(78, 26.65),
(79, 12.44),
(80, 18.75),
(81, 23.49),
(82, 12.99),
(83, 7.21),
(84, 14.33),
(85, 31.58),
(86, 21.15),
(87, 47.83),
(88, 28.02),
(89, 17.56),
(90, 51.28),
(91, 33.79),
(92, 43.95),
(93, 67.83),
(94, 12.91),
(95, 51.87),
(96, 11.21),
(97, 45.59),
(98, 27.12),
(99, 29.71),
(100, 39.34);

select * from zamowienia;
INSERT INTO zamowienia(id_klient, id_status)
values
(1,1),
(2,1),
(5,3),
(7,1),
(1,2),
(3,3),
(10,2),
(16,1),
(20,2),
(5,2),
(1,3);


INSERT INTO koszyk(id_zamowienia, id_ksiazki, tytul, cena)
values
(1, 29, 'Fifty Shades Darker', 99.99),
(1, 31, 'Fifty Shades Freed', 66.99),
(1, 52, 'Fifty Shades of Grey', 67.21),
(2, 61, 'The Adventures of Huckleberry Finn', 72.98),
(3, 4, 'Harry Potter and the Half-Blood Prince', 23.99),
(3, 47, 'Harry Potter and the Goblet of Fire', 37.99),
(3, 60, 'Harry Potter and the Prisoner of Azkaban', 43.89),
(3, 73, 'Harry Potter and the Chamber of Secrets', 32.67),
(3, 96, "Harry Potter and the Sorcerer's Stone", 11.21),
(3, 99, "Harry Potter and the Order of the Phoenix", 29.71),
(4, 74, 'Sense and Sensibility', 66.99),
(4, 3, 'An Excellent conceited Tragedie of Romeo and Juliet', 54.99),
(5, 17, 'The Glass Castle', 95.99),
(5, 76, 'Looking for Alaska', 55.99),
(6, 4, 'Harry Potter and the Half-Blood Prince', 23.99),
(6, 47, 'Harry Potter and the Goblet of Fire', 37.99),
(7, 16, 'The Fellowship of the Ring', 26.99),
(7, 67, 'The Return of the King', 56.12),
(7, 93, 'The Two Towers', 67.83),
(8, 30, 'Metro 2033', 50.99),
(8, 90, 'Mockingjay', 51.28),
(9, 49, '1984', 18.99),
(9, 25, 'Animal Farm', 55.99),
(10, 69, 'Harry Potter and the Deathly Hallows', 49.00),
(11, 87, 'Little Women', 47.83);

select * from magazyn;
INSERT INTO magazyn(id_ksiazki, stan_magazynowy, hurtownia, data_aktualizacji)
values
(1,	29,	1, '2024-01-24'),
(2,	92,	0,'2024-01-24'),
(3,	4,	0,'2024-01-24'),
(4,	36,	0,'2024-01-24'),
(5,	98,	1,'2024-01-24'),
(6,	70,	0,'2024-01-24'),
(7,	69,	0,'2024-01-24'),
(8,	18,	0,'2024-01-24'),
(9,	51,	0,'2024-01-24'),
(10, 82, 1,'2024-01-24'),
(11, 19, 0,'2024-01-24'),
(12, 10, 0,'2024-01-24'),
(13, 98, 0,'2024-01-24'),
(14, 25, 0,'2024-01-24'),
(15, 36, 1,'2024-01-24'),
(16, 62, 1,'2024-01-24'),
(17, 37, 1,'2024-01-24'),
(18, 44, 1,'2024-01-24'),
(19, 66, 0,'2024-01-24'),
(20, 97, 0,'2024-01-24'),
(21, 56, 0,'2024-01-24'),
(22, 38, 0,'2024-01-24'),
(23, 9, 1,'2024-01-24'),
(24, 26, 0,'2024-01-24'),
(25, 51, 1,'2024-01-24'),
(26, 17, 0,'2024-01-24'),
(27, 7,	0,'2024-01-24'),
(28, 84, 0,'2024-01-24'),
(29, 37, 1,'2024-01-24'),
(30, 13, 0,'2024-01-24'),
(31, 13, 1,'2024-01-24'),
(32, 45, 1,'2024-01-24'),
(33, 84, 0,'2024-01-24'),
(34, 49, 0,'2024-01-24'),
(35, 72, 0,'2024-01-24'),
(36, 76, 1,'2024-01-24'),
(37, 14, 1,'2024-01-24'),
(38, 34, 1,'2024-01-24'),
(39, 82, 0,'2024-01-24'),
(40, 46, 1,'2024-01-24'),
(41, 91, 1,'2024-01-24'),
(42, 69, 0,'2024-01-24'),
(43, 17, 0,'2024-01-24'),
(44, 88, 1,'2024-01-24'),
(45, 37, 0,'2024-01-24'),
(46, 12, 1,'2024-01-24'),
(47, 45, 1,'2024-01-24'),
(48, 1,	0,'2024-01-24'),
(49, 32, 0,'2024-01-24'),
(50, 29, 1,'2024-01-24'),
(51, 62, 0,'2024-01-24'),
(52, 69, 1,'2024-01-24'),
(53, 18, 0,'2024-01-24'),
(54, 3,	0,'2024-01-24'),
(55, 65, 1,'2024-01-24'),
(56, 3,	1,'2024-01-24'),
(57, 93, 1,'2024-01-24'),
(58, 30, 0,'2024-01-24'),
(59, 45, 1,'2024-01-24'),
(60, 62, 1,'2024-01-24'),
(61, 40, 1,'2024-01-24'),
(62, 7,	1,'2024-01-24'),
(63, 99, 1,'2024-01-24'),
(64, 46, 0,'2024-01-24'),
(65, 9,	1,'2024-01-24'),
(66, 92, 1,'2024-01-24'),
(67, 28, 0,'2024-01-24'),
(68, 45, 0,'2024-01-24'),
(69, 20, 1,'2024-01-24'),
(70, 50, 1,'2024-01-24'),
(71, 13, 0,'2024-01-24'),
(72, 77, 1,'2024-01-24'),
(73, 73, 0,'2024-01-24'),
(74, 94, 0,'2024-01-24'),
(75, 74, 0,'2024-01-24'),
(76, 94, 1,'2024-01-24'),
(77, 79, 0,'2024-01-24'),
(78, 13, 0,'2024-01-24'),
(79, 89, 1,'2024-01-24'),
(80, 74, 1,'2024-01-24'),
(81, 10, 0,'2024-01-24'),
(82, 79, 1,'2024-01-24'),
(83, 95, 0,'2024-01-24'),
(84, 90, 0,'2024-01-24'),
(85, 44, 1,'2024-01-24'),
(86, 8,	0,'2024-01-24'),
(87, 80, 0,'2024-01-24'),
(88, 1,	0,'2024-01-24'),
(89, 62, 1,'2024-01-24'),
(90, 68, 1,'2024-01-24'),
(91, 49, 1,'2024-01-24'),
(92, 7,	1,'2024-01-24'),
(93, 37, 1,'2024-01-24'),
(94, 6,	1,'2024-01-24'),
(95, 17, 1,'2024-01-24'),
(96, 90, 0,'2024-01-24'),
(97, 25, 1,'2024-01-24'),
(98, 79, 0,'2024-01-24'),
(99, 13, 1,'2024-01-24'),
(100, 14, 1,'2024-01-24');





select * from zamowienia;
select * from klienci_kurier;
INSERT INTO klienci_kurier(id_klient, id_zamowienia,adres_ulica, adres_numer_domu_mieszkania, adres_miasto, adres_kod, telefon, id_status)
values
(1,1,'Warszawska', '11', 'Krakow', '35-425', '626873987',1),
(2,2,'Obozna 57', 'Warszawa', '44-216', '754685367',1),
(3,6,'Fiolkowa', '55', 'Krakow', '35-425', '886789564',3),
(5,3,'Objazdowa', '40', 'Lodz', '94-025', '605102834',3),
(7,4,'Lisa', '114', 'Warszawa', '01-512', '679069619',1),
(1,5,'Warszawska', '11', 'Krakow', '35-425', '626873987',2),
(10,7,'Dajwor', '33', 'Krakow', '31-052', '783999913',2),
(16,8,'Dobra', '34/7', 'Raciborz', '47-404', '609974161',1),
(5,10,'Objazdowa', '40', 'Lodz', '94-025', '605102834',2),
(20,9,'Warynskiego Ludwika', '19', 'Warszawa', '00-636', '789678248',2),
(1,11,'Warszawska', '11', 'Krakow', '35-425', '626873987',3);




-- podstawowe selecty z joinami


SELECT 
    zamowienia.id_zamowienia,
    COUNT(*) AS ile_ksiazek
FROM koszyk
JOIN zamowienia ON koszyk.id_zamowienia = zamowienia.id_zamowienia
JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
GROUP BY zamowienia.id_zamowienia;



SELECT
    tytul AS "tytuł",
    ocena
FROM ksiazki_info
JOIN ksiazki_oceny ON ksiazki_info.id_ksiazki = ksiazki_oceny.id_ksiazki
ORDER BY ocena DESC
LIMIT 10;



SELECT
    tytul,
    magazyn.stan_magazynowy
FROM ksiazki_info
LEFT JOIN magazyn ON magazyn.id_ksiazki = ksiazki_info.id_ksiazki
WHERE magazyn.hurtownia = 0
ORDER BY magazyn.stan_magazynowy;


SELECT 
    klienci.imie,
    klienci.nazwisko,
    ksiazki_info.tytul
FROM 
    klienci
JOIN 
    zamowienia ON klienci.id_klient = zamowienia.id_klient
JOIN 
    koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
JOIN 
    ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki;


SELECT 
    zamowienia.id_zamowienia,
    klienci_kurier.adres_ulica,
    klienci_kurier.adres_numer_domu_mieszkania,
    klienci_kurier.adres_miasto,
    klienci_kurier.adres_kod
FROM 
    zamowienia 
LEFT JOIN 
    klienci_kurier ON zamowienia.id_klient = klienci_kurier.id_klient;
   
   


SELECT 
    ksiazki_info.tytul,
    COUNT(*) AS sprzedane,
    CASE
        WHEN magazyn.hurtownia = 0 THEN 'brak w hurtowni'
        ELSE 'dostępny w hurtowni'
    END AS dostepnosc
FROM koszyk
LEFT JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
LEFT JOIN magazyn ON ksiazki_info.id_ksiazki = magazyn.id_ksiazki
GROUP BY ksiazki_info.id_ksiazki
ORDER BY 2;






-- triggery

create or replace trigger aktualizacja_magazynu before insert on koszyk
for each row begin 
	update magazyn
		set stan_magazynowy = stan_magazynowy -1
		where magazyn.id_ksiazki = new.id_ksiazki;
end;



CREATE OR REPLACE TRIGGER tworzenie_loginu
BEFORE INSERT ON logowanie
FOR EACH ROW 
BEGIN 
    SET NEW.login = CONCAT(
        LOWER((SELECT imie FROM klienci WHERE id_klient = NEW.id_klient)),
        '.',
        LOWER((SELECT nazwisko FROM klienci WHERE id_klient = NEW.id_klient)),
        NEW.id_logowanie
    );
END;

CREATE OR REPLACE TRIGGER dodaj_epoke
BEFORE INSERT ON ksiazki_info
FOR EACH ROW
BEGIN
    SET NEW.epoka = (
        SELECT nazwa_epoki
        FROM epoki
        WHERE NEW.rok_wydania BETWEEN poczatek_epoki AND koniec_epoki
    );
END;







-- funckje 

CREATE or replace FUNCTION przelicz_klientow(n varchar(80))
RETURNS int(11)
BEGIN
declare ile int;
select count(*) into ile from klienci where nazwisko like
concat('%',n,'%');
RETURN ile;
END;

select przelicz_klientow('kowalski');

SHOW function status;


CREATE or replace FUNCTION przelicz_rok_wydania(m int)
RETURNS int(11)
BEGIN
declare ile int;
select count(*) into ile from ksiazki_info where rok_wydania like
concat('%',m,'%');
RETURN ile;
END;


select przelicz_rok_wydania(2012);


CREATE or replace FUNCTION srednia_ocena_ksiazki(ksiazka_id INT)
RETURNS FLOAT
BEGIN
    DECLARE srednia_ocena FLOAT;

    SELECT AVG(ocena) INTO srednia_ocena
    FROM ksiazki_oceny
    WHERE id_ksiazki = ksiazka_id;

    RETURN COALESCE(srednia_ocena, 0); -- Jeżeli nie ma ocen, zwraca 0
end;

select srednia_ocena_ksiazki(2);


-- procedury
CREATE or replace PROCEDURE wyswietl_klientow (IN k varchar(80), 
OUT ile int)
BEGIN
select imie, nazwisko from klienci where nazwisko = k;
set ile = FOUND_ROWS();
end;

call wyswietl_klientow('Kowalski', @ile);


CREATE or replace PROCEDURE nieaktywni_klienci()
BEGIN
    SELECT
        DISTINCT klienci.id_klient,
        klienci.email
    FROM klienci
    LEFT JOIN zamowienia ON klienci.id_klient = zamowienia.id_klient
    WHERE zamowienia.data_zamowienia IS NULL OR zamowienia.data_zamowienia < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
end;

CALL nieaktywni_klienci();


CREATE or replace PROCEDURE znizka()
BEGIN
    SELECT
        klienci.id_klient,
        klienci.email,
        CASE
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul LIKE "%Harry Potter%") THEN "Wróć do Hogwartu!!"
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul NOT LIKE "%Harry Potter%") THEN "Dołącz do uczniów Hogwartu i odkryj fascynujący świat czarów i magii"
            ELSE "Witaj mugolu!"
        END AS tresc_wiadomosci,
        CASE
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul LIKE "%Harry Potter%") THEN "BACKTOHARRY"
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul NOT LIKE "%Harry Potter%") THEN "DISCOVERHARRY"
            ELSE "FIRSTTIME"
        END AS kupon,
        CASE
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul LIKE "%Harry Potter%") THEN "10%"
            WHEN EXISTS (SELECT 1 FROM zamowienia
                         JOIN koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
                         JOIN ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
                         WHERE klienci.id_klient = zamowienia.id_klient
                           AND ksiazki_info.tytul NOT LIKE "%Harry Potter%") THEN "15%"
            ELSE "25%"
        END AS przyslugujaca_znizka
    FROM klienci;
end;



CALL znizka();


show triggers;


SHOW PROCEDURE STATUS;


-- widoki

CREATE or replace VIEW vhistoria_zamowien AS
SELECT 
    zamowienia.id_zamowienia,
    zamowienia.data_zamowienia,
    klienci.imie,
    klienci.nazwisko,
    ksiazki_info.tytul AS tytul_ksiazki,
    status_dostawy.status AS status_zamowienia
FROM 
    zamowienia 
JOIN 
    koszyk ON zamowienia.id_zamowienia = koszyk.id_zamowienia
JOIN 
    ksiazki_info ON koszyk.id_ksiazki = ksiazki_info.id_ksiazki
JOIN 
    status_dostawy ON zamowienia.id_status = status_dostawy.id_status
JOIN 
    klienci ON zamowienia.id_klient = klienci.id_klient;


 SELECT * FROM vhistoria_zamowien;
	


CREATE or replace VIEW vtop_klientow AS
SELECT 
    klienci.id_klient,
    klienci.imie,
    klienci.nazwisko,
    COUNT(zamowienia.id_zamowienia) AS liczba_zamowien
FROM 
    klienci 
LEFT JOIN 
    zamowienia ON klienci.id_klient = zamowienia.id_klient
GROUP BY 
    klienci.id_klient
ORDER BY 
    liczba_zamowien DESC
LIMIT 10;

SELECT * FROM vtop_klientow;


create or replace VIEW vdostepne_ksiazki AS
SELECT 
    ksiazki_info.id_ksiazki,
    ksiazki_info.tytul,
    magazyn.stan_magazynowy
FROM 
    ksiazki_info
LEFT JOIN 
    magazyn ON ksiazki_info.id_ksiazki = magazyn.id_ksiazki
WHERE 
    magazyn.hurtownia = 0 AND magazyn.stan_magazynowy > 0;
	
   
 select * from vdostepne_ksiazki;



   
-- indeksowanie
   
 CREATE INDEX idx_tytul ON ksiazki_info (tytul);

SELECT * FROM ksiazki_info WHERE tytul = 'Harry Potter';

CREATE INDEX idx_ocena ON ksiazki_oceny (ocena);

SELECT * FROM ksiazki_oceny WHERE ocena = 5.1;




