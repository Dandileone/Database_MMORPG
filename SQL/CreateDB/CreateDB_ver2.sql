use master
go 
drop database mmorpg_Bang  
go 
create database mmorpg_Bang  
go 
use mmorpg_Bang
go 

--Сущность E1
CREATE TABLE Player
(
	Nickname VARCHAR(15) PRIMARY KEY ,
	Firstname VARCHAR(20)  NOT NULL ,
	LastName VARCHAR(25) ,
	Patronymic VARCHAR(25) ,
	Email VARCHAR(50)  NOT NULL UNIQUE,
	DateOfBirth DATE NOT NULL 
)

--Сущность E2
CREATE TABLE Server
(
	IP VARCHAR(20) ,
	Type VARCHAR(20)  NOT NULL CHECK(Type in('PVP','PVE','RP')) ,
	Loading SMALLINT NOT NULL DEFAULT 0 ,
	PRIMARY KEY(IP)
)

--Сущность Е20
CREATE TABLE Player_on_Server
(
	Nickname VARCHAR(15)  NOT NULL FOREIGN KEY REFERENCES Player(Nickname) ,
	IP VARCHAR(20)  NOT NULL FOREIGN KEY REFERENCES Server(IP) ,
	Date_login DATETIME  NOT NULL 
)

--Сущность Е4
CREATE TABLE TFraction
(
	Fraction VARCHAR(10) ,
	Desc_Frac VARCHAR(50) ,
	PRIMARY KEY(Fraction)
)

--Сущность E9
CREATE TABLE TRace
(
	ID_race_frac INTEGER IDENTITY , -- сомневаюсь в необходимости, можно сделать PK Race, т.к. по заданию у каждой фракции по 4 расы.
	Fraction VARCHAR(10)  NOT NULL ,
	Race VARCHAR(20)  NOT NULL ,
	Desc_Race_Frac VARCHAR(50) ,
	PRIMARY KEY(ID_race_frac) ,
	FOREIGN KEY (Fraction) REFERENCES TFraction
)

--Сущность Е10
CREATE TABLE TClass
(
	Class VARCHAR(20) ,
	Desc_class VARCHAR(50) ,
	PRIMARY KEY(Class)
)

--Сущность Е17
CREATE TABLE Class_Race
(
	ID_class_race INTEGER IDENTITY ,
	Class VARCHAR(20)  NOT NULL ,
	ID_race_frac INTEGER  NOT NULL ,
	PRIMARY KEY(ID_class_race) ,
	FOREIGN KEY (Class) REFERENCES TClass ,
	FOREIGN KEY (ID_race_frac) REFERENCES TRace
)

--Сущность Е11
CREATE TABLE TRole
(
	Role VARCHAR(20) ,
	Desc_Role varchar(50) ,
	PRIMARY KEY(Role)
)

--Сущность Е16
CREATE TABLE Role_class
(	
	ID_role_class INTEGER IDENTITY ,
	Class VARCHAR(20)  NOT NULL ,
	Role VARCHAR(20)  NOT NULL ,
	PRIMARY KEY(ID_role_class) ,
	FOREIGN KEY (Class) REFERENCES TClass ,
	FOREIGN KEY (Role) REFERENCES TRole
)

--Сущность Е3
CREATE TABLE TCharacter
(
	ID_char INTEGER IDENTITY ,
	IP VARCHAR(20)  NOT NULL ,
	Nickname VARCHAR(15)  NOT NULL ,
	Fraction VARCHAR(10)  NOT NULL , --возможно в этом атрибуте нет необходимости, т.к. по ID_race_frac мы можем определить Фракцию персонажа
	Class VARCHAR(20)  NOT NULL , 
	ID_race_frac INTEGER  NOT NULL ,
	Name_char VARCHAR(20)  NOT NULL ,
	Level_char INTEGER  NOT NULL DEFAULT 1 ,
	Level_equipment INTEGER  NOT NULL DEFAULT 1 ,
	PRIMARY KEY(ID_char) ,
	FOREIGN KEY (IP) REFERENCES Server ,
	FOREIGN KEY (Nickname) REFERENCES Player ,
	FOREIGN KEY (Fraction) REFERENCES TFraction ,
	FOREIGN KEY (Class) REFERENCES TClass ,
	FOREIGN KEY (ID_race_frac) REFERENCES TRace
)

