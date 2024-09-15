use ig_clone;
#1 Loyal user
select * from users
order by created_at
limit 5;
#2 inactive user engagement
select username
from users
left join photos
on users.id = photos.user_id
where photos.id is null;

#3 Contest winner Declaration
select
username, photos.id, photos.image_url, count(likes.user_id) as total
from photos
inner join likes
on likes.photo_id = photos.id
inner join users
on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

#4 hastag research
select
tags.tag_name,
count(*) as total
from photo_tags
join tags
on photo_tags.tag_id = tags.id
group by tags.id
order by total desc
limit 5;

#5 ad campaign launch

select
DAYNAME(created_at) as day, count(*) as total
from users
group by day
order by total desc
limit 1;

#investors
#1 user engagement

select
(select count(*) from photos) / (select count(*) from users) as avg;

#2 fake accounts

select user_id, count(*) as num_likes
from likes
group by user_id
having num_likes = (select count(*) from photos);
select u.username, count(*) as num_likes
from users u
join likes l on u.id = l.user_id
group by u.id
having num_likes = (select count(*) from photos);