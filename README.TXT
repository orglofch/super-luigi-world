========================================
<- SUPER LUIGI WORLD, The Lost Levels ->
========================================
v1.3 18-JAN-2009
=================
COPYRIGHT Paradox.inc 2009

Home page: http://www.luigiworldx.com

Contents
========
Version History
Introduction
What You Will Need
Getting Started
Keyboard Controls
Netplay Support
Cheat Support
Super FX
Sound Problems
Alteration
Frequently Asked Questions
Getting Help
Credits

Version History
==========================

v1.0 - Able to jump in single directions
     - Movement capablities
     - Alpha world 1-2
v1.1 - Multidirectional jump
     - Vertical collision detection
     - Beta world 1-2
     - Alpha tutorial world
     - Basic platforming enabled
v1.2 - Coins added
     - Walk off platform glitch fixed by executing jump procedure with a velocity of zero when off platform
     - Purple coins added
     - switches added
     - World 1-2 completed
     - Beta tutorial world
     - Horizontal collision detection
     - Beta world 2-1
     - HUD added
     - Horizontal and vertical margins added to allow for background and foreground scrolling
     - Sound effects added
     - Background music added
     - World Menu added
     - Jump procedure complete
v1.3 - Coin counter added to HUD
     - Cheat menu added
     - Cheats added
     - Music menu added
     - Testmode finished
     - world 2-1 removed
     - world 1-1 completed
     - Tutorial world complete
     - Zelda Music added
     - Techno Music added
     - Main stars added
     - Hidden stars added
     - Commenting Completed
     - Main menu shader completed
     - World draw procedure
Introduction
============

Super Luigi World is user created mod of Super Mario World for the Super 
Nintendo Entertainment System (SNES). It basically allows you to play an altered 
version of the game Super Mario World.
Super Luigi World is the result 4 weeks of developement and the accumalated knowledge
of a single semester of Computer Science. Super Luigi World is coded in turing programming language
with three assembler CPU emulation cores on the
i386 Linux, DOS and Windows ports.

Super Luigi World is better than the real Super Mario World:
o Freeze a game at any position
o Stereo sound
o No need for cartrage or cartrage contact cleaning
o Easy alteration to speed, jump height etc...
o Easy to use level creation
o Play as Luigi who can jump higher! 
o Simple control alteration
o Super Luigi World allows one to save the game at any time and reload from that position the next time the game is opened

Super Luigi World is worse than a real Super Mario World:
o Unless your computer is very fast (Pentium II+), some games just can't
  hit every frame being rendered and the emulator starts to skip the drawing
  of some frames to keep the emulator running at a constant speed - to you
  it appears as if the graphics aren't moving as smoothly as they could.
o Some features dependant upon display capblities and moniter size, pictures
  may appear distorted, smaller or large
o You have to wait for your computer to boot before you can play games,
  no waiting on the real SNES version!
o Framerate slowdowns can be experienced when several pictures layers are overlapping

What You Will Need
==================

Windows 95, 98 or NT with at least DirectX 6 installed running on a modern,
fast (e.g. Pentium 200 or higher) computer with at least 32Mb of RAM. Some
games require another CPU to be emulated and/or make heavy use of colour
translucency effects, so an even faster computer may be required to get an
acceptable frame rate.

If you want SNES sound emulation, you'll need a DirectSound compatible sound
card - virtually all modern PCI sound cards are DirectSound compatible

To increase speed you should have your desktop depth set to 256 colours if translucency
emulation and 16-bit rendering are switched off and not required or hi-colour
mode (32768/65536 colours) if translucency effects are required.

Software
--------
Super Luigi World includes .gif and .bmp images of the original Super Mario world game 
included into a directory. These pictures are called upon by the software and used in animations or backgrounds.
Please note, it is illegal in most countries to have
commercial ROM images without also owning the actual SNES ROM cartridge.

Getting Started
===============
Super Luigi World can be located on the AA files or www.compsci.ca
Double click the executable turing.exe.

Use the Open option from the File menu to open the ROM load dialog. The dialog
allows you to browse your computer to locate the AA directory where SuperLuigiWorld.t 
is saved or the directory where you have you have un-zipped SuperLuigiWorld.exe 
(It is recommended that you copy the files onto the desktop to make it easier for
SuperLuigiWorld.t to locate the picture files). Double click the file directory and double click the executable
SuperLuigiWorld.t to open the program. Click run or press F1 to run the program.

On a real SNES, players controlled games using an 8-button digital joy-pad; on
Snes9x you can use your computer's keyboard (the default) or any joystick
or controller device supported by Window's DirectInput. The default key
mapping is:

'up arrow'              Up direction
'down arrow'            Down direction
'left arrow'            Left direction
'right arrow'           Right direction
'a'                     X button
'z'                     Y button
'x'                     A button
'c'                     B button
'enter'                 Start button
'space'                 Select button

