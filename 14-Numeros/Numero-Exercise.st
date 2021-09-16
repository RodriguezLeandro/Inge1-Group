!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'LR 9/15/2021 19:15:05'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:26:04'!
dividirAEntero: anEnteroDividend

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:26:16'!
dividirAFraccion: aFraccionDividend

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:25:14'!
multiplicarEntero: anEnteroMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:25:33'!
multiplicarFraccion: aFraccionMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:24:54'!
restarAEntero: anEnteroMinuend

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:25:00'!
restarAFraccion: aFraccionMinuend

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:24:37'!
sumarEntero: aEnteroAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:24:29'!
sumarFraccion: aFraccionAdder

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 10:59:55'!
* aMultiplier 
	
	^ aMultiplier multiplicarEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LB 9/12/2021 12:17:55'!
+ anAdder 

   	 ^anAdder sumarEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 11:00:05'!
- aSubtrahend 
	
	^aSubtrahend  restarAEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 11:00:12'!
/ aDivisor 
	
	^aDivisor dividirAEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LR 9/15/2021 19:37:19'!
fibonacci

	^self subclassResponsibility
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:21:23'!
dividirAEntero: anEnteroDividend
	
	^Fraccion with: anEnteroDividend over: self! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:21:35'!
dividirAFraccion: aFraccionDividend

	^Fraccion with: aFraccionDividend numerator over: (self value * aFraccionDividend denominator)! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:19:34'!
multiplicarEntero: anEnteroMultiplier 

	^self class with: value * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 11:00:27'!
multiplicarFraccion: aFraccionMultiplier 
	
	^Fraccion with: (self value * aFraccionMultiplier numerator) over: aFraccionMultiplier denominator. ! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:15:09'!
restarAEntero: aEnteroMinuend
	
	^self class with: (aEnteroMinuend integerValue) - self integerValue.
	! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:16:39'!
restarAFraccion: aFraccionMinuend

	^Fraccion with: (aFraccionMinuend numerator - (self value * aFraccionMinuend denominator)) over: aFraccionMinuend denominator.! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:13:33'!
sumarEntero: anEnteroAdder

   	 ^ self class with: value + anEnteroAdder integerValue! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:13:41'!
sumarFraccion: aFraccionAdder

	^Fraccion with: (self value * aFraccionAdder denominator + aFraccionAdder numerator) over: aFraccionAdder denominator

! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'LB 9/16/2021 10:58:47'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	(aValue < 0) ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	(aValue = 0) ifTrue: [^EnteroCero new initalizeWith: aValue].
	(aValue = 1) ifTrue: [^EnteroUno new initalizeWith: aValue].
	
	^EnteroMayorAUno new initalizeWith: aValue! !


!classDefinition: #EnteroCero category: 'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:54:04'!
executeIfNegative: aBlock! !

!EnteroCero methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:53:54'!
executeIfOne: aBlock! !

!EnteroCero methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:53:40'!
executeIfZero: aBlock
	^aBlock value
	
! !

!EnteroCero methodsFor: 'as yet unclassified' stamp: 'LR 9/15/2021 19:57:21'!
fibonacci
	^Entero with: 1.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numero-Exercise'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'check types' stamp: 'LR 9/15/2021 20:22:39'!
esDeTipo: aValue
	^aValue = 0.! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:14'!
executeIfNegative: aBlock! !

!EnteroMayorAUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:18'!
executeIfOne: aBlock! !

!EnteroMayorAUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:11'!
executeIfZero: aBlock! !

!EnteroMayorAUno methodsFor: 'as yet unclassified' stamp: 'LR 9/15/2021 20:49:01'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'check types' stamp: 'LB 9/16/2021 10:02:29'!
esDeTipo: aValue
	^aValue > 1.
	! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operation' stamp: 'LB 9/16/2021 10:56:42'!
executeIfNegative: aBlock
	^aBlock value! !

!EnteroNegativo methodsFor: 'arithmetic operation' stamp: 'LB 9/16/2021 10:56:30'!
executeIfOne: aBlock! !

!EnteroNegativo methodsFor: 'arithmetic operation' stamp: 'LB 9/16/2021 10:56:18'!
executeIfZero: aBlock! !

!EnteroNegativo methodsFor: 'arithmetic operation' stamp: 'LR 9/15/2021 19:01:42'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'check types' stamp: 'LR 9/15/2021 20:24:00'!
esDeTipo: aValue
	^aValue < 0.! !


!classDefinition: #EnteroUno category: 'Numero-Exercise'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:40'!
executeIfNegative: aBlock! !

!EnteroUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:29'!
executeIfOne: aBlock
	^aBlock value! !

!EnteroUno methodsFor: 'as yet unclassified' stamp: 'LB 9/16/2021 10:57:36'!
executeIfZero: aBlock! !

!EnteroUno methodsFor: 'as yet unclassified' stamp: 'LR 9/15/2021 20:04:25'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numero-Exercise'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'check types' stamp: 'LR 9/15/2021 20:24:44'!
esDeTipo: aValue
	^aValue = 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 10:59:20'!
* aMultiplier 

	^ aMultiplier multiplicarFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 10:59:26'!
+ anAdder 
	
	^ anAdder sumarFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 10:59:32'!
- aSubtrahend 
	
	^aSubtrahend restarAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LB 9/16/2021 10:59:37'!
/ aDivisor 
	
	^aDivisor dividirAFraccion: self. ! !


!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:22:04'!
dividirAEntero: anEnteroDividend

	^ (denominator * anEnteroDividend) / numerator! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:22:13'!
dividirAFraccion: aFraccionDividend
	
	^(denominator * aFraccionDividend numerator) / (numerator * aFraccionDividend denominator)! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:19:50'!
multiplicarEntero: anEnteroMultiplier
	
	^Fraccion with: (anEnteroMultiplier * numerator) over: denominator.! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:20:00'!
multiplicarFraccion: aFraccionMultiplier
	
	^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator).! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:16:05'!
restarAEntero: aEnteroMinuend
	
	^(Fraccion with: ((aEnteroMinuend * denominator) - numerator) over: denominator).
! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:16:21'!
restarAFraccion: aFraccionMinuend
	
	| newNumerator newDenominator |	

	newNumerator := (denominator * aFraccionMinuend numerator) - (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.

	^newNumerator / newDenominator 
	
! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:15:28'!
sumarEntero: anEnteroAdder
	
	^Fraccion with: (anEnteroAdder * denominator + numerator) over: denominator.! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'LB 9/16/2021 10:15:44'!
sumarFraccion: aFraccionAdder
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	
	^newNumerator / newDenominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'LB 9/16/2021 10:58:26'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor executeIfZero: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend executeIfZero: [ ^aDividend ].
	
	aDivisor executeIfNegative: [ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator executeIfOne: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
