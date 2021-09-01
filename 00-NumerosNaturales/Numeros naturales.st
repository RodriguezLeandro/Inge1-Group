!classDefinition: #I category: 'Numeros naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:50:57'!
* aNaturalNumber

	^aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:45:05'!
+ aNaturalNumber

	^aNaturalNumber next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:39:12'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:06:58'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified'!
! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:21:15'!
/ aNaturalNumber
	(aNaturalNumber esMayor: self) ifTrue: [^self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:19:00'!
esMayor: aNaturalNumber
	^False
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified'!
'! !

!I class methodsFor: 'as yet unclassified'!
! !

!I class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:25:12'!
restarA: aNaturalNumber
	^aNaturalNumber previous.! !


!classDefinition: #II category: 'Numeros naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros naturales'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:04:08'!
* aNaturalNumber
	^ aNaturalNumber + (aNaturalNumber * self previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:09:39'!
+ aNaturalNumber
	^ self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:26:11'!
- aNaturalNumber
	^aNaturalNumber restarA: self.
	
	" en vez de hacer X - Y , hacemos Y restarA X"! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:21:15'!
/ aNaturalNumber
	(aNaturalNumber esMayor: self) ifTrue: [^self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
	! !

!II class methodsFor: 'as yet unclassified'!
! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:22:32'!
esMayor: aNaturalNumber
	aNaturalNumber = I ifTrue: [^True].
	^self previous esMayor: aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Luis 8/29/2021 22:34:43'!
next
	next ifNotNil: [^next].
	 
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Luis 8/29/2021 22:34:17'!
previous
	^prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Luis 8/29/2021 22:34:43'!
previous: anNaturalNumber
	^prev := anNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 19:43:06'!
restarA: aNaturalNumber 
	
	^self previous restarA: aNaturalNumber previous.! !


!classDefinition: #III category: 'Numeros naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !


!classDefinition: #IIII category: 'Numeros naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	prev := III.! !


!classDefinition: #IIIII category: 'Numeros naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	prev := IIII.! !


!classDefinition: #IIIIII category: 'Numeros naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LB 9/1/2021 20:24:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!