Some games can take a very long time to complete from start to finish so
many had some RAM and a battery fitted inside the game pack that allowed the
player to save his progress in a game at predefined places throughout the
game. Super Luigi World provides freeze-files, these are files that save a game's position
at any point in the game, not just at predefined places chosen by the game's designers, this is ideal
for saving just before a tricky section. The file is automatically re-loaded the next time you play the game and can be accessed via
the start menu. 

To save a game simply press "p" to pause the game at any point and select save from the HUD (heads up display)

Freeze game files and S-RAM save files are normally read from and written to
the folder where the ROM image was loaded from, but sometimes this is not
desirable or possible, especially if its a CD-ROM, which are of course 
read-only! You can now change the folder where SuperLuigiWorld.t saves and loads S-RAM and
freeze-files from the Settings Dialog, available from the Options menu.

Keyboard Controls
=================
Menu
'enter'                 select
'c'                     back to previous screen
'up arrow'              selection tool up
'down arrow'            selection tool down

While the game is running:
'up arrow'              jump
'down arrow'            duck
'left arrow'            move left
'right arrow'           move right

Alt+'F4'                Closes the Super Luigi World run window.

Limitations
===========
o Turing is somewhat limited in its software capabilities. Multiple images overlayed ontop of eachother causes dramatic slowdowns in framerate,
  because of this is is much harder to emulate the other software. Only two images [foreground and background] can be placed ontop of 
  one another without any slowdown in framerate. In addition, foreground objects such as grass cannot easily be overlayed ontop of the red
  sections of ground forcing me to leave them where they are.
o Newer versions of turing do not support Sprite commands which somewhat limit the animations that can be performed.
  When using the Sprite.Show command to make the sprite visible the sprite remains invisible.
o Turing supports process' which allow several procedures to run simultaneously however even this is limited in it's ability due to the fact
  that it is not trully simultanoeus. Instead of running procedures at the same time it randomly picks a process and runs it which makes it appear 
  to be simultaneous, however with many processes which require precise timing it is not efficient
o Turing is no longer updated by Holtsoft.inc thus these problems will never be fixed


Joystick Support
================

Configure and calibrate your joystick controls in the control variable section of SuperLuigiWorld.t to 
your personal preference.

Netplay Support
===============

Turing currently does not support networked game play with
other users of turing.

Cheat Support
=============

Certain cheats can be toggled on and off by navigating the cheat menu.

Cheat Search Examples
--------------------
o Test mode is the ability to click and drag mario anywhere on the screen using the mouse
  [this is the only function of the mouse in Super Luigi World].
  Test mode was created for the purpose of game testing and is capable of breaking the game.
  Test mode can be toggled on by clicking enter beside testmode in the cheat menu
o God mode deacreases gravity on luigi giving him the ability to fly instead of jumping, tapping the up arrow during flight increase's 
  Luigi's upward velocity allowing luigi to fly indefinetly
o Music can be altered withing the music menu accessed by the cheat menu, the available music types are; mario, zelda, and techno
  altering the music type changes the music played in each level and while navigating the menu
Super FX
========
The Super FX is a 10/21MHz RISC CPU developed by Argonaut Software used as a
game enhancer by several game tiles. Support is still a little buggy but most
games work very well, if a little slowly. Released SNES Super FX games included
Yoshi's Island (best single-player game on SNES, if you like platform games),
Doom, Winter Gold, Dirt Trax FX, StarFox, Stunt Race FX and Vortex. If you're
lucky, you might find a copy of the unreleased Starfox 2 image floating around.

Lots of Super FX ROM images available are in an odd interleaved format that I
haven't worked out how to auto-detect. If your ROM image isn't working try
selecting the Interleave mode 2 option on the ROM load dialog before loading a
game.

SA-1
====

The SA-1 is a fast, custom 65c816 8/16-bit processor, the same as inside the
SNES itself, but clocked at 10MHz compared to a maximum of 3.58MHz for the CPU
inside the SNES.

The SA-1 isn't just a CPU, it also contains some extra circuits developed by
Nintendo which includes some very fast RAM, a memory mapper, DMA, several
real-time timers, and the region lock-out chip.

Sound Problems
==============

No sound coming from any SNES game using Snes9x? Could be any or all of
these:

- If all sound menu options are greyed out, Super Luigi World couldn't initialise
  DirectSound. Make sure DirectX 6 or above is installed and your sound card
  is supported by DirectX. Installing the latest drivers for your sound card
  might help. Another Windows application might have opened DirectSound in
  exclusive mode, in which case you will need to stop that application and
  restart Snes9x.
