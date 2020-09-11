USE VK3;
-- 1.1 took all genders and joint them with likes 
SELECT p.gender FROM profiles AS p JOIN likes AS l ON p.user_id = l.user_id;
-- 1.2 limit 3 was taken to show that all likes from genders were calculated and total quantity = 100 
SELECT gender, count(*) AS total FROM (SELECT p.gender FROM profiles AS p JOIN likes AS l ON l.user_id = p.user_id) AS gender GROUP BY gender ORDER by total DESC LIMIT 3;

-- 2
-- 2.1 try to see youngers with id birthday and name to check it manually
SELECT u.user_id, p.birthday, u.name FROM users AS u JOIN profiles AS p ON p.user_id = u.user_id ORDER BY p.birthday  ;  
-- 2.2 Show sum and we also took into account that we need to take only 1 type of like (like for users)
SELECT SUM(tot_like) AS TotalLikesFromYoungest10 FROM
(SELECT u.user_id, p.birthday, u.name, COUNT(DISTINCT l.to_like_id) AS tot_like FROM users AS u 
	LEFT JOIN profiles AS p ON u.user_id = p.user_id 
	LEFT JOIN likes AS l ON u.user_id = l.to_like_id AND l.type_id = 1 
	GROUP BY u.user_id ORDER BY birthday LIMIT 10) AS sorted_list;  
	
-- 3 it was hard for me to understand how left join workes. After that exercise second exercise was completelly rebuild bases on left join.    

SELECT 
	u.name, (COUNT(DISTINCT m.id) + COUNT(DISTINCT med.id) + COUNT(DISTINCT l.id)) AS total_active
	FROM users AS u 
	LEFT JOIN messages AS m ON m.from_user_id = u.user_id 
	LEFT JOIN likes AS l ON l.user_id= u.user_id  
	LEFT JOIN media AS med ON med.user_id = u.user_id 
	GROUP BY u.user_id ORDER BY total_active LIMIT 10 ;
