
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8/000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
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
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
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
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
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
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
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

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _flags=R4
	.DEF _flags_msb=R5
	.DEF _inflags=R6
	.DEF _inflags_msb=R7
	.DEF _first_digit=R9
	.DEF _sec_digit=R8
	.DEF __lcd_x=R11
	.DEF __lcd_y=R10
	.DEF __lcd_maxx=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x1,0x0
	.DB  0xFF,0xFF

_0x3:
	.DB  0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
	.DB  0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46
_0x4:
	.DB  0x10,0x0,0x20,0x0,0x40,0x0,0x80
_0x0:
	.DB  0x53,0x70,0x65,0x65,0x64,0x3A,0x3F,0x3F
	.DB  0x28,0x30,0x2D,0x35,0x30,0x72,0x29,0x0
	.DB  0x45,0x45,0x0,0x54,0x69,0x6D,0x65,0x3A
	.DB  0x3F,0x3F,0x28,0x30,0x2D,0x39,0x39,0x73
	.DB  0x29,0x0,0x57,0x3A,0x3F,0x3F,0x28,0x30
	.DB  0x2D,0x39,0x39,0x6B,0x67,0x29,0x0,0x54
	.DB  0x65,0x6D,0x70,0x3A,0x3F,0x3F,0x28,0x32
	.DB  0x30,0x2D,0x38,0x30,0x43,0x29,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x06
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x10
	.DW  _data_key
	.DW  _0x3*2

	.DW  0x07
	.DW  _row
	.DW  _0x4*2

	.DW  0x10
	.DW  _0x20
	.DW  _0x0*2

	.DW  0x03
	.DW  _0x20+16
	.DW  _0x0*2+16

	.DW  0x0F
	.DW  _0x32
	.DW  _0x0*2+19

	.DW  0x03
	.DW  _0x32+15
	.DW  _0x0*2+16

	.DW  0x0D
	.DW  _0x44
	.DW  _0x0*2+34

	.DW  0x03
	.DW  _0x44+13
	.DW  _0x0*2+16

	.DW  0x10
	.DW  _0x56
	.DW  _0x0*2+47

	.DW  0x03
	.DW  _0x56+16
	.DW  _0x0*2+16

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;
;char data_key[] = {
;'0','1','2','3',
;'4','5','6','7',
;'8','9','A','B',
;'C','D','E','F'};

	.DSEG
