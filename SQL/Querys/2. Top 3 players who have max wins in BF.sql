/*
Вывести TOP 3 персонажей по критерию максимально победивших боёв. 
Вывести id персонажей, никнеймы, количество подземелий на которых сыграл персонаж, общее количество боссов этих в подземелья, 
средняя численность рассы в подземелье в процентах. 
*/
USE mmorpg_Bang; 
SELECT	A.ID_char,
		A.Name_char,
		A.IP,
		A.CountWinsBF,
		DB.countBossesDung,
		DB.countPlayedDung,
		ROS.avgRaceOnServer
FROM	(	SELECT TOP(3)  *
			FROM	(	SELECT	TC.ID_char, 
								TC.Name_char, 
								BF.Command_win, 
								TC.IP, 
								TR.Race,
								COUNT(*) AS CountWinsBF/*,  
								SUM(CBFG.Damaged) AS damaged, 
								SUM(CBFG.Heal) AS heal, 
								SUM(CBFG.Taken_damage)AS  taken_damage*/
						FROM TCharacter TC
						JOIN Char_bf_group CBFG ON TC.ID_char = CBFG.ID_char
						JOIN Battlefield BF ON CBFG.ID_bf_group = BF.Command_win
						JOIN TRace TR ON TC.ID_race_frac = TR.ID_race_frac
						GROUP BY TC.ID_char, TC.Name_char, BF.Command_win, TC.IP, TR.Race ) A
		)A
LEFT JOIN (
			--Количество сыгранных подземелий и количество боссов в них
			SELECT	TC.Name_char, 
					TC.ID_char, 
					TC.IP,
					SUM(B.countBoss) countBossesDung, 
					COUNT(D.ID_dungeon) countPlayedDung
			FROM TCharacter TC
			JOIN Char_dungeon_group CDG ON TC.ID_char = CDG.ID_char
			JOIN Dungeon D ON CDG.ID_dungeon_group = D.ID_dungeon_group
			JOIN( 
					SELECT	ID_dungeon, 
							COUNT(Name_boss) as countBoss
					FROM Boss 
					GROUP BY ID_dungeon
				) 
			B ON B.ID_dungeon = D.ID_dungeon
			GROUP BY TC.Name_char, TC.ID_char, TC.IP
		 )
DB ON A.ID_char = DB.ID_char
JOIN	 (	
			--общее среднее количество рассы на сервере
			SELECT	D.IP, 
					D.Race, 
					cast(SUM(D.avgRaceInGroup)/COUNT(D.Race) as decimal(6,0)) avgRaceOnServer
			FROM (	--среднее количество рассы в процентах в каждой группе
					SELECT	A.IP, 
							A.Race, 
							A.ID_dungeon_group, 
							A.countRaceDungeon, B.allCountRace, 
							cast(	((	cast((A.countRaceDungeon) AS decimal(6,2))
								/		cast((B.allCountRace) AS decimal(6,2))
								)*100) as decimal(6,0)) AS avgRaceInGroup
					FROM (	--общее количество расы в каждой группе на сервере
							SELECT	TC.IP, 
									CDG.ID_dungeon_group, 
									TR.Race, 
									COUNT (*) countRaceDungeon
							FROM TCharacter TC
							JOIN Char_dungeon_group CDG ON TC.ID_char = CDG.ID_char
							JOIN TRace TR ON TC.ID_race_frac = TR.ID_race_frac
							GROUP BY TC.IP, CDG.ID_dungeon_group, TR.Race 
						 )  A
					JOIN (	--Общая численность рассы на сервере
							SELECT	S.IP, 
									TR.Race, 
									COUNT(TR.Race) as allCountRace
							FROM SERVER S
							JOIN TCharacter TC ON S.IP = TC.IP
							JOIN TRace TR ON TC.ID_race_frac = TR.ID_race_frac
							GROUP BY S.IP, TR.Race
						 ) B ON A.IP = B.IP AND A.Race = B.Race
					) D
			GROUP BY D.IP, D.Race
		 ) 
ROS ON A.IP = ROS.IP AND A.Race = ROS.Race