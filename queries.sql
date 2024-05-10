-- 1) Все видео в плейлисте

select * from 
(select * from RelationshipVideosPlaylists where playlistid = 2) as plst
join videos on plst.videoid=videos.videoid

-- 2) Кол-во просмотров всех видео в плейлисте

select count(views.authorid) from
(select videoid from RelationshipVideosPlaylists where playlistid = 1) as plst_videos
join views on views.videoid = plst_videos.videoid

-- 3) Все подписки пользователя

select * from 
(select * from subscriptions where subscriber=5) as authors
join users on users.userid = authors.subscribedto

-- 4) Все видео пользователей на которых подписан пользователь

select videos.videoid, videos.authorid, videos.title, videos.slug, videos.description, videos.releasedate from
(select * from (select * from subscriptions where subscriber=5) as authors
join users on users.userid = authors.subscribedto) as subscriptions
join videos on videos.authorid = subscriptions.subscribedto
order by releasedate desc

-- 5) Просмотренные видео пользователя по категориям

select videos.videoid, videos.title, videos.slug, vidcats.categoryname from (select videoid from 
views where authorid = 2) as user_views
join videos on videos.videoid = user_views.videoid
join RelationshipVideosCategories as vidcats on vidcats.videoid = videos.videoid

-- 6) Любимые категории пользователя

select vidcats.categoryname, count(vidcats.categoryname) as cats_count from (select videoid from 
views where authorid = 2) as user_views
join videos on videos.videoid = user_views.videoid
join RelationshipVideosCategories as vidcats on vidcats.videoid = videos.videoid
group by categoryname
order by cats_count desc

-- 7) Все видео которые лайкнул пользователь

select videos.videoid, videos.authorid, videos.title, videos.slug, videos.description, videos.releasedate from 
(select * from views 
where authorid=1 and liked=True) as likedvideos
join videos on videos.videoid=likedvideos.videoid
order by releasedate desc

-- 8) Количество просмотров на всех видео пользователя

select count(views.videoid) from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid

-- 9) Сумма лайков на всех видео пользователя

select count(views.liked) from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid
where liked = True

-- 10) Имена и Фамилии всех, кто дизлайнул пользователя :)

select users.firstname, users.lastname, users.email from (select videoid from
videos where authorid=1) as user_videos
join views on views.videoid = user_videos.videoid
join users on users.userid = views.authorid
where disliked = True



