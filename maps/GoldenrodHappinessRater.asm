	const_def 2 ; object constants
	const GOLDENRODHAPPINESSRATER_TEACHER
	const GOLDENRODHAPPINESSRATER_POKEFAN_M
	const GOLDENRODHAPPINESSRATER_TWIN

GoldenrodHappinessRater_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

TeacherScript_0x54953:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext UnknownText_0x549a3
	buttonsound
	ifgreater 250 - 1, UnknownScript_0x54973
	ifgreater 200 - 1, UnknownScript_0x54979
	ifgreater 150 - 1, UnknownScript_0x5497f
	ifgreater 100 - 1, UnknownScript_0x54985
	ifgreater  50 - 1, UnknownScript_0x5498b
	jump UnknownScript_0x54991

UnknownScript_0x54973:
	writetext UnknownText_0x549fc
	waitbutton
	closetext
	end

UnknownScript_0x54979:
	writetext UnknownText_0x54a2c
	waitbutton
	closetext
	end

UnknownScript_0x5497f:
	writetext UnknownText_0x54a5a
	waitbutton
	closetext
	end

UnknownScript_0x54985:
	writetext UnknownText_0x54a8e
	waitbutton
	closetext
	end

UnknownScript_0x5498b:
	writetext UnknownText_0x54a9f
	waitbutton
	closetext
	end

UnknownScript_0x54991:
	writetext UnknownText_0x54ad1
	waitbutton
	closetext
	end

GoldenrodHappinessRaterPokefanMScript:
	jumptextfaceplayer GoldenrodHappinessRaterPokefanMText

GoldenrodHappinessRaterTwinScript:
	jumptextfaceplayer GoldenrodHappinessRaterTwinText

HappinessRatersHouseBookshelf:
	jumpstd difficultbookshelf

HappinessRatersHouseRadio:
	jumpstd radio2

UnknownText_0x549a3:
	text "If you treat your"
	line "#MON nicely,"

	para "they will love you"
	line "in return."

	para "Oh? Let me see"
	line "your @"
	text_from_ram wStringBuffer3
	text "…"
	done

UnknownText_0x549fc:
	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
	done

UnknownText_0x54a2c:
	text "I get the feeling"
	line "that it really"
	cont "trusts you."
	done

UnknownText_0x54a5a:
	text "It's friendly to-"
	line "ward you. It looks"
	cont "sort of happy."
	done

UnknownText_0x54a8e:
	text "It's quite cute."
	done

UnknownText_0x54a9f:
	text "You should treat"
	line "it better. It's"
	cont "not used to you."
	done

UnknownText_0x54ad1:
	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
	done

GoldenrodHappinessRaterPokefanMText:
	text "I keep losing in"
	line "battles, and my"

	para "#MON end up"
	line "fainting…"

	para "Maybe that's why"
	line "my #MON don't"
	cont "like me much…"
	done

GoldenrodHappinessRaterTwinText:
	text "When I use an item"
	line "on my #MON, it"
	cont "acts really glad!"
	done

GoldenrodHappinessRater_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 3
	warp_event  3,  7, GOLDENROD_CITY, 3

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  1, BGEVENT_READ, HappinessRatersHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, HappinessRatersHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, HappinessRatersHouseRadio

	db 3 ; object events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeacherScript_0x54953, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterPokefanMScript, -1
	object_event  5,  6, SPRITE_TWIN, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterTwinScript, -1
