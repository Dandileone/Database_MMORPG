ALTER PROCEDURE Get_Game_Statistics_For_The_Char
	(	@In_StartPeriod DATE,
		@In_FinishPeriod DATE,
		@In_TypeGame SMALLINT,
		@In_NickName VARCHAR(15)
	)

AS
/* Codes type game:
* 1 - Raid
* 2 - Dungeon
* 3 - Battlefield
*/
BEGIN
	--DECLARE @Count INT;
	IF NOT EXISTS(Select 1 FROM Player WHERE Nickname = @In_NickName)
		BEGIN
			PRINT N'Player with Nickname ' + RTRIM(@In_NickName) + ' is not exists '
			RETURN;
		END

	IF (@In_TypeGame NOT BETWEEN 1 and 3)
		BEGIN
			PRINT N'You entered an invalid game type code ' + RTRIM(@In_TypeGame) + ' Correct codes type game: 1 - Raid , 2 - Dungeon, 3 - Battlefield'
			RETURN;
		END
	
	IF(@In_TypeGame = 1)
		BEGIN
			SELECT TC.Name_char, RL.Name_raid, RL.Level_raid, R.Start_progress, R.Finish_progress, CRG.Damaged, CRG.Heal, CRG.Taken_damage, R.Progress_raid 
			FROM Player P
			JOIN TCharacter TC ON P.Nickname = TC.Nickname
			JOIN Char_raid_group CRG ON TC.ID_char = CRG.ID_char
			JOIN Raid R ON CRG.ID_raid_group = R.ID_raid_group
			JOIN Raid_list RL ON R.ID_raid = RL.ID_raid
			WHERE P.Nickname = @In_NickName  and (R.Start_progress BETWEEN  @In_StartPeriod and @In_FinishPeriod)
		END
	
	IF(@In_TypeGame = 2)
		BEGIN
			SELECT TC.Name_char, DL.Name_dungeon, DL.Level_dungeon, D.Start_progress, D.Finish_progress, CDG.Damaged, CDG.Heal, CDG.Taken_damage, D.Progress_dungeon
			FROM Player P
			JOIN TCharacter TC ON P.Nickname = TC.Nickname
			JOIN Char_dungeon_group CDG ON TC.ID_char = CDG.ID_char
			JOIN Dungeon D ON CDG.ID_dungeon_group= D.ID_dungeon_group
			JOIN Dungeon_list DL ON D.ID_dungeon = DL.ID_dungeon
			WHERE P.Nickname = @In_NickName  and (D.Start_progress BETWEEN  @In_StartPeriod and @In_FinishPeriod)
		END
	
	IF(@In_TypeGame = 3)
	BEGIN
			SELECT TC.Name_char, BL.Bf_name, B.Start_progress, B.Finish_progress, CBG.Damaged, CBG.Heal, CBG.Taken_damage, B.Command_win
			FROM Player P
			JOIN TCharacter TC ON P.Nickname = TC.Nickname
			JOIN Char_bf_group CBG ON TC.ID_char = CBG.ID_char
			JOIN Battlefield B ON CBG.ID_bf_group = B.ID_bf_group1 OR CBG.ID_bf_group = B.ID_bf_group2
			JOIN Bf_list BL ON B.Bf_name = BL.Bf_name
			WHERE P.Nickname = @In_NickName  and (B.Start_progress BETWEEN  @In_StartPeriod and @In_FinishPeriod)					
		END
	

END

/*
EXEC Get_Game_Statistics_For_The_Char '2017-12-11','2017-12-11', 0,'Alliance';
EXEC Get_Game_Statistics_For_The_Char '2017-12-11','2017-12-11', 0,'Hronos';
EXEC Get_Game_Statistics_For_The_Char '2017-11-12','2017-11-13', 1,'Hronos';
EXEC Get_Game_Statistics_For_The_Char '2017-11-11','2017-11-13', 2,'Hronos';
EXEC Get_Game_Statistics_For_The_Char '2017-11-11','2017-11-13', 3,'Hronos';*/



INSERT INTO Dungeon_list(Name_dungeon, Level_dungeon, Min_level_char, Min_level_equipment)
VALUES 
('Test Dungeon', 'Normal', 1, 1),
('Test Dungeon2', 'Heroic', 1, 1);

INSERT INTO Dungeon_group(Count_chars)
VALUES 
(1),
(2);

INSERT INTO Dungeon(ID_dungeon, ID_dungeon_group, Kill_bosses, Progress_dungeon, Start_progress, Finish_progress)
VALUES 
(1,2,4,0,'2017-11-11 11:11:11.000', '2017-11-11 11:50:11.000'),
(1,1,4,0,'2017-11-11 11:11:11.000', '2017-11-11 12:11:11.000')

INSERT INTO Char_dungeon_group(ID_char, ID_dungeon_group, Damaged, Taken_damage, Heal)
VALUES 
--(4,1, 6000, 200, 10),
--(4,2, 9000, 500, 0),
(5,2, 500, 4000, 600);

select *
from Dungeon_list

select *
from Dungeon_group

Select *
from Dungeon

select *
from Char_dungeon_group

select *
from TCharacter

select *
from Char_Dungeon_group