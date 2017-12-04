--James Holden--
--Final Project--
--11/27/2017--
drop table if exists pokeballSpawn;
drop table if exists itemUsed;
drop view if exists universeAndCharacterNames;
drop table if exists FromUniverse;
drop table if exists Universes;
drop view if exists CharacterWinsList;
drop table if exists Items;
drop table if exists Moves;
drop table if exists Achievements;
drop table if exists MatchHistory;
drop table if exists NPCs;
drop table if exists FinalSmash;
drop table if exists Players;
drop table if exists Maps;
drop table if exists Characters;

create table Characters(
	cid			serial,
	characterName		text not null,
	characterDesc		text not null,
	weight			int not null,
	speed			decimal not null,
	gravity			decimal not null,
	jumpNumber		int DEFAULT 2  not null,
	shieldType		text DEFAULT 'Bubble' not null,
	characterType		text not null,
	unlocked		bool not null DEFAULT true,
	starter			bool DEFAULT true not null,
	primary key (cid)	
	
	
);


create table Universes(
	uid serial,
	universeName text not null,
	primary key (Uid)
);


create table FromUniverse(
	uid 	int references Universes(uid),
	cid	serial references characters(cid),
	primary key (Uid, cid)
);


create table Maps(
mapid				char(3) unique not null,
	mapName			text not null,
	mapDesc			text not null,
	fromGame		text not null,
	playerCreated		bool not null DEFAULT false,
	legalCompetitionStage	bool not null DEFAULT false,
	primary key (mapid)

);



create table Players(
	pid			char(4) unique not null,
	playerName		text not null,
	losses			int not null DEFAULT 0,
	Kills			int not null DEFAULT 0,
	deaths 			int not null DEFAULT 0,
	mostUsedCharacter 	int not null references Characters(cid),
	wins			int DEFAULT 0,
	primary key (pid)
);


create table Moves(
	moveid			char(2) unique not null,
	moveName		text not null,
	damage			text not null,
	primary key (moveid)

);

create table Achievements(
	aid			char(2) unique not null,
	objective		text not null,
	reward			text not null,
	characterToUse		int references Characters(cid), 
	completed		bool not null DEFAULT false,
	primary key (aid)
);

create table MatchHistory(
	matchNumber		int not null,
	mapid			char(3) not null references Maps(mapid),
	numOfPlayers		int not null CHECK (numOfPlayers > 1 and numOfPlayers <= 8),
	dateAndTime		timestamp not null,
	matchDuration		time not null CHECK(matchDuration > '00:00:00'),
	matchType		text not null CHECK (matchType = 'Stock' OR matchType = 'Time'),
	winningPlayer		char(4)	not null references Players(pid),
	winningCharacter	int not null references Characters(cid),
	primary key(matchNumber)			
);

create table NPCs(
	NPCid		int not null,
	NPCType		text not null,
	NPCName		text not null,
	NPCDesc		text not null,
	primary key (NPCid)
	
);

create table Items(
	iid			int unique not null,
	itemName		text not null,
	itemDesc		text not null,
	primary key (iid)
);

create table PokeballSpawn(
	iid		int not null references Items(iid),
	NPCid		int not null references NPCs(NPCid),
	primary key (iid, NPCid)
);

create table FinalSmash(
	smashid		serial,
	cid		serial references Characters(cid),
	smashName	text not null,
	primary key(smashid)
	
);

create table itemUsed(
	matchnumber	int references MatchHistory(matchNumber),
	iid		int references Items(iid),
	Primary Key (matchnumber, iid)
);




