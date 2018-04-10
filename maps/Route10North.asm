const_value set 2
	const LEGENDARYBIRD_ZAPDOS
	
Route10North_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks

	dbw MAPCALLBACK_OBJECTS, .Zapdos

.Zapdos:
	checkevent EVENT_FOUGHT_ZAPDOS
	iftrue .NoAppear
	checkevent EVENT_BEAT_RED
	iftrue .Appear
	jump .NoAppear

.Appear:
	appear LEGENDARYBIRD_ZAPDOS
	return

.NoAppear:
	disappear LEGENDARYBIRD_ZAPDOS
	return

Zapdos:
	opentext
	writetext ZapdosText
	cry ZAPDOS
	pause 15
	closetext
	setevent EVENT_FOUGHT_ZAPDOS
	loadwildmon ZAPDOS, 50
	startbattle
	disappear LEGENDARYBIRD_ZAPDOS
	reloadmapafterbattle
	end

ZapdosText:
	text "Gyaoo!"
	done
	
PowerPlantSign:
	jumptext PowerPlantSignText

Route10PokecenterSign:
	jumpstd pokecentersign

PowerPlantSignText:
	text "KANTO POWER PLANT"
	done

Route10North_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event 11,  1, ROUTE_10_POKECENTER_1F, 1
	warp_event  3,  9, POWER_PLANT, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5, 11, BGEVENT_READ, PowerPlantSign
	bg_event 12,  1, BGEVENT_READ, Route10PokecenterSign

	db 1 ; object events
	object_event 10, 7, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Zapdos, EVENT_LEGENDARY_BIRD_ZAPDOS
