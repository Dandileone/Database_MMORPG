ALTER PROCEDURE Generate_Group_Char_for_Raid
	(	@In_ID_Raid INT ,
		@In_IP_Server VARCHAR(20) ,
		@In_Fraction VARCHAR(10)
	)

AS

BEGIN
	
	DECLARE
		@required_count_char INT ,
		@current_count_char INT ,
		@required_min_level_char INT ,
		@required_min_level_equip INT ;
			
	--Get requred count character for raid
	SELECT @required_count_char = Max_count_char, @required_min_level_char = Min_level_char, @required_min_level_equip = Min_level_equipment
	FROM Raid_list
	WHERE ID_raid = @In_ID_Raid
	
	--Get current count character
	SELECT @current_count_char = count(ID_char)
	FROM TCharacter
	WHERE	IP = @In_IP_Server AND Fraction = @In_Fraction 
		AND	Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip

		
		IF(@current_count_char >= @required_count_char)
		BEGIN
			
			DECLARE
				@Damagers_curr INT , @Healers_curr INT ,@Tanks_curr INT ,
				@Req_Damagers INT ,	@Req_Healers INT , @Req_Tanks INT ;
				/*Druid or Monk are Healers
				Priest or Shaman are Damagers 
				Paladin or Warrion are Tanks
				Get count hillers, damagers and tanks of the current users*/
				SELECT	@Healers_curr = 
							(	SELECT count(TCh.Class)		FROM TCharacter TCh
								WHERE TCh.Class in ('Druid','Monk') and TCh.IP = @In_IP_Server AND TCh.Fraction = @In_Fraction
								AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip) ,
						@Damagers_curr = 
							(	SELECT count(TCh.Class)		FROM TCharacter TCh
								WHERE TCh.Class in ('Priest','Shaman') and TCh.IP = @In_IP_Server AND TCh.Fraction = @In_Fraction
								AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip) ,
						@Tanks_curr = 
							(	SELECT count(TCh.Class)		FROM TCharacter TCh
								WHERE TCh.Class in ('Paladin','Warrion') and TCh.IP = @In_IP_Server AND TCh.Fraction = @In_Fraction
								AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip) ;
				--Get required count hillers, damagers and tanks for input ID_Raid
				SELECT	@Req_Healers =
							(CASE   WHEN Max_count_char IN(10) THEN 2		WHEN Max_count_char IN(25) THEN 5	END) ,
						@Req_Damagers =   
							(CASE   WHEN Max_count_char IN(10) THEN 6 		WHEN Max_count_char IN(25) THEN 18	END) ,
						@Req_Tanks =   
							(CASE   WHEN Max_count_char IN(10) THEN 2		WHEN Max_count_char IN(25) THEN 2	END)
				FROM Raid_list
				WHERE ID_raid = @In_ID_Raid
				GROUP BY Max_count_char


				IF(@Healers_curr >= @Req_Healers AND @Damagers_curr >= @Req_Damagers AND @Tanks_curr >= @Req_Tanks)
					BEGIN
						
						--Create Raid_group to insert id_group_raid into the table char_raid_group
						INSERT INTO Raid_group(Count_chars)
						VALUES(0);
						
						DECLARE @Id_Raid_group INT; 
						SET @Id_Raid_group = @@IDENTITY;

						DECLARE Cursorr CURSOR FOR
							SELECT TOP (@Req_Healers) ID_char 
							FROM TCharacter WHERE Class in ('Druid','Monk') and IP = @In_IP_Server AND Fraction = @In_Fraction	
							AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip
								UNION
							SELECT TOP (@Req_Damagers) ID_char 
							FROM TCharacter WHERE Class in ('Priest','Shaman') and IP = @In_IP_Server AND Fraction = @In_Fraction	
							AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip
								UNION
							SELECT TOP (@Req_Tanks) ID_char 
							FROM TCharacter WHERE Class in ('Paladin','Warrion') and IP = @In_IP_Server AND Fraction = @In_Fraction	
							AND Level_char >= @required_min_level_char AND Level_equipment >= @required_min_level_equip
						OPEN Cursorr;
						DECLARE @Cursor_Id_Char INT;
						
						
						FETCH NEXT FROM Cursorr INTO @Cursor_Id_Char
						WHILE @@FETCH_STATUS = 0
							BEGIN
								INSERT INTO Char_raid_group(ID_char, ID_raid_group)
								VALUES(@Cursor_Id_Char, @Id_Raid_group)

								UPDATE Raid_group
								SET Count_chars = Count_chars + 1
								WHERE ID_raid_group = @Id_Raid_group

								FETCH NEXT FROM Cursorr INTO @Cursor_Id_Char
							END
								
						CLOSE Cursorr;
						DEALLOCATE Cursorr;
						
						INSERT INTO Raid(ID_raid, ID_raid_group, Start_progress)
						VALUES (@In_ID_Raid,@Id_Raid_group,GETDATE())

						PRINT N'Group raid with id ' + RTRIM(@Id_Raid_group) + ' success created'
					END

				ELSE
					BEGIN
						--Пишем что не хватает персонажей такого то типа и перечисление типов персов требуемого количество и текущее значение 
						RAISERROR
							(N'There are not enough characters to generate a raid group
							Current count healers :%d  required count healers :%d
							Current count damagers :%d  required count damagers :%d
							Current count tanks :%d  required count tanks :%d 
							on the server with IP :%s for id raid :%d with requirements min level equipment = :%d and min level char = :%d ',
							17, -- Severity.
							2, -- State.
							@Healers_curr,
							@Req_Healers,
							@Damagers_curr,
							@Req_Damagers,
							@Tanks_curr,
							@Req_Tanks,
							@In_IP_Server,
							@In_ID_Raid,
							@required_min_level_equip,
							@required_min_level_char);
					END
		END
	
	ELSE
		BEGIN
			--Пишем что не хватает персонажей для такой то фракции
			--с таким то левелом экипировки, с таким то левелом самого персонажа
			--и с таким то рекомендуемым количество персонажей
			RAISERROR
				(N'There are not enough characters to generate a raid group
				Current count chars :%d != required count chars :%d on the server with IP :%s 
				for id raid :%d with requirements min level equipment = :%d and min level char = :%d ',
				18, -- Severity.
				1, -- State.
				@current_count_char,
				@required_count_char,
				@In_IP_Server,
				@In_ID_Raid,
				@required_min_level_equip,
				@required_min_level_char);
		END

END









/*
EXEC Generate_Group_Char_for_Raid 1,'192.168.0.6', 'Alliance'


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

DELETE FROM Raid_group
WHERE ID_raid_group = 3

DELETE FROM Char_raid_group
WHERE ID_raid_group = 3

DELETE FROM Raid
WHERE ID_raid_group = 3 and ID_raid = 1
*/