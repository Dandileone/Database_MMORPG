USE mmorpg_Bang
GO


INSERT INTO Player(Nickname, Firstname, LastName, Patronymic, Email, DateOfBirth)
VALUES
('Hronos', 'Chris', '', '', 'hronos@gmail.com','1991-01-01'),
('Zeus', 'Alexandr', 'Sidorov', 'Ivanovich', 'zeus@mail.ru','1992-02-02'),
('Aid', 'Kevin', 'Lewis', '', 'aid@gmail.com','1993-03-03'),
('Afina', 'Kate', 'Miller', '', 'afina@gmail.com','1994-04-04'),
('Demetra', 'Anna', 'Ivanovna', 'Petrovna', 'demetra@mail.ru','1995-05-05'),
('Persei', 'Michael', 'Fischer ', '', 'persei@gmail.com','1996-06-06'),
('Achelous', 'Lewis', '', '', 'achelos@gmail.com','1991-01-01'),
('Ares', 'Tom', 'Marshal', '', 'ares@mail.ru','1992-02-02'),
('Hades', 'Lars', 'Malkov', '', 'hades@gmail.com','1993-03-03'),
('Hermes', 'Nick', 'Nilmar', '', 'harmes@gmail.com','1994-04-04'),
('Aphrodite', 'Kate', 'Klinova', 'Ivanovna', 'aphrodite@mail.ru','1995-05-05'),
('Hera', 'Lima', 'Tomasheva', '', 'hera@gmail.com','1996-06-06')



INSERT INTO Server(IP, Type, Loading)
VALUES
('192.168.0.1', 'PVP', 10),
('192.168.0.2', 'PVE', 20),
('192.168.0.3', 'RP', 30),
('192.168.0.4', 'PVP', 40),
('192.168.0.5', 'PVE', 50),
('192.168.0.6', 'RP', 60)


INSERT INTO Player_on_Server(Nickname, IP, Date_login)
VALUES
('Hronos','192.168.0.1', '2017-01-11 11:11:11.000'),
('Zeus','192.168.0.2', '2017-01-11 11:12:11.000'),
('Aid','192.168.0.3', '2017-01-11 11:13:11.000'),
('Afina','192.168.0.4', '2017-01-11 11:14:11.000'),
('Demetra','192.168.0.5', '2017-01-11 11:15:11.000'),
('Persei','192.168.0.6', '2017-01-11 11:16:11.000'),
('Achelous','192.168.0.1', '2017-01-11 11:11:11.000'),
('Ares','192.168.0.2', '2017-01-11 11:12:11.000'),
('Hades','192.168.0.3', '2017-01-11 11:13:11.000'),
('Hermes','192.168.0.4', '2017-01-11 11:14:11.000'),
('Aphrodite','192.168.0.5', '2017-01-11 11:15:11.000'),
('Hera','192.168.0.6', '2017-01-11 11:16:11.000')



INSERT INTO TFraction(Fraction, Desc_Frac)
VALUES
('Alliance', 'Alliance are enemies to the Horde'),
('Horde', 'Horde are enemies to the Alliance')


INSERT INTO TRace(Fraction, Race, Desc_Race_Frac)
VALUES
('Alliance','Human','Human history ...'),
('Alliance','Night Elf','Night Elf history ...'),
('Alliance','Gnome','Gnome history ...'),
('Alliance','Draenei','Draenei history ...'),
('Horde','Orc','Orc history ...'),
('Horde','Blood Elf','Blood Elf history ...'),
('Horde','Troll','Troll history ...'),
('Horde','Undead','Undead history ...')


INSERT INTO TClass(Class, Desc_class)
VALUES
('Warrion', 'Warrion can be Tank and Damager'),
('Paladin', 'Paladin can be Tank and Damager'),
('Shaman', 'Shaman can be Healer and Damager'),
('Priest', 'Priest can be Healer and Damager'),
('Druid', 'Druid can be Tank and Healer'),
('Monk', 'Monk can be Tank and Healer')


