NameRaterMNText::
	text "I don't know how"
	line "to give this a"
	cont "nickname."
	done
	
MoveRelearner_IntroText::
	text "Ah! You have a"
	line "PEARL!"
	para "Shall I help your"
	line "#MON remember"
	cont "a move?"
	done
	
MoveRelearner_WhichMonText::
	text "Excellent! Which"
	line "#MON should"
	cont "remember a move?"
	done
	
MoveRelearner_HandedOverOneHeartScaleText::
	text "<PLAYER> handed"
	line "over one PEARL."
	done

MoveRelearner_ComeAgainText::
	text "If you come back"
	line "with a PEARL,"
	cont "I'll help your"
	cont "#MON remember"
	cont "moves."
	done
	
MoveRelearner_WhichMoveText::
	text "Which move should"
	line "it remember?"
	done

MoveRelearner_EggText::
	text "An EGG can't learn"
	line "moves."
	done

MoveRelearner_NotMonText::
	text "What?! That's not"
	line "a #MON!"
	done
	
MoveRelearner_NoMovesToLearnText::
	text "This #MON can't"
	line "learn any moves"
	cont "from me."
	done
	
AccessedSomeonesPCText::
	text "SOMEONE's PC"
	line "accessed."

	para "#MON Storage"
	line "System opened."
	prompt
    
PasswordCheckerIntroText::
    text "Hello. I'm the"
    line "password checker."
    
    para "If you know a"
    line "password, tell it"
    line "to me and maybe I"
    line "can give you some-"
    line "thing in return."
    done
    
PasswordCheckerEmptyText::
    text "I'm sorry. You"
    line "need to give me a"
    line "password if you"
    line "want the reward."
    
    para "Come back if you"
    line "want something."
    done

PasswordCheckerIncorrectText::
    text "The password that"
    line "you gave me is"
    line "incorrect."
    done
	
SomeonesPCText::
	text "SOMEONE's PC"
	line "accessed."

	para "#MON Storage"
	line "System opened."
	prompt

HeldItemsPocketText::
	text "<PLAYER> put the"
	line "@"
	text_from_ram wStringBuffer1
	text " in"
	cont "the @"
	text_from_ram wStringBuffer3
	cont "POCKET."
	prompt
	
HeldItemsFullText::
	text "The @"
	text_from_ram wStringBuffer3
	text_start
	line "POCKET is full…"
	prompt
