-- 1
USE VK2;
CREATE INDEX name ON users(name);
CREATE INDEX birthday ON profiles(birthday);
CREATE INDEX post ON posts(id);
CREATE INDEX media_type ON media_types(name);
CREATE INDEX communitie ON communities_users(id);
CREATE INDEX groups ON communities(group_id);

-- 2
USE VK;
SELECT DISTINCT 
  communities.group_name AS group_name,
  COUNT(communities_users.user_id) OVER() 
    / (SELECT COUNT(*) FROM communities) AS avg_users_in_groups,
  FIRST_VALUE(CONCAT_WS(" ", users.first_name, users.last_name)) OVER w_community_birthday_desc AS youngest,
  FIRST_VALUE(CONCAT_WS(" ", users.first_name, users.last_name)) OVER w_community_birthday_asc AS oldest,
  COUNT(communities_users.user_id) OVER w_community AS users_in_group,
  (SELECT COUNT(*) FROM users) AS users_total,
  COUNT(communities_users.user_id) OVER w_community / (SELECT COUNT(*) FROM users) *100 AS '%%'
    FROM communities
      LEFT JOIN communities_users 
        ON communities_users.community_id = communities.id
      LEFT JOIN users 
        ON communities_users.user_id = users.id
      LEFT JOIN profiles 
        ON profiles.user_id = users.id
      WINDOW w_community AS (PARTITION BY communities.id),
             w_community_birthday_desc AS (PARTITION BY communities.id ORDER BY profiles.birthday DESC),
             w_community_birthday_asc AS (PARTITION BY communities.id ORDER BY profiles.birthday; 
