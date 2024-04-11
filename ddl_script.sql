DROP TABLE IF EXISTS RelationshipVideosCategories;
DROP TABLE IF EXISTS Views;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS RelationshipVideosPlaylists;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Playlists;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Categories;


CREATE TABLE Users(
	UserID SERIAL PRIMARY KEY,
	AccountName VARCHAR(128) NOT NULL UNIQUE,
	FirstName VARCHAR(128) NOT NULL,
	LastName VARCHAR(128) NOT NULL,
	Email VARCHAR(128) NOT NULL CHECK (Email LIKE '%@%'),
	ProfilePhotoPath VARCHAR(512),
	ProfileHeaderPath VARCHAR(512),
	ChannelDescription VARCHAR(2048),
	Slug VARCHAR(256) NOT NULL UNIQUE,
	RegistrationData TIMESTAMP NOT NULL
);

CREATE TABLE Videos(
	VideoID SERIAL PRIMARY KEY,
	VideoFilePath VARCHAR NOT NULL,
	ReleaseDate TIMESTAMP NOT NULL,
	Title VARCHAR NOT NULL,
	Description VARCHAR,
	IsPublished BOOLEAN DEFAULT False,
	Slug VARCHAR NOT NULL UNIQUE,
	PreviewImagePath TIMESTAMP,
	ValidFrom TIMESTAMP,
	ValidTo TIMESTAMP DEFAULT '5999-01-01 00:00:00'
);

CREATE TABLE Playlists(
	PlaylistID SERIAL PRIMARY KEY,
	Slug VARCHAR(256) NOT NULL,
	Title VARCHAR(128) NOT NULL,
	Description VARCHAR(256),
	AuthorID INTEGER REFERENCES Users(UserID)
);

CREATE TABLE Comments(
	CommentID SERIAL PRIMARY KEY,
	AuthorID INTEGER REFERENCES Users(UserID),
	VideoID INTEGER REFERENCES Videos(VideoID),
	CommentText VARCHAR(1024) NOT NULL,
	CreationData TIMESTAMP NOT NULL
);

CREATE TABLE Categories(
	CategoryName VARCHAR(128) PRIMARY KEY
);

INSERT INTO Categories(CategoryName) VALUES ('Video');

CREATE TABLE Views(
	UniqueID SERIAL PRIMARY KEY,
	AuthorID INTEGER REFERENCES Users(UserID),
	Liked BOOLEAN DEFAULT False,
	Disliked BOOLEAN DEFAULT False
);

CREATE TABLE Subscriptions(
	UnquieID SERIAL PRIMARY KEY,
	Subscriber INTEGER REFERENCES Users(UserID),
	SubscribedTo INTEGER REFERENCES Users(UserID)
);

CREATE TABLE RelationshipVideosPlaylists(
	UnquieID SERIAL PRIMARY KEY,
	VideoID INTEGER REFERENCES Videos(VideoID),
	PlaylistID INTEGER REFERENCES Playlists(PlaylistID)
);

CREATE TABLE RelationshipVideosCategories(
	UnquieID SERIAL PRIMARY KEY,
	VideoID INTEGER REFERENCES Videos(VideoID),
	CategoryName VARCHAR(128) REFERENCES Categories(CategoryName) DEFAULT 'Video'
);