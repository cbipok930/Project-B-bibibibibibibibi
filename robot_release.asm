asect 0x00
beg:
ldi r0, 0xf3 #================= Vxy 
ld r0, r0
ldi r2, 0xf5 #===============ballY
ld r2, r2
ldi r1,0xf4 #============ballX
ld r1, r1
if ############# vxy = 0 (when blocked){
tst r0
is eq
ldi r0, 0xf8
st r0, r2
br beg
fi#####################################}
ldi r3, 0b00000100
and r0, r3
if###################################Vx < 0 ? => just move to torture the player {
tst r3
is gt
ldi r0, 0xf8
st r0, r2
br beg
fi############################################################################## }
#ldi r3, 8
#if ################################## Vy == 0 ? ***simple {
#cmp r0, r3                                               
#is lt													 
#ldi r0, 0xf8											 
#st r0, r2												 
#br beg
#fi ###################################################### }
neg r1
ldi r3, 228#######(228 - x)
add r3, r1 ## left to cross bat
#push r0#############checking vx
#ldi r3, 0b00000111
#and r3, r0
#neg r0
#inc r0
#ldi r3, -3 ##(224 - x)/vx
#if
#cmp r3, r0
#is eq#################################### in case abs(Vx) == 3
#shr r1
#ldi r3, 0b01111111
#and r3, r1
#move r1, r3
#	while 
#	tst r3
#	stays gt
#	add r0, r3
#	dec r1
#	wend
#br endx
#fi
#ldi r3, -2
#if#################################### in case abs(Vx) == 2
#cmp r3, r0
#is eq
shr r1
ldi r3, 0b01111111
and r3, r1
#fi	 
#endx:
#pop r0
ldi r3, 32
if################################################ Vy > 0 { 
cmp r0, r3
is lt
shra r0
shra r0
shra r0 # only vy
ldi r3, 3
	if 
	 cmp r0, r3
	 is eq 
	 ldi r0, 0xff
	 st r0, r2
	 move r1, r2
	 ldi r0, 0
	 ldi r3, 0
	 add r1, r1
	 addc r0, r3
	 ldi r0, 0
	 add r2, r1
	 addc r0, r3
	 ldi r0, 0xff
	 ld r0, r2
	 br next
	fi
ldi r3, 2
	if
	 cmp r0, r3
	 is eq
	 ldi r3, 0
	 ldi r0, 0
	 add r1, r1
	 addc r0, r3
	 br next
	fi	
ldi r3, 0
next:
ldi r0, 0
add r1, r2 ########### r2 = d = y + (224 - x)/vx * vy
addc r0, r3
ldi r0, 1
and r0, r3
if### even / odd
tst r3
is eq
else
neg r2
fi
ldi r0, 0xf8 
st r0, r2
br beg
########################################################}
else####################################################################Vy < 0 {
shra r0
shra r0
shra r0 
ldi r3, 0b11111000
or r3, r0
ldi r3, -3
	if 
	 cmp r0, r3
	 is eq 
	 ldi r0, 0xff
	 st r0, r2
	 move r1, r2
	 ldi r3, 0
	 ldi r0, 0
	 add r2, r1
	 addc r0, r3
     ldi r0, 0
	 add r2, r1
	 addc r0, r3
	 ldi r0, 0xff
	 ld r0, r2
	 neg r1
	 br next2
	fi
ldi r3, -2
	if
	 cmp r0, r3
	 is eq
	 ldi r3, 0
	 ldi r0, 0
	 add r1, r1
	 addc r0, r3
	 neg r1
	 br next2
	fi	
ldi r3, 0
neg r1
next2:
ldi r0, 0
add r1, r2 ########### r2 = d = y + (224 - x)/vx * vy
addc r0, r3
ldi r0, 1
and r0, r3
if### even / odd
tst r3
is eq
neg r2
else
fi
ldi r0, 0xf8 
st r0, r2
br beg
fi######################################################}
halt
#vxy: 
#dc 42
#ballX:
#dc 55
#ballY: 
#dc -77
end