/* 8888888888888888888888888888888888888888888888888888888888888888888888888
Major Project -1
UNMESSENGER
oooooooooooooooooooooooooooooooooo
Social Media Interactions Analysis

This project will focus on analyzing user activities, hashtags, posts, and
comments on a social media platform using SQL queries. It is designed to
help you understand social media dynamics, including engagement
patterns, user behaviors, and content trends. By working through these
tasks, you will develop skills in writing efficient queries, aggregating data,
and deriving actionable insights from a database.

Project Scope
In this major project, you will be tasked with creating SQL queries to
address various aspects of social media interactions. Each question is
designed to explore different data points that provide insights into user
behavior, trending hashtags, and post performance.

Project Questions
1. Identify Users by Location
Write a query to find all posts made by users in specific locations such as
'Agra', 'Maharashtra', and 'West Bengal'.
Hint: Focus on filtering users by location.
2. Determine the Most Followed Hashtags
Write a query to list the top 5 most-followed hashtags on the platform.
Hint: Join relevant tables to calculate the total follows for each hashtag.
3. Find the Most Used Hashtags
Identify the top 10 most-used hashtags in posts.
Hint: Count how many times each hashtag appears in posts.
UNMESSENGER
4. Identify the Most Inactive User
Write a query to find users who have never made any posts on the
platform.
Hint: Use a subquery to identify these users.
5. Identify the Posts with the Most Likes
Write a query to find the posts that have received the highest number of
likes.
Hint: Count the number of likes for each post.
6. Calculate Average Posts per User
Write a query to determine the average number of posts made by users.
Hint: Consider dividing the total number of posts by the number of unique
users.
7. Track the Number of Logins per User
Write a query to track the total number of logins made by each user.
Hint: Join user and login tables.
8. Identify a User Who Liked Every Single Post
Write a query to find any user who has liked every post on the platform.
Hint: Compare the number of posts with the number of likes by this user.
9. Find Users Who Never Commented
Write a query to find users who have never commented on any post.
Hint: Use a subquery to exclude users who have commented.
10. Identify a User Who Commented on Every Post
Write a query to find any user who has commented on every post on the
platform.
Hint: Compare the number of posts with the number of comments by this
user.

11. Identify Users Not Followed by Anyone
Write a query to find users who are not followed by any other users.
Hint: Use the follows table to find users who have no followers.
12. Identify Users Who Are Not Following Anyone
Write a query to find users who are not following anyone.
Hint: Use the follows table to identify users who are not following others.
13. Find Users Who Have Posted More than 5 Times
Write a query to find users who have made more than five posts.
Hint: Group the posts by user and filter the results based on the number of
posts.
14. Identify Users with More than 40 Followers
Write a query to find users who have more than 40 followers.
Hint: Group the followers and filter the result for those with a high follower
count.
15. Search for Specific Words in Comments
Write a query to find comments containing specific words like "good" or
"beautiful."
Hint: Use regular expressions to search for these words.
16. Identify the Longest Captions in Posts
Write a query to find the posts with the longest captions.
Hint: Calculate the length of each caption and sort them to find the top 5
longest ones.

YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
Submission: The Entire assignment should be submitted by the end of the week
(Sunday,17/11/2024),You have to Submit one SQL Script in which all the Answer Queries
included. Upload the script in your GitHub Account.

*/

/*
 01. Identify Users by Location
	Write a query to find all posts made by users in specific locations such as
	'Agra', 'Maharashtra', and 'West Bengal'.
	Hint: Focus on filtering users by location.
*/
Select 	* 
from 	post
where 	location like '%Agra%' or location like '%maharashtra%' or location like '%West Bengal%' ;	-- 14

/*
02. Determine the Most Followed Hashtags
	Write a query to list the top 5 most-followed hashtags on the platform.
	Hint: Join relevant tables to calculate the total follows for each hashtag.
*/
Select 	count(f.hashtag_id)as TotalHastag,f.hashtag_id,h.hashtag_name
from	hashtag_follow f, hashtags h
where	h.hashtag_id=f.hashtag_id
group by f.hashtag_id
order by TotalHastag desc limit 5;

/*
03. Find the Most Used Hashtags
	Identify the top 10 most-used hashtags in posts.
	Hint: Count how many times each hashtag appears in posts.
*/

Select 		p.hashtag_id ,h.hashtag_name,count(p.hashtag_id) as HashtagCount
from 		post_tags p,hashtags h
where 		h.hashtag_id=p.hashtag_id
group by 	hashtag_id
order by 	HashtagCount desc
limit 10 ;

