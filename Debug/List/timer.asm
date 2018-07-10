
;CodeVisionAVR C Compiler V3.30 Evaluation
;(C) Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATtiny2313V
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Tiny
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 32 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_TINY_

	#pragma AVRPART ADMIN PART_NAME ATtiny2313V
	#pragma AVRPART MEMORY PROG_FLASH 2048
	#pragma AVRPART MEMORY EEPROM 128
	#pragma AVRPART MEMORY INT_SRAM SIZE 128
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU WDTCR=0x21
	.EQU WDTCSR=0x21
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SREG=0x3F
	.EQU GPIOR0=0x13
	.EQU GPIOR1=0x14
	.EQU GPIOR2=0x15

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x00DF
	.EQU __DSTACK_SIZE=0x0020
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,__CLEAR_SRAM_SIZE
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_SRAM

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x80

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.30
;Automatic Program Generator
;© Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 12/27/2017
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATtiny2313V
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Tiny
;External RAM size       : 0
;Data Stack size         : 32
;*******************************************************/
;
;#include <io.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;// Declare your global variables here
;void fun(int);
;void main(void)
; 0000 001B {

	.CSEG
_main:
; .FSTART _main
; 0000 001C // Declare your local variables here
; 0000 001D int a=0,i;
; 0000 001E 
; 0000 001F // Crystal Oscillator division factor: 1
; 0000 0020 #pragma optsize-
; 0000 0021 CLKPR=(1<<CLKPCE);
;	a -> R16,R17
;	i -> R18,R19
	__GETWRN 16,17,0
	LDI  R30,LOW(128)
	OUT  0x26,R30
; 0000 0022 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 0023 #ifdef _OPTIMIZE_SIZE_
; 0000 0024 #pragma optsize+
; 0000 0025 #endif
; 0000 0026 
; 0000 0027 // Input/Output Ports initialization
; 0000 0028 // Port A initialization
; 0000 0029 // Function: Bit2=In Bit1=In Bit0=In
; 0000 002A DDRA=(0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	OUT  0x1A,R30
; 0000 002B // State: Bit2=T Bit1=T Bit0=T
; 0000 002C PORTA=(0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 002D 
; 0000 002E // Port B initialization
; 0000 002F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0030 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0031 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0032 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0033 
; 0000 0034 // Port D initialization
; 0000 0035 // Function: Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0036 DDRD=(0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0037 // State: Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0038 PORTD=(0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 0039 
; 0000 003A // Timer/Counter 0 initialization
; 0000 003B // Clock source: System Clock
; 0000 003C // Clock value: Timer 0 Stopped
; 0000 003D // Mode: Normal top=0xFF
; 0000 003E // OC0A output: Disconnected
; 0000 003F // OC0B output: Disconnected
; 0000 0040 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x30,R30
; 0000 0041 TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0042 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0043 OCR0A=0x00;
	OUT  0x36,R30
; 0000 0044 OCR0B=0x00;
	OUT  0x3C,R30
; 0000 0045 
; 0000 0046 // Timer/Counter 1 initialization
; 0000 0047 // Clock source: System Clock
; 0000 0048 // Clock value: Timer1 Stopped
; 0000 0049 // Mode: Normal top=0xFFFF
; 0000 004A // OC1A output: Disconnected
; 0000 004B // OC1B output: Disconnected
; 0000 004C // Noise Canceler: Off
; 0000 004D // Input Capture on Falling Edge
; 0000 004E // Timer1 Overflow Interrupt: Off
; 0000 004F // Input Capture Interrupt: Off
; 0000 0050 // Compare A Match Interrupt: Off
; 0000 0051 // Compare B Match Interrupt: Off
; 0000 0052 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0053 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0054 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0055 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0056 ICR1H=0x00;
	OUT  0x25,R30
; 0000 0057 ICR1L=0x00;
	OUT  0x24,R30
; 0000 0058 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0059 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 005A OCR1BH=0x00;
	OUT  0x29,R30
; 0000 005B OCR1BL=0x00;
	OUT  0x28,R30
; 0000 005C 
; 0000 005D // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 005E TIMSK=(0<<TOIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<ICIE1) | (0<<OCIE0B) | (0<<TOIE0) | (0<<OCIE0A);
	OUT  0x39,R30
; 0000 005F 
; 0000 0060 // External Interrupt(s) initialization
; 0000 0061 // INT0: Off
; 0000 0062 // INT1: Off
; 0000 0063 // Interrupt on any change on pins PCINT0-7: Off
; 0000 0064 GIMSK=(0<<INT1) | (0<<INT0) | (0<<PCIE);
	OUT  0x3B,R30
; 0000 0065 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0066 
; 0000 0067 // USI initialization
; 0000 0068 // Mode: Disabled
; 0000 0069 // Clock source: Register & Counter=no clk.
; 0000 006A // USI Counter Overflow Interrupt: Off
; 0000 006B USICR=(0<<USISIE) | (0<<USIOIE) | (0<<USIWM1) | (0<<USIWM0) | (0<<USICS1) | (0<<USICS0) | (0<<USICLK) | (0<<USITC);
	OUT  0xD,R30
; 0000 006C 
; 0000 006D // USART initialization
; 0000 006E // USART disabled
; 0000 006F UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0070 
; 0000 0071 // Analog Comparator initialization
; 0000 0072 // Analog Comparator: Off
; 0000 0073 // The Analog Comparator's positive input is
; 0000 0074 // connected to the AIN0 pin
; 0000 0075 // The Analog Comparator's negative input is
; 0000 0076 // connected to the AIN1 pin
; 0000 0077 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0078 // Digital input buffer on AIN0: On
; 0000 0079 // Digital input buffer on AIN1: On
; 0000 007A DIDR=(0<<AIN0D) | (0<<AIN1D);
	LDI  R30,LOW(0)
	OUT  0x1,R30
; 0000 007B 
; 0000 007C 
; 0000 007D 
; 0000 007E DDRB=255;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 007F DDRD=255;
	OUT  0x11,R30
; 0000 0080 DDRA.2=1;
	SBI  0x1A,2
; 0000 0081 PORTA.2=0;
	CBI  0x1B,2
; 0000 0082 
; 0000 0083 
; 0000 0084         PORTB.0=1;
	RCALL SUBOPT_0x0
; 0000 0085         PORTB.1=1;
; 0000 0086         PORTB.2=1;
; 0000 0087         PORTB.3=0;
; 0000 0088         PORTB.4=1;
	SBI  0x18,4
; 0000 0089         PORTB.5=1;
	SBI  0x18,5
; 0000 008A         PORTB.6=1;
	SBI  0x18,6
; 0000 008B         PORTB.7=0;
	CBI  0x18,7
; 0000 008C 
; 0000 008D 
; 0000 008E         PORTD.0=1;
	RCALL SUBOPT_0x1
; 0000 008F         PORTD.1=0;
; 0000 0090         PORTD.2=1;
; 0000 0091         PORTD.3=1;
; 0000 0092         PORTD.4=1;
; 0000 0093         PORTD.5=1;
; 0000 0094         PORTD.6=1;
	SBI  0x12,6
; 0000 0095 
; 0000 0096 while (1)
_0x25:
; 0000 0097       {
; 0000 0098        p:  PORTB.7=0;
_0x28:
	CBI  0x18,7
; 0000 0099        if(PINA.0==1&&PINA.1==0)    //to increase number
	SBIS 0x19,0
	RJMP _0x2C
	SBIS 0x19,1
	RJMP _0x2D
_0x2C:
	RJMP _0x2B
_0x2D:
; 0000 009A         {
; 0000 009B             a++;
	RCALL SUBOPT_0x2
; 0000 009C             if(a>99)
	BRLT _0x2E
; 0000 009D             {
; 0000 009E                 a=99;
	__GETWRN 16,17,99
; 0000 009F             }
; 0000 00A0             fun(a);
_0x2E:
	RCALL SUBOPT_0x3
; 0000 00A1             for(i=0;i<10;i++)
	__GETWRN 18,19,0
_0x30:
	__CPWRN 18,19,10
	BRGE _0x31
; 0000 00A2             {
; 0000 00A3                 delay_ms(50);
	RCALL SUBOPT_0x4
; 0000 00A4                 if(PINA.0==0&&PINA.1==0)
	SBIC 0x19,0
	RJMP _0x33
	SBIS 0x19,1
	RJMP _0x34
_0x33:
	RJMP _0x32
_0x34:
; 0000 00A5                 {
; 0000 00A6                     goto p;
	RJMP _0x28
; 0000 00A7                 }
; 0000 00A8             }
_0x32:
	__ADDWRN 18,19,1
	RJMP _0x30
_0x31:
; 0000 00A9             if(PINA.0==1&&PINA.1==0)       //to increase number continously
	SBIS 0x19,0
	RJMP _0x36
	SBIS 0x19,1
	RJMP _0x37
_0x36:
	RJMP _0x35
_0x37:
; 0000 00AA             {
; 0000 00AB                 while(PINA.0==1&&PINA.1==0)
_0x38:
	SBIS 0x19,0
	RJMP _0x3B
	SBIS 0x19,1
	RJMP _0x3C
_0x3B:
	RJMP _0x3A
_0x3C:
; 0000 00AC                 {
; 0000 00AD                     a++;
	RCALL SUBOPT_0x2
; 0000 00AE                     if(a>99)
	BRLT _0x3D
; 0000 00AF                     {
; 0000 00B0                         a=99;
	__GETWRN 16,17,99
; 0000 00B1                     }
; 0000 00B2                     fun(a);
_0x3D:
	RCALL SUBOPT_0x3
; 0000 00B3                     delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00B4                 }
	RJMP _0x38
_0x3A:
; 0000 00B5             }
; 0000 00B6         }
_0x35:
; 0000 00B7         else if(PINA.0==0&&PINA.1==1)   //to decrease number
	RJMP _0x3E
_0x2B:
	SBIC 0x19,0
	RJMP _0x40
	SBIC 0x19,1
	RJMP _0x41
_0x40:
	RJMP _0x3F
_0x41:
; 0000 00B8         {
; 0000 00B9             a--;
	__SUBWRN 16,17,1
; 0000 00BA             if(a<0)
	TST  R17
	BRPL _0x42
; 0000 00BB             {
; 0000 00BC                 a=0;
	__GETWRN 16,17,0
; 0000 00BD             }
; 0000 00BE             fun(a);
_0x42:
	RCALL SUBOPT_0x3
; 0000 00BF             for(i=0;i<10;i++)
	__GETWRN 18,19,0
_0x44:
	__CPWRN 18,19,10
	BRGE _0x45
; 0000 00C0             {
; 0000 00C1                 delay_ms(50);
	RCALL SUBOPT_0x4
; 0000 00C2                 if(PINA.0==0&&PINA.1==0)
	SBIC 0x19,0
	RJMP _0x47
	SBIS 0x19,1
	RJMP _0x48
_0x47:
	RJMP _0x46
_0x48:
; 0000 00C3                 {
; 0000 00C4                     goto p;
	RJMP _0x28
; 0000 00C5                 }
; 0000 00C6             }
_0x46:
	__ADDWRN 18,19,1
	RJMP _0x44
_0x45:
; 0000 00C7             if(PINA.0==0&&PINA.1==1)     //to decrease number continously
	SBIC 0x19,0
	RJMP _0x4A
	SBIC 0x19,1
	RJMP _0x4B
_0x4A:
	RJMP _0x49
_0x4B:
; 0000 00C8             {
; 0000 00C9                 while(PINA.0==0&&PINA.1==1)
_0x4C:
	SBIC 0x19,0
	RJMP _0x4F
	SBIC 0x19,1
	RJMP _0x50
_0x4F:
	RJMP _0x4E
_0x50:
; 0000 00CA                 {
; 0000 00CB                     a--;
	__SUBWRN 16,17,1
; 0000 00CC                     if(a<0)
	TST  R17
	BRPL _0x51
; 0000 00CD                     {
; 0000 00CE                         a=0;
	__GETWRN 16,17,0
; 0000 00CF                     }
; 0000 00D0                     fun(a);
_0x51:
	RCALL SUBOPT_0x3
; 0000 00D1                     delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00D2                 }
	RJMP _0x4C
_0x4E:
; 0000 00D3             }
; 0000 00D4         }
_0x49:
; 0000 00D5         if((PINA.0==0&&PINA.1==0)&&a!=0)  //to start countdown
_0x3F:
_0x3E:
	SBIC 0x19,0
	RJMP _0x53
	SBIS 0x19,1
	RJMP _0x54
_0x53:
	RJMP _0x55
_0x54:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRNE _0x56
_0x55:
	RJMP _0x52
_0x56:
; 0000 00D6         {
; 0000 00D7             while(PINA.0==0&&PINA.1==0)
_0x57:
	SBIC 0x19,0
	RJMP _0x5A
	SBIS 0x19,1
	RJMP _0x5B
_0x5A:
	RJMP _0x59
_0x5B:
; 0000 00D8             {
; 0000 00D9                 for(i=0;i<20;i++)
	__GETWRN 18,19,0
_0x5D:
	__CPWRN 18,19,20
	BRGE _0x5E
; 0000 00DA                 {
; 0000 00DB                     delay_ms(50);
	RCALL SUBOPT_0x4
; 0000 00DC                     if(i==10){
	RCALL SUBOPT_0x5
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x5F
; 0000 00DD                         PORTB.7=1;
	SBI  0x18,7
; 0000 00DE                     }
; 0000 00DF                     if(PINA.0==1||PINA.1==1)
_0x5F:
	SBIC 0x19,0
	RJMP _0x63
	SBIS 0x19,1
	RJMP _0x62
_0x63:
; 0000 00E0                     {
; 0000 00E1                         goto p;
	RJMP _0x28
; 0000 00E2                     }
; 0000 00E3                 }
_0x62:
	__ADDWRN 18,19,1
	RJMP _0x5D
_0x5E:
; 0000 00E4                 a--;
	__SUBWRN 16,17,1
; 0000 00E5                 fun(a);
	RCALL SUBOPT_0x3
; 0000 00E6                 if(a==0)                //to start buzzer
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x65
; 0000 00E7                 {
; 0000 00E8                     PORTB.7=0;
	CBI  0x18,7
; 0000 00E9                     PORTA.2=1;
	SBI  0x1B,2
; 0000 00EA                     delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
; 0000 00EB                     PORTA.2=0;
	CBI  0x1B,2
; 0000 00EC                     break;
	RJMP _0x59
; 0000 00ED                 }
; 0000 00EE             }
_0x65:
	RJMP _0x57
_0x59:
; 0000 00EF         }
; 0000 00F0       }
_0x52:
	RJMP _0x25
; 0000 00F1 }
_0x6C:
	RJMP _0x6C
; .FEND
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
;void fun(int x)
; 0000 00F5 {
_fun:
; .FSTART _fun
; 0000 00F6     if(x/10==0)
	RCALL __SAVELOCR2
	MOVW R16,R26
;	x -> R16,R17
	RCALL SUBOPT_0x6
	SBIW R30,0
	BRNE _0x6D
; 0000 00F7     {
; 0000 00F8         PORTB.0=1;
	RCALL SUBOPT_0x0
; 0000 00F9         PORTB.1=1;
; 0000 00FA         PORTB.2=1;
; 0000 00FB         PORTB.3=0;
; 0000 00FC         PORTB.4=1;
	RJMP _0x1AB
; 0000 00FD         PORTB.5=1;
; 0000 00FE         PORTB.6=1;
; 0000 00FF     }
; 0000 0100      else if(x/10==1)
_0x6D:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x7D
; 0000 0101     {
; 0000 0102         PORTB.0=1;
	RCALL SUBOPT_0x7
; 0000 0103         PORTB.1=0;
; 0000 0104         PORTB.2=0;
; 0000 0105         PORTB.3=0;
	CBI  0x18,3
; 0000 0106         PORTB.4=0;
	CBI  0x18,4
; 0000 0107         PORTB.5=0;
	CBI  0x18,5
; 0000 0108         PORTB.6=1;
	RJMP _0x1AC
; 0000 0109     }
; 0000 010A      else if(x/10==2)
_0x7D:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x8D
; 0000 010B     {
; 0000 010C         PORTB.0=0;
	CBI  0x18,0
; 0000 010D         PORTB.1=1;
	SBI  0x18,1
; 0000 010E         PORTB.2=1;
	SBI  0x18,2
; 0000 010F         PORTB.3=1;
	SBI  0x18,3
; 0000 0110         PORTB.4=0;
	CBI  0x18,4
; 0000 0111         PORTB.5=1;
	RJMP _0x1AD
; 0000 0112         PORTB.6=1;
; 0000 0113     }
; 0000 0114      else if(x/10==3)
_0x8D:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x9D
; 0000 0115     {
; 0000 0116         PORTB.0=1;
	RCALL SUBOPT_0x8
; 0000 0117         PORTB.1=1;
; 0000 0118         PORTB.2=0;
; 0000 0119         PORTB.3=1;
; 0000 011A         PORTB.4=0;
	CBI  0x18,4
; 0000 011B         PORTB.5=1;
	RJMP _0x1AD
; 0000 011C         PORTB.6=1;
; 0000 011D     }
; 0000 011E      else if(x/10==4)
_0x9D:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xAD
; 0000 011F     {
; 0000 0120         PORTB.0=1;
	RCALL SUBOPT_0x7
; 0000 0121         PORTB.1=0;
; 0000 0122         PORTB.2=0;
; 0000 0123         PORTB.3=1;
	SBI  0x18,3
; 0000 0124         PORTB.4=1;
	SBI  0x18,4
; 0000 0125         PORTB.5=0;
	CBI  0x18,5
; 0000 0126         PORTB.6=1;
	RJMP _0x1AC
; 0000 0127     }
; 0000 0128      else if(x/10==5)
_0xAD:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xBD
; 0000 0129     {
; 0000 012A         PORTB.0=1;
	RCALL SUBOPT_0x8
; 0000 012B         PORTB.1=1;
; 0000 012C         PORTB.2=0;
; 0000 012D         PORTB.3=1;
; 0000 012E         PORTB.4=1;
	SBI  0x18,4
; 0000 012F         PORTB.5=1;
	SBI  0x18,5
; 0000 0130         PORTB.6=0;
	CBI  0x18,6
; 0000 0131     }
; 0000 0132      else if(x/10==6)
	RJMP _0xCC
_0xBD:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0xCD
; 0000 0133     {
; 0000 0134         PORTB.0=1;
	SBI  0x18,0
; 0000 0135         PORTB.1=1;
	SBI  0x18,1
; 0000 0136         PORTB.2=1;
	SBI  0x18,2
; 0000 0137         PORTB.3=1;
	SBI  0x18,3
; 0000 0138         PORTB.4=1;
	SBI  0x18,4
; 0000 0139         PORTB.5=1;
	SBI  0x18,5
; 0000 013A         PORTB.6=0;
	CBI  0x18,6
; 0000 013B     }
; 0000 013C      else if(x/10==7)
	RJMP _0xDC
_0xCD:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0xDD
; 0000 013D     {
; 0000 013E         PORTB.0=1;
	RCALL SUBOPT_0x7
; 0000 013F         PORTB.1=0;
; 0000 0140         PORTB.2=0;
; 0000 0141         PORTB.3=0;
	CBI  0x18,3
; 0000 0142         PORTB.4=0;
	CBI  0x18,4
; 0000 0143         PORTB.5=1;
	RJMP _0x1AD
; 0000 0144         PORTB.6=1;
; 0000 0145     }
; 0000 0146      else if(x/10==8)
_0xDD:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0xED
; 0000 0147     {
; 0000 0148         PORTB.0=1;
	SBI  0x18,0
; 0000 0149         PORTB.1=1;
	SBI  0x18,1
; 0000 014A         PORTB.2=1;
	SBI  0x18,2
; 0000 014B         PORTB.3=1;
	RJMP _0x1AE
; 0000 014C         PORTB.4=1;
; 0000 014D         PORTB.5=1;
; 0000 014E         PORTB.6=1;
; 0000 014F     }
; 0000 0150      else if(x/10==9)
_0xED:
	RCALL SUBOPT_0x6
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xFD
; 0000 0151     {
; 0000 0152         PORTB.0=1;
	SBI  0x18,0
; 0000 0153         PORTB.1=1;
	SBI  0x18,1
; 0000 0154         PORTB.2=0;
	CBI  0x18,2
; 0000 0155         PORTB.3=1;
_0x1AE:
	SBI  0x18,3
; 0000 0156         PORTB.4=1;
_0x1AB:
	SBI  0x18,4
; 0000 0157         PORTB.5=1;
_0x1AD:
	SBI  0x18,5
; 0000 0158         PORTB.6=1;
_0x1AC:
	SBI  0x18,6
; 0000 0159     }
; 0000 015A     if(x%10==0)
_0xFD:
_0xDC:
_0xCC:
	RCALL SUBOPT_0x9
	SBIW R30,0
	BRNE _0x10C
; 0000 015B     {
; 0000 015C         PORTD.0=1;
	RCALL SUBOPT_0x1
; 0000 015D         PORTD.1=0;
; 0000 015E         PORTD.2=1;
; 0000 015F         PORTD.3=1;
; 0000 0160         PORTD.4=1;
; 0000 0161         PORTD.5=1;
; 0000 0162         PORTD.6=1;
	RJMP _0x1AF
; 0000 0163     }
; 0000 0164      else if(x%10==1)
_0x10C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x11C
; 0000 0165     {
; 0000 0166         PORTD.0=0;
	CBI  0x12,0
; 0000 0167         PORTD.1=0;
	CBI  0x12,1
; 0000 0168         PORTD.2=0;
	CBI  0x12,2
; 0000 0169         PORTD.3=1;
	SBI  0x12,3
; 0000 016A         PORTD.4=0;
	CBI  0x12,4
; 0000 016B         PORTD.5=0;
	RJMP _0x1B0
; 0000 016C         PORTD.6=1;
; 0000 016D     }
; 0000 016E      else if(x%10==2)
_0x11C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x12C
; 0000 016F     {
; 0000 0170         PORTD.0=0;
	CBI  0x12,0
; 0000 0171         PORTD.1=1;
	RCALL SUBOPT_0xA
; 0000 0172         PORTD.2=1;
; 0000 0173         PORTD.3=1;
	SBI  0x12,3
; 0000 0174         PORTD.4=1;
	SBI  0x12,4
; 0000 0175         PORTD.5=1;
	SBI  0x12,5
; 0000 0176         PORTD.6=0;
	CBI  0x12,6
; 0000 0177     }
; 0000 0178      else if(x%10==3)
	RJMP _0x13B
_0x12C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x13C
; 0000 0179     {
; 0000 017A         PORTD.0=0;
	CBI  0x12,0
; 0000 017B         PORTD.1=1;
	RJMP _0x1B1
; 0000 017C         PORTD.2=1;
; 0000 017D         PORTD.3=1;
; 0000 017E         PORTD.4=1;
; 0000 017F         PORTD.5=0;
; 0000 0180         PORTD.6=1;
; 0000 0181     }
; 0000 0182      else if(x%10==4)
_0x13C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x14C
; 0000 0183     {
; 0000 0184         PORTD.0=1;
	SBI  0x12,0
; 0000 0185         PORTD.1=1;
	SBI  0x12,1
; 0000 0186         PORTD.2=0;
	CBI  0x12,2
; 0000 0187         PORTD.3=1;
	SBI  0x12,3
; 0000 0188         PORTD.4=0;
	CBI  0x12,4
; 0000 0189         PORTD.5=0;
	RJMP _0x1B0
; 0000 018A         PORTD.6=1;
; 0000 018B     }
; 0000 018C      else if(x%10==5)
_0x14C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x15C
; 0000 018D     {
; 0000 018E         PORTD.0=1;
	SBI  0x12,0
; 0000 018F         PORTD.1=1;
	RCALL SUBOPT_0xA
; 0000 0190         PORTD.2=1;
; 0000 0191         PORTD.3=0;
	CBI  0x12,3
; 0000 0192         PORTD.4=1;
	RJMP _0x1B2
; 0000 0193         PORTD.5=0;
; 0000 0194         PORTD.6=1;
; 0000 0195     }
; 0000 0196      else if(x%10==6)
_0x15C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x16C
; 0000 0197     {
; 0000 0198         PORTD.0=1;
	SBI  0x12,0
; 0000 0199         PORTD.1=1;
	RCALL SUBOPT_0xA
; 0000 019A         PORTD.2=1;
; 0000 019B         PORTD.3=0;
	CBI  0x12,3
; 0000 019C         PORTD.4=1;
	SBI  0x12,4
; 0000 019D         PORTD.5=1;
	SBI  0x12,5
; 0000 019E         PORTD.6=1;
	RJMP _0x1AF
; 0000 019F     }
; 0000 01A0      else if(x%10==7)
_0x16C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x17C
; 0000 01A1     {
; 0000 01A2         PORTD.0=0;
	CBI  0x12,0
; 0000 01A3         PORTD.1=0;
	CBI  0x12,1
; 0000 01A4         PORTD.2=1;
	SBI  0x12,2
; 0000 01A5         PORTD.3=1;
	SBI  0x12,3
; 0000 01A6         PORTD.4=0;
	CBI  0x12,4
; 0000 01A7         PORTD.5=0;
	RJMP _0x1B0
; 0000 01A8         PORTD.6=1;
; 0000 01A9     }
; 0000 01AA      else if(x%10==8)
_0x17C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x18C
; 0000 01AB     {
; 0000 01AC         PORTD.0=1;
	SBI  0x12,0
; 0000 01AD         PORTD.1=1;
	RCALL SUBOPT_0xA
; 0000 01AE         PORTD.2=1;
; 0000 01AF         PORTD.3=1;
	SBI  0x12,3
; 0000 01B0         PORTD.4=1;
	SBI  0x12,4
; 0000 01B1         PORTD.5=1;
	SBI  0x12,5
; 0000 01B2         PORTD.6=1;
	RJMP _0x1AF
; 0000 01B3     }
; 0000 01B4      else if(x%10==9)
_0x18C:
	RCALL SUBOPT_0x9
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x19C
; 0000 01B5     {
; 0000 01B6         PORTD.0=1;
	SBI  0x12,0
; 0000 01B7         PORTD.1=1;
_0x1B1:
	SBI  0x12,1
; 0000 01B8         PORTD.2=1;
	SBI  0x12,2
; 0000 01B9         PORTD.3=1;
	SBI  0x12,3
; 0000 01BA         PORTD.4=1;
_0x1B2:
	SBI  0x12,4
; 0000 01BB         PORTD.5=0;
_0x1B0:
	CBI  0x12,5
; 0000 01BC         PORTD.6=1;
_0x1AF:
	SBI  0x12,6
; 0000 01BD     }
; 0000 01BE 
; 0000 01BF }
_0x19C:
_0x13B:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;
;
;
;

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	SBI  0x18,0
	SBI  0x18,1
	SBI  0x18,2
	CBI  0x18,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	SBI  0x12,0
	CBI  0x12,1
	SBI  0x12,2
	SBI  0x12,3
	SBI  0x12,4
	SBI  0x12,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	__ADDWRN 16,17,1
	__CPWRN 16,17,100
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	MOVW R26,R16
	RJMP _fun

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(50)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 21 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x6:
	MOVW R26,R16
	RCALL SUBOPT_0x5
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7:
	SBI  0x18,0
	CBI  0x18,1
	CBI  0x18,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	SBI  0x18,0
	SBI  0x18,1
	CBI  0x18,2
	SBI  0x18,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x9:
	MOVW R26,R16
	RCALL SUBOPT_0x5
	RCALL __MODW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	SBI  0x12,1
	SBI  0x12,2
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	NEG  R27
	NEG  R26
	SBCI R27,0
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
