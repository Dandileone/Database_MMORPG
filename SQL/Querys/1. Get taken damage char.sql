/*
Найти в группах поля боя таких персонажей у которых значение полученного урона >= максимальному значению нанесённого урона в группе.
Вывести никнейм, полученный урон, нанесённый урон персонажа, максимальный нанесённый урон для группы, количество боёв персонажа в рамках его группы.
*/
SELECT	T.Name_char,
		T.ID_char,
		T.ID_bf_group,
		T.IP,
		T.countPlayedBattle,
		R.Damaged,
		R.Taken_damage,
		R.maxDamagedGroup
FROM (	SELECT	TC.Name_char, 
				TC.ID_char, 
				CBFG.ID_bf_group,
				TC.IP,
				COUNT(CBFG.ID_bf_group) countPlayedBattle
		FROM TCharacter TC
		JOIN Char_bf_group CBFG ON TC.ID_char = CBFG.ID_char
		JOIN Battlefield BF ON CBFG.ID_bf_group = BF.ID_bf_group1 OR CBFG.ID_bf_group = BF.ID_bf_group2
		GROUP BY TC.Name_char, TC.ID_char, CBFG.ID_bf_group, TC.IP
	 ) T
JOIN (--Ищем в группе id персонажей, у которых taken_damage >= max damage для группы
		SELECT 	CBFG.ID_char, 
				CBFG.ID_bf_group, 
				CBFG.Damaged, 
				CBFG.Taken_damage, 
				TMD.maxDamagedGroup
		FROM Char_bf_group CBFG
		JOIN	(
					SELECT ID_bf_group, MAX(Damaged) maxDamagedGroup
					FROM Char_bf_group
					GROUP BY ID_bf_group
				) TMD ON CBFG.ID_bf_group = TMD.ID_bf_group
		WHERE CBFG.Taken_damage >=TMD.maxDamagedGroup
	 ) R ON T.ID_char = R.ID_char AND T.ID_bf_group = R.ID_bf_group
ORDER BY Name_char