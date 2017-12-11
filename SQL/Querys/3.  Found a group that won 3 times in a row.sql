/*
Найти такую группу на поле боя, которая победила три раза подряд на одном и том же поле в течении одного календарного месяца.
*/
SELECT	BFG.ID_bf_group as ID_bf_group,
		B.Bf_name,
		MIN(B.Finish_progress) AS minDate,
		MAX(B.Finish_progress) AS maxDate
FROM Bf_group BFG
JOIN Battlefield B ON BFG.ID_bf_group = B.Command_win
GROUP BY BFG.ID_bf_group, B.Bf_name, MONTH(B.Finish_progress), Year(B.Finish_progress)
HAVING	COUNT(*)=3 
	AND ID_bf_group NOT IN
	(
		SELECT q1.ID_bf_group 
		FROM
				(	SELECT	BFG.ID_bf_group AS ID_bf_group, 
							B.Bf_name AS name , 
							MIN(B.Finish_progress) AS minDate,
							MAX(B.Finish_progress) AS maxDate			
					FROM Bf_group BFG
					JOIN Battlefield B ON BFG.ID_bf_group= B.Command_win
					GROUP BY BFG.ID_bf_group, B.Bf_name, MONTH(B.Finish_progress), Year(B.Finish_progress)
					HAVING Count(*)=3
				 ) as q1
		LEFT JOIN Battlefield B on 
					( q1.ID_bf_group = B.ID_bf_group1 or q1.ID_bf_group=B.ID_bf_group2 ) 
				AND q1.ID_bf_group<>B.Command_win 
		WHERE q1.mindate < B.Finish_progress and q1.maxdate>B.Finish_progress
	 )