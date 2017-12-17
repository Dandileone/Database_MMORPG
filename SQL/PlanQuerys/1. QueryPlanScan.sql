/*Найти персонажей у которых нет ни одной победы в составе групп поля боя и которые не нанесли, не вылечили и не получили урона. 
И вывести количество поражений
*/
SELECT B.Nickname, B.ID_char, B.Name_char, CBL.countLose
FROM (	Select CBFG.ID_char, CBFG.ID_bf_group, P.Nickname, TC.Name_char
		FROM Player P 
		JOIN TCharacter TC  ON p.Nickname = TC.Nickname
	 	JOIN Char_bf_group CBFG ON TC.ID_char = CBFG.ID_char
		WHERE CBFG.Damaged = 0 AND CBFG.Heal = 0 AND CBFG.Taken_damage = 0 
	 ) B
LEFT JOIN (	SELECT DISTINCT BF.Command_win
			FROM Battlefield BF
			WHERE BF.Command_win IS NOT NULL
		  ) 
PWC ON B.ID_bf_group = PWC.Command_win
LEFT JOIN	(
				SELECT	BFG.ID_bf_group AS ID_bf_group, 
						COUNT(BFG.ID_bf_group) countLose
				FROM Bf_group BFG
				JOIN Battlefield B ON BFG.ID_bf_group != B.Command_win AND (B.ID_bf_group1 = BFG.ID_bf_group OR B.ID_bf_group2 = BFG.ID_bf_group)
				GROUP BY BFG.ID_bf_group
			) CBL ON B.ID_bf_group = CBL.ID_bf_group
WHERE PWC.Command_win IS  NULL

/*Найти персонажей у которых нет ни одной победы в составе групп поля боя и которые не нанесли, не вылечили и не получили урона. 
И вывести количество поражений
*/
SELECT B.Nickname, B.ID_char, B.Name_char, CBL.countLose
FROM (	Select CBFG.ID_char, CBFG.ID_bf_group, P.Nickname, TC.Name_char
		FROM Player P WITH (FORCESEEK) 
		JOIN TCharacter TC WITH (FORCESEEK)  on p.Nickname = TC.Nickname
	 	JOIN Char_bf_group CBFG ON TC.ID_char = CBFG.ID_char
		WHERE CBFG.Damaged = 0 AND CBFG.Heal = 0 AND CBFG.Taken_damage = 0 
	 ) B
LEFT JOIN (	SELECT DISTINCT BF.Command_win
			FROM Battlefield BF 
			WHERE BF.Command_win IS NOT NULL
		  ) 
PWC ON B.ID_bf_group = PWC.Command_win
LEFT JOIN	(
				SELECT	BFG.ID_bf_group AS ID_bf_group, 
						COUNT(BFG.ID_bf_group) countLose
				FROM Bf_group BFG WITH (FORCESEEK) 
				JOIN Battlefield B ON BFG.ID_bf_group != B.Command_win AND (B.ID_bf_group1 = BFG.ID_bf_group OR B.ID_bf_group2 = BFG.ID_bf_group)
				GROUP BY BFG.ID_bf_group
			) as CBL ON B.ID_bf_group = CBL.ID_bf_group
WHERE PWC.Command_win IS  NULL