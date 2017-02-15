-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;

CREATE TABLE player (
    ID      integer PRIMARY KEY,
    Name    varchar(50) NOT NULL
);

CREATE TABLE matches ( 
    WinnerID   integer,
    LoserID    integer 
);

CREATE VIEW record AS 
    SELECT player.ID, player.Name, Mule.wins, Mule.matches
    FROM (SELECT Temp1.ID AS ID, Temp1.wins AS wins, Temp1.wins + Temp2.loses AS matches
	  FROM (SELECT WinnerID AS ID, COUNT(*) AS wins
                FROM matches 
                GROUP BY WinnerID) AS Temp1,
               (SELECT LoserID AS ID, COUNT(*) AS loses
                FROM matches
                GROUP BY LoserID) AS Temp2
          WHERE Temp1.ID = Temp2.ID) AS Mule, player
    WHERE Mule.ID = player.ID
    ORDER BY Mule.wins, Mule.matches DESC;
