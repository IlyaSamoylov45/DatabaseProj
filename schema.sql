DROP DATABASE IF EXISTS `project`;
CREATE DATABASE  IF NOT EXISTS `project`;
USE `project`;

DROP TABLE IF EXISTS `Administrator`;
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
    `alertTime` DATETIME,
    PRIMARY KEY(`username`, `gameID`),
    FOREIGN KEY(`username`) REFERENCES `Account`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`gameID`) REFERENCES `VideoGame`(`gameID`) ON DELETE CASCADE ON UPDATE CASCADE
);

/*================================================================================================================*/
 
/*================================================================================================================*/
/*												Test															  */
/*================================================================================================================*/

INSERT INTO `Account`(`username`, `password`) VALUES ('endusr1', 'pass');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('endusr1', 'Bruce','Wayne','1 Twinwig Apt 36','brucewayne@gmail.com'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('endusr2', 'pass');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('endusr2', 'John','Smith','35 Hamilton St','JohnSmith@gmail.com'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('endusr3', 'pass');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('endusr3', 'Liza','Wood','55 Washington St','liazawood@gmail.com'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('endusr4', 'pass');
INSERT INTO `EndUser`(`username`, `firstname`, `lastname`, `address`, `email`) VALUES ('endusr4', 'Anisa','Woodsworth','55 Washington St','anisawoodsworth@gmail.com'); 

INSERT INTO `Account`(`username`, `password`) VALUES ('rep', 'pass');
INSERT INTO `Cust_Representative` (`username`,  `firstname`,`lastname`,`email`) VALUES ('rep', 'Reggie', 'Tomwat', 'reggietomwat@yahoo.com');
    
INSERT INTO `Account`(`username`, `password`) VALUES ('admin', 'pass');
INSERT INTO `Administrator`(`username`) VALUES ('admin'); 

INSERT INTO `Question`(`questionID`, `sender`, `question`, `content`) VALUES (1, 'endusr1', 'What is 9 + 10?', 'Lorem ipsum dolor sit amet, ad iisque facilis duo, q');
INSERT INTO `Answer`(`answerID` ,`responder` ,  `answer` ) VALUES (1,'rep','its 21!');

INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (1, 'endusr1', 'endusr2', NOW(), 'Lorem ipsum dolor sit amet, ad iisque facilis duo, quod officiis quaestio et eum. Vel mazim choro at, feugait iudicabit et nec. Id vidisse fastidii mei, dicam gubergren sea id, pri erant postea forensibus in. Qui hendrerit vulputate cu, qui cu justo voluptatibus.', 'Lorem');

INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (1, 'batman arkham knight', 'Action', 'Xbox One', 'Not Working', 'Single-Player');
INSERT INTO `Everyone`(`gameID`, `mild_language`, `mild_violence`) VALUES (1, 1, 1);

INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (2, 'league of legends', 'MOBA', 'PC', 'Used', 'Online');
INSERT INTO `Teen`(`gameID` ,`suggestive_themes`, `violence`, `crude_humor` , `minimal_blood`, `gambling`, `strong_language`) VALUES(2,1,1,1,1,0,1);

INSERT INTO `VideoGame`(`gameID`, `game_name`,`genre`, `platform`, `condition`, `total_players`) VALUES (3, 'State of Decay 2', 'Survival', 'Xbox One', 'New', 'Co-op');
INSERT INTO `Mature`(`gameID` ,`violence` , `blood_gore`, `sexual_content` , `strong_language`, `drug_use`) VALUES (3,1,1,1,0,1);

INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (1, 1, NOW(), DATE_ADD(now(), INTERVAL 10 DAY), 20.00, 5.00, null, 'endusr2', 50.00, null, 'Batmanz iz coolz');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (2, 2, NOW(), DATE_ADD(now(), INTERVAL 5 DAY), 50.00, 10.00, 'endusr3', 'endusr1', 50.00,  now(), 'League of Lego: Don\'t step on it.');
INSERT INTO `Auction`(`auctionID`,`gameID`, `dateCreated`, `dateClosing`, `initial_price` , `minimum_increase`, `buyer`, `seller`, `minimum_sell`,`sell_time`,`information`) VALUES (3, 3, NOW(), DATE_ADD(now(), INTERVAL 15 DAY), 10.00, 5.00, null, 'endusr3', 20.00, null, 'Lorem Ipsum');
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (20, 'endusr4',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (25, 'endusr1',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (30, 'endusr4',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (35, 'endusr1',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (40, 'endusr4',NOW(),1); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (20, 'endusr2',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (25, 'endusr4',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (30, 'endusr2',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (35, 'endusr4',NOW(),3); 
INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES (100, 'endusr2',NOW(),3); 

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


SELECT A.*, G.game_name FROM Auction A, VideoGame G, Bid B WHERE A.`gameID` = G.`gameID` AND BINARY A.seller = BINARY '" + testing + "' AND B.auctionID = A.auctionID AND B.amount > A.minimum_sell
**/