/*
04. Identify the Most Inactive User
	Write a query to find users who have never made any posts on the
	platform.
	Hint: Use a subquery to identify these users.
*/
select	User_id, username
from	users 
where  user_id not in (select 	distinct user_id
from	post);

/*
05. Identify the Posts with the Most Likes
	Write a query to find the posts that have received the highest number of
	likes.
	Hint: Count the number of likes for each post.
*/
select 	p.Post_id,n.caption,count(p.post_id) as LikesCount
from	post_likes p,post n
where	n.post_id=p.post_id
group by p.post_id
order by LikesCount desc;

/*
06. Calculate Average Posts per User
	Write a query to determine the average number of posts made by users.
	Hint: Consider dividing the total number of posts by the number of unique
	users.
*/
Select round(sum(t.NoOfPost)/sum(t.TotalUser),0)
from
(select 	count(*) as NoOfPost,0 as TotalUser
from 	post
union all
select 	0 as NoOfPost, count(*) as TotalUser 
from 	users) as t; 

/*
07. Track the Number of Logins per User
	Write a query to track the total number of logins made by each user.
	Hint: Join user and login tables.
*/

select 		l.User_id,u.username,count(l.user_id) as TotalLogIn
from 		login l, users u
where		u.user_id=l.user_id
group by	l.user_id 
order by 	l.user_id;

/*
8. Identify a User Who Liked Every Single Post
Write a query to find any user who has liked every post on the platform.
Hint: Compare the number of posts with the number of likes by this user.
*/

select 		count(*)  from 		post; -- 100
select t.user_id
from
(select 	user_id, count(user_id) as TotalLikes 
from 		post_likes
group by	user_id
order by 	user_id) as t 
where t.TotalLikes=(select count(*) from post);


/*
9. Find Users Who Never Commented
Write a query to find users who have never commented on any post.
Hint: Use a subquery to exclude users who have commented.
*/

select	User_id, username
from	users 
where  user_id not in (select 	distinct user_id
from	comments);

/* 
10. Identify a User Who Commented on Every Post
Write a query to find any user who has commented on every post on the
platform.
Hint: Compare the number of posts with the number of comments by this
user.
-- select count(*) from post; -- 100
-- select count(*) from comments; -- 199
*/
select t.user_id
from
		(select 	count(user_id)as TotalComments,User_id 
		from 		comments 
		group by 	user_id) as t
Where t.TotalComments=(select count(*) from post);

/*
11. Identify Users Not Followed by Anyone
Write a query to find users who are not followed by any other users.
Hint: Use the follows table to find users who have no followers.
*/
select	User_id, username
from	users 
where  	user_id not in (select 	distinct follower_id
from	follows);
/*
12. Identify Users Who Are Not Following Anyone
Write a query to find users who are not following anyone.
Hint: Use the follows table to identify users who are not following others.
*/
select	User_id, username
from	users 
where  	user_id not in (select 	distinct followee_id
from	follows);

/*
13. Find Users Who Have Posted More than 5 Times
Write a query to find users who have made more than five posts.
Hint: Group the posts by user and filter the results based on the number of
posts.
*/
select t.TotalPost,t.user_id,t.username
from
		(select 	count(p.user_id)as TotalPost,p.user_id,u.username 
		from 		post p,users u
		where		u.user_id=p.user_id
		group by 	p.user_id) as t
where 		t.TotalPost>=5; 

/*
14. Identify Users with More than 40 Followers
Write a query to find users who have more than 40 followers.
Hint: Group the followers and filter the result for those with a high follower
count.
*/
select 	t.TotalFollowler,t.follower_id,t.username
from
	(select 	count(f.follower_id)as TotalFollowler,f.follower_id,u.username 
	from 	follows f,users u
	where	u.user_id = f.follower_id
	group by f.follower_id)as t
where t.TotalFollowler > 40;

/*
15. Search for Specific Words in Comments
Write a query to find comments containing specific words like "good" or
"beautiful."
Hint: Use regular expressions to search for these words.
*/
select 	comment_text 
from	comments
where	comment_text like'%good%' or comment_text like '%beautiful%';
/*
16. Identify the Longest Captions in Posts
Write a query to find the posts with the longest captions.
Hint: Calculate the length of each caption and sort them to find the top 5
longest ones.
*/
select 	caption,length(caption)as TotalLength 
from 	post
order by length(caption) desc limit 5;