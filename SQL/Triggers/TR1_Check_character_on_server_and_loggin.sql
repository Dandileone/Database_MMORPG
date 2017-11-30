USE mmorpg_Bang
GO

ALTER TRIGGER Check_character_on_server_and_loggin ON TCharacter
INSTEAD OF INSERT AS
SET NOCOUNT ON;

BEGIN
		DECLARE
			@IP VARCHAR(20) ,
			@Nickname VARCHAR(15) ,
			@Fraction VARCHAR(10) ,
			@Class VARCHAR(20) ,
			@ID_race_frac INTEGER , 
			@Name_char VARCHAR(20)
			
		SELECT	@IP = IP, @Nickname = Nickname, 
				@Fraction = Fraction, @Class = Class, @ID_race_frac = ID_race_frac, @Name_char = Name_char
		FROM INSERTED;
		
	BEGIN
		DECLARE		 
		@Count_char_on_account SMALLINT,
		@Count_char_on_server SMALLINT;
		
		--Get cout char on server who inserted
		SELECT @Count_char_on_server = count(TC.ID_char) 
		FROM TCharacter TC
			JOIN Server S ON TC.IP = S.IP
			JOIN Player PL ON PL.Nickname=TC.Nickname
		WHERE TC.Nickname = @Nickname and TC.IP = @IP
		
		--Get all cout char on server for nickname from inserted
		SELECT @Count_char_on_account= SUM(count_char)
		FROM (	SELECT TC.Nickname, TC.IP, count(TC.ID_char) AS count_char
				FROM TCharacter TC
					JOIN Server S ON TC.IP = S.IP
					JOIN Player PL on PL.Nickname=TC.Nickname
				WHERE TC.Nickname = @Nickname
				GROUP BY  TC.Nickname, TC.IP ) as RES

	END
	
IF @Count_char_on_server < 3 and @Count_char_on_account < 10 
	BEGIN
		INSERT INTO TCharacter(IP, Nickname, Fraction, Class, ID_race_frac, Name_char)
		VALUES(@IP, @Nickname, @Fraction, @Class, @ID_race_frac, @Name_char)
		DECLARE @msg nvarchar (300);
			SET @msg = ('A new character ' + RTRIM(@Name_char) +' was successfully created for the account '+ RTRIM(@Nickname) + ' on the server ' + RTRIM(@IP))
			print @msg
	END

ELSE
	BEGIN
		DECLARE @msgErr nvarchar (300);
			SET @msgErr = ('Character ' + RTRIM(@Name_char) +' was not created for the account '+ RTRIM(@Nickname) + 'on the server ' + RTRIM(@IP) +
			' Current count on server = '+ RTRIM(@Count_char_on_server) + ' Current count on account = ' + RTRIM(@Count_char_on_account))
			print @msgErr
	END
END



/*For check trigger 
INSERT INTO TCharacter(IP, Nickname, Fraction, Class, ID_race_frac, Name_char)
VALUES
('192.168.0.5', 'Hronos', 'Alliance', 'Warrion', 1, 'HumWar' ),
('192.168.0.5', 'Hronos', 'Alliance', 'Shaman', 4, 'DreanSham' ),
('192.168.0.5', 'Hronos', 'Horde', 'Warrion', 6, 'OrcWar' ),
('192.168.0.6', 'Hronos', 'Horde', 'Priest', 8, 'UndPriest' ),
('192.168.0.5', 'Zeus', 'Alliance', 'Paladin', 1, 'HumPall' )


INSERT INTO TCharacter(IP, Nickname, Fraction, Class, ID_race_frac, Name_char)
VALUES
('192.168.0.1', 'Hronos', 'Alliance', 'Warrion', 1, 'Tanch' )

--Сколько персонажей для персонажей на серверах с логином Hronos
SELECT count(TC.ID_char) as count_char_on_server
FROM TCharacter TC
JOIN Server S ON TC.IP = S.IP
JOIN Player PL ON PL.Nickname=TC.Nickname
WHERE TC.Nickname = 'Hronos' and TC.IP like '192.168.0.5' --вместо IP и Nickname вставим переменные
--GROUP BY TC.Nickname, TC.IP
*/