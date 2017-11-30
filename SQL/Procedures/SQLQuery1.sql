SELECT Nickname,count(ID_char)
FROM TCharacter 
WHERE IP = '192.168.0.5'
WHERE

SELECT TOP 10 ID_char , Nickname
FROM TCharacter WHERE IP = '192.168.0.5' AND Fraction = 'Alliance'	
AND Level_char >= 1 AND Level_equipment >= 1


SELECT count(IF(Class = 'Priest',1,0))
FROM TCharacter TCh
join TClass TCl on Tch.Class = TCl.Class


SELECT (SELECT COUNT(*) FROM tickets WHERE is_read = 'N') new_t, (SELECT COUNT(*) 
FROM tickets) all_t


SELECT @Damagers= (
SELECT count(TCh.Class)
FROM TCharacter TCh
JOIN TClass TCl on Tch.Class = TCl.Class
WHERE TCh.Class in ('Priest','Shaman') and TCh.IP = AND TCh.Fraction = ) 




SELECT    
   CASE   
	WHEN Max_count_char IN(10) THEN 6 
	WHEN Max_count_char IN(25) THEN 10
   END,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
   END,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
   END
FROM Raid_list
Group by Max_count_char


select *
from Raid_list


SELECT    
   CASE   
	WHEN Max_count_char IN(10) THEN 6 
	WHEN Max_count_char IN(25) THEN 18
   END AS Damagers,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
    WHEN Max_count_char IN(25) THEN 5
   END AS Healers,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
	WHEN Max_count_char IN(25) THEN 2
   END AS Tanks
FROM Raid_list
WHERE ID_raid = 4
Group by Max_count_char


SELECT *
FROM Raid_list

INSERT INTO Raid_list(Name_raid, Level_raid, Min_level_char, Min_level_equipment, Max_count_char)
VALUES
--('Test10', 'Epos', 80, 2400 ,10),
('Test25', 'Epos', 80, 2400 ,25)



SELECT *
FROM TCharacter
WHERE Level_char >= (SELECT Min_level_char FROM Raid_list WHERE ID_raid = 1)






SELECT sum()
FROM (
SELECT    
   CASE   
	WHEN Max_count_char IN(10) THEN 6 
	WHEN Max_count_char IN(25) THEN 18
   END AS Damagers,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
    WHEN Max_count_char IN(25) THEN 5
   END AS Healers,
   CASE   
	WHEN Max_count_char IN(10) THEN 2
	WHEN Max_count_char IN(25) THEN 2
   END AS Tanks
FROM Raid_list
WHERE ID_raid = 4
Group by Max_count_char) AS T


Select id
select TOP 2 ID_char from TCharacter
where Class in ('Paladin','Warrion') 
union
select TOP 2 ID_char from TCharacter
where Class in ('Shaman','Priest') 
select 

select *
from TCharacter;



INSERT INTO Raid_group(Count_chars)
VALUES(0);


SELECT * 
FROM Player
SELECT * 
FROM Server
SELECT * 
FROM TCharacter
SELECT * 
FROM Raid_list

--Insert For test proc1
INSERT INTO TCharacter
Aid
Zeus
Persei


INSERT INTO TCharacter(IP, Nickname, Fraction, Class, ID_race_frac, Name_char, Level_char,Level_equipment)
VALUES
('192.168.0.6', 'Afina', 'Alliance', 'Shaman', 4, 'AfiDrenSham', 60, 600 ),
('192.168.0.6', 'Aid', 'Alliance', 'Priest', 3, 'AidGnomPriest', 60, 600 ),
('192.168.0.6', 'Demetra', 'Alliance', 'Shaman', 4, 'DemDrenSham', 60, 600 ),
('192.168.0.6', 'Persei', 'Alliance', 'Priest', 2, 'PerElfPriest', 60, 600 ),
('192.168.0.6', 'Zeus', 'Alliance', 'Paladin', 1, 'ZeusHumPal', 60, 600 ),

('192.168.0.6', 'Afina', 'Alliance', 'Monk', 2, 'AfiElfMonk', 60, 600 ),
('192.168.0.6', 'Aid', 'Alliance', 'Shaman', 4, 'AidElfSham', 60, 600 ),
('192.168.0.6', 'Demetra', 'Alliance', 'Priest', 1, 'DemHumPriest', 60, 600 ),
('192.168.0.6', 'Persei', 'Alliance', 'Warrion', 3, 'PerGnomWar', 60, 600 ),
('192.168.0.6', 'Hronos', 'Alliance', 'Warrion', 2, 'HronElfDru', 60, 600 );

Select *
From TRace T
join Class_Race CR on T.ID_race_frac= CR.ID_race_frac
WHERE Fraction = 'Alliance' --and Class = 'Druid'


DELETE FROM TCharacter
WHERE Fraction = 'Alliance' AND IP = '192.168.0.6'


UPDATE TCharacter
SET Class = 'Druid'
WHERE Fraction = 'Alliance' AND IP = '192.168.0.6' AND Name_char = 'HronElfDru'


select *
from Char_raid_group CRG
join TCharacter TC on TC.ID_char = CRG.ID_char
join Raid R on CRG.ID_raid_group = R.ID_raid_group

SELECT *
FROM TCharacter




SELECT TC.Name_char, BL.Bf_name, B.Start_progress, B.Finish_progress, CBG.Damaged, CBG.Heal, CBG.Taken_damage, B.Command_win
FROM Player P
JOIN TCharacter TC ON P.Nickname = TC.Nickname
JOIN Char_bf_group CBG ON TC.ID_char = CBG.ID_char
JOIN Battlefield B ON CBG.ID_bf_group = B.ID_bf_group1 OR CBG.ID_bf_group = B.ID_bf_group2
JOIN Bf_list BL ON B.Bf_name = BL.Bf_name
WHERE P.Nickname = 'Hronos'  and (B.Start_progress BETWEEN '2017-11-11' and '2017-13-12 23:44:29.847')


select @@rowcount


Select 1 FROM Player 
WHERE Nickname = 'eND'