Developer: 
  Name: Lleyton W Morris 
  email: lleyton92@gmail.com

Description:
  an application that allows multiple entities to be created with multiple hitboxes, saved and loaded from a file.

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
	left click : delete hitbox (of current entity) at mouse position (will remove bottom most hitbox)
  insertMode:
        left click : initiate new hitbox creation for current entity
        left click (confirm) : confirm hitbox creation on current entity
	

note: each entity has an array of hitboxes but also stores information for an overall bounding box to use in simple collision.
e.g. quadtree

information for all entities is stored in the textfile "PlayerData.txt" and consequently read from also.