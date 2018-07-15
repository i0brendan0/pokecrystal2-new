	const_def 2 ; object constants
	const LEGENDARY_MEWTWO

CeruleanCave_MapScripts:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_OBJECTS, .Mewtwo

.Mewtwo:
	checkevent EVENT_FOUGHT_MEWTWO
	iftrue .NoAppear
	checkevent EVENT_BEAT_RED
	iftrue .Appear
.NoAppear:
	disappear LEGENDARY_MEWTWO
	return

.Appear:
	appear LEGENDARY_MEWTWO
	return

Mewtwo:
	opentext
	writetext MewtwoText
	cry Mewtwo
	pause 15
	closetext
	setevent EVENT_FOUGHT_MEWTWO
	loadwildmon MEWTWO, 50
	startbattle
	disappear LEGENDARY_MEWTWO
	reloadmapafterbattle
	end

MewtwoText:
	text "Gyaoo!"
	done

CeruleanCave_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_def 37, 21, 7, CERULEAN_CITY

	db 0 ; coord events

	db 1 ; bg events
	signpost 19, 19, SIGNPOST_ITEM, CeruleanCityHiddenBerserkGene

	db 1 ; object events
	person_event SPRITE_CHARMANDER, 19, 19, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PINK, PERSONTYPE_SCRIPT, 0, Mewtwo, EVENT_LEGENDARY_MEWTWO
