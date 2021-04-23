asect 0x00
beg:
ldi r0, vxy #================= Vxy 
ld r0, r0
ldi r2,ballY #===============ballY
ld r2, r2
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
ldi r1, ballX #============ballX
ld r1, r1
neg r1
ldi r3, 224#######(224 - x)
add r3, r1 ## left to cross bat
shr r1# in case abs(Vx) == 2 !!!!!!!!!!!!!!!!!!!! depens on Controller(idk) 
ldi r3, 0b01111111
and r3, r1
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
	 push r2
	 move r1, r2
	 ldi r0, 0
	 ldi r3, 0
	 shla r1
	 addc r0, r3
	 ldi r0, 0
	 add r2, r1
	 addc r0, r3
	 pop r2
	 br next
	fi
ldi r3, 2
	if
	 cmp r0, r3
	 is eq
	 ldi r3, 0
	 ldi r0, 0
	 shla r1
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
inc r2
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
neg r0# only vy
ldi r3, 4
	if 
	 cmp r0, r3
	 is eq 
	 ldi r3, 0
	 ldi r0, 0
	 shla r1
	 addc r0, r3
	 ldi r0, 0
	 shla r1
	 addc r0, r3
	 br next2
	fi
ldi r3, 3
	if 
	 cmp r0, r3
	 is eq 
	 push r2
	 move r1, r2
	 ldi r3, 0
	 ldi r0, 0
	 shla r1
 	 addc r0, r3
     ldi r0, 0
	 add r2, r1
	 addc r0, r3
	 pop r2
	 br next2
	fi
ldi r3, 2
	if
	 cmp r0, r3
	 is eq
	 ldi r3, 0
	 ldi r0, 0
	 shla r1
	 addc r0, r3
	 br next2
	fi	
ldi r3, 0
next2:
ldi r0, 0
add r1, r2 ########### r2 = d = y + (224 - x)/vx * vy
addc r0, r3
#neg r2######?
ldi r0, 1
and r0, r3
if### even / odd
tst r3
is gt
neg r2
inc r2
else
fi
ldi r0, 0xf8 
st r0, r2
br beg
fi######################################################}
halt
vxy: 
dc 0x32
ballX:
dc 0x1c
ballY: 
dc 0x82
end