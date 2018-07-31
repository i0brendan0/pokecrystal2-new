ItemPocketNames:
; entries correspond to item type constants
	dw .Item
	dw .Key
	dw .Ball
	dw .TM
	dw .Holding

.Item:    db "ITEM POCKET@"
.Key:     db "KEY POCKET@"
.Ball:    db "BALL POCKET@"
.TM:      db "TM POCKET@"
.Holding: db "HELD ITEMS@"