;int flags = 0;
;int inflags = 1;
;char first_digit = -1;
;char sec_digit = -1;
;
;int row[4] = {0x10,0x20,0x40,0x80};
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <alcd.h>
;
;char keypad(void)
; 0000 0013 {   char c;

	.CSEG
_keypad:
; .FSTART _keypad
; 0000 0014     char r;
; 0000 0015     char key=100;
; 0000 0016 
; 0000 0017 
; 0000 0018 
; 0000 0019      inflags =0;
	CALL __SAVELOCR4
;	c -> R17
;	r -> R16
;	key -> R19
	LDI  R19,100
	CLR  R6
	CLR  R7
; 0000 001A 
; 0000 001B     for (r=0;r<4;r++)
	LDI  R16,LOW(0)
_0x6:
	CPI  R16,4
	BRSH _0x7
; 0000 001C     {
; 0000 001D         PORTB=row[r];
	MOV  R30,R16
	LDI  R26,LOW(_row)
	LDI  R27,HIGH(_row)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
; 0000 001E         c=20;
	LDI  R17,LOW(20)
; 0000 001F         delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0000 0020         if (PINB.0==1) c=0;
	SBIC 0x16,0
	LDI  R17,LOW(0)
; 0000 0021         if (PINB.1==1) c=1;
	SBIC 0x16,1
	LDI  R17,LOW(1)
; 0000 0022         if (PINB.2==1) c=2;
	SBIC 0x16,2
	LDI  R17,LOW(2)
; 0000 0023         if (PINB.3==1) c=3;
	SBIC 0x16,3
	LDI  R17,LOW(3)
; 0000 0024         if (!(c==20)){
	CPI  R17,20
	BREQ _0xC
; 0000 0025         key=(r*4)+c;
	MOV  R30,R16
	LSL  R30
	LSL  R30
	ADD  R30,R17
	MOV  R19,R30
; 0000 0026         PORTB=0xf0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
; 0000 0027         while (PINB.0==1) {}
_0xD:
	SBIC 0x16,0
	RJMP _0xD
; 0000 0028         while (PINB.1==1) {}
_0x10:
	SBIC 0x16,1
	RJMP _0x10
; 0000 0029         while (PINB.2==1) {}
_0x13:
	SBIC 0x16,2
	RJMP _0x13
; 0000 002A         while (PINB.3==1) {}
_0x16:
	SBIC 0x16,3
	RJMP _0x16
; 0000 002B         }
; 0000 002C         PORTB=0xf0;
_0xC:
	LDI  R30,LOW(240)
	OUT  0x18,R30
; 0000 002D     }
	SUBI R16,-1
	RJMP _0x6
_0x7:
; 0000 002E 
; 0000 002F 
; 0000 0030     return key;
	MOV  R30,R19
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; 0000 0031 }
; .FEND
;
;void speed();
;void Time();
;void W();
;void Temp();
;
;
;void main(void)
; 0000 003A {
_main:
; .FSTART _main
; 0000 003B //char tmp;
; 0000 003C 
; 0000 003D DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 003E PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 003F 
; 0000 0040 DDRB=0xf0; // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
	LDI  R30,LOW(240)
	OUT  0x17,R30
; 0000 0041 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0042 
; 0000 0043 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0044 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0045 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0046 
; 0000 0047 // Port D initialization
; 0000 0048 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0049 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 004A // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 004B PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 004C 
; 0000 004D 
; 0000 004E GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0000 004F MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(12)
	OUT  0x35,R30
; 0000 0050 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0051 GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(128)
	OUT  0x3A,R30
; 0000 0052 
; 0000 0053 
; 0000 0054 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0055 
; 0000 0056 
; 0000 0057 
; 0000 0058 while (1)
_0x19:
; 0000 0059       {
; 0000 005A           speed();
	RCALL _speed
; 0000 005B           Time();
	RCALL _Time
; 0000 005C           W();
	RCALL _W
; 0000 005D           Temp();
	RCALL _Temp
; 0000 005E 
; 0000 005F 
; 0000 0060       }
	RJMP _0x19
; 0000 0061 }
_0x1C:
	RJMP _0x1C
