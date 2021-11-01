!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:24:05'!
bookInCatalog

	^ 'Smalltalk-80: The Language and its Implementation'! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:24:05'!
createACartWithABookInHisCatalog
	
	| catalog |
	catalog := OrderedCollection with: self bookInCatalog.
	^Cart withCatalog: catalog.! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:22:21'!
test01ANewCartIsEmpty
	| newCart |

	newCart := self createACartWithABookInHisCatalog.
	
	self assert: newCart items isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:24:05'!
test02AddABookToCartMakesCartNotEmpty
	
	|newCart aBook |
	
	aBook := self bookInCatalog.
	newCart := self createACartWithABookInHisCatalog.
	
	newCart add: aBook quantity: 1. 
	
	self assert: newCart items size equals: 1.
	self assert: newCart items includes: aBook.! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:27:42'!
test03AddMultipleBooksToCartMakesCartHaveAllOfThem
	|newCart book1 book2 catalog | 
	
	book1 := self bookInCatalog .
	book2 := 'Squeak by Example'.
	
	catalog := OrderedCollection with: book1 with: book2.
	newCart := Cart withCatalog: catalog.
	
	newCart add: book1 quantity: 1.
	newCart add: book2 quantity: 1.
	
	self assert: newCart items size equals: 2.
	self assert: (newCart have: book1).
	self assert: (newCart have: book2).! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:35:05'!
test04AddABookToCartThatIsNotInCatalogRaisesError
	|newCart aBook aBadBook | 
	
	aBook := self bookInCatalog.
	newCart := self createACartWithABookInHisCatalog.
	
	aBadBook := 'Growing Object-Oriented Software Guided by Tests'.
	self should:
		[newCart add: aBadBook quantity: 1]
		raise: Error
		withExceptionDo: [:error | self assert: Cart bookDoesNotBelongInThisCatalogError equals: error messageText].
	
	! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:34:50'!
test05AddANonPositiveQuantityOfBooksTimesRaisesError
	|newCart aBook |
	
	aBook := self bookInCatalog.
	newCart := self createACartWithABookInHisCatalog.
	
	self should:  [newCart add: aBook quantity: -1]
		raise: Error
		withExceptionDo: [:error | self assert: Cart invalidAmountOfBooksError equals: error messageText].
	! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:34:55'!
test06AddANonIntegerQuantityOfBooksTimesRaisesError
	|newCart aBook |
	
	aBook := self bookInCatalog.
	newCart := self createACartWithABookInHisCatalog.
	
	self should:  [newCart add: aBook quantity: 0.5]
		raise: Error
		withExceptionDo: [:error | self assert: Cart invalidAmountOfBooksError equals: error messageText].
	! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/1/2021 16:33:41'!
test07AddABookToCartWithAQuantityGreaterThanOneMakesCartHaveTheBookWithTheCorrectQuantity
	
	|newCart aBook|
	
	aBook := self bookInCatalog.
	newCart := self createACartWithABookInHisCatalog.
	
	newCart add: aBook quantity: 2. 
	
	self assert: newCart items size equals: 2.
	self assert: (newCart items occurrencesOf: aBook) equals: 2.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books clientId password catalogy catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'LB 11/1/2021 16:12:52'!
assertCatalogHasBook: aBook

	(catalog includes: aBook) 	ifFalse: [self error: self class bookDoesNotBelongInThisCatalogError]! !

!Cart methodsFor: 'assertions' stamp: 'LB 11/1/2021 16:32:02'!
assertQuantityIsValid: aQuantityOfBooks

	(aQuantityOfBooks > 0 and: aQuantityOfBooks isInteger) ifFalse: [self error: self class invalidAmountOfBooksError]! !


!Cart methodsFor: 'adding' stamp: 'LB 11/1/2021 16:37:43'!
add: aBook quantity: aQuantityOfBooks
	
	self assertQuantityIsValid: aQuantityOfBooks.
	self assertCatalogHasBook: aBook.
	
	books add: aBook withOccurrences: aQuantityOfBooks.! !


!Cart methodsFor: 'initialization' stamp: 'LB 11/1/2021 16:02:33'!
initializeWithCatalog: aCatalog 
	
	books := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'testing' stamp: 'sm 10/31/2021 23:24:51'!
have: thisBook
	
	^books includes: thisBook.! !


!Cart methodsFor: 'accessing' stamp: 'sm 10/31/2021 23:12:37'!
items
	^ books.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error' stamp: 'LB 11/1/2021 13:03:43'!
bookDoesNotBelongInThisCatalogError
	
	^'No se puede agregar un libro que no este en el catalogo'! !

!Cart class methodsFor: 'error' stamp: 'LB 11/1/2021 16:07:16'!
invalidAmountOfBooksError
	
	^'No se puede agregar un libro con una cantidad nula o negativa al carrito'! !


!Cart class methodsFor: 'instance creation' stamp: 'LB 11/1/2021 11:26:29'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !
