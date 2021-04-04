%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%..%%%%%%%%%%%%%%%%%%%%..%%%...........%%%..%%%%%%%%%%%%%....%%%%%%%%%%%%%..%%%%%%%%%%%%%...........%..............%%%%.........%%%...........%%%..%%%%%%%%%%%.....%%%%%%%%%%%%%.....%%%%%%%%%%%................
%..%%%%%%%%%%%%%%%%%%%%..%%%...........%%%..%%%%.....%%%%%...%%%%%%%%%%%%%..%%%%.....%%%%%.........%%%.............%%%%.........%%%...........%%%..%%%%%%%%%%%...%%%%%%%%%%%%%%%%%...%%%%%%%%%%%................
%..%%%%%%%%%%............%%%...........%%%..%%%%.....%%%%%%..%%%%...........%%%%.....%%%%%%.......%%%%%............%%%%.........%%%...........%%%.....%%%%%.....%%%%%%%%%%%%%%%%%%%.....%%%%%...................
%..%%%%%%%%%%............%%%...........%%%..%%%%.....%%%%%...%%%%...........%%%%.....%%%%%.......%%%%%%%...........%%%%.........%%%...........%%%.....%%%%%.....%%%%%%..................%%%%%...................
%...%%%%%%%%%%%%%%%%.....%%%...........%%%..%%%%.....%%%.....%%%%%%%%%%%%%..%%%%.....%%%........%%%%%%%%%..........%%%%.........%%%...........%%%.....%%%%%.....%%%%....................%%%%%...................
%.....%%%%%%%%%%%%%%.....%%%...........%%%..%%%%%%%%%%.......%%%%%%%%%%%%%..%%%%%%%%%%%........%%%%%%%%%%%.........%%%%.........%%%...........%%%.....%%%%%.....%%%%....%%%%%%%%%%%.....%%%%%...................
%.....%%%%%%%%%%%%%%%%...%%%%.........%%%%..%%%%.............%%%%...........%%%%.....%%.........%%%%%%%%%..........%%%%.........%%%%.........%%%%.....%%%%%.....%%%%....%%%%%%%%%%%.....%%%%%...................
%...........%%%%%%%%%%...%%%%%.......%%%%%..%%%%.............%%%%...........%%%%.....%%..........%%%%%%%...........%%%%.........%%%%%.......%%%%%.....%%%%%.....%%%%%%.........%%%%.....%%%%%...................
%...........%%%%%%%%%%...%%%%%%.....%%%%%%..%%%%.............%%%%...........%%%%.....%%%..........%%%%%............%%%%.........%%%%%%.....%%%%%%.....%%%%%.....%%%%%%%%%%%%%%%%%%%.....%%%%%...................
%..%%%%%%%%%%%%%%%%%%%....%%%%%%%%%%%%%%%...%%%%.............%%%%%%%%%%%%%..%%%%.....%%%...........%%%.............%%%%%%%%%%%...%%%%%%%%%%%%%%%...%%%%%%%%%%%...%%%%%%%%%%%%%%%%%...%%%%%%%%%%%................
%..%%%%%%%%%%%%%%%%%%%......%%%%%%%%%%%.....%%%%.............%%%%%%%%%%%%%..%%%%.....%%%%...........%..............%%%%%%%%%%%.....%%%%%%%%%%%.....%%%%%%%%%%%....%%%%%%%%%%%%%%%....%%%%%%%%%%%................

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                           Developed by Owen Glofcheski
%                                                                                    Mrs. Eagles
%                                                                      Course Culminating, Monday January 26 2009
%                                                                         Course Culminating:SUPER LUIGI WORLD
%                                         This program was created for the purpose of game, entertainment and emulation of the original mario games
%                         This program is a 2D side scrolling luigi game which emulates the original Mario games for the NES and SNES using basic physics and movement commands.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The Turing programming language is incapable of effectively running two things at a single time and instead creates an illusion of this by picking processes at random and running them, because of this
% animations become more complicated as everything must run back to back. I originally concepted a more elaborate game however in my current state I am only capable of a certain caliber of math a
% physics knowledge such as deceleration due to gravity. Turings graphic capablities cause the game to suffer severe framerate slowdowns limiting the picture overlays to only a background and foreground.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setscreen ("graphics:380;300,position:middle;centre,nobuttonbar,title:Super Luigi World")
%Sets the screen size to 380 x 300, the screen to the center of the screen, removes the button bar and writes the title "Super Luigi World"
setscreen ("offscreenonly") %All pictures are drawn off the screen until a View.Update commands updates them onto the screen, this reduces flicker

var x, y, x2, y2, x3, y3 : real := 0 %x and y represent luigi's bottom left corner, x2 and y2 represent the foreground's bottom left corner, x3 and y3 represent the background's bottom left corner
var chars : array char of boolean %Predefined array used to determine when a key is pressed down
var font : int := Font.New ("comicsans:10")
%The font used in the program, a basic "put" could not work because it would interupt background and foreground pictures, however a Draw.Font command draws ontop of previous pictures


%Picture and music files do not require a directory to find them, a directory only allows it to find them faster, by removing directories from the picture and music files the game is more flexible in where it can be stored
%============================CHARACTER SPRITES==================================
var luigi_standR : int := Pic.FileNew ("luigi_stand.bmp") %Luigi's basic stand facing right 
var luigi_runR : int := Pic.FileNew ("luigi_run.bmp") %Luigi's first running animation facing right
var luigi_runR2 : int := Pic.FileNew ("luigi_run2.bmp") %Luigi's second running animation facing right
var luigi_jumpR : int := Pic.FileNew ("luigi_jump.bmp") %Luigi's jump animation while going upwards facing right
var luigi_fallR : int := Pic.FileNew ("luigi_fall.bmp") %Luigi's jump animations while falling downwards facing right
var luigi_duckR : int := Pic.FileNew ("luigi_duck.bmp") %Luigi ducking down facing right
var luigi_flyR : int := Pic.FileNew ("luigi_fly.bmp") %Luigi during flight, can only be found using the "godmode" cheat facing right
var luigi_finish : int := Pic.FileNew ("luigi_finish.bmp") %Luigi giving the peace sign, shown after capturing a star facing right
var luigi_standL : int := Pic.Mirror (luigi_standR) %Luigi standing facing left
var luigi_runL : int := Pic.Mirror (luigi_runR) %Luigi running facing left
var luigi_runL2 : int := Pic.Mirror (luigi_runR2) %Luigi's second running animation facing left
var luigi_jumpL : int := Pic.Mirror (luigi_jumpR) %Luigi jumping upwards facing left
var luigi_fallL : int := Pic.Mirror (luigi_fallR) %Luigi jumping downwards facing left
var luigi_duckL : int := Pic.Mirror (luigi_duckR) %Luigi ducking facing left
var luigi_flyL : int := Pic.Mirror (luigi_flyR) %Luigi flying facing left

%==========================================LEVELS=======================================================
%-------Level 1----------
var world1_1 : int := Pic.FileNew ("world1-1.bmp") %Picture file of world 1-1's foreground
var world1_1background : int := Pic.FileNew ("world1-1background.bmp") %Picture file of world 1-1's background
%-------Level 2----------
var world1_2 : int := Pic.FileNew ("world1-2.bmp") %Picture file of world 1-2's foreground
var world1_2background : int := Pic.FileNew ("world1-2background.bmp") %Picture file of world 1-2's background
%-------Intro------------
var introworld : int := Pic.FileNew ("intro_world.bmp") %Picture file the intro world's background foreground
var introworld_background : int := Pic.FileNew ("intro_world_background.gif") %Picture file of the intro world's background

var world : int %The foreground picture of the world determined by worldchoose is assinged to this variable, a variable is used for the foreground so the program reguires less if statements
var worldbackground : int %The background picture of the world determined by worldchoose is assinged to this variable, a variable is used for the background so the program require's less if statements

%-============================MENU ITEMS=================================
var title : array 1 .. 8 of int %Array of title screens in different shades, running through the picture files in order creates a fading effect, the higher the array number the darker the picture
title (1) := Pic.FileNew ("title_screen.bmp")
title (2) := Pic.FileNew ("title_screen2.bmp")
title (3) := Pic.FileNew ("title_screen3.bmp")
title (4) := Pic.FileNew ("title_screen4.bmp")
title (5) := Pic.FileNew ("title_screen5.bmp")
title (6) := Pic.FileNew ("title_screen6.bmp")
title (7) := Pic.FileNew ("title_screen7.bmp")
title (8) := Pic.FileNew ("title_screen8.bmp")
var choose_icon : int := Pic.FileNew ("choose_icon.bmp") %Picture icon that shows where the cursor is when navigating the menu
var main_menu : int := Pic.FileNew ("main_menu.bmp") %Picture file that shows various navigation options from the main menu
var world_menu : int := Pic.FileNew ("world_menu.bmp") %Picture file that shows various world options
var cheat_menu : int := Pic.FileNew ("cheat_menu.bmp") %Picture file that shows various cheat options
var music_menu : int := Pic.FileNew ("music_menu.bmp") %Picture file that shows various music option
var menu_star : int := Pic.FileNew ("menu_star.bmp") %Picture file that shows how many stars the user has captured in the game
var menu : string := "main" %Depending on the value of this variable the menu picture file changes along with the option   ie... "cheat" brings up the cheat menu along with various options
var music : string := "mario" %Depending on the value of this variable the music played in the menu and various worlds changes, options are; mario, zelda, and techno

%=======================NON-CHARACTER SPRITES===========================
var coin : int := Pic.FileNew ("coin.bmp") %Normal coin sprite picture file
var star : int := Pic.FileNew ("star.bmp") %Star sprite picture file
var purplecoin : int := Pic.FileNew ("purplecoin.bmp") %Purple coin sprite picture file
var infoblock : int := Pic.FileNew ("infoblock.bmp") %Info block sprite picture file
var switch1_2 : int := Pic.FileNew ("world1-2switch.bmp") %Unactivated switch sprite picture file for world 1-2
var switchactive1_2 : int := Pic.FileNew ("world1-2activeswitch.bmp") %Switch sprite picture file for world 1-2 after switch has been activated
var switchintro : int := Pic.FileNew ("introworldswitch.bmp") %Unactivated switch sprite picture file for the introduction world
var switchactiveintro : int := Pic.FileNew ("introworldactiveswitch.bmp") %Switch sprite picture file for the introduction world have switch has been activated
var switch : int %Becomes a picture file of a switch based upon whether or not the switch is or is not activated

%======================NONCHARACTER SPRITE VARIABLES==========================
var coinnum : int := 20 %This variable represents the number of normal coin sprites placed in each level
var purplecoinnum : int := 8 %This variable represents the number of purple coin sprites placed in each level
var starnum : int := 2 %This variable represents the number of star sprites placed in each level
var switchnum : int := 1 %This variable represents the number of switch sprites placed in each level
var infonum := 3 %This variable represents the number of infoblocks placed in the introduction level
var worldcoinx : array 1 .. coinnum of int %This variable represents all of the x-coordinates of the normal coins sprites
var worldcoiny : array 1 .. coinnum of int %This variable represents all of the y-coordinates of the normal coins sprites
var worldpurplex : array 1 .. purplecoinnum of int %This variable represents all of the x-coordinates of the purple coin sprites
var worldpurpley : array 1 .. purplecoinnum of int %This variable represents all of the y-coordinates of the purple coin sprites
var worldstarx : array 1 .. starnum of int %This variable represents all of the x-coordinates of the star sprites
var worldstary : array 1 .. starnum of int %This variable represents all of the y-coordinates of the star sprites
var worldswitchx : array 1 .. switchnum of int %This variable represents all of the x-coordinates of the switch sprites
var worldswitchy : array 1 .. switchnum of int %This variable represents all of the y-coordinates of the switch sprites
var infox : array 1 .. infonum of int %This variable represents all of the x-coordinates of the info block sprites
infox (1) := 1416
infox (2) := 951
infox (3) := 243
var infoy : array 1 .. infonum of int %This variable represents all of the y-coordinates of the info block sprites
infoy (1) := 244
infoy (2) := 75
infoy (3) := 90
var starcap : array 1 .. 7 of boolean := init (false, false, false, false, false, false, false) %This variable represents which stars out of 7 the player has captured

%=====================CHARACTER ANIMATION VARIABLES============================
var runcounter : int := 0 %The counter used to determine which picture is drawn in luigi's running animation
var death : boolean %The variable that determines whether or not luigi has died, if it equals true luigi has done something that has caused death, this boolean is needed because it's possible to die during the jump procedure and the death has to be carried over into the programs body 
var stand : string %The variable that determines which direction luigi is standing (either left or right), if the value is "left" it will draw the normal animation except mirrored
var velocity : real := 2.1 %This variable represents luigi's initial upward velocity when jumping or falling, altering this value can increase or decrease the height of luigi's jump

var godx, gody, button : int %These variables represent the mouse location and determine if a button is pressed, the mouse is only used when using the "test mode" cheat
var character : string (1) %This variable is assigned using getch and is used in the menu menu for navigation, progressing [ENTER] or backtracking "c"
var worldchoose : string %This variable represents which world is chosen by the player and is used when determining which music is played and which world is drawn
var iconlocation : int := 0 %This variable represents the location of the navigation icon on the main menu, the value of this variable determines which menu choice the icon is positioned beside
var coincount : int %This variable holds the total value of all the coins collected by luigi in a single level
var purplecoincount : int %This variable holds the total value of all the purple coins collected by luigi in a single level

%%%%%CHEATS%%%%%%%%%%%
var godmode : boolean := false %Represents if the godmode cheat is on or off, true for on, false for off
var testmode : boolean := false %Represents if the testmode cheat is on or off, true for on, false for off
%%%%%%%%%%%%%%%%%%%%%%

var clear : boolean %Represents whether the world is complete or not, needed because it's possible to clear a world during the jump procedure and thus the clear must be carried over into the programs body

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PROCESSES/PROCEDURE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
process PlayBackgroundMusic %Process plays music depending on which music type has been chosen and which world has been chosen
    loop %Loops the music so it plays the music over continuously in a loop until the music changes
	if worldchoose = "intro" then %If the worl you are playing in is the introduction world
	    if music = "zelda" then %If the type of music is zelda music
		Music.PlayFile ("worldintromusic2.mp3") %Zelda music for the intro world
	    elsif music = "techno" then %If the type of music is techno music
		Music.PlayFile ("worldintromusic3.mp3") %Techno music for the intro world
	    else %If the type of music is mario music
		Music.PlayFile ("worldintromusic.mp3") %Mario music for the intro world
	    end if
	elsif worldchoose = "1-1" then %If the level you are playing in is world 1-1
	    if music = "zelda" then %If the type of music is zelda music
		Music.PlayFile ("world1-1music2.mp3") %Zelda music for world 1-2
	    elsif music = "techno" then %If the type of music is techno music
		Music.PlayFile ("world1-1music3.mp3") %Techno music for world 1-2
	    else %If the type of music is mario music
		Music.PlayFile ("world1-1music.mp3") %Mario music for world 1-2
	    end if
	else %If the world you are plyaing in is world 1-2
	    if music = "zelda" then %If the type of music is zelda music
		Music.PlayFile ("world1-2music2.mp3") %Zelda music for world 1-1
	    elsif music = "techno" then %If the type of music is techno music
		Music.PlayFile ("world1-2music3.mp3") %Techno music for world 1-1
	    else %If the type of music is mario music
		Music.PlayFile ("world1-2music.mp3") %Mario music for world 1-1
	    end if
	end if
    end loop
end PlayBackgroundMusic

process PlayTitleMusic %Process plays music depending solely on which music type has been chosen while navigating the menu
    loop %Loops the music so it plays the music over continuously in a loop until the music changes
	if music = "zelda" then %If the type of music is zelda music
	    Music.PlayFile ("title_music2.mp3") %Plays Zelda music for navigating the menu
	elsif music = "techno" then %If the type of music is techno music
	    Music.PlayFile ("title_music3.mp3") %Plays techno music for navigating the menu
	else %If the type of music is mario music
	    Music.PlayFile ("title_music.mp3") %plays Mario music for navigating the menu
	end if
    end loop
end PlayTitleMusic

proc ClearSoundEffect %Plays the world completion music when clear = true
    Music.PlayFile ("worldclear_music.mp3") %Plays the worldclear_music.wav file
end ClearSoundEffect

process SwitchSoundEffect %Plays the switch sound effect when a switch is activated or deactivated 
    Music.PlayFile ("switch.wav") %Plays the switch.wav file
end SwitchSoundEffect

process JumpSoundEffect %Plays the jump sound effect when luigi jumps
    Music.PlayFile ("luigi_jump.wav") %Plays the luigi_jump.wav file
end JumpSoundEffect

process CoinSoundEffect %Plays the normal coin sound effect when luigi gets a coin
    Music.PlayFile ("coin.wav") %Plays the coin.wav file
end CoinSoundEffect

process PurpleCoinSoundEffect %Plays the purple coin sound effect when luigi gets a purple coin
    Music.PlayFile ("purplecoin.wav") %Plays the purplecoin.wav file
end PurpleCoinSoundEffect

proc DeathSoundEffect %Plays the death sound effect when luigi dies
    Music.PlayFile ("death.wav") %Plays death.wav file
end DeathSoundEffect

proc leveldraw %Procedure which draws the level and all sprites within the level depending on which level is chosen
    Pic.Draw (worldbackground, x3 div 1, y3 div 1, picCopy) %Draws the background picture of the world determined by worldchoose over the previous picture as a means of refreshing
    Pic.Draw (world, x2 div 1, y2 div 1, picMerge) %Merges the foreground picture of the world determined by worldchoose ontop of the the background picture
    if worldchoose not= "intro" then %The introduction level does not contain any normal coins
	for coins : 1 .. coinnum %Draws each coin one at a time in it's location determined by worldcoinx and worldcoiny
	    if x + 7 > x2 div 1 + worldcoinx (coins) and x + 7 < x2 div 1 + worldcoinx (coins) + 10 and y + 15 > y2 div 1 + worldcoiny (coins) and y + 15 < y2 div 1 + worldcoiny (coins) + 30 then %Checks to see if the center of the luigi sprite is somewhere within the coin sprite
		worldcoiny (coins) := -2000 %It is far less complicated to make the coin appear somewhere luigi cannot go than make the coin no longer exist
		fork CoinSoundEffect %Plays the coin sound effect associated with collecting a coin
		coincount += 1 %Capturing a coin increases the total count of the coins collected by luigi by one
	    end if
	    Pic.Draw (coin, x2 div 1 + worldcoinx (coins), y2 div 1 + worldcoiny (coins), picMerge) %Draws the coin at the location determined by worldcoinx and worldcoiny
	    if coincount = 20 then %After collecting 20 coins a star is unlocked
		if worldchoose = "1-1" then %If the world luigi is in is 1-1 then
		    starcap (3) := true %Tells the variable starcap that the 3rd star has been captured 
		elsif worldchoose = "1-2" then %If the world luigi is in is 1-2 then
		    starcap (6) := true %Tells the variable starcap that the 6th star has been captured
		end if
		clear := true %Because a star has been captured the world has been cleared
	    end if
	end for
    end if
    if worldchoose not= "1-1" then %World 1-1 does not have any switch sprites or purple coin sprites within it
	for switchs : 1 .. switchnum %Draws each switch one at a time in it's location determined by worldswitchx and worldswitchy
	    if switch not= switchactive1_2 and switch not= switchactiveintro then %Enless the picture switch contains the acutal "p" switch picture then this loop should not be run, this is so the program does not do unneccessary work and the sound effect does not continuously play
		if x + 7 >= x2 div 1 + worldswitchx (switchs) and x + 7 <= x2 + worldswitchx (switchs) + 15 and y >= y2 div 1 + worldswitchy (switchs) + 10 and y <= y2 div 1 + worldswitchy (switchs) + 18 then %Checks to see if luigi is just above the switch, if he is the switch is activated
		    if worldchoose = "1-2" then %If the world is 1-2 then the switch picture becomes equal to world 1-2's activated switch
			switch := switchactive1_2 %The switch picture becomes equal to the picture of the activated switch for world 1-2
			worldswitchx (switchs) := 3733 %The coordinate of the switch become different because the switch changes pictures in different locations
			worldswitchy (switchs) := 296 %%The coordinate of the switch become different because the switch changes pictures in different locations
		    else %If the world is the introduction world then the switch picture becomes equal to world 1-2's unactivated switch
			switch := switchactiveintro %The switch picture becomes equal to the picture of the activated switch for the introduction world
			worldswitchx (switchs) := 1084 %The coordinate of the switch become different because the switch changes pictures in different locations
			worldswitchy (switchs) := 75 %The coordinate of the switch become different because the switch changes pictures in different locations
		    end if
		    fork SwitchSoundEffect %Plays the switch sound effect because the switch was activated
		end if
	    end if
	    Pic.Draw (switch, x2 div 1 + worldswitchx (switchs), y2 div 1 + worldswitchy (switchs), picMerge) %Draws the picture of either the un activated switch or the activated switch depending on the value of switch
	end for
	if purplecoincount not= 8 then %If the number of purple coins collected is equal to eight it is pointless to continue to draw the purple coins and running this with purplecoincount = 8 world cause the switch sound effect to run continuously
	    for purplecoins : 1 .. purplecoinnum %Draws each purple coin one at a time in it's location determined by worldpurplex and worldpurpley
		if x + 7 > x2 div 1 + worldpurplex (purplecoins) and x + 7 < x2 div 1 + worldpurplex (purplecoins) + 10 and y + 15 > y2 div 1 + worldpurpley (purplecoins) and y + 15 < y2 div 1 + worldpurpley (purplecoins) + 30 then %Checks to see if the center of the luigi sprite is somewhere within the purple coin sprite
		    worldpurpley (purplecoins) := -2000 %It is far less complicated to make the coin appear somewhere luigi cannot go than make the coin no longer exist 
		    fork PurpleCoinSoundEffect %Plays the coin sound effect associated with collecting a purple coin
		    purplecoincount += 1 %Capturing a purple coin increases the total count of the purple coins collected by luigi by one
		end if
		Pic.Draw (purplecoin, x2 div 1 + worldpurplex (purplecoins), y2 div 1 + worldpurpley (purplecoins), picMerge) %Draws the purple coin at the location determined by worldpurplex and worldpurpley
		if purplecoincount = 8 then %If Luigi collects 8 purple coins an activated switch returns back to it's unactivated state
		    if worldchoose = "1-2" then %If the world is 1-2 then the switch picture becomes equal to world 1-2's unactivated switch
			switch := switch1_2
			worldswitchx (1) := 4437 %The original switch coordinates must be reassigned
			worldswitchy (1) := 387
		    else %If the world is the introduction world then the switch picture becomes equal to the introduction worlds unactivated switch
			switch := switchintro 
			worldswitchx (1) := 1360 %The orignal switch coordinates much be reassigned
			worldswitchy (1) := 33
		    end if
		    fork SwitchSoundEffect %Plays the switch activation/deactivation sound effect
		end if
	    end for
	end if
    end if
    for stars : 1 .. starnum %Draws each star one at a time in it's location determined by worldstarx and worldstary
	if x + 7 > x2 div 1 + worldstarx (stars) and x + 7 < x2 div 1 + worldstarx (stars) + 30 and y + 15 > y2 div 1 + worldstary (stars) and y + 15 < y2 div 1 + worldstary (stars) + 30 then %Checks to see if the center of the luigi sprite is somewhere within the star sprite
	    if worldchoose = "1-1" then %if you are in world 1-1
		if stars = 1 then %Checks to see if it was the first or second world star captured
		    starcap (4) := true %Tells the variable starcap that the 4th star has been captured
		else
		    starcap (2) := true %Tells the variable starcap that the 2nd star has been captured
		end if
	    elsif worldchoose = "1-2" then %if you are in world 1-2
		if stars = 1 then %Checks to see if it was the first or second world star captured
		    starcap (5) := true %Tells the variable starcap that the 5th star has been captured
		else
		    starcap (7) := true %Tells the variable starcap that the 7th star has been captured
		end if
	    else %if you are in the introduction world
		starcap (1) := true %Tells the variable starcap that the 1st star has been captured because the introduction world only has 1 star
	    end if
	    clear := true %Capturing a star means Luigi has completed the level
	    exit %Early exit because there is no longer a need to draw the other stars 
	end if
	Pic.Draw (star, x2 div 1 + worldstarx (stars), y2 div 1 + worldstary (stars), picMerge) %Draws the star at the location determined by worldstarx and worldstary
    end for
    if worldchoose = "intro" then %Info blocks are only featured in the introduction world
	for infoblocks : 1 .. infonum %Draws the info blocks one at a time in it's location determined by infox and infoy
	    Pic.Draw (infoblock, x2 div 1 + infox (infoblocks), y2 div 1 + infoy (infoblocks), picMerge) %Draws the info block at the location determined by infox and infoy
	    if x + 7 > x2 div 1 + infox (infoblocks) and x + 7 < x2 div 1 + infox (infoblocks) + 12 and y + 28 < y2 div 1 + infoy (infoblocks) and y + 28 > y2 div 1 + infoy (infoblocks) - 2 then %Checks to see if luigi hits his head on the info block (Luigi is 28 pixels tall
		if infoblocks = 3 then %Checks to see which of the info blocks was hit, depending on which info block is hit different info will be displayed
		    Font.Draw ("Move using the arrow keys", 140, 200, font, red) %Draws info onto the screen as text
		    Font.Draw ("You jump higher when you hold up", 140, 180, font, red) %Draws info onto the screen as red text
		    Font.Draw ("Pressing down will make you duck", 140, 160, font, red) %Draws info onto the screen as red text
		elsif infoblocks = 2 then %If the second info block is hit then give the info below
		    Font.Draw ("Hitting a switch will help you progress", 100, 200, font, red) %Draws info onto the screen as red  text
		else %If the first info block is hit then give the info below
		    Font.Draw ("Collect 8 purple coins to deactivate a switch", 100, 200, font, red) %Draws info onto the screen as red text
		end if
		delay (200) %Delays for a period of time long enough to read the text, 0.2 seconds is enough time because the program will reach this point 4 times, twice going up because of the 2 pixel length in the if statement and twice going down for the same reason
	    end if
	end for
    end if
    Pic.Draw (coin, 5, 280, picMerge) %Draws a normal coin at the top of the screen and the number of normal coins determined by coincount beside it
    Font.Draw (" x " + intstr (coincount), 15, 280, font, red) %Draws a x meaning times and the coincount, which is required to be a string to draw it
    Pic.Draw (purplecoin, 65, 280, picMerge) %Draws a purple coin at the top of the screen and the number of purple coins determined by purplecoincount beside it
    Font.Draw (" x " + intstr (purplecoincount), 75, 280, font, red) %Draws a x meaning times and the purplecoincount, which is required to be a string to draw it
end leveldraw

proc jump %Procedure which makes luigi jump and able to move during his jump
    if velocity > 0 then %Because the jump procedure is also used for falling and velocity is set to 0 when falling the jumping soundeffect should not be played when luigi falls
	fork JumpSoundEffect %Plays the jump sound effect
    end if
    var gravity : real %Represents the acceleration due to gravity acting upon luigi
    var motion : real := 0.5 %Represents the how fast luigi travels horizontally and used to decide how far he travels during flight horizontally
    if godmode = true then %Checks to see if Godmode is on because gravity has to be decreased to allow luigi to fly
	gravity := 0.04 %Godmode has decreased gravity
    else %Normal mode
	gravity := 0.08 %Normal gravity
    end if
    loop %Looping through the jump procedure allows Luigi to rise and fall forever until he lands on the ground [red(12)]
	Input.KeyDown (chars) %Inputs the array of characters so it can be checked if a character is pressed down
	leveldraw %Calls the level drawing procedure
	if velocity >= -2.1 then %Sets the terminal/maximum negative velocity to 2.1, this limits the amount of pixels luigi jumps each time he is drawn so he doesnt skip over the red line drawn
	    velocity -= gravity
	end if
	if y + 35 < 0 then %If luigi falls off the bottom of the screen which is only possible while jumping/falling then he has died
	    death := true %Luigi's death becomes equal to true so the main body of the program knows he is dead
	    exit %Early exit of the jump procedure, without this luigi would never stop jumping because he would never land on red beneath the screen
	end if
	if chars (KEY_RIGHT_ARROW) then %If the right arrow is pressed
	    if stand = "right" then %If luigi is standing right then he continues to accelerate but if he is standing left than he must decellerate before accelerating right
		if whatdotcolour (x div 1 + 16, y div 1 + 8) not= 12 and whatdotcolour (x div 1 + 17, y div 1 + 8) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 16) not= 12 and %Checks to see with great accuracy at various points along the side of luigi's picture to see if he collides with anything to his right because he's moving right 
			whatdotcolour (x div 1 + 17, y div 1 + 16) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 24) not= 12 and whatdotcolour (x div 1 + 17, y div 1 + 24) not= 12 %Luigi cannot move if something red(12) is in his way
			and whatdotcolour (x div 1 + 17, y div 1 + 30) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 30) not= 12 then
		    if motion < 0.8 then %Luigi's horizontal velocity is capped at 0.8 pixels so he doesn't skip over red lines drawn for horizontal collision detection
			motion += 0.1 %Luigi accelerates at 0.1 pixels
		    end if
		    if x > 205 then %If Luigi is greater than the right margin the background and foreground move rather than Luigi, foreground and background go in the opposite direction as Luigi
			x2 -= motion %The x coordinate of the lower left corner of the foreground decreases by the same amount as Luigi
			x3 -= motion / 2 %The background picture moves at half the speed of the foreground
		    else
			x += motion %The x coordinate of the lower left corner of Luigi increases as he moves right
		    end if
		end if
	    else %If luigi is standing left and he wishes to move right he must first decellerate to 0 before moving right
		if motion > 0 then %If motion only decreases if Luigi changes direction and will not decrease below 0 or else Luigi would jump backwards
		    motion -= 0.05
		else %Once Luigi has slowed down to zero velocity left he can accelerate right
		    stand := "right"
		end if
	    end if
	elsif chars (KEY_LEFT_ARROW) then %If the left arrow is pressed
	    if stand = "left" then %If luigi is standing left then he continues to accelerate but if he is standing right than he must decellerate before accelerating right
		if whatdotcolour (x div 1, y div 1 + 8) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 8) not= 12 and whatdotcolour (x div 1, y div 1 + 16) not= 12 and %Checks to see with great accuracy at various points along the side of luigi's picture to see if he collides with anything to his left because he's moving left
			whatdotcolour (x div 1 - 1, y div 1 + 16) not= 12 and whatdotcolour (x div 1, y div 1 + 24) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 24) not= 12 %Luigi cannot move if something red(12) is in his way
			and whatdotcolour (x div 1 - 1, y div 1 + 30) not= 12 and whatdotcolour (x div 1, y div 1 + 30) not= 12 then
		    if motion < 0.8 then %Luigi's horizontal velocity is capped at 0.8 pixels so he doesn't skip over red lines drawn for horizontal collision detection
			motion += 0.1 %Luigi accelerates at 0.1 pixels
		    end if
		    if x < 155 then %If Luigi is less than the left margin the background and foreground move rather than Luigi, foreground and background go in the opposite direction as Luigi
			x2 += motion %The x coordinate of the lower left corner of the foreground increases by the same amount as Luigi 
			x3 += motion / 2 %The background picture moves at half the speed of the foreground
		    else
			x -= motion %The x coordinate of the lower left corner of Luigi decreases as he moves left
		    end if
		    stand := "left"
		end if
	    else %If luigi is standing right and he wishes to move left he must first decellerate to 0 before moving left
		if motion > 0 then %Luigi will slow down until his motion is <= 0
		    motion -= 0.05
		else %Once Luigi has slowed down to zero velocity right he can accelerate left
		    stand := "left"
		end if
	    end if
	else
	end if
	if chars (KEY_UP_ARROW) then %If you hold the up arrow you decelerate slower than normal which means you can alter the height of your jump by holding up
	    if godmode = true and velocity < 0 then %In the case of god mode velocity up is greater than gravity down thus allowing Luigi so fly upwards if the up arrow is pressed
		velocity += 0.14
	    else %The velocity upwards when holding up is still less than gravity downwards however Luigi still accelerates downwards
		velocity += 0.05
	    end if
	end if
	if godmode = true then %If godmode is true than Luigi's jump sprite become a flying sprite
	    if stand = "right" then %If Luigi is standing right than draw Luigi's right flying sprite
		Pic.Draw (luigi_flyR, x div 1, y div 1, picMerge)
	    else %If Luigi is standing left than draw Luigi's right flying left
		Pic.Draw (luigi_flyL, x div 1, y div 1, picMerge)
	    end if
	else 
	    if velocity > 0 then %If velocity is greater than zero  Luigi is still climbing so the climbing sprites are drawn
	       if stand = "right" then %If Luigi is facing right then draw him jumping facing right
		    Pic.Draw (luigi_jumpR, x div 1, y div 1, picMerge)
		else %If Luigi is facing left then draw him jumping facing left
		    Pic.Draw (luigi_jumpL, x div 1, y div 1, picMerge)
		end if
	    else %If velocity is less than zero Luigi is still falling so the falling sprites are drawn
		if stand = "right" then %If Luigi is facing right then draw him falling facing right
		    Pic.Draw (luigi_fallR, x div 1, y div 1, picMerge)
		else %If Luigi is facing left then draw him falling facing left
		    Pic.Draw (luigi_fallL, x div 1, y div 1, picMerge)
		end if
	    end if
	end if
	if velocity < 0 then %Only initiates this when Luigi is falling, if this checked when Luigi was climbing than it would activate immediatly and exit not allowing Luigi to jump
	    if whatdotcolour (x div 1 + 3, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 3, y div 1 - 1) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 1) = 12 then %If the ground beneath Luigi is red(12) when he's falling Luigi has landed
		exit %Exits the jump procedure because Luigi is no longer falling once he has landed
	    end if
	end if
	if velocity > 0 then %Only checks to see if the colour above him is red(4) when he is climbing
	    if whatdotcolour (x div 1 + 3, y div 1 + 30) = 4 or whatdotcolour (x div 1 + 11, y div 1 + 30) = 4 then %Checks to see if the pixels right above his head are red (4) which means he hit's his head
		velocity := 0 %Because Luigi hits his head he should no longer accelerate upwards and begin to accelerate downwards by making the velocity immediatly equal to 0
	    else
		if y > 240 then %If Luigi is greater than the top margin the background and foreground move rather than Luigi, foreground and background go in the opposite direction as Luigi
		    y2 -= velocity %The y coordinate of the lower left corner of the foreground decreases by the same amount as Luigi
		    y3 -= velocity / 2 %The background moves at half the speed of the foreground
		else
		    y += velocity %If velocity is positive which it is, Luigi's y value increases
		end if
	    end if
	else
	    if y < 80 and y2 < 0 then %If Luigi is less than the bottom margin the background and foreground move rather than Luigi, foreground and background go in the opposite direction as Luigi
		y2 -= velocity %The y coordinate of the lower left corner of the foreground increases by the same amount as Luigi
		y3 -= velocity / 2 %The background moves at half the speed of the foreground
	    else
		y += velocity %If velocity is negative which it is, Luigi's y value decreases
	    end if
	end if
	delay (5) %Delays a tiny bit giving the player more time to react to Luigi's jump
	View.Update %Updates the picture locations each time it loops onscreen
	exit when clear = true %If clear equals true becuase of the leveldraw procedure than exit the jump procedure so Luigi does not continue to jump after he has already won
    end loop
    velocity := 2.1 %After the jump is over the velocity is reset for the next jump
    motion := 0.5 %After the jump is over the horizontal velocity is reset for the next jump
