-- Представление пользователей без конфеденциальных данных
create or replace view safe_user as
select Users.UserID, Users.AccountName, Users.ProfilePhotoPath, Users.ProfileHeaderPath, Users.ChannelDescription, Users.slug, Users.RegistrationData
from Users

-- Только техническая информация о видео
create or replace view video_tech as
select Videos.VideoID, Videos.IsPublished, Videos.Slug, Videos.PreviewImagePath
from Videos

-- Все подписки пользователя
create or replace view user_subscriptions
select * from 
(select * from subscriptions where subscriber=5) as authors
join users on users.userid = authors.subscribedto

-- Все лайкнутые пользователем видео
create or replace view user_liked as
select videos.videoid, videos.authorid, videos.title, videos.slug, videos.description, videos.releasedate from 
(select * from views 
where authorid=1 and liked=True) as likedvideos
join videos on videos.videoid=likedvideos.videoid
order by releasedate desc