; .FEND
;
;
;void speed()
; 0000 0065 {   char tmp;
_speed:
; .FSTART _speed
; 0000 0066     while(1){
	ST   -Y,R17
;	tmp -> R17
_0x1D:
; 0000 0067         lcd_gotoxy(0,0);
	RCALL SUBOPT_0x0
; 0000 0068         lcd_puts("Speed:??(0-50r)");
	__POINTW2MN _0x20,0
	RCALL _lcd_puts
; 0000 0069         while(1)
_0x21:
; 0000 006A         {
; 0000 006B             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 006C             if (tmp >=0 && tmp <=9){
	BRLO _0x25
	CPI  R17,10
	BRLO _0x26
_0x25:
	RJMP _0x24
_0x26:
; 0000 006D                 lcd_gotoxy(0,1);
	RCALL SUBOPT_0x2
; 0000 006E                 first_digit = tmp;
; 0000 006F                 lcd_putchar(data_key[tmp]);
; 0000 0070 
; 0000 0071                 break;
	RJMP _0x23
; 0000 0072             }
; 0000 0073 
; 0000 0074         }
_0x24:
	RJMP _0x21
_0x23:
; 0000 0075 
; 0000 0076         while(1)
_0x27:
; 0000 0077         {
; 0000 0078             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 0079             if (tmp >=0 && tmp <=9){
	BRLO _0x2B
	CPI  R17,10
	BRLO _0x2C
_0x2B:
	RJMP _0x2A
_0x2C:
; 0000 007A                 //lcd_gotoxy(2,2);
; 0000 007B                 sec_digit = tmp;
	RCALL SUBOPT_0x3
; 0000 007C                 lcd_putchar(data_key[tmp]);
; 0000 007D                 break;
	RJMP _0x29
; 0000 007E             }
; 0000 007F 
; 0000 0080         }
_0x2A:
	RJMP _0x27
_0x29:
; 0000 0081 
; 0000 0082         if ( !(first_digit *10 + sec_digit <=50 )){
	RCALL SUBOPT_0x4
	MOV  R30,R8
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,51
	BRLT _0x2D
; 0000 0083             lcd_puts("EE");
	__POINTW2MN _0x20,16
	RCALL SUBOPT_0x5
; 0000 0084             delay_ms(2000);
; 0000 0085             lcd_clear();
; 0000 0086             }
; 0000 0087 
; 0000 0088         else{
	RJMP _0x2E
_0x2D:
; 0000 0089             delay_ms(1000);
	RCALL SUBOPT_0x6
; 0000 008A             lcd_clear();
; 0000 008B             return;
	RJMP _0x2020002
; 0000 008C 
; 0000 008D          }
_0x2E:
; 0000 008E         }
	RJMP _0x1D
; 0000 008F }
; .FEND

	.DSEG
_0x20:
	.BYTE 0x13
;
;
;
;void Time()
; 0000 0094 {   char tmp;

	.CSEG
_Time:
; .FSTART _Time
; 0000 0095     while(1){
	ST   -Y,R17
;	tmp -> R17
_0x2F:
; 0000 0096         lcd_gotoxy(0,0);
	RCALL SUBOPT_0x0
; 0000 0097         lcd_puts("Time:??(0-99s)");
	__POINTW2MN _0x32,0
	RCALL _lcd_puts
; 0000 0098         while(1)
_0x33:
; 0000 0099         {
; 0000 009A             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 009B             if (tmp >=0 && tmp <=9){
	BRLO _0x37
	CPI  R17,10
	BRLO _0x38
_0x37:
	RJMP _0x36
_0x38:
; 0000 009C                 lcd_gotoxy(0,1);
	RCALL SUBOPT_0x2
; 0000 009D                 first_digit = tmp;
; 0000 009E                 lcd_putchar(data_key[tmp]);
; 0000 009F 
; 0000 00A0                 break;
	RJMP _0x35
; 0000 00A1             }
; 0000 00A2 
; 0000 00A3         }
_0x36:
	RJMP _0x33
_0x35:
; 0000 00A4 
; 0000 00A5         while(1)
_0x39:
; 0000 00A6         {
; 0000 00A7             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 00A8             if (tmp >=0 && tmp <=9){
	BRLO _0x3D
	CPI  R17,10
	BRLO _0x3E
_0x3D:
	RJMP _0x3C
_0x3E:
; 0000 00A9                 //lcd_gotoxy(2,2);
; 0000 00AA                 sec_digit = tmp;
	RCALL SUBOPT_0x3
; 0000 00AB                 lcd_putchar(data_key[tmp]);
; 0000 00AC                 break;
	RJMP _0x3B
; 0000 00AD             }
; 0000 00AE 
; 0000 00AF         }
_0x3C:
	RJMP _0x39
_0x3B:
; 0000 00B0 
; 0000 00B1         if ( !(first_digit *10 + sec_digit <=99 ) ){
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x7
	BRLT _0x3F
; 0000 00B2             lcd_puts("EE");
	__POINTW2MN _0x32,15
	RCALL SUBOPT_0x5
; 0000 00B3             delay_ms(2000);
; 0000 00B4             lcd_clear();
; 0000 00B5             }
; 0000 00B6 
; 0000 00B7         else{
	RJMP _0x40
_0x3F:
; 0000 00B8             delay_ms(1000);
	RCALL SUBOPT_0x6
; 0000 00B9             lcd_clear();
; 0000 00BA             return;
	RJMP _0x2020002
; 0000 00BB 
; 0000 00BC          }
_0x40:
; 0000 00BD 
; 0000 00BE     }
	RJMP _0x2F
; 0000 00BF 
; 0000 00C0 
; 0000 00C1 }
; .FEND

	.DSEG
