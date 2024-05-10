-- Все видео в плейлисте

select * from 
(select * from RelationshipVideosPlaylists where playlistid = 2) as plst
join videos on plst.videoid=videos.videoid

-- Все подписки пользователя

select * from 
(select * from subscriptions where subscriber=5) as authors
join users on users.userid = authors.subscribedto

-- Все видео пользователей на которых подписан пользователь

select videos.videoid, videos.authorid, videos.title, videos.slug, videos.description, videos.releasedate from
(select * from (select * from subscriptions where subscriber=5) as authors
join users on users.userid = authors.subscribedto) as subscriptions
join videos on videos.authorid = subscriptions.subscribedto
order by releasedate desc

-- Все видео которые лайкнул пользователь

select videos.videoid, videos.authorid, videos.title, videos.slug, videos.description, videos.releasedate from 
(select * from views 
where authorid=1 and liked=True) as likedvideos
join videos on videos.videoid=likedvideos.videoid
order by releasedate desc

-- Количество просмотров на всех видео пользователя

select count(views.videoid) from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid

-- Сумма лайков на всех видео пользователя

select count(views.liked) from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid
where liked = True

-- Имена и Фамилии всех, кто дизлайнул пользователя :)

select users.firstname, users.lastname, users.email from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid
join users on users.userid = views.authorid
where disliked = True

