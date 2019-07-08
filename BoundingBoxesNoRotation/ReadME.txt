Developer: 
  Name: Lleyton W Morris 
  email: lleyton92@gmail.com

Description:
  an application that allows multiple entities to be created with multiple hitboxes, saved and loaded from a file.
  entities also contain an sprite (image) that's link is stored in file for loading.

There are currently several different application states:
  gameMode:
    for moving around the screen space.
  deleteMode:
    for deleting hitboxes from an entity.
  insertMode:
    for inserting hitboxes onto an entity.

Controls:
  general:
	WASD : movement
	'u' : increment entity for editing hitboxes
	'i' : decrement entity for editing hitboxes
	's' + ctrl (in that order) : save config
	'e' : enters insertMode
        'r' : enters deleteMode
	'g' : enters gameMode
  deleteMode: 
	left click : initiate new hitbox deletion for current entity
	left click (confirm) : confirm area of deletion on current entity
  insertMode:
        left click : initiate new hitbox creation for current entity
        left click (confirm) : confirm hitbox creation on current entity
	
file storage structure:
  information for all entities is stored in the textfile "PlayerData.txt" and consequently read from also. Data is stored
  in a custom, JSON-like style with white space for readability
Implemented:
  control any player
  delete multiple hitboxes
  Add version field to dictate which version is currently being used (loading and saving to file)
  Modify storage structure (Mk3)
  	at the end of an object it should look like: "} Player,". This way it should be easier to read where an object begins and ends 
        for easier searching
  Load specific player
  only create hitboxes within surrounding hitbox
To Implement:
  Player Class that inherits from entity
  	it makes sense that an entity would have a type (String dictating what it actually is)
  	such as "Table" or "Player" and then the player class stores it's username in a new field
  create new player (GUI)
  Confirm hitbox creation
  surrounding hitbox is image size ++ buffer (currently hardcoded)
  resizing
  quadtree storing + collision
FixedIssues:
  moving crashes with no second entity
  collision only works when there are two entities
  cannot add hitboxes to entities
KnownIssues:
  no known issues at the moment




Future program notes:
  recently i had an idea to create essentially this program except instead of storing hitboxes i can draw the surrounding shape, which
is then split up into triangles that utilise off axis theory to calculate collision, this would give much tighter hitboxes at a cost of
potentially many more hitboxes (causing lag).
  research ear-clipping-triangulation topic to learn