--Сущность Е13
CREATE TABLE Raid_list
(
	ID_raid INTEGER IDENTITY ,
	Name_raid VARCHAR(25)  NOT NULL ,
	Level_raid VARCHAR(15)  NOT NULL CHECK (Level_raid in('Normal','Heroic','Epos')) ,
	Min_level_char INTEGER  NOT NULL DEFAULT 1 ,
	Min_level_equipment INTEGER  NOT NULL DEFAULT 1 ,
	--добавил параметр ниже для того, чтобы проверять, для какого количества игроков предназначен рейд и не превысило ли их количество
	Max_count_char SMALLINT NOT NULL CHECK(Max_count_char in(10,25)) ,
	PRIMARY KEY(ID_raid)	
)

--Сущность Е18
CREATE TABLE Raid_group
(
	ID_raid_group INTEGER IDENTITY ,
	Count_chars SMALLINT  NOT NULL DEFAULT 0 ,
	PRIMARY KEY(ID_raid_group)
)

--Сущность Е7
CREATE TABLE Raid
(
	ID_raid INTEGER ,
	ID_raid_group INTEGER ,
	Kill_bosses SMALLINT NOT NULL DEFAULT 0 , -- добавил для определения сколько боссов убито, чтобы определить прогресс рейда
	Progress_raid FLOAT  NOT NULL CHECK(Progress_raid BETWEEN 0 AND 100 ) DEFAULT 0 , -- в процентном соотношении будет определять прогресс прохождения
	Start_progress DATETIME  NOT NULL ,
	Finish_progress DATETIME ,
	PRIMARY KEY(ID_raid,ID_raid_group) ,
	FOREIGN KEY (ID_raid) REFERENCES Raid_list ,
	FOREIGN KEY (ID_raid_group) REFERENCES Raid_group
)

--Сущность Е12 персонажи групп рейда
CREATE TABLE Char_raid_group
(
	ID_char INTEGER ,
	ID_raid_group INTEGER ,
	Damaged INTEGER  NOT NULL DEFAULT 0 CHECK(Damaged >= 0) ,
	Taken_damage INTEGER  NOT NULL DEFAULT 0 CHECK(Taken_damage >= 0) ,
	Heal INTEGER  NOT NULL DEFAULT 0 CHECK(Heal >= 0) ,
	PRIMARY KEY(ID_char,ID_raid_group) ,
	FOREIGN KEY (ID_char) REFERENCES TCharacter ,
	FOREIGN KEY (ID_raid_group) REFERENCES Raid_group
)


--Сущность Е15
CREATE TABLE Dungeon_list
(
	ID_dungeon INTEGER IDENTITY,
	Name_dungeon VARCHAR(25)  NOT NULL ,
	Level_dungeon VARCHAR(15)  NOT NULL CHECK (Level_dungeon in('Normal','Heroic','Epos')) ,
	Min_level_char INTEGER  NOT NULL DEFAULT 1 ,
	Min_level_equipment INTEGER  NOT NULL DEFAULT 1 ,
	PRIMARY KEY(ID_dungeon)	
)

--Сущность Е19
CREATE TABLE Dungeon_group
(
	ID_dungeon_group INTEGER IDENTITY ,
	Count_chars SMALLINT  NOT NULL DEFAULT 0 ,
	PRIMARY KEY(ID_dungeon_group)
)