_0x32:
	.BYTE 0x12
;
;void W()
; 0000 00C4 {   char tmp;

	.CSEG
_W:
; .FSTART _W
; 0000 00C5     while(1){
	ST   -Y,R17
;	tmp -> R17
_0x41:
; 0000 00C6         lcd_gotoxy(0,0);
	RCALL SUBOPT_0x0
; 0000 00C7         lcd_puts("W:??(0-99kg)");
	__POINTW2MN _0x44,0
	RCALL _lcd_puts
; 0000 00C8         while(1)
_0x45:
; 0000 00C9         {
; 0000 00CA             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 00CB             if (tmp >=0 && tmp <=9){
	BRLO _0x49
	CPI  R17,10
	BRLO _0x4A
_0x49:
	RJMP _0x48
_0x4A:
; 0000 00CC                 lcd_gotoxy(0,1);
	RCALL SUBOPT_0x2
; 0000 00CD                 first_digit = tmp;
; 0000 00CE                 lcd_putchar(data_key[tmp]);
; 0000 00CF 
; 0000 00D0                 break;
	RJMP _0x47
; 0000 00D1             }
; 0000 00D2 
; 0000 00D3         }
_0x48:
	RJMP _0x45
_0x47:
; 0000 00D4 
; 0000 00D5         while(1)
_0x4B:
; 0000 00D6         {
; 0000 00D7             tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 00D8             if (tmp >=0 && tmp <=9){
	BRLO _0x4F
	CPI  R17,10
	BRLO _0x50
_0x4F:
	RJMP _0x4E
_0x50:
; 0000 00D9                 //lcd_gotoxy(2,2);
; 0000 00DA                 sec_digit = tmp;
	RCALL SUBOPT_0x3
; 0000 00DB                 lcd_putchar(data_key[tmp]);
; 0000 00DC                 break;
	RJMP _0x4D
; 0000 00DD             }
; 0000 00DE 
; 0000 00DF         }
_0x4E:
	RJMP _0x4B
_0x4D:
; 0000 00E0 
; 0000 00E1         if (!(first_digit *10 + sec_digit <=99) ){
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x7
	BRLT _0x51
; 0000 00E2             lcd_puts("EE");
	__POINTW2MN _0x44,13
	RCALL SUBOPT_0x5
; 0000 00E3             delay_ms(2000);
; 0000 00E4             lcd_clear();
; 0000 00E5                }
; 0000 00E6 
; 0000 00E7         else{
	RJMP _0x52
_0x51:
; 0000 00E8             delay_ms(1000);
	RCALL SUBOPT_0x6
; 0000 00E9             lcd_clear();
; 0000 00EA             return;
	RJMP _0x2020002
; 0000 00EB 
; 0000 00EC          }
_0x52:
; 0000 00ED         }
	RJMP _0x41
; 0000 00EE 
; 0000 00EF }
; .FEND

	.DSEG
_0x44:
	.BYTE 0x10
