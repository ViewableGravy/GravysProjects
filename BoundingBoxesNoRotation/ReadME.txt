Developer: 
  Name: Lleyton W Morris 
  email: lleyton92@gmail.com

Description:
  an application that allows multiple entities to be created with multiple hitboxes, saved and loaded from a file.
  entities also contain an sprite (image) that's link is stored in file for loading.

There are currently several different application states:
  gameMode:
    No current functionality
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
To Implement:
  Add version field to dictate which version is currently being used (loading and saving to file)
  Modify storage structure (Mk3)
    at the end of an object it should look like: "} Player,". This way it should be easier to read where an object begins and ends 
    for easier searching
  create new player (GUI)
  Load specific player
  only create hitboxes within surrounding hitbox
  Confirm hitbox creation
  surrounding hitbox is image size ++ buffer
  resizing
  quadtree storing + collision
FixedIssues:
  moving crashes with no second entity
  collision only works when there are two entities
  cannot add hitboxes to entities
KnownIssues:
  no known issues at the moment