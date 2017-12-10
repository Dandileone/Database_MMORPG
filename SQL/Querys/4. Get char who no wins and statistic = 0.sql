/*Найти персонажей у которых нет ни одной победы в составе групп поля боя и которые не нанесли, не вылечили и не получили урона. */
SELECT B.Nickname, B.ID_char, B.Name_char
FROM (	Select CBFG.ID_char, CBFG.ID_bf_group, P.Nickname, TC.Name_char
		FROM Player P
		JOIN TCharacter TC on p.Nickname = TC.Nickname
	 	JOIN Char_bf_group CBFG ON TC.ID_char = CBFG.ID_char
		WHERE CBFG.Damaged = 0 AND CBFG.Heal = 0 AND CBFG.Taken_damage = 0 
	 ) B
LEFT JOIN (	SELECT DISTINCT BF.Command_win
			FROM Battlefield BF
			WHERE BF.Command_win IS NOT NULL
		  ) 
PWC ON B.ID_bf_group = PWC.Command_win
WHERE PWC.Command_win IS  NULL