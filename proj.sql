DROP DATABASE IF EXISTS `project`;
CREATE DATABASE  IF NOT EXISTS `project`;
USE `project`;

DROP TABLE IF EXISTS `Admin`;
DROP TABLE IF EXISTS `EndUser`;
DROP TABLE IF EXISTS `Cust_Representative`;
DROP TABLE IF EXISTS `Account`;

/* THIS TAKES CARE OF END USERS, CUSTOMER REPRESENTATIVES AND ADMINISTRATORS WHICH ARE ALL 'Accounts' THERE IS ALSO 'Email' WHICH IS FOR COMMUNICATION BETWEEN ENDUSERS AND REPRESENTATIVES*/
/*author ILYA SAMOYLOV */
CREATE TABLE `Account` (
	`username` CHAR(50) BINARY,
	`password` CHAR(50) BINARY NOT NULL,
	PRIMARY KEY (`username`)
);
CREATE TABLE `Administrator` (
	`username` CHAR(50) BINARY,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `EndUser` (
	`username` CHAR(50) BINARY,
	`firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
	`address` CHAR (50) NOT NULL,
	`email` CHAR(50) NOT NULL,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Cust_Representative` (
	`username` CHAR(50) BINARY,
    `firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
    `email` CHAR(50) NOT NULL,
    PRIMARY KEY(`username`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Email`;
CREATE TABLE `Email` (
	`messageID` INTEGER,
	`from` CHAR(50),
    `to` CHAR(50), 
	`dateTime` DATETIME,  
    `content` TEXT NOT NULL,
    `subject` CHAR(50) NOT NULL,
    PRIMARY KEY (`messageID`)
);

/*THESE ARE THE VIDEOGAMES TABLE AND THE RATING SCALES WITH THREE HIERARCHICAL SUBCATEGORIES AND ALERT FOR VIDEOGAME*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Everyone`;
DROP TABLE IF EXISTS `Teen`;
DROP TABLE IF EXISTS `Mature`;
DROP TABLE IF EXISTS `VideoGame`;

CREATE TABLE `VideoGame`(
	`gameID` INTEGER AUTO_INCREMENT,
    `game_name` CHAR(50) NOT NULL,
    `genre` ENUM('Action', 'Horror', 'Strategy', 'FPS', 'Adventure', 'Sports', 'Role-playing' ) NOT NULL,
	`platform` ENUM('Xbox', 'PC', 'Nintendo', 'Playstation', 'Cross-Platform') NOT NULL,
    `condition` ENUM('Not Working', 'Used', 'Like-New', 'Brand New') NOT NULL,
    `total_players` ENUM('Single-Player', 'Co-op', 'Multiplayer', 'All') NOT NULL,
    PRIMARY KEY(`gameID`)
);


/* THESE ARE RATING SCALES */
CREATE TABLE `Everyone` (
	`gameID` INTEGER,
    `mild_language` BIT NOT NULL,
    `mild_violence` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Teen`(
	`gameID` INTEGER,
    `suggestive_themes` BIT NOT NULL,
    `violence` BIT NOT NULL,
    `crude_humor` BIT NOT NULL,
    `minimal_blood` BIT NOT NULL,
    `gambling` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Mature`(
	`gameID` INTEGER,
    `violence` BIT NOT NULL,
    `blood_gore` BIT NOT NULL,
    `sexual_content` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    `drug_use` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/* THIS WILL BE WHERE THE AUCTION TABLE IS AND PARTICIPATION AND BID*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Auction`;
CREATE TABLE `Auction`(
	`auctionID` INTEGER AUTO_INCREMENT,
	`gameID` INTEGER NOT NULL,
    `dateCreated` DATETIME NOT NULL,
    `dateClosing` DATETIME NOT NULL,
    `initial_price` FLOAT NOT NULL,
    `minimum_increase` FLOAT,
    `buyer` CHAR(50) BINARY,
    `seller` CHAR(50) BINARY NOT NULL,
    `minimum_sell` FLOAT,
    `sell_time` DATETIME,
    `information` TEXT,
    PRIMARY KEY(`auctionID`),
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(`buyer`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`seller`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Bid`;
DROP TABLE IF EXISTS `AutoBid`;

CREATE TABLE `Bid`(
	`amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `bidder`, `amount`),
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE `AutoBid`(
	`max_amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `max_amount`, `bidder`), /* Make trigger to make sure same user doesnt autobid against themselves, but be able to increasetheir autobid if they are outbid*/
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);


/* THIS IS HOW USERS ASK AND ANSWER QUESTIONS ALSO ALERTS*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Answer`;
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	`questionID` INTEGER,
	`sender` CHAR(50),
    `question` CHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`questionID`)
);

CREATE TABLE `Answer`(
	`answerID` INTEGER,
	`responder` CHAR(50) NOT NULL,
    `answer` TEXT NOT NULL,
    PRIMARY KEY(`answerID`),
    FOREIGN KEY(`answerID`) REFERENCES `Question`(`questionID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Alert`(
	`username` CHAR(50) BINARY,
    `auctionID` INTEGER,
	`gameID` INTEGER,
    PRIMARY KEY(`username`, `gameID`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/*================================================================================================================*/

/*================================================================================================================*/
INSERT INTO `Account`(`username`, `password`) VALUES ('admin', 'admin');
INSERT INTO `Administrator`(`username`) VALUES ('admin'); 
INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (1, 'frotest', 'testing', NOW(), 'contenttest', 'subjecttest');
INSERT INTO `Question`(`questionID`, `sender`, `question`, `content`) VALUES (1, 'testuser', 'isthisaquestion?', 'YOANSWERME');
INSERT INTO `Account`(`username`, `password`) VALUES ('testing', 'testing');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testing', 'testing','testing','testing','testing'); 
INSERT INTO `Account`(`username`, `password`) VALUES ('testingtwo', 'testingtwo');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testingtwo', 'testingtwo','testingtwo','testingtwo','testingtwo'); 
INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (1, 'gametwo', 'Action', 'Xbox', 'Not Working', 'Single-Player');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (1, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
DROP DATABASE IF EXISTS `project`;
CREATE DATABASE  IF NOT EXISTS `project`;
USE `project`;

DROP TABLE IF EXISTS `Admin`;
DROP TABLE IF EXISTS `EndUser`;
DROP TABLE IF EXISTS `Cust_Representative`;
DROP TABLE IF EXISTS `Account`;

/* THIS TAKES CARE OF END USERS, CUSTOMER REPRESENTATIVES AND ADMINISTRATORS WHICH ARE ALL 'Accounts' THERE IS ALSO 'Email' WHICH IS FOR COMMUNICATION BETWEEN ENDUSERS AND REPRESENTATIVES*/
/*author ILYA SAMOYLOV */
CREATE TABLE `Account` (
	`username` CHAR(50) BINARY,
	`password` CHAR(50) BINARY NOT NULL,
	PRIMARY KEY (`username`)
);
CREATE TABLE `Administrator` (
	`username` CHAR(50) BINARY,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `EndUser` (
	`username` CHAR(50) BINARY,
	`firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
	`address` CHAR (50) NOT NULL,
	`email` CHAR(50) NOT NULL,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Cust_Representative` (
	`username` CHAR(50) BINARY,
    `firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
    `email` CHAR(50) NOT NULL,
    PRIMARY KEY(`username`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Email`;
CREATE TABLE `Email` (
	`messageID` INTEGER,
	`from` CHAR(50),
    `to` CHAR(50), 
	`dateTime` DATETIME,  
    `content` TEXT NOT NULL,
    `subject` CHAR(50) NOT NULL,
    PRIMARY KEY (`messageID`)
);

/*THESE ARE THE VIDEOGAMES TABLE AND THE RATING SCALES WITH THREE HIERARCHICAL SUBCATEGORIES AND ALERT FOR VIDEOGAME*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Everyone`;
DROP TABLE IF EXISTS `Teen`;
DROP TABLE IF EXISTS `Mature`;
DROP TABLE IF EXISTS `VideoGame`;

CREATE TABLE `VideoGame`(
	`gameID` INTEGER AUTO_INCREMENT,
    `game_name` CHAR(50) NOT NULL,
    `genre` ENUM('Action', 'Horror', 'Strategy', 'FPS', 'Adventure', 'Sports', 'Role-playing' ) NOT NULL,
	`platform` ENUM('Xbox', 'PC', 'Nintendo', 'Playstation', 'Cross-Platform') NOT NULL,
    `condition` ENUM('Not Working', 'Used', 'Like-New', 'Brand New') NOT NULL,
    `total_players` ENUM('Single-Player', 'Co-op', 'Multiplayer', 'All') NOT NULL,
    PRIMARY KEY(`gameID`)
);


/* THESE ARE RATING SCALES */
CREATE TABLE `Everyone` (
	`gameID` INTEGER,
    `mild_language` BIT NOT NULL,
    `mild_violence` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Teen`(
	`gameID` INTEGER,
    `suggestive_themes` BIT NOT NULL,
    `violence` BIT NOT NULL,
    `crude_humor` BIT NOT NULL,
    `minimal_blood` BIT NOT NULL,
    `gambling` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Mature`(
	`gameID` INTEGER,
    `violence` BIT NOT NULL,
    `blood_gore` BIT NOT NULL,
    `sexual_content` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    `drug_use` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/* THIS WILL BE WHERE THE AUCTION TABLE IS AND PARTICIPATION AND BID*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Auction`;
CREATE TABLE `Auction`(
	`auctionID` INTEGER AUTO_INCREMENT,
	`gameID` INTEGER NOT NULL,
    `dateCreated` DATETIME NOT NULL,
    `dateClosing` DATETIME NOT NULL,
    `initial_price` FLOAT NOT NULL,
    `minimum_increase` FLOAT,
    `buyer` CHAR(50) BINARY,
    `seller` CHAR(50) BINARY NOT NULL,
    `minimum_sell` FLOAT,
    `sell_time` DATETIME,
    `information` TEXT,
    PRIMARY KEY(`auctionID`),
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(`buyer`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`seller`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Bid`;
DROP TABLE IF EXISTS `AutoBid`;

CREATE TABLE `Bid`(
	`amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `bidder`, `amount`),
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE `AutoBid`(
	`max_amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `max_amount`, `bidder`), /* Make trigger to make sure same user doesnt autobid against themselves, but be able to increasetheir autobid if they are outbid*/
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);


/* THIS IS HOW USERS ASK AND ANSWER QUESTIONS ALSO ALERTS*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Answer`;
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	`questionID` INTEGER,
	`sender` CHAR(50),
    `question` CHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`questionID`)
);

CREATE TABLE `Answer`(
	`answerID` INTEGER,
	`responder` CHAR(50) NOT NULL,
    `answer` TEXT NOT NULL,
    PRIMARY KEY(`answerID`),
    FOREIGN KEY(`answerID`) REFERENCES `Question`(`questionID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Alert`(
	`username` CHAR(50) BINARY,
    `auctionID` INTEGER,
	`gameID` INTEGER,
    PRIMARY KEY(`username`, `gameID`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/*================================================================================================================*/

/*================================================================================================================*/
INSERT INTO `Account`(`username`, `password`) VALUES ('admin', 'admin');
INSERT INTO `Administrator`(`username`) VALUES ('admin'); 
INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (1, 'frotest', 'testing', NOW(), 'contenttest', 'subjecttest');
INSERT INTO `Question`(`questionID`, `sender`, `question`, `content`) VALUES (1, 'testuser', 'isthisaquestion?', 'YOANSWERME');
INSERT INTO `Account`(`username`, `password`) VALUES ('testing', 'testing');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testing', 'testing','testing','testing','testing'); 
INSERT INTO `Account`(`username`, `password`) VALUES ('testingtwo', 'testingtwo');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testingtwo', 'testingtwo','testingtwo','testingtwo','testingtwo'); 
INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (1, 'gametwo', 'Action', 'Xbox', 'Not Working', 'Single-Player');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (1, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
DROP DATABASE IF EXISTS `project`;
CREATE DATABASE  IF NOT EXISTS `project`;
USE `project`;

DROP TABLE IF EXISTS `Admin`;
DROP TABLE IF EXISTS `EndUser`;
DROP TABLE IF EXISTS `Cust_Representative`;
DROP TABLE IF EXISTS `Account`;

/* THIS TAKES CARE OF END USERS, CUSTOMER REPRESENTATIVES AND ADMINISTRATORS WHICH ARE ALL 'Accounts' THERE IS ALSO 'Email' WHICH IS FOR COMMUNICATION BETWEEN ENDUSERS AND REPRESENTATIVES*/
/*author ILYA SAMOYLOV */
CREATE TABLE `Account` (
	`username` CHAR(50) BINARY,
	`password` CHAR(50) BINARY NOT NULL,
	PRIMARY KEY (`username`)
);
CREATE TABLE `Administrator` (
	`username` CHAR(50) BINARY,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `EndUser` (
	`username` CHAR(50) BINARY,
	`firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
	`address` CHAR (50) NOT NULL,
	`email` CHAR(50) NOT NULL,
	PRIMARY KEY (`username`),
	FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Cust_Representative` (
	`username` CHAR(50) BINARY,
    `firstname` CHAR(50) NOT NULL,
	`lastname` CHAR(50) NOT NULL,
    `email` CHAR(50) NOT NULL,
    PRIMARY KEY(`username`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Email`;
CREATE TABLE `Email` (
	`messageID` INTEGER,
	`from` CHAR(50),
    `to` CHAR(50), 
	`dateTime` DATETIME,  
    `content` TEXT NOT NULL,
    `subject` CHAR(50) NOT NULL,
    PRIMARY KEY (`messageID`)
);

/*THESE ARE THE VIDEOGAMES TABLE AND THE RATING SCALES WITH THREE HIERARCHICAL SUBCATEGORIES AND ALERT FOR VIDEOGAME*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Everyone`;
DROP TABLE IF EXISTS `Teen`;
DROP TABLE IF EXISTS `Mature`;
DROP TABLE IF EXISTS `VideoGame`;

CREATE TABLE `VideoGame`(
	`gameID` INTEGER AUTO_INCREMENT,
    `game_name` CHAR(50) NOT NULL,
    `genre` ENUM('Action', 'Horror', 'Strategy', 'FPS', 'Adventure', 'Sports', 'Role-playing' ) NOT NULL,
	`platform` ENUM('Xbox', 'PC', 'Nintendo', 'Playstation', 'Cross-Platform') NOT NULL,
    `condition` ENUM('Not Working', 'Used', 'Like-New', 'Brand New') NOT NULL,
    `total_players` ENUM('Single-Player', 'Co-op', 'Multiplayer', 'All') NOT NULL,
    PRIMARY KEY(`gameID`)
);


/* THESE ARE RATING SCALES */
CREATE TABLE `Everyone` (
	`gameID` INTEGER,
    `mild_language` BIT NOT NULL,
    `mild_violence` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Teen`(
	`gameID` INTEGER,
    `suggestive_themes` BIT NOT NULL,
    `violence` BIT NOT NULL,
    `crude_humor` BIT NOT NULL,
    `minimal_blood` BIT NOT NULL,
    `gambling` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Mature`(
	`gameID` INTEGER,
    `violence` BIT NOT NULL,
    `blood_gore` BIT NOT NULL,
    `sexual_content` BIT NOT NULL,
    `strong_language` BIT NOT NULL,
    `drug_use` BIT NOT NULL,
    PRIMARY KEY(`gameID`),
    FOREIGN KEY (`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/* THIS WILL BE WHERE THE AUCTION TABLE IS AND PARTICIPATION AND BID*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Auction`;
CREATE TABLE `Auction`(
	`auctionID` INTEGER AUTO_INCREMENT,
	`gameID` INTEGER NOT NULL,
    `dateCreated` DATETIME NOT NULL,
    `dateClosing` DATETIME NOT NULL,
    `initial_price` FLOAT NOT NULL,
    `minimum_increase` FLOAT,
    `buyer` CHAR(50) BINARY,
    `seller` CHAR(50) BINARY NOT NULL,
    `minimum_sell` FLOAT,
    `sell_time` DATETIME,
    `information` TEXT,
    PRIMARY KEY(`auctionID`),
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(`buyer`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`seller`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Bid`;
DROP TABLE IF EXISTS `AutoBid`;

CREATE TABLE `Bid`(
	`amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `bidder`, `amount`),
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE `AutoBid`(
	`max_amount` FLOAT,
    `bidder` CHAR(50) BINARY,
    `time_of_bid` DATETIME NOT NULL,
    `auctionID` INTEGER,
    PRIMARY KEY(`auctionID`, `max_amount`, `bidder`), /* Make trigger to make sure same user doesnt autobid against themselves, but be able to increasetheir autobid if they are outbid*/
    FOREIGN KEY(`auctionID`) REFERENCES `Auction`(`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`bidder`) REFERENCES `EndUser`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);


/* THIS IS HOW USERS ASK AND ANSWER QUESTIONS ALSO ALERTS*/
/*AUTHOR ILYA SAMOYLOV */
DROP TABLE IF EXISTS `Answer`;
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	`questionID` INTEGER,
	`sender` CHAR(50),
    `question` CHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`questionID`)
);

CREATE TABLE `Answer`(
	`answerID` INTEGER,
	`responder` CHAR(50) NOT NULL,
    `answer` TEXT NOT NULL,
    PRIMARY KEY(`answerID`),
    FOREIGN KEY(`answerID`) REFERENCES `Question`(`questionID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Alert`(
	`username` CHAR(50) BINARY,
    `auctionID` INTEGER,
	`gameID` INTEGER,
    PRIMARY KEY(`username`, `gameID`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/*================================================================================================================*/

/*================================================================================================================*/
INSERT INTO `Account`(`username`, `password`) VALUES ('admin', 'admin');
INSERT INTO `Administrator`(`username`) VALUES ('admin'); 
INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (1, 'frotest', 'testing', NOW(), 'contenttest', 'subjecttest');
INSERT INTO `Question`(`questionID`, `sender`, `question`, `content`) VALUES (1, 'testuser', 'isthisaquestion?', 'YOANSWERME');

INSERT INTO `Account`(`username`, `password`) VALUES ('testing', 'testing');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testing', 'testing','testing','testing','testing'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('testingtwo', 'testingtwo');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testingtwo', 'testingtwo','testingtwo','testingtwo','testingtwo'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('testingthree', 'testingthree');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testingthree', 'testingthree','testingthree','testingthree','testingthree'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('testingfour', 'testingfour');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('testingfour', 'testingfour','testingfour','testingfour','testingfour'); 

INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (1, 'gametwo', 'Action', 'Xbox', 'Not Working', 'Single-Player');
INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (2, 'gameone', 'FPS', 'Xbox', 'Used', 'Co-op');


INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (1, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (2, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (3, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (4, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (5, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (6, 1, NOW(), NOW(), 20.00, 5.00, null, 'testing', 5.00, NOW(), 'ey');

INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (50.00, 'testing', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (1000.00, 'testingtwo', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (2340.00, 'testingthree', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (5420.00, 'testingtwo', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (54350.00, 'testing', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (53453450.00, 'testingtwo', NOW(), 1);
INSERT INTO `Bid`(`amount`,`bidder`, `time_of_bid`, `auctionID`) VALUES (553453450.00, 'testingthree', NOW(), 1);

/**
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),5); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1070, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1700, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1007, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),2); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),6); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),7); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),8); 
**/


/**
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),5); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1070, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1700, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1007, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),2); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),6); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),7); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),8); 
**/


/**
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),5); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1070, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1700, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (1007, 'testing',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),2); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),6); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),7); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'testing',NOW(),8); 
**/