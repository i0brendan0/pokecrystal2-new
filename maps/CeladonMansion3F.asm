	const_def 2 ; object constants
	const CELADONMANSION3F_COOLTRAINER_M
	const CELADONMANSION3F_GYM_GUY
	const CELADONMANSION3F_SUPER_NERD
	const CELADONMANSION3F_FISHER

CeladonMansion3F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

CooltrainerMScript_0x71670:
	faceplayer
	opentext
	writetext UnknownText_0x716ce
	checkcode VAR_DEXCAUGHT
	ifgreater NUM_POKEMON - 1, UnknownScript_0x7167e ; ignore Missingno
	waitbutton
	closetext
	end

UnknownScript_0x7167e:
	buttonsound
	writetext UnknownText_0x71725
	playsound SFX_DEX_FANFARE_230_PLUS
	waitsfx
	writetext UnknownText_0x71760
	buttonsound
	special Diploma
	writetext UnknownText_0x71763
	waitbutton
	closetext
	setevent EVENT_ENABLE_DIPLOMA_PRINTING
	end

GymGuyScript_0x71696:
	faceplayer
	opentext
	checkevent EVENT_ENABLE_DIPLOMA_PRINTING
	iftrue UnknownScript_0x716a4
	writetext UnknownText_0x717b4
	waitbutton
	closetext
	end

UnknownScript_0x716a4:
	writetext UnknownText_0x717d8
	yesorno
	iffalse UnknownScript_0x716b0
	special PrintDiploma
	closetext
	end

UnknownScript_0x716b0:
	writetext UnknownText_0x71830
	waitbutton
	closetext
	end

UnknownScript_0x716b6:
	writetext UnknownText_0x71863
	waitbutton
	closetext
	end

CeladonMansion3FSuperNerdScript:
	jumptextfaceplayer CeladonMansion3FSuperNerdText

CeladonMansion3FFisherScript:
	jumptextfaceplayer CeladonMansion3FFisherText

MapCeladonMansion3FSignpost0Script:
	jumptext UnknownText_0x7190b

MapCeladonMansion3FSignpost1Script:
	jumptext UnknownText_0x71928

MapCeladonMansion3FSignpost2Script:
	opentext
	writetext UnknownText_0x71952
	yesorno
	iffalse .DidNotMessWithGame
	checkevent EVENT_BEAT_RED
	iffalse .NothingHappened
	callasm .MissingNoCaught
	iftrue .NothingHappened
	random 100
	if_true .SeenMissingNo ; 99/100 - 99%
	writetext MissingNoCry
	cry MISSINGNO
	setevent EVENT_SAW_MISSINGNO
	pause 20
	loadwildmon MISSINGNO, 25
	startbattle
	end

.DidNotMessWithGame:
	writetext DidNotMessText
	waitbutton
	closetext
	end

.MissingNoCaught:
	ld c, MISSINGNO
	farcall CheckCaughtMonFromFarcall
	ld a, b
	ld [wScriptVar], a
	ret

.SeenMissingNo:
	checkevent EVENT_SAW_MISSINGNO
	iftrue .NothingHappened

.NotMissingNo: ;If MissingNo. does not show up, new random #
	random 255
	if_greater_than 100, .NothingHappened ;155/255 ~ 60.7%
	if_greater_than  70, .GivePokeBall    ; 30/255 ~ 11.8%
	if_greater_than  56, .Give2000Money   ; 14/255 ~ 05.5%
	if_greater_than  50, .GivePotion      ;  6/255 ~ 02.4%
	if_greater_than  40, .Take1000Money   ; 10/255 ~ 03.9%
	if_greater_than  33, .GiveGreatBall   ;  7/255 ~ 02.7%
	if_greater_than  20, .TakePokeBall    ; 13/255 ~ 05.1%
	if_greater_than  16, .GiveUltraBall   ;  4/255 ~ 01.2%
	if_greater_than  10, .Give100Coins    ;  6/255 ~ 02.7%
	if_greater_than   5, .GiveLeftovers   ;  5/255 ~ 02.0%
	if_greater_than   1, .Give1000Coins   ;  4/255 ~ 01.6%
	verbosegiveitem MASTER_BALL           ;  1/255 ~ 00.4%
	waitbutton
	closetext
	end

.GivePokeBall:
	verbosegiveitem POKE_BALL
	waitbutton
	closetext
	end

.Give2000Money:
	checkmoney 0, 998000
	iftrue .GiveMoneyToMom
	givemoney 0, 2000
	writetext GotMoneyText
	playsound SFX_ITEM
	waitsfx
	waitbutton
	closetext
	end

.GiveMoneyToMom:
	checkmoney 1, 998000
	iftrue .NothingHappened
	givemoney 1, 2000
	writetext MomGotMoneyText
	playsound SFX_ITEM
	waitsfx
	waitbutton
	closetext
	end

.GivePotion:
	verbosegiveitem POTION
	waitbutton
	closetext
	end

.Take1000Money:
	checkmoney 0, 1000
	iffalse .TakeMoneyFromMom
	takemoney 0, 1000
	writetext LostMoneyText
	waitbutton
	closetext
	end

.TakeMoneyFromMom:
	checkmoney 1, 1000
	iffalse .NothingHappened
	takemoney 1, 1000
	writetext MomLostMoneyText
	waitbutton
	closetext
	end