- The sound card's volume level might be set too low. Snes9x doesn't alter the 
  card's master volume level so your might need to adjust it using the sound
  card's mixer controls usually available from the task bar or start menu.
- Make sure your speakers and turned on, plugged in and the volume controls are
  set to a suitable level.

General sound problems:
- A continuous crackling sound can be heard. Trying increasing the sound
  buffer size from the sound menu. If you need to set the value above 100ms to
  get clean sound then you will also need to enable sync-sound mode or SNES
  sound emulation will suffer.
- Sound quality is poor on all games. You might have a noisy sound card 
  [usually cheap cards], turning on interpolated sound, sync-sync and/or 
  increasing the playback rate might help.
- Sound seems to have gaps. Sometimes, when changing sound settings, either
  DirectSound or Snes9x messes up (not sure which) and Snes9x losses sound 
  playback synchronisation. Try changing the playback rate to a different 
  value and back again or quit and then restart Super Luigi World.
- Sound in a few games sounds crackly. Try turning off sync-sound and/or 
  interpolated sound - both seem to have problems with a few games.
- Sound is awful in all games. You might have selected a playback rate/stereo/
  8-bit/16-bit combination that your sound card can't cope with. Try setting
  8-bit mono @22KHz from the sound menu and if that cures the problem, try
  other combinations until you find the best setting that works on your sound
  card.

If all else fails, try posting a message describing your problem and 
requesting help on the SuperLuigiWorld message board at; 
http://www.luigiworldx.com

Alteration
=========

Levels
------
Super Luigi World uses a colour based collision detection rather than co-ordinates 
so new levels can be easily created, uploaded and played by drawing red lines

Turing supports; .gif, .bmp, and .jpg images 

to create a new level;
o  draw a red line [#14 of the 256 colours supported in turing] two pixels
   thick on anything you wish to be able to jump on or do not want to be able to run through
o  draw a darker red line [#7 of the 256 colours supported in turing] two pixels thick on anything 
   you want mario to hit his head on
o  Sprites such as coins or switches can be altered by changing the x and y variable coordinates as 
   well as the coin and switch number variables

To alter a previously created level or sprite open a picture editing software such as paint or photoshop and click
Open on the file menu. Locate the Super Luigi world directory and open the level or sprite you wish to edit from the picture file.

The non-character sprite variables such as coinnum, worldcoinx, and worldcoiny can be altered to increase the number of coins in each level and the location of those sprites

Animations
----------
By altering the variable 'speed' the rate at which luigi runs will increase in game. A speed of 15 is ideal.
The height at which luigi jumps and the rate at which he decends can also be altered using the 'gravity' and 'velocity' variables.
Terminal velocity can be altered using the variable 'terminalvelocity'. [WARNING] a higher terminal velocity can cause vertical collision 
to work less reliably and causeing luigi to fall through ground.
Hover time can be increased or decreased by altering the 'hover' variable

Frequently Asked Questions
==========================

What do I do if when I try to run the program is says illegal picture ID?
-------------------------------------------------------------------------
If there is an illegal picture idea it means the picture was never created.
There are several reasons why this may happen; the file name may be wrong or the directory location may be wrong
Make sure all picture ID's match the picture names in the picture directory and make sure that the SuperLuigiWorld file is saved onto the desktop
or an appropriate directory.

Luigi jumps to high, what should I do?
--------------------------------------
Luigi's jump height and speed are determined by two different variable 'gravity' and 'velocity'. Luigi jumps in a parabolic shape going higher
and higher by smaller amounts until the amounts he goes up by becomes negative and he begins to go down. 'Velocity' determines the amount Luigi initially goes up by.
Gravity determines the amount velocity decreases by every second. Either velocity is to high or gravity is to low if Luigi is jumping to high.

I went off the screen and now I can't move, why is this?
-------------------------------------------------------------
You have probably discovered a whole in the collision detection or were using testmode. This happens because the program refreshes by constantly redrawing the background
foreground and luigi, however once luigi walks off the screen the background can no longer reset the image and the previous images remain left on the screen. It is
possible that two red images were drawn around luigi at the last reset and thus he can no long mover back or forth.

Credits
=======
- Special thanks to Nintendo for creating the original SNES version of 
  Super Mario World
- OldSchoolMario for providing the luigi sprites
- Super for creating the Super Mario Oc remix's used within the program
- The community of compsci.ca for providing inspiration and ideas
- Predicador for the Mario icon's
- Music by; Basshunter
            Scooter
            Nintendo
            Dj Sammy
Nintendo is a trademark.
Super NES, SuperScope and Super FX are a trademarks of Nintendo. 
Turing is a trademark of Holtsoft.inc
MS-DOS and Windows 95 are trademarks of Microsoft Corp.

------------------------------------------------------------------------------
Owen Glofcheski
oglofcheski@luigiworldx.com