INSERT INTO Class_Race(Class, ID_race_frac)
VALUES
('Warrion', 1),
('Paladin', 1),
('Priest', 1),
('Monk', 1),
('Warrion', 2),
('Priest', 2),
('Druid', 2),
('Monk', 2),
('Warrion', 3),
('Paladin', 3),
('Shaman', 3),
('Priest', 3),
('Warrion', 4),
('Paladin', 4),
('Shaman', 4),
('Druid', 4),
('Warrion', 5),
('Paladin', 5),
('Shaman', 5),
('Monk', 5),
('Warrion', 6),
('Paladin', 6),
('Priest', 6),
('Druid', 6),
('Warrion', 7),
('Shaman', 7),
('Priest', 7),
('Druid', 7),
('Warrion', 8),
('Paladin', 8),
('Priest', 8),
('Monk', 8)


INSERT INTO TRole(Role, Desc_Role)
VALUES
('Tank', 'The one who takes damage'),
('Damager', 'The one who deals damage'),
('Healer', 'The who heals the damage')


INSERT INTO Role_class(Class, Role)
VALUES
('Warrion', 'Tank'),
('Warrion', 'Damager'),
('Paladin', 'Tank'),
('Paladin', 'Damager'),
('Shaman', 'Healer'),
('Shaman', 'Damager'),
('Priest', 'Healer'),
('Priest', 'Damager'),
('Druid', 'Tank'),
('Druid', 'Healer'),
('Monk', 'Tank'),
('Monk', 'Healer')


INSERT INTO TCharacter(IP, Nickname, Fraction, Class, ID_race_frac, Name_char, Level_char,Level_equipment)
VALUES
/*
('192.168.0.5', 'Hronos', 'Alliance', 'Warrion', 1, 'HumWar', 60, 600 ),
('192.168.0.5', 'Hronos', 'Alliance', 'Shaman', 4, 'DreanSham', 60, 600 ),
('192.168.0.5', 'Hronos', 'Horde', 'Warrion', 6, 'OrcWar', 60, 600 ),
('192.168.0.6', 'Hronos', 'Horde', 'Priest', 8, 'UndPriest', 60, 600 ),
('192.168.0.5', 'Zeus', 'Alliance', 'Paladin', 1, 'HumPall', 60, 600 ),*/

('192.168.0.6', 'Afina', 'Alliance', 'Shaman', 4, 'AfiDrenSham', 60, 600 ),
('192.168.0.6', 'Aid', 'Alliance', 'Priest', 3, 'AidGnomPriest', 60, 600 ),
('192.168.0.6', 'Demetra', 'Alliance', 'Shaman', 4, 'DemDrenSham', 60, 600 ),
('192.168.0.6', 'Persei', 'Alliance', 'Priest', 2, 'PerElfPriest', 60, 600 ),
('192.168.0.6', 'Zeus', 'Alliance', 'Paladin', 1, 'ZeusHumPal', 60, 600 ),

('192.168.0.6', 'Afina', 'Alliance', 'Monk', 2, 'AfiElfMonk6', 60, 600 ),
('192.168.0.6', 'Aid', 'Alliance', 'Shaman', 4, 'AidElfSham6', 60, 600 ),
('192.168.0.6', 'Demetra', 'Alliance', 'Priest', 1, 'DemHumPriest6', 60, 600 ),
('192.168.0.6', 'Persei', 'Alliance', 'Warrion', 3, 'PerGnomWar6', 60, 600 ),
('192.168.0.6', 'Hronos', 'Alliance', 'Druid', 2, 'HronElfDru6', 60, 600 ),


('192.168.0.5', 'Afina', 'Alliance', 'Shaman', 4, 'AfiDrenSham5', 60, 600 ),
('192.168.0.5', 'Aid', 'Alliance', 'Priest', 3, 'AidGnomPriest5', 60, 600 ),
('192.168.0.5', 'Demetra', 'Alliance', 'Shaman', 4, 'DemDrenSham5', 60, 600 ),
('192.168.0.5', 'Persei', 'Alliance', 'Priest', 2, 'PerElfPriest5', 60, 600 ),
('192.168.0.5', 'Zeus', 'Alliance', 'Paladin', 1, 'ZeusHumPal5', 60, 600 ),

