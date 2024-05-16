-- Индекс для таблицы видео. Часто нам нужны самые новые видео
create index idx_videos_by_time_idx on Videos (ValidFrom)

-- Аналогично с комментариями
create index idx_comments_idx on Comments (CreationData)

-- Часто поиск видео происходит именно по заголовку - этот индекс должен оптимизировать поиск
create index idx_videos_titles_idx on Videos (Title)

-- Аналогично с плейлистами
create index idx_playlists_titles_idx on Playlists (Title)

-- Нас часто интересуют подписки на какого-то из пользователя

create index idx_subscribers_idx on Subscriptions(Subscriber)

-- Так же и в обратную сторону
create index idx_subscribed_on_idx on Subscriptions(SubscribedTo)