;
;
;void Temp()
; 0000 00F3 {   char tmp;

	.CSEG
_Temp:
; .FSTART _Temp
; 0000 00F4     while(1){
	ST   -Y,R17
;	tmp -> R17
_0x53:
; 0000 00F5     lcd_gotoxy(0,0);
	RCALL SUBOPT_0x0
; 0000 00F6     lcd_puts("Temp:??(20-80C)");
	__POINTW2MN _0x56,0
	RCALL _lcd_puts
; 0000 00F7     while(1)
_0x57:
; 0000 00F8     {
; 0000 00F9         tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 00FA         if (tmp >=0 && tmp <=9){
	BRLO _0x5B
	CPI  R17,10
	BRLO _0x5C
_0x5B:
	RJMP _0x5A
_0x5C:
; 0000 00FB             lcd_gotoxy(0,1);
	RCALL SUBOPT_0x2
; 0000 00FC             first_digit = tmp;
; 0000 00FD             lcd_putchar(data_key[tmp]);
; 0000 00FE 
; 0000 00FF             break;
	RJMP _0x59
; 0000 0100         }
; 0000 0101 
; 0000 0102     }
_0x5A:
	RJMP _0x57
_0x59:
; 0000 0103 
; 0000 0104     while(1)
_0x5D:
; 0000 0105     {
; 0000 0106         tmp = keypad();
	RCALL SUBOPT_0x1
; 0000 0107         if (tmp >=0 && tmp <=9){
	BRLO _0x61
	CPI  R17,10
	BRLO _0x62
_0x61:
	RJMP _0x60
_0x62:
; 0000 0108             //lcd_gotoxy(2,2);
; 0000 0109             sec_digit = tmp;
	RCALL SUBOPT_0x3
; 0000 010A             lcd_putchar(data_key[tmp]);
; 0000 010B             break;
	RJMP _0x5F
; 0000 010C         }
; 0000 010D 
; 0000 010E     }
_0x60:
	RJMP _0x5D
_0x5F:
; 0000 010F 
; 0000 0110     if (!(first_digit *10 + sec_digit <=80 &&  first_digit *10 + sec_digit >=20))
	RCALL SUBOPT_0x4
	CLR  R30
	ADD  R26,R8
	ADC  R27,R30
	CPI  R26,LOW(0x51)
	LDI  R30,HIGH(0x51)
	CPC  R27,R30
	BRGE _0x64
	MOVW R26,R0
	MOV  R30,R8
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,20
	BRGE _0x63
_0x64:
; 0000 0111       {
; 0000 0112         lcd_puts("EE");
	__POINTW2MN _0x56,16
	RCALL SUBOPT_0x5
; 0000 0113         delay_ms(2000);
; 0000 0114         lcd_clear();
; 0000 0115       }
; 0000 0116 
; 0000 0117     else{   delay_ms(1000);
	RJMP _0x66
_0x63:
	RCALL SUBOPT_0x6
; 0000 0118             lcd_clear();
; 0000 0119 
; 0000 011A             return;
	RJMP _0x2020002
; 0000 011B 
; 0000 011C 
; 0000 011D            }
_0x66:
; 0000 011E 
; 0000 011F 
; 0000 0120     }
	RJMP _0x53
; 0000 0121 
; 0000 0122 }
_0x2020002:
	LD   R17,Y+
	RET
; .FEND

	.DSEG
_0x56:
	.BYTE 0x13
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x2020001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2020001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R11,Y+1
	LDD  R10,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x8
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x8
	LDI  R30,LOW(0)
	MOV  R10,R30
	MOV  R11,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R11,R13
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R10
	MOV  R26,R10
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x2020001
_0x2000007:
_0x2000004:
	INC  R11
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x2020001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LDD  R13,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x9
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2020001:
	ADIW R28,1
	RET
; .FEND

	.DSEG
_data_key:
	.BYTE 0x10
_row:
	.BYTE 0x8
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1:
	RCALL _keypad
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:30 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
	MOV  R9,R17
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_data_key)
	SBCI R31,HIGH(-_data_key)
	LD   R26,Z
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3:
	MOV  R8,R17
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_data_key)
	SBCI R31,HIGH(-_data_key)
	LD   R26,Z
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4:
	MOV  R26,R9
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x5:
	RCALL _lcd_puts
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	CALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CLR  R30
	ADD  R26,R8
	ADC  R27,R30
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