('192.168.0.5', 'Afina', 'Alliance', 'Monk', 2, 'AfiElfMonk5', 60, 600 ),
('192.168.0.5', 'Aid', 'Alliance', 'Shaman', 4, 'AidElfSham5', 60, 600 ),
('192.168.0.5', 'Demetra', 'Alliance', 'Priest', 1, 'DemHumPriest5', 60, 600 ),
('192.168.0.5', 'Persei', 'Alliance', 'Warrion', 3, 'PerGnomWar5', 60, 600 ),
('192.168.0.5', 'Hronos', 'Alliance', 'Druid', 2, 'HronElfDru5', 60, 600 ),


('192.168.0.2', 'Afina', 'Alliance', 'Shaman', 4, 'AfiDrenSham2', 60, 600 ),
('192.168.0.2', 'Aid', 'Alliance', 'Priest', 3, 'AidGnomPriest2', 60, 600 ),
('192.168.0.2', 'Demetra', 'Alliance', 'Shaman', 4, 'DemDrenSham2', 60, 600 ),
('192.168.0.2', 'Persei', 'Alliance', 'Priest', 2, 'PerElfPriest2', 60, 600 ),
('192.168.0.2', 'Zeus', 'Alliance', 'Paladin', 1, 'ZeusHumPal2', 60, 600 ),

('192.168.0.2', 'Afina', 'Alliance', 'Monk', 2, 'AfiElfMonk2', 60, 600 ),
('192.168.0.2', 'Aid', 'Alliance', 'Shaman', 4, 'AidElfSham2', 60, 600 ),
('192.168.0.2', 'Demetra', 'Alliance', 'Priest', 1, 'DemHumPriest2', 60, 600 ),
('192.168.0.2', 'Persei', 'Alliance', 'Warrion', 3, 'PerGnomWar2', 60, 600 ),
('192.168.0.2', 'Hronos', 'Alliance', 'Druid', 2, 'HronElfDru2', 60, 600 ),



