# Remember to make your changes to the [README.md](http://readme.md) as well

# Beholden

## Summary

You're an explorer whose goal is to travel to this ancient curse pyramid. Many have told you that the exploration would be dangerous, but you're different, you're better. As you get close to your destination, you realize things aren't exactly what you expected. With the help of the Beholder, you make your way through the traps, platforms, and puzzles embarked on this adventure to retrieve the relic that lies within the pyramid.

## Project Resources

Playable Link - [Beholden by Mediocre-Mr-Fish](https://mediocre-mr-fish.itch.io/beholden)

Game Project Initial Plans - [Game Project: Initial Plan](https://docs.google.com/document/d/1JWGkOymUIyjewWZnPvQ477D33R6pdZ5rX4beXp0gH3E/edit?usp=sharing)

Fall Game Jam Version - [Beholden (Fall Game Jam) by Mediocre-Mr-Fish](https://mediocre-mr-fish.itch.io/beholden-fall-game-jam)

## Gameplay Explanation

As you start the game you are thrown into the main menu, which from here there are 4 buttons, these buttons being Start, Control, Level, and Credit. Clicking the credit sends you to our team! Clicking level sends you to the level selection page, where you can select which level you want to go to. Then clicking Control goes into the setting. In the setting there are multiple things you can do, such as change some of the controls and rebind different keys, check out spoilers for the game, or have hints. Pressing start, or any level within the level selection page, begins the game.

Beginning the game, the first few levels are there for you to get comfortable with the controls. From here you learn the basic mechanic, which revolves around having you, the player, solve puzzles by either having to figure out the color filters or by shifting your camera to fully be able to clear the stage.  

Default Keybindings:

| Movement | A, D, left arrow key, right arrow key |
| :---- | :---- |
| Jump | Space Bar |
| Activate Filter | Q |
| Filter Color Swap | Tab |
| Camera Shifting | Shift |
| Hints | H |
| Interaction | E |
| Main Menu | Escape |
| Reset | R |

The following contains spoilers for the solutions to the puzzles.

Certain objects have a fickle existence.
These objects exist when evidence supports their existence
and are non-existant when evidence contradicts it.

Seeing an object supports its existence.
Walking though an empty space denies it.

Many of the puzzles you will encounter play with this concept in mind-bending ways. Some puzzles require you to shift the camera towards or away from objects, while others require you to reveal objects using the Beholder's colored filter.

An important aspect to consider is that once an object's existence becomes determined, it cannnot be undetermined. 

# External Code, Ideas, and Structure

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

Youtube Tutorials

- [How to Use the New TileMap in Godot 4](https://youtu.be/tQSL2scuqeU?si=7Db4JsnGzg094cMv)
- [How To Create, Save And Load Keybinds In Godot 4!](https://youtu.be/z-vU475Rixk?si=DB3aNmD3c0M5_6Yj)
- [How to make a Scrolling Background in Godot 4](https://youtu.be/TMeT541OLPA?si=zPZ0v8kiUF37QnCV)
- [Parallax Scrolling in under 3 minutes! Godot 3.2 Tutorial](https://youtu.be/f8z4x6R7OSM?si=ltydm12dU2wjpZf6)
- [Creating volume sliders in Godot 4](https://www.youtube.com/watch?v=aFkRmtGiZCw)
- [Create Falling Platforms in Godot 4.4](https://youtu.be/WSoluV_8ITU?si=xGrWwW45SKNN1l9L)
- [Godot Tutorial #13 - Springs](https://youtu.be/12g5NrZXI3g?si=D_GP0v3zd_Bvcj6W)
- [Adding Multiple Levels and Moving Platforms to Your Godot Game](https://youtu.be/bjmNauqXkVw?si=kMcfLO7PTlXIFZCU)
- <https://youtube.com/shorts/U7wKF26r89g?si=eWkfg-8qpWLKgdxN>

ChatGPT

- Used in creation for some texture assets
- Assisted in code implementation
  - Lasso (Eric's version) however it did not help :(
- Assisted in Godot feature explanation:
  - Physics
  - Lighting
  - Computer Graphic in general

Class resources
- Used exercise 1 durative commands

# Team Member Contributions

## Eric Nguyen

Github: asianfry

### Main Role - Producer

- As the producer I was in charge of organizing the meetings and making sure the parts of our game work and are cohesive together. While we had a lot of initial plans and ideas it fell short from our original plan, but I made sure to utilize what we end up having to produce a worthwhile game with an interesting concept we can share.
  - Funny enough I did not create the Github, but Ellison did before I was able to do it. We all had our own personal branches we did our work on and I helped with figuring out how to merge the finished code to our main branch.
  - We had weekly meetings, and whenever someone was not able to make it we had a small paragraph recap to update them on what was discussed. We used when2meet to help schedule our free times (<https://www.when2meet.com/?33432406-bvwLm>)
  - And I helped implement my ideas and suggestions because I was not comfortable with making so many demands and suggestions without helping out myself. I help create traps like the spikes and moving platforms, but more details about that will be discussed in other contributions.

### Sub-Role - Narrative Design
- I sketched up and made a whole lot of sketches about the lore and world for our game, but I wish I was able to implement it within the various levels, but outside of the cutscene and some implementations like level 12 I was unable to make up for it in time. Copies of my sketches will be uploaded to the [github](Sketches).

### Other contributions

- The [spike trap](puzzle-platformer-game-jam/scripts/traps/spike.gd) and [moving platforms](puzzle-platformer-game-jam/scripts/traps/moving_platform.tscn) I contributed to the project, as well as a shooting arrow trap that did not make it into the project. I’ve wanted to try merging these with the indeterminate object class but that did not make it far.
- Most of my time was spent trying to implement the lasso mechanic because it just sounded really cool and if we were able to have it it would have made our game. Unfortunately my attempts at it did not work, and I wish I was able to show what progress I have actually made, but I ran into trouble with Github Desktop and my scripts and scenes were lost to history. There is evidence on my computer of the scenes, so I hope that is enough to show.
- Some animation help, but I designed the [death animation](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/4fbcca61d41c906e93611d08fa4647d21ee035f8/puzzle-platformer-game-jam/objects/player/player_controller.gd#L331).
- [DurativeDeath](puzzle-platformer-game-jam/scripts/commands/npc/durative_death_command.gd) Command inspired from Exercise 1.
- [DurativeDade](puzzle-platformer-game-jam/scripts/commands/npc/durative_fade_out_command.gd) Command inspired from Exercise 1.

## Ellison Song

Github: Mediocre-Mr-Fish

### Main Role - Game Logic

- Wrote the initial scripts for prototype testing. Although many more scripts have been added since and much of the player and camera scripts have been rewritten, many of the smaller scripts remain intact in the current version.
  - Notable examples:
    - [zone-out script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/zone_out.gd),
    - [the exit script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/exit/exit.gd),
    - [the base indeterminate object script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/object_indeterminate.gd),
    - [hitbox script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/hit_box.gd)
      - [touch hitbox script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/touch_hit_box.gd)
      - [camera hitbox script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/camera/camera_hitbox.gd)
- Wrote the extended scripts for the indeterminate objects. A key objective for these scripts was to make them highly parameterized and easy to place into levels without needing to subclass them for every variant of behavior; this was something that was lacking in the Game Jam Version. This would greatly accelerate the process of creating levels.
  - [Simple Visble-Tangible Objects](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/indeterminate_object/simple_visble_tangible.gd)
  - [Filtered Visble-Tangible Objects](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/indeterminate_object/filtered_visble_tangible.gd)
- Implemented the [camera movement logic](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/camera/camera_controller.gd). The camera is a very integral part of the mechanics of Beholder, so it needed to feel natural and cooperative.
  - A key complaint that came up during both development and testing was that the camera felt too zoomed in. The camera's zoom also affected the scale of all other objects in the world. To remedy this, the camera's zoom, scale, and movement were made to be parameterizable.
  - Because the camera zoom was made to be parametrizable, [a script to dynamically change the zoom based on player location](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/camera/camera_changer.gd) was added. This gave some levels a significant juicing.
- Set the foundation for player movement and controls. Although most of the code has been overridden since, some parts still remain
- Wrote the scripts that automate the [assignment of levels to the level select screen](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/screens/levelselection.gd) and [to each of the level exits](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/objects/exit/exit.gd). This allows the level order to be adjusted very easily without needing to change every level.
  - [Global Level Map Class](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/level_map.gd)

### Sub-Role - Player Onboarding and Tutorial Design

- Designed and implemented the first 7 levels. A key objective was to create situations where the player would discover the mechanics naturally. This is very difficult for such an unintuitive mechanic.
  - Using the multi-tab capablities of the hint system,
  levels can dispense multiple stages of helpful information without spoiling too much all at once. They also add a lot of personality to each of the levels. 
- Playtested work-in-progress builds with friends to guage how difficult the puzzles were to solve.


### Other contributions

- Developed the [Physics Boxes](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/Level-LeapOfFaith/puzzle-platformer-game-jam/objects/physics_box/PhysicsBox.tscn) and [Floor Buttons](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/Level-LeapOfFaith/puzzle-platformer-game-jam/objects/floor_button/floor_button.tscn), which ended up not making it into the current version.
- Partially developed the [lasso projectile mechanic](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/dev-lasso/puzzle-platformer-game-jam/objects/player/lasso_end.tscn), which ended up not making it into the current version.
- Drew the majority of placeholder sprites. As they are placeholders, none of these are used in the current version.
- Manages the [itch.io page](https://mediocre-mr-fish.itch.io/beholden) and the [Github page](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project)

## Brian Kim

Github: brianleekim

### Main Role - System and Tools Engineer

- Supported the team by helping build small reusable systems and workflows that made our development smoother. Because the project moved quickly and a lot of ideas were being built at the same time, some of the tooling responsibilities were shared across the group. Still, I contributed to technical pieces that were used throughout the game.
- I collaborated with my teammate on getting the Beholder system implemented, since it's the main mechanic in the game, and making sure it behaved correctly across levels.
- Beholder Lens Rotation & Color-Filter System (https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/main/puzzle-platformer-game-jam/levels/level5_brian.tscn):
  - Implemented the logic that allows the Beholder to switch between different lenses and rotate through color filters.
  - Created the scripts that let the Beholder cycle through lens states, activate the correct filter color, and interact smoothly with the player's input bindings.
  - Worked on the part of the lens system that controls which walls or platforms become visible depending on the active color. This included setting up the logic so certain obstacles only appear when viewed through the correct lens.
  - This system allowed designers to quickly drop the Beholder into a level and gain puzzle functionality without rewriting logic.
  - This contribution aligned strongly with the Systems & Tools Engineer role because it enabled other roles to build puzzles quickly using the mechanic rather than hard-coding behaviors per scene.

### Sub-Role - Game Feel

- Focused on small adjustments that made the game feel smoother to play. I helped feedback things like camera responsiveness, filter-switch timing, and overall feedback when the player interacts with puzzles. These changes were mainly about making the experience clearer and less frustrating, especially during platforming sections or quick lens swaps.
- I also tested levels and adjusted parts that felt off, anything that made the controls feel sluggish or unclear. These were small changes, but they added up and helped make the game feel more polished.

### Other contributions

- Level Design Implementation:
  - Contributed to implementing playable levels and providing ideas.
  - Ensuring filters, lenses, triggers, and interactions worked correctly inside each scene.
  - Debugging collisions, platform behavior, and camera transitions.
- Debugging:
  - On my own workspace, worked on resolving issues with group:
    - Camera shift and color-filter bugs
    - Interaction nodes not triggering
    - Level flow issues like misaligned tiles, incorrect filter behavior
    - Gameplay feel inconsistencies (jump responsiveness, platform detection, feedback timing)
- This debugging work reduced friction for designers and visual roles, aligning with the Systems & Tools Engineer's responsibility to improve team workflow and reduce technical barriers.
- I tried to fill in gaps wherever the team needed help and make sure things worked together smoothly.

## Wen Zhao

Github: wen-z-z

### Main Role - Animations and Visuals

- Main designer of items and item inventory, implementing the whole script of [items.gd](http://items.gd) and inventory code inside of player.gd.
- Designed UI for items like the inventory_handler.gd visuals that displays the inventory on the bottom left.
- Designed and coded item key bind tooltips that shows which keys affect which item in your inventory.
- Drew up and coded item sprites excluding torch sprite. This includes 6 unique sprites and 6 modulated sprites that are in the assets/beholder file.
- Coded the color modulation of the beholder ability where the player can see objects of a certain color when applying a filter over the screen.
- Coded the color modulation of the objects that the beholder ability affects on.

### Sub-Role - Audio

- Had no relevant contributions to this role. However, I was very involved with feature implementation and worked extensively to create the necessary scripts and tools in order for items and abilities to be created and used easily by the level designers.

### Other contributions

- Coded and created the beholder, the main item in the game.
- Created the bridge object and a level focused on it.

## Tho Nguyen

Github: ThoN148

### Main Role - User Interface and Input

- Designed and polished the screens portrayed in the menu. (i.e. Controls, Level Selections, Team, spoilers, etc). Additionally added a feature that allows hotkey rebinding for player comfort.
  - Originally from the game jam, there was already a good base to go off of so I added a background, titles, and buttons sprites to the menu screens. Basically, I remodeled all of the screens with new sprites and addons in order to make it look more fleshed out.
  - All games should have some type of setting management, so I designed the setting panel, which has the hotkey binding, and the volume controls. This allows the player to change whatever keys they want to play along with how loud they want the volume to be.
  - [HotKey Rebindings Scripts](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/bf00438b4b9b8f2775d1f56986832d5db77c3eab/puzzle-platformer-game-jam/hotkey_keybind.gd#L1)
  - All Button Sprites designed are within the "Button" Folder in Assets
- Created some of the sprites for the interactions. (Buttons, etc)
  - I wanted to create a more immersive experience with the player and allow them to feel like they're pressing buttons when they click on them. This introduced me to the idea of adding textured buttons rather than having regular sprites. So I went on Aseprite and created some pixel art of buttons that fit with our theme.

### Sub-Role - Gameplay Testing

- Everyone did their own gameplay testing, at the end to figure out the bug, so it wasn't just my role in the end.
  - Tested the game multiple times, different ways, to uncover random bugs or glitches within the game and fix them. Mainly the goal was to test each level and see if it is coherent, solvable, and fair to the players. In any case that I find tiles that had no collision, sprites that were bugged, or some aspect of the game that weren't meant to be, I would inform the team. If I can fix it myself, then I'd go ahead and do so and update the level.

### Other contributions

- Designed the backgrounds for the game, both in the menu screen and actual gameplay.
  - I looked into how to create a scrolling background for the menu. I wanted something to spice it up so that it has a better look to the game as the player gets introduced to the main menu. Additionally, I wanted the player to feel immersive as they played the game rather than having a standard background. Therefore I learned how to utilize the parallax background and learned how to make it so that the background moves as the player moves. (Was assisted by the others when it came to camera zooming debug)
- Contributed in level design and was able to create an extra level.
  - Everyone in the team ended up creating a stage of their own in our game, some created more. However in my stage, I wanted to focus more on the aspect of parkour and slight rage inducing rather than pure puzzle. I focused on my lvl (in the game it should be 11), where it would have to allow the player to try multiple times in order to understand how the level works. In some way there is a puzzle you need to figure out, but once you do it's quite simple.
- Familiarized myself with the tiles and created / polished them for early testing, including learning how to add physics, collision as well, and implementing them as a substitute for sprites.
  - I took it upon myself to learn how to do the tiles in order to refurbish the earlier stages during progress 1 so that during the interview with other teams, we have something to present that was more fleshed out. So I learned how to use tile maps and the sets with the given assets we had, adding physics, and how to code it so that we can substitute the sprite2D models with miles for some of the tiles. (Believed others have also learned how to do this in the end)

## Zishuo Li

Github: AllRightsReserved093

### Main Role - Movement / Physics

- Our actual development was based on a playable framework built by our team members during the Game Jam; due to time constraints, the control and physics systems were relatively rudimentary at the time, and I was responsible for the remaster, adjustment, and iteration of this control system. Which included:
  - Character control: I was responsible for redesigning the character's movement and control system, adding a motion pattern of stationary-accelerated-constant; Slow fall function when long-pressing the jump button speed-decelerated-stationar, Input invalidation functionality added to cutscene, and etc.
    - [Character control scrip](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/bf00438b4b9b8f2775d1f56986832d5db77c3eab/puzzle-platformer-game-jam/objects/player/player_controller.gd#L118C2-L118C16)
  - I created animations and animation trees for the characters, and built a character animation logic tree and support system. Because the original asset pack's animation textures were misaligned, they were completely unusable. I used tools like Photoshop to adjust and redraw some of the character textures, achieving the correct animation playback effect.
    - [Animation control script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/bf00438b4b9b8f2775d1f56986832d5db77c3eab/puzzle-platformer-game-jam/objects/player/player_controller.gd#L236)
  - It implemented some physics-based map components, such as rail objects(A module that binds physically based objects to a fixed track and allows for real-time interaction.) This was originally intended to be a major module in our gameplay, but unfortunately, it wasn't ultimately implemented in the game due to the limitations of the Godot physics system, which made the lasso system used for interaction difficult to implement.
    - [rail_object control script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/bf00438b4b9b8f2775d1f56986832d5db77c3eab/puzzle-platformer-game-jam/objects/rail_object/rail_object_control.gd#L2C1-L3C1)
  - Painting's eye tracking mechanism - In the final level, I designed a character (The Painting) whose eyes automatically track the player. It's hung on the wall of the level's room and silently watches the player. I implemented this eye-tracking using the simple similar triangles principle.
    - [Eye control script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/ad662ff01e0c56cb4343ee66de1ce6a25be9a017/puzzle-platformer-game-jam/levels/level_loop/eye_control.gd)

### Sub-Role - Visual Cohesion and Style Guide

- My original sub-role was press kit and trailer, but due to the enormous workload involved in this game project, I chose to focus on the visual design of the game itself instead. This includes my new Sub-role Visual Cohesion and Style Guide, as well as a host of other contributions that I will list in "Other contributions".
  - Guidance was provided to the team when selecting art asset packs to ensure a consistent overall art style.
- In charge of the lighting design, primarily for the final chapter, utilizes Godot's texture-based 2D lighting system. The lighting design employs procedurally generated inverse square intensity maps and overlays multiple layers of light objects to simulate diffuse reflection and glow effects on walls and objects, achieving a relatively satisfactory visual effect.
- I used Photoshop's Camera Raw to adjust the color style of multiple texture files to match the overall art style.
- Normal map systems were applied to many game textures related to lighting effects. Using Photoshop 3D tools to generate and manually repair the textures, normal maps were applied to some materials that interact with Godot light sources, resulting in a virtual 3D effect and a more layered visual presentation.
  - [One of the normal map that I created](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/7b175c234cf99ca25759eaa13878a6e26e67d723/puzzle-platformer-game-jam/assets/World/Desert/desert-8x8/sprites/desert_brickwall_background_normal_map.png)
- Parallax background: I reprocessed the background layers extracted from the original background texture using Photoshop and designed appropriate Godot parallax background parameters to achieve a visually plausible parallax background effect.
- Created quite a few texture assets that fit the overall style were created using AI tools and photoshop.
  - I tested various AI image generation tools, including different pixel art generation models, but the results were unsatisfactory. Ultimately, I chose to use ChatGPT to generate high-resolution images that approximate pixel art, and then manually repaired and pixelated them in Photoshop.
  - The new materials and textures I made are scattered in various places, but they are mainly gathered in the [assets/Object](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/tree/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/assets/Objects), [assects/Desert 8×8](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/tree/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/assets/World/Desert/desert-8x8), and [object/Painting](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/tree/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/objects/painting) .

### Other contributions

- Level design - Responsible for the design and construction of the final level
  - [Level design document](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/7b175c234cf99ca25759eaa13878a6e26e67d723/puzzle-platformer-game-jam/doc/level_loop_design_document.pdf)
- Audio system:
  - A background audio system, completely independent of the level system, was implemented to uniformly play background music and various character and level-related sound effects.
    - [BGM control script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/audio_control/bgm_player.gd)
    - [SFX control script](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/blob/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/audio_control/player_sfx_player.gd)
  - I downloaded many attribution-free/open-source sound effect files on free game sound effect websites such as Freesound, Pixabay Sound Effects, and Creazilla Audio, and applied them to the game.
    - [Audio assets](https://github.com/Mediocre-Mr-Fish/ECS179-Final-Project/tree/555fa2a686de2b6cdb0bd8b66cfdc0e9dcb42e1d/puzzle-platformer-game-jam/assets/Audio)
- Buttons textures - A few buttons that were not included in the asset pack have been drawn, such as the Debug level button and the Loop level button (temporary, and will not be used in the final game).
