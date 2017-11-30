Select	S.IP, 
		isnull(DResult.avgTimePlayDungeon,0) as avgTimePlayDungeon, 
		isnull(DResult.countDungeon,0) as countDungeon, 
		isnull(BFResult.avgTimePlayBattlefield,0) as avgTimePlayBattlefield, 
		isnull(BFResult.countBattlefield,0) as countBattlefield
From Server S
LEFT JOIN (	--Get the average time of passing dungeon and count of dungeons on which the players played
			SELECT IDG.IP, SUM(DATEDIFF(MINUTE, D.Start_progress, D.Finish_progress))/COUNT(*) as avgTimePlayDungeon, COUNT(*) as countDungeon
			FROM Dungeon D
			JOIN (	SELECT DISTINCT CDG.ID_dungeon_group, S.IP
					FROM (SELECT DISTINCT IP, ID_char FROM TCharacter)T
					JOIN Server S ON T.IP = S.IP
					JOIN Char_dungeon_group CDG ON T.ID_char = CDG.ID_char
					JOIN dungeon R ON CDG.ID_dungeon_group = R.ID_dungeon_group 
				 ) IDG 
			ON D.ID_dungeon_group = IDG.ID_dungeon_group
			WHERE D.Finish_progress is not null
			GROUP BY IDG.IP
		  ) DResult 
ON S.IP = DResult.IP

LEFT JOIN (--Get the average time of passing battlefield and count of battlefield on which the players played
			Select B.IP, SUM(DATEDIFF(MINUTE, BF.Start_progress, BF.Finish_progress))/COUNT(*) as avgTimePlayBattlefield, COUNT(*) as countBattlefield
			From Battlefield BF
			JOIN (
					SELECT B.ID_bf_group1, B.ID_bf_group2, S.IP, B.Bf_name
					FROM Server S
					JOIN TCharacter T ON S.IP = T.IP
					JOIN Char_bf_group CBFG ON T.ID_char = CBFG.ID_char
					JOIN Battlefield B ON B.ID_bf_group1 =  CBFG.ID_bf_group OR B.ID_bf_group2 = CBFG.ID_bf_group
					WHERE B.Finish_progress is not null
					GROUP BY B.ID_bf_group1, B.ID_bf_group2, S.IP , B.Bf_name
				 ) B 
			ON BF.ID_bf_group1 = B.ID_bf_group1 AND BF.ID_bf_group2 = B.ID_bf_group2 and BF.Bf_name = B.Bf_name
			Group by B.IP 
		  ) BFResult 
ON S.IP = BFResult.IP