--Сущность Е5
CREATE TABLE Dungeon
(
	ID_dungeon INTEGER ,
	ID_dungeon_group INTEGER  ,
	Kill_bosses SMALLINT NOT NULL DEFAULT 0 , -- добавил для определения сколько боссов убито, чтобы определить прогресс рейда
	Progress_dungeon FLOAT  NOT NULL CHECK(Progress_dungeon BETWEEN 0 AND 100 ) DEFAULT 0 , -- в процентном соотношении будет определять прогресс прохождения
	Start_progress DATETIME  NOT NULL ,
	Finish_progress DATETIME ,
	PRIMARY KEY(ID_dungeon,ID_dungeon_group) ,
	FOREIGN KEY (ID_dungeon) REFERENCES Dungeon_list ,
	FOREIGN KEY (ID_dungeon_group) REFERENCES Dungeon_group
)

--Сущность Е14 персонажи групп подземелий
CREATE TABLE Char_dungeon_group
(
	ID_char INTEGER ,
	ID_dungeon_group INTEGER ,
	Damaged INTEGER  NOT NULL DEFAULT 0 CHECK(Damaged >= 0) ,
	Taken_damage INTEGER  NOT NULL DEFAULT 0 CHECK(Taken_damage >= 0) ,
	Heal INTEGER  NOT NULL DEFAULT 0 CHECK(Heal >= 0) ,
	PRIMARY KEY(ID_char,ID_dungeon_group) ,
	FOREIGN KEY (ID_char) REFERENCES TCharacter ,
	FOREIGN KEY (ID_dungeon_group) REFERENCES Dungeon_group
)

--Сущность Е8 
CREATE TABLE Boss
(
	ID_boss INTEGER IDENTITY ,
	ID_raid INTEGER ,
	ID_dungeon INTEGER ,
	Name_boss VARCHAR(30)  NOT NULL ,
	Level_boss VARCHAR(20) NOT NULL CHECK (Level_boss in('Normal','Heroic','Epos')) ,
	PRIMARY KEY(ID_boss) ,
	FOREIGN KEY (ID_raid) REFERENCES Raid_list ,
	FOREIGN KEY (ID_dungeon) REFERENCES Dungeon_list
)

--Сущность Е22
CREATE TABLE Bf_group
(
	ID_bf_group INTEGER IDENTITY ,
	Count_chars SMALLINT  NOT NULL DEFAULT 5 CHECK(Count_chars BETWEEN 5 AND 10) ,
	Captured_flags SMALLINT  NOT NULL DEFAULT 0 CHECK(Captured_flags BETWEEN 0 AND 3 ) ,
	Count_kills INTEGER  NOT NULL DEFAULT 0 
	PRIMARY KEY(ID_bf_group)
)

--Сущность Е23
CREATE TABLE Bf_list
(
	Bf_name VARCHAR(40) ,
	Min_level_char INTEGER  NOT NULL DEFAULT 1 ,
	Min_level_equipment INTEGER  NOT NULL DEFAULT 1 ,
	PRIMARY KEY(Bf_name)
)

--Сущность Е6
CREATE TABLE Battlefield
(
	Bf_name VARCHAR(40) ,
	ID_bf_group1 INTEGER REFERENCES Bf_group(ID_bf_group) ,
	ID_bf_group2 INTEGER REFERENCES Bf_group(ID_bf_group) ,
	Command_win INTEGER ,
	Start_progress DATETIME  NOT NULL ,
	Finish_progress DATETIME ,
	PRIMARY KEY(Bf_name,ID_bf_group1,ID_bf_group2) ,
	FOREIGN KEY (Bf_name) REFERENCES Bf_list 
)

--Сущность Е21 Персонажи группы поля боя
CREATE TABLE Char_bf_group
(
	ID_char INTEGER ,
	ID_bf_group INTEGER ,
	Damaged INTEGER  NOT NULL DEFAULT 0 CHECK(Damaged >= 0) ,
	Taken_damage INTEGER  NOT NULL DEFAULT 0 CHECK(Taken_damage >= 0) ,
	Heal INTEGER  NOT NULL DEFAULT 0 CHECK(Heal >= 0) ,
	PRIMARY KEY(ID_char,ID_bf_group) ,
	FOREIGN KEY (ID_char) REFERENCES TCharacter ,
	FOREIGN KEY (ID_bf_group) REFERENCES Bf_group
)