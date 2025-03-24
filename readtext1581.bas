0 poke53272,23:poke53281,0:poke53280,12:dv=peek(186):rem device
1 print "{white}read from device";dv:input "enter to use, or type #";a
2 if a<>0 then dv=a
3 mc=127:dimc%(mc,2),c$(mc),x(15),f$(13):cc=0:du=1:cs=18
6 print"{clear}{white}Bible reader v0.8 by Eyvind Ebsen 2024{green}":?
7 gosub10
8 gosub9520::gosub800:goto940:rem cache du=do upper;hoyo decode
9 rem show a menu
10 for x=1 to 13:read a$,f$(x):print chr$(64+x)"-";a$:next
20 print:input"{light green}Select a book A-M. 0 to quit";s$:if s$="0" then end
30 if s$<"a" or s$>"m" then restore:print:goto10
35 fi$=f$(asc(s$)-64):print:print:return
40 end
80 data "First book of Moses  'Genesis'","book1"
81 data "Second book of Moses 'Exodus'","book2"
82 data "Third book of Moses  'Leviticus'","book3"
83 data "Fourth book of Moses 'Numbers'","book4"
84 data "Fifth book of Moses  'Deuteronomy'","book5"
85 data "Book of Joshua","joshua"
86 data "Book of judges","judges"
87 data "First book of Samuel","samuel1"
88 data "Second book of Samuel","samuel2"
89 data "First book of the kings","bookofkings1"
90 data "Second book of the kings","bookofkings2"
91 data "First book of the chronicles","chron1"
92 data "Second book of the chronicles","chron2"
799 rem setup decoder
800 s$="0123456789.,:;?!AIO'()-"+chr$(13)
810 dimbl(16):for x=.to14:readbl(x):next
820 data 6,9,11,11,12,12,11,11,10,9,8,7,7,6,3
822 rem open the seq file of data
824 open 3,dv,3,fi$+",s,r":gosub1000
825 bc=0:get#3,q$:by=asc(q$+chr$(0)):rem set bitcount, read first byte
830 return
899 rem decode a byte; read 1 bit
900 bi=0:if by>127 then bi=1
910 by=by*2 and 255:rem shl; next bit
920 bc=bc+1:ifbc>7thenbc=0:get#3,q$:by=asc(q$+chr$(0)):ifst=64thengoto1030
930 return
935 rem read a chunk
940 gosub 900:if bi=0then970
945 rem print "found word, now read 4 bits..."
946 td=4:gosub 990
951 if w=15 then print"end of text.":close15:close2:end
956 rem print"wordbank #"w" bitlen:"bl(w)
958 td=bl(w):ow=w:gosub990
960 if sp>1 then print" ";:sp=0:cx=cx+1:gosub 9300
962 nu=w:w=ow
963 gosub 9000:if d$<>""thencx=cx+2+len(d$):gosub9300:gosub9500:print d$" ";:goto940:rem check cache
965 gosub9540:cs=cs-1:if cs=0 then cs=18:gosub9120
966 goto940
969 rem read special; 5 bits
970 td=5:gosub990
974 if w=23 then print:print:cx=0:sp=0:du=1:goto940
976 if w=12then print"{left}, ";:cx=cx+2:sp=0:goto940
978 if w=11then print"{left}. ";:cx=cx+2:du=1:sp=0:goto940
979 if w=17then d$="a":gosub9500:printd$" ";:goto940
980 if w=18then d$="i":gosub9500:printd$" ";:goto940
981 if w=19then d$="o":gosub9500:printd$" ";:goto940
982 if w=15then print"? ";:cx=cx+2:du=1:sp=0:goto940
983 printmid$(s$,w,1);:sp=sp+1
984 goto940
989 rem read x bits
990 w=0:rem call with td set=bits to read
992 gosub900:if bi=1 then w=w+1
996 td=td-1:if td>0 then w=w*2:goto992:rem only shr if more bits
998 return
999 rem error check
1000 input#15,e,e$,e1,e2
1010 rem print e;e$;e1,e2
1020 return
1030 ?:print"end-of-text":close15:close2:close3:end
8999 rem cache stuff - check cache
9000 d$="":if cc=0 then return
9010 x=.
9020 if w=c%(x,0) then if nu=c%(x,1) then gosub 9040:return
9030 x=x+1:ifx>cc then return
9035 goto 9020
9040 d$=c$(x):c%(x,2)=c%(x,2)+1:return:rem found in cache, inc hits
9099 rem insert in cache
9100 c%(cc,0)=w:c%(cc,1)=nu:c%(cc,2)=0:c$(cc)=d$:cc=cc+1:rem print"ins in c: "b$
9110 poke 1063,cc:if cc>mc then cc=91:rem restart cache
9111 rem if cc=64 or cc=128 or cc=192 then print:print"sorting cache...":gosub9120
9112 rem if cc>5 then gosub 9120:rem sort one run
9114 return
9119 rem sort cache by hits
9120 sd=cc-1:rem print"free mem:"fre(0)
9122 forx=0tosd-1
9132 if c%(x,2)>c%(x+1,2)then9150:rem else swap
9134 d$=c$(x):a%=c%(x,0):b%=c%(x,1):c%=c%(x,2)
9142 c%(x,0)=c%(x+1,0):c%(x,1)=c%(x+1,1):c%(x,2)=c%(x+1,2)
9146 c$(x)=c$(x+1)
9148 c%(x+1,0)=a%:c%(x+1,1)=b%:c%(x+1,2)=c%:c$(x+1)=d$
9150 next:poke1063,sd
9160 return:rem:sd=sd-1:if sd>1 then goto9122
9170 return
9199 rem show cache
9200 forx=.to cc-1
9210 print x,c$(x),c%(x,2)
9220 next:end
9299 rem check for x pos
9300 if cx>35 then print:cx=0
9310 return
9499 rem set first letter uppercase
9500 if du=0then return
9502 f$=chr$(asc(left$(d$,1))+128)
9506 f$=f$+right$(d$,len(d$)-1)
9507 d$=f$:du=0
9510 return
9519 rem get rec 1 data of rec pos
9520 open15,dv,15:open 2,dv,2,"words"
9522 rem now goto rec 1 and check
9524 r=1:rem:print"checks rec 1":print
9526 r0=int(r/256):r1=r-r0*256:rem calc hi and low record number
9528 print#15,"p"+chr$(96+2)+chr$(r1)+chr$(r0)+chr$(1):rem seek rec
9530 input#2,a$:rem printa$
9532 forx=0to15:v=val(mid$(a$,1+x*3,3)):x(x)=v:next
9534 return:rem close2:close15:end
9539 rem calc rec and word num, w=len,nu=num
9540 wr=x(w):rem init rec
9542 al=int(254/(w+2)) : rem a rec len
9544 ro=int(nu/al):rem offset rec pos
9546 nr=nu-ro*al: rem wordnum in offset rec
9556 rem print wr,al,ro,nr
9558 rem print "loc rec"wr+ro"read from pos"nr*w" ("w"b)"
9560 r=wr+ro:bb=0:rem print"opening record"r
9562 r0=int(r/256):r1=r-r0*256:rem calc hi and low record number
9564 print#15,"p"+chr$(96+2)+chr$(r1)+chr$(r0)+chr$(1+nr*(w+2)):rem seek rec256
9566 rem gosub 1000:ife<>0 then 135:rem record not found
9568 d$=""
9570 get#2,a$:d$=d$+a$:ot=st:bb=bb+1:if bb<w+2 and ot<>64 then goto9570
9572 cx=cx+2+len(d$):gosub9300:gosub 9100:gosub9500:print d$" ";:rem insert in cache
9574 return
