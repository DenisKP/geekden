USE VK3;

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 3;  

SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10;
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;
SELECT (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS likes FROM likes  WHERE  ;
SELECT (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10 AS likes.) FROM

SELECT SUM(likes_total) FROM  
  (SELECT 
    (SELECT COUNT(*) FROM likes WHERE to_like_id = profiles.user_id AND to_like_id = 2) AS likes_total  
    FROM profiles 
    ORDER BY birthday 
    DESC LIMIT 20) AS user_likes;
SELECT COUNT(*) FROM likes 
  WHERE to_like_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles ) 
;
    
SELECT 
  name AS loosers, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.user_id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.user_id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.user_id) AS total_vk_use 
	  FROM users
	  ORDER BY total_vk_use
	  LIMIT 10;