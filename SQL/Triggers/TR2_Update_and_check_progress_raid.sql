USE mmorpg_Bang
GO

ALTER TRIGGER Update_and_check_progress_raid ON Raid
INSTEAD OF UPDATE AS
SET NOCOUNT ON;

BEGIN
		DECLARE
			@ID_raid INTEGER ,
			@ID_raid_group INTEGER ,
			@Kill_bosses SMALLINT ,
			@Progress_raid FLOAT ,
			@Start_progress DATETIME , 
			@Finish_progress DATETIME
			
		SELECT	@ID_raid = ID_raid, @ID_raid_group = ID_raid_group, 
				@Kill_bosses = Kill_bosses, @Progress_raid = Progress_raid, @Start_progress = Start_progress, @Finish_progress = Finish_progress
		FROM INSERTED;
		
	BEGIN
		DECLARE		 
		@Count_bosses_in_raid SMALLINT
		
		--Get cout bosses for updated raid 
		SELECT @Count_bosses_in_raid =  count(BS.ID_boss)
		FROM Raid R
			JOIN Raid_list RL ON R.ID_raid = RL.ID_raid
			JOIN Boss BS ON RL.ID_raid= BS.ID_raid		
		WHERE R.ID_raid_group =  @ID_raid_group and R.ID_raid = @ID_raid
		
	END
	
IF @Count_bosses_in_raid = @Kill_bosses 
	BEGIN
		
		UPDATE Raid 
		SET Progress_raid = 100 , Finish_progress= @Finish_progress
		WHERE ID_raid = @ID_raid AND ID_raid_group = @ID_raid_group
		
		DECLARE @msg_success nvarchar (300);
			SET @msg_success = ('Raid with ID = ' + RTRIM(@ID_raid) + ' in which '+ RTRIM(@Count_bosses_in_raid) + 
						' bosses were killed out ' + RTRIM(@Kill_bosses) +'  was successfully passed by the group ' + RTRIM(@ID_raid_group))
			print @msg_success
	END

ELSE --IF @Count_bosses_in_raid > @Kill_bosses
	BEGIN
		
		UPDATE Raid 
		SET Progress_raid = cast(((100/@Count_bosses_in_raid)*@Kill_bosses) as float), Finish_progress= @Finish_progress
		WHERE ID_raid = @ID_raid AND ID_raid_group = @ID_raid_group
		
		
		DECLARE @msg nvarchar (300);
			SET @msg = ('Raid with ID = ' + RTRIM(@ID_raid) + ' in which '+ RTRIM(@Count_bosses_in_raid) + 
						' bosses were killed out ' + RTRIM(@Kill_bosses) +'  was no passed by the group ' + RTRIM(@ID_raid_group))
			print @msg
	END
	
/*ELSE 
		DECLARE @msgError nvarchar (300);
			SET @msgError = ('In the raid with ID = ' + RTRIM(@ID_raid) + ' '+ RTRIM(@Count_bosses_in_raid) + ' bosses '+  
						' bosses were killed out ' + RTRIM(@Kill_bosses) +'  by the group' + RTRIM(@ID_raid_group))
			print @msgError*/
END




/*For check trigger
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
(1,1,4,'2017-01-11 11:11:11.000'),
(1,2,5,'2017-01-12 12:12:12.000')


INSERT INTO Boss(ID_raid, Name_boss, Level_boss)
VALUES
(1, 'Lord Marrowgar', 'Normal'),
(1, 'Lady Deathwhisper', 'Normal'),
(1, 'Deathbringer Saurfang', 'Normal'),
(1, 'Blood-Queen Lanathel', 'Normal'),
(1, 'The Lich King', 'Normal')


SELECT count(BS.ID_boss)
FROM Raid R
	JOIN Raid_list RL ON R.ID_raid = RL.ID_raid
	JOIN Boss BS ON RL.ID_raid= BS.ID_raid		
WHERE R.ID_raid_group = 1


UPDATE Raid
SET Finish_progress = '2017-01-11 11:50:11.000'
WHERE ID_raid_group = 1 and ID_raid = 1 

UPDATE Raid
SET Finish_progress = '2017-01-11 12:50:30.000'
WHERE ID_raid_group = 2 and ID_raid = 1 

*/