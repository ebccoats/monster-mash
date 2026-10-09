## MonsterMash game jam game


### Devlog

#### Starting out
Friday 10/9/26 - I've been working for about 3 weeks on a prototype for a game involving traversing tippy platforms, without making much progress on a playable prototype at all. Rory told us about the [Halloween Game Jam](https://itch.io/jam/the-halloween-jam-2026), and I wanted to see what I could do in Godot without relying on coding agents for help (I think that's where I'm running into problems with my prototype). 

So I started thinking about a game I could do that's manageably challenging and Halloween-related. 
##### Sketch

<p align="center" width="100%">
<img width="75%" src="./assets/monster-dj.JPG" />
</p>

- Top right: initial idea about a graveyard-based spooky sound effect music loop creator. Realized how complicated a music loop creator would be to make for someone who is not a knowledgeable musician so dropped that idea.
- General right side: From top to bottom, sketching out ideas for a game with camera view (foreground, no dance floor), notes about what types of music different monsters might like:
    - slashers like human screams
    - vampires like spooky organs
    - zombies like groans and the word "brains"
    - ghosts like moaning/crooning and "boo"
    - skeletons like marimbas
    - victorian ghosts like crummy old victorian recordings of music
- Ideas for album covers
- Notes about sound effects/music to use
- Bottom right: what's the absolute MVP so I can actually make something playable?
    - player starts the game with 1 type of monster on the dance floor (ghosts, zombies, or vampires)
    - player figures out the dj system and gets the monsters dancing
    - another type of monsters arrive
    - try to get the whole group dancing
    - track/loop object (that can hold what the "good part" of a track is, who likes it, etc)
    - audio player
    - slider to mix L/R turntable
    - animation loops for not interested, getting warmer, dancing, going nuts
        - doodles for the monsters, start with 2d billboards in the 3d space
        - thinking I'll start with just bobbing the billboards around
- Top left: wrapping my head around how to approach the assets. I'm liking the idea of lowpoly with pixel art textures. The scale of the pixel art will be anchored by the album art. I'm trying to figure out what the "unit" of the gameworld visuals are, so that everything will feel cohesive.
    - By making the milk-crate a simple cube and texturing it like a milk crate (using alpha channel for gaps) I can avoid getting into the weeds modeling stuff
    - I think the record should be less than 1 unit thick, but will test out in layout how it looks. Either 1 unit thick, 1/2, or 1/4? Needs to be able to fit inside the album cover
    - Slider on the turntable
- Bottom left: Framing idea about a mad scientist telling you (the frankenstein'd assistant) to DJ for his party. Not going to do this, opening the game with a monster dance party poster is way faster and probably just as effective to get the concept across.

##### Rough layout

<p align="center" width="100%">
<img width="75%" src="./assets/initial_layout.png" />
</p>

Here I roughed in the shapes and initial lighting in Godot to figure out the sizing and camera frame, with dance floor monsters billboarded as 3d sprites. You can see the room, some dancing monsters, your turntable, some records, the milk crate that will hold your albums, an album in "selected" state, and some initial lighting. 

##### Next steps:

[ ] Get audio playing when you click on one of the records
[ ] Make rough loop animation for the monsters
[ ] Make the ghosts react when player plays Ghostbusters
[ ] Make placeholder turntable scene with mixing slider