.GiveGreatBall:
	verbosegiveitem GREAT_BALL
	waitbutton
	closetext
	end

.TakePokeBall:
	checkitem POKE_BALL
	iffalse .NothingHappened
	takeitem POKE_BALL
	writetext LostPokeballText
	waitbutton
	closetext
	end

.GiveUltraBall:
	verbosegiveitem ULTRA_BALL
	waitbutton
	closetext
	end

.Give100Coins:
	checkcoins 9800
	iftrue .NothingHappened
	givecoins 100
	writetext Got100CoinsText
	playsound SFX_ITEM
	waitsfx
	waitbutton
	closetext
	end

.GiveLeftovers:
	verbosegiveitem LEFTOVERS
	waitbutton
	closetext
	end

.Give1000Coins:
	checkcoins 9000
	iftrue .NothingHappened
	givecoins 1000
	writetext Got1000CoinsText
	playsound SFX_ITEM
	waitsfx
	waitbutton
	closetext
	end

.NothingHappened:
	closetext
	pause 10
	opentext
	writetext NothingText
	waitbutton
	closetext
	end
	
MapCeladonMansion3FSignpost3Script:
	jumptext UnknownText_0x71996

UnknownText_0x716ce:
	text "Is that right?"

	para "I'm the GAME"
	line "DESIGNER!"

	para "Filling up your"
	line "#DEX is tough,"
	cont "but don't give up!"
	done

UnknownText_0x71725:
	text "Wow! Excellent!"
	line "You completed your"
	cont "#DEX!"

	para "Congratulations!"
	done

UnknownText_0x71760:
	text "…"
	done

UnknownText_0x71763:
	text "The GRAPHIC ARTIST"
	line "will print out a"
	cont "DIPLOMA for you."

	para "You should go show"
	line "it off."
	done

UnknownText_0x717b4:
	text "I'm the GRAPHIC"
	line "ARTIST."

	para "I drew you!"
	done

UnknownText_0x717d8:
	text "I'm the GRAPHIC"
	line "ARTIST."

	para "Oh, you completed"
	line "your #DEX?"

	para "Want me to print"
	line "out your DIPLOMA?"
	done

UnknownText_0x71830:
	text "Give me a shout if"
	line "you want your"
	cont "DIPLOMA printed."
	done

UnknownText_0x71863:
	text "Something's wrong."
	line "I'll have to can-"
	cont "cel printing."
	done

CeladonMansion3FSuperNerdText:
	text "Who, me? I'm the"
	line "PROGRAMMER."

	para "Play the slot"
	line "machines!"
	done

CeladonMansion3FFisherText:
	text "Aren't the TWINS"
	line "adorable?"

	para "JASMINE's pretty"
	line "too."

	para "Oh, I love them!"
	done

UnknownText_0x7190b:
	text "GAME FREAK"
	line "DEVELOPMENT ROOM"
	done

UnknownText_0x71928:
	text "It's a detailed"
	line "drawing of a"
	cont "pretty girl."
	done

UnknownText_0x71952:
	text "It's the game"
	line "program. Messing"

	para "with it could put"
	line "a bug in the game!"
	
	para "Mess with it?<...>"
	done

UnknownText_0x71996:
	text "It's crammed with"
	line "reference materi-"
	cont "als. There's even"
	cont "a # DOLL."
	done

DidNotMessText:
	text "Decided not to"
	line "mess with the"
	cont "game program."
	done

NothingText:
	text "Looks like no-"
	line "thing happened."
	done

MissingNoCry:
	text "???: -/0'vü] J←▼×"
	cont "4♂ &<MN>Ö ERROR M"
	done

GotMoneyText:
	text "<PLAYER> recieved"
	cont "¥2000."
	done

MomGotMoneyText:
	text "<PLAYER>'s MOM"
	cont "recieved ¥2000."
	done

LostMoneyText:
	text "<PLAYER> lost"
	cont "¥1000."
	done

MomLostMoneyText:
	text "<PLAYER>'s MOM"
	cont "lost ¥1000."
	done

LostPokeballText:
	text "<PLAYER> lost"
	cont "a POKEBALL."
	done

Got100CoinsText:
	text "<PLAYER> recieved"
	cont "100 Coins."
	done

Got1000CoinsText:
	text "<PLAYER> recieved"
	cont "1000 Coins."
	done
	
CeladonMansion3F_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  0,  0, CELADON_MANSION_ROOF, 1
	warp_event  1,  0, CELADON_MANSION_2F, 2
	warp_event  6,  0, CELADON_MANSION_2F, 3
	warp_event  7,  0, CELADON_MANSION_ROOF, 2

	db 0 ; coord events

	db 4 ; bg events
	bg_event  5,  8, BGEVENT_UP, MapCeladonMansion3FSignpost0Script
	bg_event  4,  3, BGEVENT_UP, MapCeladonMansion3FSignpost1Script
	bg_event  1,  6, BGEVENT_UP, MapCeladonMansion3FSignpost2Script
	bg_event  1,  3, BGEVENT_UP, MapCeladonMansion3FSignpost3Script

	db 4 ; object events
	object_event  3,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CooltrainerMScript_0x71670, -1
	object_event  3,  4, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GymGuyScript_0x71696, -1
	object_event  0,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonMansion3FSuperNerdScript, -1
	object_event  0,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonMansion3FFisherScript, -1