('192.168.0.6', 'Achelous', 'Horde', 'Shaman', 7, 'AchelTrollSham6', 60, 600 ),
('192.168.0.6', 'Ares', 'Horde', 'Paladin', 5, 'AresOrcPal6', 60, 600 ),
('192.168.0.6', 'Aphrodite', 'Horde', 'Priest', 6, 'AphrBlElfPriest6', 60, 600 ),
('192.168.0.6', 'Hermes', 'Horde', 'Shaman', 5, 'HermOrcSham6', 60, 600 ),
('192.168.0.6', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest6', 60, 600 ),

('192.168.0.6', 'Achelous', 'Horde', 'Warrion', 5, 'AchelOrcWar6', 60, 600 ),
('192.168.0.6', 'Ares', 'Horde', 'Shaman', 7, 'AresUndSham6', 60, 600 ),
('192.168.0.6', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest6', 60, 600 ),
('192.168.0.6', 'Hermes', 'Horde', 'Monk', 8, 'HermUndMonk6', 60, 600 ),
('192.168.0.6', 'Hera', 'Horde', 'Druid', 6, 'HeraBlElfDru6', 60, 600 ),


('192.168.0.5', 'Achelous', 'Horde', 'Shaman', 7, 'AchelTrollSham5', 60, 600 ),
('192.168.0.5', 'Ares', 'Horde', 'Paladin', 5, 'AresOrcPal5', 60, 600 ),
('192.168.0.5', 'Aphrodite', 'Horde', 'Priest', 6, 'AphrBlElfPriest5', 60, 600 ),
('192.168.0.5', 'Hermes', 'Horde', 'Shaman', 5, 'HermOrcSham5', 60, 600 ),
('192.168.0.5', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest5', 60, 600 ),

('192.168.0.5', 'Achelous', 'Horde', 'Warrion', 5, 'AchelOrcWar5', 60, 600 ),
('192.168.0.5', 'Ares', 'Horde', 'Shaman', 7, 'AresUndSham5', 60, 600 ),
('192.168.0.5', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest5', 60, 600 ),
('192.168.0.5', 'Hermes', 'Horde', 'Monk', 8, 'HermUndMonk5', 60, 600 ),
('192.168.0.5', 'Hera', 'Horde', 'Druid', 6, 'HeraBlElfDru5', 60, 600 ),



('192.168.0.2', 'Achelous', 'Horde', 'Shaman', 7, 'AchelTrollSham2', 60, 600 ),
('192.168.0.2', 'Ares', 'Horde', 'Paladin', 5, 'AresOrcPal2', 60, 600 ),
('192.168.0.2', 'Aphrodite', 'Horde', 'Priest', 6, 'AphrBlElfPriest2', 60, 600 ),
('192.168.0.2', 'Hermes', 'Horde', 'Shaman', 5, 'HermOrcSham2', 60, 600 ),
('192.168.0.2', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest2', 60, 600 ),

('192.168.0.2', 'Achelous', 'Horde', 'Warrion', 5, 'AchelOrcWar2', 60, 600 ),
('192.168.0.2', 'Ares', 'Horde', 'Shaman', 7, 'AresUndSham2', 60, 600 ),
('192.168.0.2', 'Hades', 'Horde', 'Priest', 8, 'HadUndPriest2', 60, 600 ),
('192.168.0.2', 'Hermes', 'Horde', 'Monk', 8, 'HermUndMonk2', 60, 600 ),
('192.168.0.2', 'Hera', 'Horde', 'Druid', 6, 'HeraBlElfDru2', 60, 600 )





INSERT INTO Raid_list(Name_raid, Level_raid, Min_level_char, Min_level_equipment, Max_count_char)
VALUES
('Frozen Citadel', 'Normal', 60, 600 ,10),
('Frozen Citadel', 'Heroic', 70, 1200 ,10),
('Frozen Citadel', 'Epos', 80, 2400 ,10)


INSERT INTO Raid_group(Count_chars)
VALUES 
(10),
(10);


INSERT INTO Raid(ID_raid, ID_raid_group, Kill_bosses, Start_progress)
VALUES
(1,1,4,'2017-01-11 11:11:11.000')
(1,2,5,'2017-01-12 12:12:12.000')


INSERT INTO Char_raid_group()
VALUES


INSERT INTO Dungeon_list(Name_dungeon, Level_dungeon)
VALUES
('Gnomeregan','Normal'),
('Wailing Caverns','Normal'),
('Stormwind Stockade','Normal'),
('Uldaman','Heroic'),
('Razorfen Downs','Heroic'),
('Dire Maul','Heroic'),
('Stratholme','Epos'),
('ZulFarrak','Epos'),
('Blackrock Depths','Epos');

INSERT INTO Dungeon_group(Count_chars)
VALUES
(5),
(5),
(5),
(5),
(5),
(5),
(5);


INSERT INTO Dungeon(ID_dungeon, ID_dungeon_group, Progress_dungeon, Start_progress, Finish_progress)
VALUES
--4 записи на одном сервере
(1, 1, 100, '2017-01-01 01:01:00.000', '2017-01-01 01:57:00.000'),
(1, 2, 100, '2017-01-01 01:01:00.000', '2017-01-01 02:28:00.000'),
(3, 1, 50, '2017-02-02 03:03:03.000', '2017-02-02 03:15:00.000'),
(2, 1, 30, '2017-05-05 05:05:00.000', '2017-05-05 05:05:00.000'), --finish должен быть null
--
(6, 6, 100, '2017-13-01 01:01:00.000', '2017-13-01 01:59:00.000'),
(9, 7, 100, '2017-16-01 01:01:00.000', '2017-16-01 02:21:00.000'),
--
--4 записи на одном сервере
(4, 3, 100, '2017-06-06 18:30:12.000', '2017-06-06 21:20:00.000'),
(5, 4, 100, '2017-06-06 19:45:10.000', '2017-06-06 23:30:11.000'),
(6, 3, 50, '2017-03-03 10:10:12.000', '2017-03-03 13:11:11.000'),
(7, 4, 100, '2017-07-07 16:40:15.000', '2017-07-07 20:57:11.000'),
--2 записи на одном сервере
(8, 5, 100, '2017-03-03 14:35:40.000', '2017-03-03 15:00:11.000'),
(9, 5, 30, '2017-11-11 11:11:11.000', '2017-11-11 11:11:11.000');--finish должен быть null


INSERT INTO Char_dungeon_group(ID_char, ID_dungeon_group, Damaged, Taken_damage, Heal)
VALUES
--две группы для одного сервера
( 1, 1, 0, 0, 0 ),
( 2, 1, 0, 0, 0 ),
( 3, 1, 0, 0, 0 ),
( 5, 1, 0, 0, 0 ),
( 6, 1, 0, 0, 0 ),

( 4, 2, 0, 0, 0 ),
( 7, 2, 0, 0, 0 ),
( 8, 2, 0, 0, 0 ),
( 9, 2, 0, 0, 0 ),
( 10, 2, 0, 0, 0 ),

--две группы для одного сервера
( 14, 3, 0, 0, 0 ),
( 17, 3, 0, 0, 0 ),
( 18, 3, 0, 0, 0 ),
( 19, 3, 0, 0, 0 ),
( 20, 3, 0, 0, 0 ),

( 11, 4, 0, 0, 0 ),
( 12, 4, 0, 0, 0 ),
( 13, 4, 0, 0, 0 ),
( 15, 4, 0, 0, 0 ),
( 16, 4, 0, 0, 0 ),

--группа для одного сервера
( 21, 5, 0, 0, 0 ),
( 22, 5, 0, 0, 0 ),
( 23, 5, 0, 0, 0 ),
( 25, 5, 0, 0, 0 ),
( 26, 5, 0, 0, 0 );

--
( 1, 6, 0, 0, 0 ),
( 2, 6, 0, 0, 0 ),
( 7, 6, 0, 0, 0 ),
( 5, 6, 0, 0, 0 ),
( 6, 6, 0, 0, 0 ),

( 4, 7, 0, 0, 0 ),
( 3, 7, 0, 0, 0 ),
( 8, 7, 0, 0, 0 ),
( 9, 7, 0, 0, 0 ),
( 10, 7, 0, 0, 0 );


INSERT INTO Boss(ID_raid, Name_boss, Level_boss)
VALUES
(1, 'Lord Marrowgar', 'Normal'),
(1, 'Lady Deathwhisper', 'Normal'),
(1, 'Deathbringer Saurfang', 'Normal'),
(1, 'Blood-Queen Lanathel', 'Normal'),
(1, 'The Lich King', 'Normal')

INSERT INTO Boss(ID_dungeon, Name_boss, Level_boss)
VALUES
(1, 'Techbot', 'Normal'),
(1, 'Viscous Fallout', 'Normal'),
(1, 'Grubbis', 'Normal'),
(1, 'Electrocutioner 6000', 'Normal'),
(1, 'Mekgineer Thermaplugg', 'Normal'),

(2, 'Lady Anacondra', 'Normal'),
(2, 'Lord Cobrahn', 'Normal'),
(2, 'Kresh', 'Normal'),
(2, 'Lord Pythas', 'Normal'),
(2, 'Skum', 'Normal'),

(3, 'Randolph Moloch', 'Normal'),
(3, 'Lord Overheat', 'Normal'),
(3, 'Hogger', 'Normal'),

(4, 'Revelosh', 'Heroic'),
(4, 'Baelog', 'Heroic'),
(4, 'Ironaya', 'Heroic'),
(4, 'Grimlok', 'Heroic'),
(4, 'Archaedas', 'Heroic'),

(5, 'Roogug', 'Heroic'),
(5, 'Aggem Thorncurse', 'Heroic'),
(5, 'Death Spiker Jargba', 'Heroic'),
(5, 'Agathelos the Raging', 'Heroic'),
(5, 'Charlga Razorflank', 'Heroic'),


(6, 'Zevrim Thornhoof', 'Heroic'),
(6, 'Stomper Kreeg', 'Heroic'),
(6, 'Captain Kromcrush', 'Heroic'),
(6, 'Immolthar', 'Heroic'),


(7, 'The Unforgiven', 'Epos'),
(7, 'Balnazzar', 'Epos'),
(7, 'Nerubenkan', 'Epos'),
(7, 'Lord Aurius Rivendare', 'Epos'),

(8, 'Antusul', 'Epos'),
(8, 'Hydromancer Velratha', 'Epos'),
(8, 'Chief Ukorz Sanscalp', 'Epos'),

(9, 'BaelGar', 'Epos'),
(9, 'Phalanx', 'Epos'),
(9, 'Dark Coffer', 'Epos'),
(9, 'Magmus', 'Epos'),
(9, 'Emperor Dagran Thaurissan', 'Epos'),



INSERT INTO Bf_group(Count_chars)
VALUES 
(5),
(5),
(5),
(5);


INSERT INTO Bf_list (Bf_name)
VALUES
('Warsong Gulch'),
('Arathi Basin'),
('Alterac Valley'),
('Eye of the Storm'),
('Strand of the Ancients'),
('Isle of Conquest'),
('Battle for Gilneas'),
('Twin Peaks');


INSERT INTO Battlefield(Bf_name, ID_bf_group1, ID_bf_group2, Command_win, Start_progress, Finish_progress)
VALUES
( 'Arathi Basin', 1, 2, 1, '2017-01-01 01:01:00.000', '2017-01-01 01:10:00.000'),
( 'Arathi Basin', 3, 4, null, '2017-01-01 01:01:00.000', null),
( 'Arathi Basin', 1, 4, 1, '2017-02-02 02:02:00.000', '2017-02-02 02:05:00.000'),
( 'Warsong Gulch', 1, 2, 2, '2017-11-11 10:01:00.000', '2017-11-11 10:10:00.000'),
( 'Warsong Gulch', 2, 1, 2, '2017-13-11 11:01:00.000', '2017-13-11 11:07:00.000'),
( 'Warsong Gulch', 2, 3, 2, '2017-28-11 11:01:00.000', '2017-28-11 11:10:00.000'),
/*Тест 1. Негативный. Проверяем, что не будет выводиться группа 1. Т.к. она выиграла не подряд на одном и том же поле боя*/
( 'Alterac Valley', 1, 2, 1, '2017-01-11 10:01:00.000', '2017-01-11 10:09:00.000'),
( 'Eye of the Storm', 2, 1, 1, '2017-03-11 10:01:00.000', '2017-01-11 10:05:00.000'),
( 'Alterac Valley', 1, 3, 3, '2017-05-11 11:01:00.000', '2017-05-11 11:10:00.000'),
( 'Alterac Valley', 2, 1, 1, '2017-06-11 21:02:00.000', '2017-06-11 21:07:00.000'),
( 'Alterac Valley', 3, 1, 1, '2017-06-11 13:01:00.000', '2017-06-11 13:08:00.000');




INSERT INTO Char_bf_group(ID_char, ID_bf_group, Damaged, Taken_damage, Heal)
VALUES
--две группы для одного сервера
--Первая пара групп для боя
--Alliance
( 1, 1, 500, 150, 50 ),
( 2, 1, 500, 150, 50 ),
( 3, 1, 500, 150, 50 ),
( 5, 1, 150, 500, 150 ),
( 6, 1, 100, 100, 500 ),
--Horde
( 31, 2, 500, 150, 50 ),
( 32, 2, 150, 500, 150 ),
( 33, 2, 500, 150, 50 ),
( 34, 2, 500, 150, 50 ),
( 39, 2, 100, 100, 500 ),

--Вторая пара групп для боя
--Alliance
( 4, 3, 500, 150, 50 ),
( 7, 3, 500, 150, 50 ),
( 8, 3, 500, 150, 50 ),
( 9, 3, 150, 500, 50 ),
( 10, 3, 100, 100, 500 ),
--Horde
( 35, 4, 500, 150, 50 ),
( 36, 4, 150, 500, 50 ),
( 38, 4, 500, 150, 50 ),
( 37, 4, 500, 150, 50 ),
( 40, 4, 100, 100, 500 );