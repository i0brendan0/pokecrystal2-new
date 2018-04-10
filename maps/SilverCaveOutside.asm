const_value set 2
	const LEGENDARYBIRD_MOLTRES
	
SilverCaveOutside_MapScripts:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	dbw MAPCALLBACK_OBJECTS, .Moltres

.FlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

.Moltres:
	checkevent EVENT_FOUGHT_MOLTRES
	iftrue .NoAppear
	checkevent EVENT_BEAT_RED
	iftrue .Appear
	jump .NoAppear

.Appear:
	appear LEGENDARYBIRD_MOLTRES
	return

.NoAppear:
	disappear LEGENDARYBIRD_MOLTRES
	return

Moltres:
	opentext
	writetext MoltresText
	cry Moltres
	pause 15
	closetext
	setevent EVENT_FOUGHT_MOLTRES
	loadwildmon MOLTRES, 50
	startbattle
	disappear LEGENDARYBIRD_MOLTRES
	reloadmapafterbattle
	end

MoltresText:
	text "Gyaoo!"
	done

MtSilverPokecenterSign:
	jumpstd pokecentersign

MtSilverSign:
	jumptext MtSilverSignText

SilverCaveOutsideHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE

MtSilverSignText:
	text "MT.SILVER"
	done

SilverCaveOutside_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event 23, 19, SILVER_CAVE_POKECENTER_1F, 1
	warp_event 18, 11, SILVER_CAVE_ROOM_1, 1

	db 0 ; coord events

	db 3 ; bg events
	bg_event 24, 19, BGEVENT_READ, MtSilverPokecenterSign
	bg_event 17, 13, BGEVENT_READ, MtSilverSign
	bg_event  9, 25, BGEVENT_ITEM, SilverCaveOutsideHiddenFullRestore

	db 1 ; object events
	object_event 25, 9, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Moltres, EVENT_LEGENDARY_BIRD_MOLTRES