--Characters Table Data--

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mario', 'The main character of the mario series. A well balanced easy to play character.', 98, 1.6, 0.08715, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Luigi', 'Mario''s brother of the mario series. A well balanced easy to play character.', 97, 1.5, 0.075, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Peach', 'The main princess of the mario series. A floaty character with strong attacks.', 89, 1.4175, 0.068, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Bowser', 'The antagonist of the mario series. A slow moving character with powerful attacks.', 130, 1.792, 0.11, 'Creature');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Dr. Mario', 'A different version of Mario with stronger attacks but slower speed.', 98, 1.312, 0.08715, 'Human', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, shieldType)
VALUES ('Yoshi', 'One of the heroes of the Mario series. Has very good neutral attacks', 104, 1.86, 0.08, 'Creature', 'Egg');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Donkey Kong', 'Antagonist from the original Mario Game. Powerful character that is very heavy', 122, 1.7031, 0.08505, 'Animal');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Diddy Kong', 'Character from the Donkey Kong series. A fast monkey character.', 93, 1.824, 0.105, 'Animal');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Link', 'The main character from the Legend of Zelda Series. A skilled swordsman.', 104, 1.3944,  0.096, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Zelda', 'Princess from the Legend of Zelda Series. A character with magic abilities.', 85, 1.3, 0.071, 'human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Sheik', 'An alter ego of Zelda. An extremely fast character', 81, 2.016, 0.15, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Ganondorf', 'The main antagonist in Nintendo''s The Legend of Zelda video game series. A character with powerful B-Moves.', 113, 1.218, 0.107835, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Toon Link', 'The cartoon version of the character Link. Differs slightly in moves and attributes.', 93, 1.7325, 0.079, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Samus', 'The protagonist of the Metroid Series. A woman with an extremely powerful exoskeleton power-suit.', 108, 1.504, 0.077, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Zero Suit Samus', 'A version of Samus without her power-suit.', 80, 2.1, 0.12, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, jumpNumber)
VALUES ('Kirby', 'Main character of the kirby series. A floaty character than can copy other characters moves.', 108, 1.57, 0.06405, 'Creature', 6);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, jumpNumber)
VALUES ('Meta Knight', 'A character from the Kirby Series.', 80, 1.9, 0.11, 'Creature', 6);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, jumpNumber)
VALUES ('King Dedede', 'The Antagonist of the Kirby Series. A large floaty character.', 119, 1.36, 0.087885, 'Creature', 5);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Fox', 'The protagonist of the Starfox Series. A very fast character with powerful smash moves.', 79, 2.184, 0.19, 'Animal');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Falco', 'A character of the Starfox Series. A very fast character.', 82, 1.472, 0.13, 'Animal', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Pikachu', 'A creature from the Pokemon Series. Has electric attacks.', 79, 1.85325, 0.095, 'Pokemon');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, shieldType, jumpNumber)
VALUES ('Jigglypuff', 'A creature from the Pokemon Series. Very floaty with weak attacks but good aerials.', 68, 1.155, 0.053088, 'Pokemon', 'Large Bubble', 6);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mewtwo', 'A creature from the Pokemon Series. A legendary pokemon created by scientists.', 74, 2.04, 0.082, 'Pokemon');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, jumpNumber)
VALUES ('Charizard', 'A creature from the Pokemon Series. A flying dragon Pokemon.', 116, 2, 0.085, 'Pokemon', 3);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Lucario', 'A creature from the Pokemon Series. A fox-like Pokemon with a rage ability that makes him stronger the more damage he takes.', 99, 1.55, 0.084, 'Pokemon');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Captain Falcon', 'A character from the F-Zero series. A fast character with powerful B-Moves.', 104, 2.32, 0.12, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Ness', 'A character from the Earthbound series and my personal favorite.', 94, 1.46265, 0.077, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Lucas', 'Ness''s Brother. Similar to Ness with better ground game and weaker aerial game.', 94, 1.5, 0.09, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Marth', 'A character from the Fire Emblem Series. An expert swordsman', 90, 1.785, 0.075, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Roy', 'A character from the Fire Emblem Series. He is a semi-clone of Marth.', 95, 1.95, 0.114, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Ike', 'A character from the Fire Emblem Series. A swordsman with good special attacks.', 107, 1.5, 0.092, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Mr. Game & Watch', 'A character from Nintendo''s line of handheld electronic games, called "Game & Watch".', 75, 1.5264, 0.08, 'Human', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, jumpNumber)
VALUES ('Pit', 'A character from the Kid Icarus series. A fast flying character.', 96, 1.66215, 0.081, 'Human', 4);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Wario', 'A character from the Mario Series. This character is Mario''s arch-rival.', 107, 1.5, 0.092, 'Human', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Olimar', 'A character from Nintendo''s Pikmin series. He can have several Pikmin follow and assist him in battle.', 79, 1.47, 0.068, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('R.O.B.', 'A character derived from Nintendo''s accessory for NES. A robot with jets and powerful attacks.', 106, 1.568, 0.09, 'Robot', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Sonic', 'The main character of the Sonic Series. The fastest character in the game.', 94, 3.5, 0.09, 'Animal');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Rosalina & Luma', 'The princess from Super Mario Galaxy. Rosalina can use Luma to attack.', 77, 1.632, 0.062, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Bowser Jr.', 'Bowser''s son and heir to the throne. A smaller, lighter version of Bowser.', 108, 1.424, 0.092, 'Creature');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Greninja', 'A creature from the Pokemon series. An incredibly fast water type pokemon.', 94, 2.08, 0.18, 'Pokemon');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Robin', 'A character from the Fire Emblem series. He uses a book of magic and a sword.', 95, 1.15, 0.089, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Lucina', 'A character from the Fire Emblem series. She is a female clone of Marth.', 90, 1.785, 0.075, 'Human', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Corrin', 'A character from the Fire Emblem series. A swordsman with a sword that can extend to attack enemies at great lengths.', 98, 1.45, 0.092, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Palutena', 'A character from Kid Icarus. Can use magic to defeat opponents.', 91, 1.888, 0.105, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter, jumpNumber)
VALUES ('Dark Pit', 'A complete clone of the Pit character.', 96, 1.66215, 0.081, 'Human', false, 4);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Villager', 'From the Animal Crossing Game series. A small character with powerful attacks.', 97, 1.27, 0.078, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Little Mac', 'A boxer from the game Punch-0ut!. Very powerful at close range with no long range moves.', 82, 2.24, 0.08, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Wii Fit Trainer', 'A character from Nintendo''s Wii Fit game. Has attacks with lots of damage.', 96, 1.696, 0.09, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Shulk', 'A character from the game Xenoblade. This character can switch between abilities and wields a powerful sword.', 102, 1.52, 0.085, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType, starter)
VALUES ('Duck Hunt', 'A dog and bird sidekick from Nintendo''s game, Duck Hunt. A solid fighter that can summon some NPCs.', 91, 1.63, 0.076, 'Animal', false);

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mega Man', 'The main character from the Megaman game series. A weaponized Robot that resembles a 10 year old human boy.', 102, 1.456, 0.1071, 'Robot');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Pac-Man', 'The main character of Pac-Man. Pac-man has many moves that allude to his original debut in the 1980 game PAC-MAN.', 95, 1.52, 0.072, 'Creature');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Ryu', 'A character from the Street Fighter arcade game. Has powerful punches and kicks.', 103, 1.6, 0.12, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Cloud', 'A character from the Final Fantasy series. He wields a giant sword and can charge his B ability through combat.', 100, 1.97, 0.098, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Bayonetta', 'A character from the Bayonetta game series. She is a witch who uses various firearms along with shapeshifting in combat.', 84, 1.6, 0.12, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mii Brawler', 'A customizable avatar from Nintendo''s game console. The user can select a Mii that exists within the console to use as a character. The Brawler is a fighter that uses fists and close combat..', 100, 1.72, 0.1, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mii Swordfighter', 'A customizable avatar from Nintendo''s game console. The user can select a Mii that exists within the console to use as a character. The Swordfighter is a Mii that uses swords to fight opponents.', 100, 1.5, 0.096, 'Human');

INSERT INTO Characters (characterName, characterDesc, weight, speed, gravity, characterType)
VALUES ('Mii Gunner', 'A customizable avatar from Nintendo''s game console. The user can select a Mii that exists within the console to use as a character. The Gunner uses firearm projectiles in order to attack enemies in game..', 100, 1.3, 0.08715, 'Human');


--Items Table Data--

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('01', 'Pokeball', 'After being thrown by a player, this item will summon a random Pokemon once it makes contact with any platform on the Map.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('02', 'Backshield', 'As the name would suggest, the item protects the fighter''s rear from harm.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('03', 'Ray Gun', 'A Ray Gun can be shot 16 times before it runs out of ammunition. Each shot does 2-4% damage.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('04', 'Killer Eye', 'When the holder throws it down, it activates, then launches pink energy in the direction it faces.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('05', 'Lightning Bolt', 'When used, it will shrink every other character to minimal size, and reduce their attack power to 0.7x.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('06', 'Deku Nut', 'When it explodes by being thrown, attacked, or timed out, any character in its blast range (including the thrower) becomes stunned, making them vulnerable to a free hit.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('07', 'Fire Bar', 'When swung, the Fire Bar deals fire damage, alongside moderate knockback and damage, with a forward smash being able to KO opponents at 50% when fully charged.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('08', 'Food', 'Heals the player slightly, can heal anywhere from 1-12% damage.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('09', 'Banana Peel', 'The Banana Peel can be thrown like any other regular item, and when a character other than its thrower steps on it they slip and are temporarily stunned. ');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('10', 'Beam Sword', 'As a battering item, the Beam Sword will bolster the player''s power.');

INSERT INTO Items (iid, itemName, itemDesc)
VALUES ('11', 'Beetle', 'The Beetle is a throwable item. It can potentially One-Hit KO opponents by sending them to the upper blast line.');


--NPC Table Data--

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('01', 'Enemy', 'Metal Mario', 'A super-heavy fighter bearing an edited Mario series symbol. Metal Mario is a metallic version of Mario. He is fought on stage 9 of the 1P Game.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('02', 'Pokemon', 'Snorlax', 'Snorlax leaps off the screen and returns larger. It descends with the force of its full body weight.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('03', 'Pokemon', 'Deoxys', 'Deoxys appears in its Attack form. It silently ascends to the top of the stage, where it will proceed to unleash a vertical beam of energy.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('04', 'Pokemon', 'Snivy', 'Snivy releases a flurry of leaves in a horizontal trajectory. It is the successor to Chikorita.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('05', 'Pokemon', 'Fennekin', 'Fennekin releases a small fireball that bursts into a large pillar of flames upon impact. Opponents will take repeated damage.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('06', 'Pokemon', 'Meowth', 'Meowth will hurl coins in a horizontal trajectory and will switch the direction it''s oriented to face opponents.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('07', 'Pokemon', 'Goldeen', 'Goldeen flops on the ground, causing no damage in the process.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('08', 'Pokemon', 'Kyogre', 'Kyogre homes-in on an opponent releases a consistent stream of water that pushes them off the screen. It usually causes an one-hit KO.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('09', 'Neutral', 'Mr. Saturn', 'Walks around the screen doing no damage. He can be picked up and thrown at the enemy for very little damage.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('10', 'Boss', 'Master Hand', 'A giant hand, the final boss.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('11', 'Boss', 'Yellow Devil', 'The Yellow Devil appears as a boss on the Wily Castle stage, where, if defeated, ends in a large explosion damaging nearby players except the one who defeated it.');

INSERT INTO NPCs (NPCid, NPCType, NPCName, NPCDesc)
VALUES ('12', 'Boss', 'Ridley', 'A dragon that appears as a boss on the Pyrosphere stage, where, if damaged enough, he can join a fighter''s side and be KO''d as a normal fighter.');

--Achievements Table Data--

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('01', 'Clear the true Solo All-Star mode on normal or higher while playing as Captain Falcon without healing between rounds.', '	Deathborn (trophy)', '26');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('02', 'Clear Crazy Orders while playing as Villager.', 'Rover (trophy)', '46');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('03', 'Play as PAC-MAN in Stage 3 and score 300000 or more in Solo Target Blast with a single bomb off the back wall.', 'Whomp (trophy)', '52');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('04', 'Play as Ganondorf and hit Sandbag at least 1000m (3280 ft.) in Solo Home-Run Contest.', 'King K.Rool (trophy)', '12');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('05', '	Play as Meta Knight and score 90 KOs or more in Solo Endless Smash.', 'Substitute Doll (trophy)', '17');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('06', 'Play as Bowser Jr. in Stage 1 and get a score of 150000 or more in a single game of Solo Target Blast.', 'Countdown Drill (equipment)', '39');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('07', 'Clear Solo Classic in 12 minutes at intensity 9.0 while playing as Marth.', 'Critical Hitter Sword (equipment)', '29');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('08', 'Clear a Master Order on Hard difficulty or higher while playing as King Dedede.', 'King Dedede''s Theme (music)', '18');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('09', 'Play alone and as Dr. Mario and get a Fever Rush 8 or more times in a single game of Trophy Rush.', '100,000G', '05');

INSERT INTO Achievements(aid, objective, reward, characterToUse)
VALUES('10', 'Clear Solo Classic on intensity 5.5 or higher while playing as Kirby.', 'Kirby''s Adventure (masterpiece)', '16');

--Players Table Data--

INSERT INTO Players(pid, playerName, mostUsedCharacter, kills)
VALUES('a000', 'AI(Computer Player)', '01', 1);

INSERT INTO Players(pid, playerName, Kills, mostUsedCharacter)
VALUES('a001', 'JT', 359, '27');

INSERT INTO Players(pid, playerName, losses, Kills, mostUsedCharacter)
VALUES('a002', 'Squid', 359, 20, '16');

INSERT INTO Players(pid, playerName, losses, Kills, deaths, mostUsedCharacter)
VALUES('a003', 'Alan', 120, 0, 200, '08');

INSERT INTO Players(pid, playerName, losses, Kills, deaths, mostUsedCharacter)
VALUES('a004', 'Daniel', 140, 400, 365, '10');

INSERT INTO Players(pid, playerName, losses, Kills, deaths, mostUsedCharacter)
VALUES('a005', 'Syries', 1000, 3000, 1000, '22');

INSERT INTO Players(pid, playerName, losses, Kills, deaths, mostUsedCharacter)
VALUES('a006', 'PwnStar', 50, 100, 600, '50');

INSERT INTO Players(pid, playerName, losses, Kills, deaths, mostUsedCharacter)
VALUES('a007', 'Norrisaurus', 500, 1000, 200, '46');

INSERT INTO Players(pid, playerName, losses, deaths, mostUsedCharacter, kills)
VALUES('a008', 'K1ll3r', 50, 250, '47', 1);

INSERT INTO Players(pid, playerName, Kills, mostUsedCharacter)
VALUES('a009', '1337', 9999999, '22');

--Maps Table Data--

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame, legalCompetitionStage)
VALUES(01, 'Final Destination', 'The stage consists of a single floating platform with no hazards.', 'Super Smash Brothers(1999)', true);

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame)
VALUES(02, 'Wii Fit Studio', 'Wii Fit Studio consists mainly in a large floor covering all the horizontal range of the screen up to the lateral blast lines: there are no pits of any kind.', 'Wii Fit(2007)');

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame)
VALUES(03, 'Boxing Ring', 'The boxing ring lies inside of an indoor stadium. An overhead light fixture hangs above the ring, along with a jumbotron in the background with large speakers astride of it.', 'Punch-Out!(1983)');

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame)
VALUES(04, 'Pyrosphere', 'The main body of Pyrosphere is a fairly long platform with a metallic surface mounted on top of a tall metal shaft extending down below the surface of the lava. Above it floats four metallic platforms sporting green glowing strips wrapped around them. The lava appears pouring in the background, but doesn''t affect the playing area.', 'Metroid: Other M(2010)');

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame)
VALUES(05, 'Wily Castle', 'The main body of the stage is a flat body which fighters cannot go underneath. There are two floating platforms at either side of the stage, suspended beyond the body of the stage.', 'Mega Man(1987)');

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame, legalCompetitionStage)
VALUES(06, 'Smashville', 'The stage''s scenery changes from night to day depending on the Wii''s internal clock. Players battle on a platform with a moving horizontal jump-through platform suspended above an Animal Crossing town while spectators watch on.', 'Animal Crossing(2001)', true);

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame)
VALUES(07, 'Bridge of Eldin', 'ridge of Eldin is normally completely flat, reaching both lateral blast lines. Occasionally, a horn is heard: King Bulblin then rides across the stage, dealing damage to any fighters he rides into.', 'The Legend of Zelda: Twilight Princess(2006)');

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame, legalCompetitionStage)
VALUES(08, 'Battlefield', 'Battlefield consists of a central, solid platform, with ledges at its sides that can be grabbed. Above this platform, there are three more soft platforms, arranged in a triangular layout.', 'Super Smash Brothers(1999)', true);

INSERT INTO Maps(mapid, mapName, mapDesc, fromGame, playerCreated)
VALUES(09, 'JT''s Map', 'This is a map I made using the SSB4 map creator', 'Super Smash Brothers WiiU(2014)', true);




--Match History Table Data--

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(01, 02, 8, '07/17/1997 11:31:06', '00:05:36', 'Stock', 'a001', 27);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(02, 05, 8, '07/17/2017 13:42:03', '00:05:00', 'Time', 'a001', 27);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(03, 06, 2, '08/08/2015 10:00:06', '00:10:00', 'Time', 'a009', 05);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(04, 09, 2, '12/31/2014 16:43:21', '00:07:04', 'Stock', 'a003', 31);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(05, 01, 5, '12/04/2017 23:34:59', '23:00:00', 'Time', 'a009', 57);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(06, 09, 3, '10/21/2015 15:31:52', '00:03:30', 'Stock', 'a006', 24);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(07, 07, 4, '07/21/2016 12:31:25', '00:10:36', 'Stock', 'a001', 10);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(08, 03, 4, '06/21/2016 03:31:25', '00:05:36', 'Stock', 'a005', 01);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(09, 02, 4, '05/14/2016 05:31:38', '00:20:00', 'Time', 'a006', 5);

INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
VALUES(10, 04, 4, '12/08/2016 02:31:19', '00:05:36', 'Stock', 'a001', 27);


--Universes Table Data--

INSERT INTO Universes(universeName)
VALUES('Mario');

INSERT INTO Universes(universeName)
VALUES('Yoshi');

INSERT INTO Universes(universeName)
VALUES('Donkey Kong');


INSERT INTO Universes(universeName)
VALUES('The Legend of Zelda');


INSERT INTO Universes(universeName)
VALUES('Metroid');


INSERT INTO Universes(universeName)
VALUES('Kirby');


INSERT INTO Universes(universeName)
VALUES('Star Fox');

INSERT INTO Universes(universeName)
VALUES('Pokemon');

INSERT INTO Universes(universeName)
VALUES('F-Zero');

INSERT INTO Universes(universeName)
VALUES('EarthBound');


INSERT INTO Universes(universeName)
VALUES('Fire Emblem');

INSERT INTO Universes(universeName)
VALUES('Game & Watch');

INSERT INTO Universes(universeName)
VALUES('Kid Icarus');

INSERT INTO Universes(universeName)
VALUES('Wario');

INSERT INTO Universes(universeName)
VALUES('Pikmin');

INSERT INTO Universes(universeName)
VALUES('R.O.B.');

INSERT INTO Universes(universeName)
VALUES('Sonic');

INSERT INTO Universes(universeName)
VALUES('Animal Crossing');

INSERT INTO Universes(universeName)
VALUES('Punch-Out!');

INSERT INTO Universes(universeName)
VALUES('Wii Fit');

INSERT INTO Universes(universeName)
VALUES('Xenoblade');

INSERT INTO Universes(universeName)
VALUES('Duck Hunt');

INSERT INTO Universes(universeName)
VALUES('Mega Man');

INSERT INTO Universes(universeName)
VALUES('Pac-Man');

INSERT INTO Universes(universeName)
VALUES('Street Fighter');

INSERT INTO Universes(universeName)
VALUES('Final Fantasy');

INSERT INTO Universes(universeName)
VALUES('Bayonetta');

INSERT INTO Universes(universeName)
VALUES('Mii');


--FromUniverse Table Data--

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('2');

INSERT INTO FromUniverse(Uid)
VALUES('3');

INSERT INTO FromUniverse(Uid)
VALUES('3');

INSERT INTO FromUniverse(Uid)
VALUES('4');

INSERT INTO FromUniverse(Uid)
VALUES('4');

INSERT INTO FromUniverse(Uid)
VALUES('4');

INSERT INTO FromUniverse(Uid)
VALUES('4');

INSERT INTO FromUniverse(Uid)
VALUES('4');

INSERT INTO FromUniverse(Uid)
VALUES('5');

INSERT INTO FromUniverse(Uid)
VALUES('5');

INSERT INTO FromUniverse(Uid)
VALUES('6');

INSERT INTO FromUniverse(Uid)
VALUES('6');

INSERT INTO FromUniverse(Uid)
VALUES('6');

INSERT INTO FromUniverse(Uid)
VALUES('7');

INSERT INTO FromUniverse(Uid)
VALUES('7');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('9');

INSERT INTO FromUniverse(Uid)
VALUES('10');

INSERT INTO FromUniverse(Uid)
VALUES('10');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('12');

INSERT INTO FromUniverse(Uid)
VALUES('13');

INSERT INTO FromUniverse(Uid)
VALUES('14');

INSERT INTO FromUniverse(Uid)
VALUES('15');

INSERT INTO FromUniverse(Uid)
VALUES('16');

INSERT INTO FromUniverse(Uid)
VALUES('17');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('1');

INSERT INTO FromUniverse(Uid)
VALUES('8');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('11');

INSERT INTO FromUniverse(Uid)
VALUES('13');

INSERT INTO FromUniverse(Uid)
VALUES('13');

INSERT INTO FromUniverse(Uid)
VALUES('18');

INSERT INTO FromUniverse(Uid)
VALUES('19');

INSERT INTO FromUniverse(Uid)
VALUES('20');

INSERT INTO FromUniverse(Uid)
VALUES('21');

INSERT INTO FromUniverse(Uid)
VALUES('22');

INSERT INTO FromUniverse(Uid)
VALUES('23');

INSERT INTO FromUniverse(Uid)
VALUES('24');

INSERT INTO FromUniverse(Uid)
VALUES('25');

INSERT INTO FromUniverse(Uid)
VALUES('26');

INSERT INTO FromUniverse(Uid)
VALUES('27');

INSERT INTO FromUniverse(Uid)
VALUES('28');

INSERT INTO FromUniverse(Uid)
VALUES('28');

INSERT INTO FromUniverse(Uid)
VALUES('28');


--Populating the Items Table--

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 01, 05);

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 04, 06);

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 06, 01);

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 07, 03);

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 01, 07);

INSERT INTO ItemUsed(iid, matchNumber)
VALUES( 02, 09);

--Final Smash Table Data--

INSERT INTO FinalSmash(smashid, smashName)
SELECT cid, CONCAT(characterName, '''s Final Smash')
FROM characters;

--Populating the Pokeball Spawn Table--

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 2);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 3);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 4);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 5);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 6);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 7);

INSERT INTO PokeballSpawn(iid, NPCid)
VALUES(1, 8);


-- This part goes through the Match History table and counts the wins for each player, and then updates the players wins in the Players Table--

UPDATE Players
SET Wins = 	(SELECT COUNT(winningPlayer)
		FROM MatchHistory
		WHERE winningPlayer = Players.pid
		)
FROM matchHistory as mh
WHERE Players.pid = mh.winningPlayer;

--This one sets all the characters that are not starters to be locked. Since the game does not start with them, they have to be unlocked still.--



UPDATE Characters
SET unlocked = false
WHERE starter = false;

DROP FUNCTION IF EXISTS updateWins();


--Function to Update the wins in the player table whenever a match is added to the matchHistory Table--
CREATE OR REPLACE FUNCTION updateWins() RETURNS trigger AS $$
	BEGIN
		UPDATE Players
		SET Wins = 	(SELECT COUNT(winningPlayer)
				FROM MatchHistory
				WHERE winningPlayer = Players.pid
				)
		FROM matchHistory as mh
		WHERE Players.pid = mh.winningPlayer;
		RETURN new;
	END;	
	$$ Language plpgsql;
	
--Trigger for when there is an insert on MatchHistory, this will automatically update the players wins.--

CREATE TRIGGER checkWins
AFTER INSERT on MatchHistory
EXECUTE PROCEDURE updateWins();

--When Inserting this new row into MatchHistory, the Players table's Wins Columns will automatically update.--
--INSERT INTO MatchHistory(matchNumber, mapid, numOfPlayers, dateAndTime, matchDuration, matchType, winningPlayer, winningCharacter)
--VALUES(11, 04, 4, '12/08/2016 02:31:19', '00:05:36', 'Stock', 'a002', 27);

--View of which characters won how many times-- 

CREATE VIEW CharacterWinsList AS
	SELECT winningCharacter, COUNT(winningCharacter) AS wins
		FROM matchHistory
		GROUP BY winningCharacter;


--This creates a view of all the character names and the names of their respective universes--
CREATE VIEW universeAndCharacterNames AS
SELECT c.characterName, u.universeName 
FROM FromUniverse as f, universes as u, Characters as c 
WHERE f.uid = u.uid 
AND c.cid = f.cid 
AND c.cid = f.cid 
AND u.uid = f.uid 
ORDER BY u.universeName;

SELECT*
FROM universeAndCharacterNames;


--This function will check the match history and see which character has been used to win the most--


DROP FUNCTION IF EXISTS getBestCharacter();

CREATE OR REPLACE FUNCTION getBestCharacter() RETURNS int AS
		'SELECT winningCharacter
		FROM CharacterWinsList
		ORDER BY wins DESC
		LIMIT 1;'
		Language sql;

SELECT* FROM getBestCharacter();


--Sample Queries--

--Selects Name of Character with highest speed--

SELECT characterName
FROM characters
WHERE speed in (SELECT max(speed)
		FROM Characters);

--Selects achievements that you have to use the character captain falcon to complete, without knowing captain falcons ID--

SELECT*
FROM Achievements
WHERE characterToUse IN (
			SELECT cid
			FROM Characters
			WHERE characterName = 'Captain Falcon'
);

SELECT* FROM getBestCharacter();