end jump




%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<PROGRAM BODY>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

loop %A permanent indefinite loop that will never exit no matter what, this loop ensures the player can play continuously until the player wishes to quit by exiting the program window
    fork PlayTitleMusic %Plays the title music which is dependent on the value of the variable music
    for decreasing titlenum : 8 .. 2 %Draws the 7 shades of the titlescreen from darkest to lightest
	Pic.Draw (title (titlenum), 1, 1, picCopy) %Draws the shade of the title screen determined by the title number
	delay (50) %Delays so the player has time to see the shading of the title screen
	View.Update %Updates the picture locations each time it loops onscreen
    end for
    %===========================================MENU LOOP============================================
    loop %The Menu loop coninuously loops until a world is chosen in the world menu at which point the menu loop will exit and will enter the level drawing loop
	Pic.Draw (title (1), 1, 1, picCopy)%Draws the non-shaded version of the title screen
	Input.KeyDown (chars) %Inputs the array of characters so it can be checked if a character is pressed down
	if chars (KEY_UP_ARROW) then
	    if iconlocation > 0 then %The navigation icon cannot go above the highest menu choice
		iconlocation -= 20 %The icon location moves down in incraments of 20
		delay (100) %Delays a short time so the icon can move with some precision, without this it would be very hard to land on the center menu choice
	    end if
	elsif chars (KEY_DOWN_ARROW) then
	    if menu not= "main" then %On all menues but the main menu the navigation icon cannot go below 40
		if iconlocation < 40 then %The iconlocation cannot exceed 40 meaning 3 choice 0, 20 and 40
		    iconlocation += 20 %The icon location moves up in incraments of 20
		end if
	    else %The menu is main so there are only two menu choices
		if iconlocation < 20 then %There are only two menu choices on the main menu 0 and 20
		    iconlocation += 20 %The icon location moves up in incraments of 20
		end if
	    end if
	    delay (100)%Delays a short time so the icon can move with some precision, without this it would be very hard to land on the center menu choice
	end if
	Pic.Draw (choose_icon, 150, 115 - iconlocation div 1, picMerge) %Draws the navigation icon
	if menu = "main" then %If the value of menu is main then draw the main menu
	    Pic.Draw (main_menu, 170, 80, picMerge)
	    if hasch then %Only get a character if a character is pressed
		getch (character) %Gets the value of character without pressing enter
		if character = chr (10) then %If enter is pressed then the menu progresses depending on where the navigation icon is
		    if iconlocation = 0 then %A value of zero would be the top value choice
			menu := "world" %The menu becomes the top menu choice which is world
		    elsif iconlocation = 20 then %A value of 20 would be the bottom value choice in the main menu
			menu := "cheat" %The menu becomes the bottom menu choice which is cheat
		    end if
		end if
	    end if
	elsif menu = "world" then %If the value of menu is world then draw the world menu
	    Pic.Draw (world_menu, 170, 80, picMerge) 
	    for stars : 1 .. 7 %Draws a small menu star depending if a star has been captured in the game, the menu star appears beside the world the star was captured in depending on which star it is 
		if starcap (stars) = true then %If the starcap is true it means that star has been captured and thus it will draw a star showing it has been captured
		    if stars = 1 then %Star one is found in the introduction world and is drawn beside world 0-0 if the starcap = true
			Pic.Draw (menu_star, 289, 114, picMerge)
		    elsif stars > 1 and stars < 5 then %Stars 2 through 4 are found in world 1-1 and are drawn beside it if starcap = true
			Pic.Draw (menu_star, 289 + 18 * (stars - 2), 98, picMerge) %The calculation for the x position is an arithmetic sequence, the stars position is increased by 18 for each term number increase in the stars sequence 1 .. 7, you subtract 2 because term 1 isn't included in world 1-1 and because term 2 doesn't increase by 18
		    else %The remaining stars, 5 through 7 are found in world 1-2 and are drawn beside it if starcap = true
			Pic.Draw (menu_star, 289 + 18 * (stars - 5), 81, picMerge) %The calculation for the x position is an arithmetic sequence, the stars position is increased by 18 for each term number increase in the stars sequence 1 .. 7, you subtract 5 because terms 1 - 4 are not included in world 1-2 and because term 5 doesn't increase by 18
		    end if
		end if
	    end for
	    if hasch then %Only get a character if a character is pressed
		getch (character) %Gets the value of character without pressing enter
		if character = chr (10) then %If enter is pressed then the menu progresses depending on where the navigation icon is
		    if iconlocation = 0 then %A value of zero would be the top menu choice
			worldchoose := "intro" %The world becomes the top menu choice
		    elsif iconlocation = 20 then %A value of 20 would be the middle menu choice
			worldchoose := "1-1" %The world becomes the middle menu choice
		    else %A value of 40 would be the bottom menu choice
			worldchoose := "1-2" %The world becomes the bottom menu choice
		end if
		    exit %Exit the menu loop so the game can enter the world drawing loop
		elsif character = "c" or character = "C" then %If lowercase or capital "c" is pressed [c being the equivalent to b on an snes] then the menu goes back to the previous menu
		    menu := "main" %"worlds" previous menu is "main"
		    iconlocation := 0 %Because the main menu stops at 20 if the c button is pressed when the icon is at 40 the iconlocation should be moved to either 0 or 20
		end if
	    end if
	elsif menu = "cheat" then %If the value of menu is cheat then draw the cheat menu
	    Pic.Draw (cheat_menu, 170, 80, picMerge)
	    if godmode = true then %May draws a dot beside godmode to show whether or not godmode is enabled
		drawfilloval (150, 102, 5, 5, black) 
	    end if
	    if testmode = true then %May draw a dot beside testmode to show whether or not testmode is enabled
		drawfilloval (150, 85, 5, 5, black)
	    end if
	    if hasch then %Only get a character if a character is pressed
		getch (character) %Gets the value of character without pressing enter
		if character = chr (10) then %If enter is pressed then the menu progresses depending on where the navigation icon is
		    if iconlocation = 0 then %A value of zero would be the top menu choice
			menu := "music"
		    elsif iconlocation = 20 then %A value of 20 would be the middle menu choice
			if godmode = false then %The value of godmode becomes the opposite of what it was previously
			    godmode := true
			else %If godmode was true then it become false
			    godmode := false 
			end if
		    else %A value of 40 would be the bottom menu choice
			if testmode = false then %The value of testmode becomes the opposite of what it was previously
			    testmode := true
			else %If testmode was true then it becomes false
			    testmode := false
			end if
		    end if
		elsif character = "c" or character = "C" then %If lowercase or capital "c" is pressed [c being the equivalent to b on an snes] then the menu goes back to the previous menu
		    menu := "main" %"world" previous menu is "main"
		    iconlocation := 0 %Because the main menu stops at 20 if the c button is pressed when the icon is at 40 the iconlocation should be moved to either 0 or 20
		end if
	    end if
	elsif menu = "music" then %If the value of menu is music then draw the music menu
	    Pic.Draw (music_menu, 170, 80, picMerge)
	    if hasch then %Only get a character if a character is pressed
		getch (character) %Gets the value of character without pressing enter
		if character = chr (10) then %If enter is pressed then the menu progresses depending on where the navigation icon is
		    if iconlocation = 0 then %A value of zero would be the top menu choice
			music := "zelda" %The music type becomes zelda which is the top menu choice
		    elsif iconlocation = 20 then %A value of 20 would be the middle menu choice
			music := "techno" %The music type becomes techno which is the middle menu choice
		    else %A value of 40 would be the bottom menu choice
			music := "mario" %The music type becomes mario which is the bottom menu choice
		    end if
		    fork PlayTitleMusic %Restarts the title music because a new title music was chosen so the player can see what the new music is like
		elsif character = "c" or character = "C" then %If lowercase or capital "c" is pressed [c being the equivalent to b on an snes] then the menu goes back to the previous menu
		    menu := "cheat" %"music" previous menu is "cheat
		end if
	    end if
	end if
	View.Update%Updates the picture locations each time it loops onscreen
    end loop
    %The only way to exit the menu loop is throught the world menu
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fork PlayBackgroundMusic  %Plays the background music according to which world was chosen in the menu loop and which type of music was chosen in the music menu
    
    
    
    
    
    
    
    %--------------------------------Value Assignment-------------------------------
    %Each world has different coordinates for sprites and Luigi starts at different heights so these values must be assigned before the game can be drawn
    if worldchoose = "1-2" then %If the world determined by worldchoose in the world menu is world 1-2 then use these variables
	starnum := 2
	world := world1_2
	worldbackground := world1_2background
	switch := switch1_2
	y := 48
	worldcoinx (1) := 488
	worldcoinx (2) := 503
	worldcoinx (3) := 518
	worldcoinx (4) := 2901
	worldcoinx (5) := 2916
	worldcoinx (6) := 2931
	worldcoinx (7) := 2946
	worldcoinx (8) := 2961
	worldcoinx (9) := 2976
	worldcoinx (10) := 2991
	worldcoinx (11) := 3006
	worldcoinx (12) := 3021
	worldcoinx (13) := 3036
	worldcoinx (14) := 790
	worldcoinx (15) := 1417
	worldcoinx (16) := 2051
	worldcoinx (17) := 1259
	worldcoinx (18) := 1890
	worldcoinx (19) := 2389
	worldcoinx (20) := 2618
	worldcoiny (1) := 68
	worldcoiny (2) := 68
	worldcoiny (3) := 68
	worldcoiny (4) := 380
	worldcoiny (5) := 380
	worldcoiny (6) := 380
	worldcoiny (7) := 380
	worldcoiny (8) := 380
	worldcoiny (9) := 380
	worldcoiny (10) := 380
	worldcoiny (11) := 380
	worldcoiny (12) := 380
	worldcoiny (13) := 380
	worldcoiny (14) := 222
	worldcoiny (15) := 179
	worldcoiny (16) := 231
	worldcoiny (17) := 74
	worldcoiny (18) := 80
	worldcoiny (19) := 67
	worldcoiny (20) := 176
	worldswitchx (1) := 4437
	worldswitchy (1) := 387
	worldpurplex (1) := 4875
	worldpurplex (2) := 4631
	worldpurplex (3) := 4793
	worldpurplex (4) := 4752
	worldpurplex (5) := 4648
	worldpurplex (6) := 4891
	worldpurplex (7) := 5155
	worldpurplex (8) := 4853
	worldpurpley (1) := 292
	worldpurpley (2) := 180
	worldpurpley (3) := 124
	worldpurpley (4) := 451
	worldpurpley (5) := 473
	worldpurpley (6) := 236
	worldpurpley (7) := 181
	worldpurpley (8) := 20
	worldstarx (1) := 4538
	worldstary (1) := 454
	worldstarx (2) := 3587
	worldstary (2) := 467
    elsif worldchoose = "1-1" then %If the world determined by worldchoose in the world menu is world 1-1 then use these variables
	starnum := 2
	world := world1_1
	worldbackground := world1_1background
	y := 50
	worldcoinx (1) := 688
	worldcoinx (2) := 688
	worldcoinx (3) := 688
	worldcoinx (4) := 1145
	worldcoinx (5) := 1440
	worldcoinx (6) := 1665
	worldcoinx (7) := 680
	worldcoinx (8) := 700
	worldcoinx (9) := 660
	worldcoinx (10) := 1777
	worldcoinx (11) := 2167
	worldcoinx (12) := 2305
	worldcoinx (13) := 2325
	worldcoinx (14) := 2345
	worldcoinx (15) := 2365
	worldcoinx (16) := 2673
	worldcoinx (17) := 2784
	worldcoinx (18) := 3218
	worldcoinx (19) := 3188
	worldcoinx (20) := 3458
	worldcoiny (1) := 208
	worldcoiny (2) := 238
	worldcoiny (3) := 268
	worldcoiny (4) := 58
	worldcoiny (5) := 183
	worldcoiny (6) := 195
	worldcoiny (7) := 107
	worldcoiny (8) := 107
	worldcoiny (9) := 107
	worldcoiny (10) := 94
	worldcoiny (11) := 130
	worldcoiny (12) := 57
	worldcoiny (13) := 57
	worldcoiny (14) := 57
	worldcoiny (15) := 57
	worldcoiny (16) := 272
	worldcoiny (17) := 192
	worldcoiny (18) := 398
	worldcoiny (19) := 398
	worldcoiny (20) := 304
	worldstarx (1) := 4775
	worldstary (1) := 149
	worldstarx (2) := 3859
	worldstary (2) := 46
    else %If the world determined by worldchoose in the world menu is the introduction world then use these variables
	starnum := 1
	world := introworld
	worldbackground := introworld_background
	y := 32
	worldswitchx (1) := 1360
	worldswitchy (1) := 33
	switch := switchintro
	worldpurplex (1) := 1463
	worldpurplex (2) := 1483
	worldpurplex (3) := 1351
	worldpurplex (4) := 1371
	worldpurplex (5) := 1466
	worldpurplex (6) := 1486
	worldpurplex (7) := 1680
	worldpurplex (8) := 1700
	worldpurpley (1) := 403
	worldpurpley (2) := 403
	worldpurpley (3) := 345
	worldpurpley (4) := 345
	worldpurpley (5) := 299
	worldpurpley (6) := 299
	worldpurpley (7) := 240
	worldpurpley (8) := 240
	worldstarx (1) := 1878
	worldstary (1) := 292
    end if
    %These variables are universal for each world but must still be reset or else the game might think Luigi is dead right off the bat or Luigi has won right off the bat
    death := false
    clear := false
    x := 190
    x2 := 0
    y2 := 0
    x3 := 0
    y3 := 0
    stand := "right"
    coincount := 0
    purplecoincount := 0
    
    
    
    
    
    
    %=======================================================WORLD LOOP================================================================
    loop %The loop draws Luigi allowing him to move and call the jump and level drawing procedures indefinetly unless Luigi clears the level or dies in some way at which point it will exit
	if testmode = true then %If testmode is on then the mousecan be used to move mario
	    mousewhere (godx, gody, button) %the x and y coordinates of a mouse and the button variable
	    if button = 1 then %Because the mouse was not defined as a mulitbutton mouse any button can be pressed to equal 1
		x2 -= godx - x %Allows Luigi to move small distances by a mouseclick and at angles rather than only up-down, left-right
		y2 -= gody - y %The foreground moves an opposite distance equal to the differnce between Luigi's coordinates and the mouse coordinates
		x3 -= (godx - x) / 2 %The background moves half the distance of the foreground
		y3 -= (gody -y) / 2  %The background moves half the distance of the foreground
		if x > 225 then %If Luigi is greater than the right margin then the background and foreground move
		    x2 -= 1 %The x value of the lower left corner of the foreground increases by a value opposite the direction of Luigi
		    x3 -= 0.5 %The background moves at half the value of the foreground
		elsif x < 115 then %If Luigi is less than the left margin then the background and foreground move
		    x2 += 1 %The x value of the lower left corner of the foreground increases by a value opposite the direction of Luigi
		    x3 += 0.5 %The background moves at half the value of the foreground
		end if
		if y > 245 then %If Luigi is greater than the top margin then the background and foreground move
		    y2 -= 1 %The x value of the lower left corner of the foreground increases by a value opposite the direction of Luigi
		    y3 -= 0.5 %The background moves at half the value of the foreground
		elsif y < 75 then %If Luigi is less than the bottom margin then the background and foreground move
		    y2 += 1 %The x value of the lower left corner of the foreground increases by a value opposite the direction of Luigi
		    y3 += 0.5 %The background moves at half the value of the foreground
		end if
		x := godx %The x coordinate of Luigi becomes equal to the mouse x coordinate
		y := gody %The y coordinate of Luigi becomes equal to the mouse y coordinate
	    end if
	end if
	leveldraw %Calls the level drawing procedure into action
	if clear = true then %If the game was cleared in any way during the level draw procedure 
	    Pic.Draw (star, x div 1 - 8, y div 1 + 30, picMerge) %Draws the star above Luigi because after capturing a star the level draw procedure exits and does not draw the star
	    Pic.Draw (luigi_finish, x div 1, y div 1, picMerge) %Draws Luigi giving the peace sign after capturing a star
	    View.Update %Updates the picture with the previous two draw commands before exiting
	    ClearSoundEffect %Plays the cleared level sound effect
	    exit %The program no longer loops through the level drawing loop because Luigi has completed the level
	end if
	Input.KeyDown (chars) %Inputs the array of characters so it can be checked if a character is pressed down
	if chars (KEY_RIGHT_ARROW) then %If the right arrow is pressed then Luigi will move right
	    stand := "right" %If Luigi moves right he will face right
	    if chars (KEY_UP_ARROW) then %If the up arrow is pressed while Luigi is moving then Luigi will jump
		jump %Calls the jump procedure
	    else %If Luigi is not jumping while moving right then he is running right
		if whatdotcolour (x div 1 + 3, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 3, y div 1 - 1) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 1) = 12 then %Checks to see if there is ground beneath Luigi. Luigi cannot move forward if there is no ground [red(12)] beneath him
		    if whatdotcolour (x div 1 + 16, y div 1 + 4) not= 12 and whatdotcolour (x div 1 + 17, y div 1 + 4) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 10) not= 12 and %Checks to see with great accuracy at various points along the side of luigi's picture to see if he collides with anything to his right because he's moving right 
			    whatdotcolour (x div 1 + 17, y div 1 + 10) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 20) not= 12 and whatdotcolour (x div 1 + 17, y div 1 + 20) not= 12 %Luigi cannot move right if something red(12) is infront of him
			    and whatdotcolour (x div 1 + 17, y div 1 + 26) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 26) not= 12
			    and whatdotcolour (x div 1 + 17, y div 1 + 32) not= 12 and whatdotcolour (x div 1 + 16, y div 1 + 32) not= 12 then
			if x > 205 then %If Luigi is greater than the left margin then the background and foreground move
			    x2 -= 3 %The x coordinate of the lower left corner of the foreground decreases by the same amount as Luigi
			    x3 -= 1.5 %The x coordinate of the lower left conver of the background decreases by half the amount of the foreground
			else %If Luigi is between the margins then Luigi moves
			    x += 3 %The x coordinatre of the lower left corner of Luigi increases while going right
			end if
		    end if
		    %Large delays mess with certain components of the program so using a range of values with the mod command makes the program run smoother than with a delay
		    %A loop cannot be used for running because Luigi should be able to exit his running animation as soon as the right button is released
		    if runcounter mod 9 < 3 then %The possible remainders for the number 9 are 0,1,2,3,4,5,6,7,8     so < 3 = 0,1,2 
			Pic.Draw (luigi_runR, x div 1, y div 1, picMerge) %Draws Luigi's first running position
		    elsif runcounter mod 9 >= 3 and runcounter mod 9 < 6 then %>=3 and < 6 = 3,4,5
			Pic.Draw (luigi_runR2, x div 1, y div 1, picMerge) %Draws Luigi's second running position
		    else %and the rest are 6,7,8
			Pic.Draw (luigi_standR, x div 1, y div 1, picMerge) %Luigi standing is part of the run animation
		    end if
		    delay (20) %Small delay can be altered to make Luigi run slower or faster     ie ... delay (20 - speed) for variable delay
		    runcounter += 1 %Increases the value of the runcounter by 1
		else %If there is no ground beneath Luigi
		    velocity := 0 %Sets velocity to zero before calling procedure so instead of going up then down he immediatly starts to fall
		    jump %Calls the jump procedure
		end if
	    end if
	elsif chars (KEY_LEFT_ARROW) then %If the left arrow is pressed then Luigi will move left
	    stand := "left"  %If Luigi moves left he will face left
	    if chars (KEY_UP_ARROW) then %If the up arrow is pressed while Luigi is moving then Luigi will jump
		jump %Calls the jump procedure
	    else %If Luigi is not jumping while moving left then he is running left
		if whatdotcolour (x div 1 + 3, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 2) = 12 or whatdotcolour (x div 1 + 3, y div 1 - 1) = 12 or whatdotcolour (x div 1 + 11, y div 1 - 1) = 12 then %Checks to see if there is ground beneath Luigi. Luigi cannot move forward if there is no ground [red(12)] beneath him
		    if whatdotcolour (x div 1, y div 1 + 4) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 4) not= 12 and whatdotcolour (x div 1, y div 1 + 10) not= 12 and %Checks to see with great accuracy at various points along the side of luigi's picture to see if he collides with anything to his right because he's moving right 
			    whatdotcolour (x div 1 - 1, y div 1 + 10) not= 12 and whatdotcolour (x div 1, y div 1 + 20) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 20) not= 12 %Luigi cannot move left if something red(12) is infront of him
			    and whatdotcolour (x div 1, y div 1 + 26) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 26) not= 12
			    and whatdotcolour (x div 1, y div 1 + 32) not= 12 and whatdotcolour (x div 1 - 1, y div 1 + 32) not= 12 then
			if x < 155 then %If Luigi is less than the left margin then the background and foreground move
			    x2 += 3 %The x coordinate of the lower left corner of the foreground increases by the same amount as Luigi
			    x3 += 1.5 %The x coordinate of the lower left conver of the background increases by half the amount of the foreground
			else %If Luigi is between the margins then Luigi moves
			    x -= 3 %The x coordinatre of the lower left corner of Luigi decreases while going left
			end if
		    end if
		    %Large delays mess with certain components of the program so using a range of values with the mod command makes the program run smoother than with a delay
		    %A loop cannot be used for running because Luigi should be able to exit his running animation as soon as the left button is released
		    if runcounter mod 9 < 3 then %The possible remainders for the number 9 are 0,1,2,3,4,5,6,7,8     so < 3 = 0,1,2 
			Pic.Draw (luigi_runL, x div 1, y div 1, picMerge) %Draws Luigi's first running position
		    elsif runcounter mod 9 >= 3 and runcounter mod 9 < 6 then %>=3 and < 6 = 3,4,5
			Pic.Draw (luigi_runL2, x div 1, y div 1, picMerge) %Draws Luigi's second running position
		    else %and the rest are 6,7,8
			Pic.Draw (luigi_standL, x div 1, y div 1, picMerge) %Luigi standing is part of the run animation
		    end if
		    delay (20) %Small delay can be altered to make Luigi run slower or faster     ie ... delay (20 - speed) for variable delay
		    runcounter += 1 %Increases the value of the runcounter by 1
		else %If there is no ground beneath Luigi
		    velocity := 0 %Sets velocity to zero before calling procedure so instead of going up then down he immediatly starts to fall
		    jump %Calls the jump procedure
		end if
	    end if
	elsif chars (KEY_UP_ARROW) then %If the up arrow is pressed then luigi will jump
	    jump %Calls the jump procedure
	elsif chars (KEY_DOWN_ARROW) then %If the down arrow is pressed then Luigi will duck
	    if stand = "left" then %If luigi is facing left then he will duck facing left left
		Pic.Draw (luigi_duckL, x div 1, y div 1, picMerge)
	    else %If luigi is facing right then he will duck facing right
		Pic.Draw (luigi_duckR, x div 1, y div 1, picMerge)
	    end if
	else %If the player isn't pressing any of the command characters then nothing will happen and it will draw Luigi standing in the appropriate direction
	    if stand = "left" then %If luigi is facing left then he will stand facing left
		Pic.Draw (luigi_standL, x div 1, y div 1, picMerge)
	    else %If luigi is facing right then he will stand facing right
		Pic.Draw (luigi_standR, x div 1, y div 1, picMerge)
	    end if
	end if
	View.Update %Updates the picture locations each time it loops onscreen
	if death = true then %If Luigi has died in any way then
	    DeathSoundEffect %Plays the death sound effect
	    exit %Exits the world loop and returns to the menu loop
	end if
    end loop
end loop
