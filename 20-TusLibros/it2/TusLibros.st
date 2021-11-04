!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:00:48'!
test01NewCartsAreCreatedEmpty

	self assert: testObjects createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:02:41'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [ cart add: testObjects itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:03:01'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:03:05'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 0 of: testObjects itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:02:32'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 2 of: testObjects itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:03:10'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self assert: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:03:15'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	self deny: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 10:03:19'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: 2 of: testObjects itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjects itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/2/2021 17:05:05'!
test09EmptyCartTotalIsZero

	| cart |
	cart := testObjects createCart.
	
	self assert: 0 equals: cart total.! !

!CartTest methodsFor: 'tests' stamp: 'LB 11/4/2021 11:27:58'!
test10CartCanotUseCatalogueWIthNonPositivePrices

	| cart 	 catalogueWithZero catalogueWithNegativePrice |
	catalogueWithZero:=  Dictionary new.
	catalogueWithZero at: 'validBook' put: 0.

	self 
		should: [ cart := Cart  acceptingItemsOf:  catalogueWithZero. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueErrorMessage equals: anError messageText.
			self assert: cart isNil].
		
	catalogueWithNegativePrice:=  Dictionary new.
	catalogueWithNegativePrice at: 'validBook' put: -1.

	self 
		should: [ cart := Cart  acceptingItemsOf: catalogueWithNegativePrice. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueErrorMessage equals: anError messageText.
			self assert: cart isNil].! !


!CartTest methodsFor: 'support' stamp: 'LB 11/2/2021 10:00:23'!
setUp
	
	testObjects := StoreTestObjectsMaker new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjects salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 10:50:29'!
test01CanNotCheckoutAnEmptyCart
	
	self 
		should: [ self createCashierToCheckout: testObjects createCart ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: Cashier emptyCartMessageError.
			self assert: salesBook isEmpty].	
	! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 10:50:29'!
test02CalculatedTotallsCorrect
	| cashier cart |
	
	cart := testObjects createCart.
	cart add: 2 of: testObjects itemSellByTheStore.
	
	cashier := self createCashierToCheckout: cart.
		
	self 
		assert: testObjects itemSellByTheStorePrice * 2 
		equals: cashier checkout. ! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 10:55:03'!
test03CanNotCheckoutWithAnExpiredCreditCard

	self 
		should: [ self 
					createCashierToCheckout: testObjects createCartWithAnItem 
					charging: testObjects createExpiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier expiredCreditCardMessageError.
			self assert: salesBook isEmpty].! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 10:55:42'!
test04CheckoutRegistersASale
	| cashier total |

	cashier := self createCashierToCheckout: testObjects createCartWithAnItem.
	
	total := cashier checkout.
	
	self assert: salesBook notEmpty.
	self assert: total 	equals: salesBook first ! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 11:02:02'!
test05CheckingOutWIthCashierPerSaleTwiceRaisesError
	| cashier |
	
	cashier := self createCashierToCheckout: testObjects createCartWithAnItem.
				
	cashier checkout.
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: 'Can not checkout twice' 
				equals: anError messageText.
			self assert: 1 equals: salesBook size.
		].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 11:14:22'!
test06CheckoutWithStolenCardRaisesErrorAndHaveNoEffectOnSalesBook
	
	self 
		checkoutWith: MPSimulator setUpWithStolenCard 
		raisesError: MPSimulator canNotChargeOnStolenCardErrorMessage.! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 11:14:11'!
test07CheckoutWithFakeCardRaisesErrorAndHaveNoEffectOnSalesBook
	
	self 
		checkoutWith: MPSimulator setUpWithFakeCard 
		raisesError: MPSimulator canNotChargeOnFakeCardErrorMessage.! !

!CashierTest methodsFor: 'tests' stamp: 'LB 11/4/2021 11:14:16'!
test08CheckoutWithNoFoundsCardRaisesErrorAndHaveNoEffectOnSalesBook
	
	self 
		checkoutWith: MPSimulator setUpWithNoFoundsCard 
		raisesError: MPSimulator canNotChargeOnNoFoundsCardErrorMessage.! !


!CashierTest methodsFor: 'support' stamp: 'LB 11/4/2021 11:10:03'!
checkoutWith: aMPSimulator raisesError: anErrorMessage
	| cashier |
	
	cashier := self createCashierToCheckoutAnOneItemCartWith: aMPSimulator.
	
	self 
		should: [	 cashier checkout ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self 
				assert: anErrorMessage
				equals: anError messageText.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'support' stamp: 'LB 11/4/2021 10:50:28'!
createCashierToCheckout: aCart
	
	^Cashier
		toCheckOut: aCart
		charging: testObjects createValidCreditCard 
		on: testObjects today
		registeringOn: salesBook 
		with: MPSimulator setUpWithOK! !

!CashierTest methodsFor: 'support' stamp: 'LB 11/4/2021 10:53:03'!
createCashierToCheckout: aCart charging: aCreditCard
	
	^Cashier
		toCheckOut: aCart
		charging: aCreditCard
		on: testObjects today
		registeringOn: salesBook 
		with: MPSimulator setUpWithOK! !

!CashierTest methodsFor: 'support' stamp: 'LB 11/4/2021 11:00:06'!
createCashierToCheckoutAnOneItemCartWith: aMPSimulator
	
	^Cashier
		toCheckOut: testObjects createCartWithAnItem 
		charging: testObjects createValidCreditCard 
		on: testObjects today
		registeringOn: salesBook 
		with: aMPSimulator! !

!CashierTest methodsFor: 'support' stamp: 'LB 11/4/2021 10:41:46'!
setUp
	
	testObjects := StoreTestObjectsMaker new.
	salesBook := OrderedCollection new.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LB 11/2/2021 12:58:31'!
test01ACardCanNotHaveANameLongerThan30Characters
	
	self createACardAndRaiseErrorWithCardName: '123456789012345678901234567890X'.
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LB 11/2/2021 12:58:46'!
test02ACardCanNotHaveAnEmptyName

	self createACardAndRaiseErrorWithCardName: ''.! !

!CreditCardTest methodsFor: 'tests' stamp: 'LB 11/2/2021 12:59:29'!
test03ACardCanNotHaveANumberDifferentThan16Digits

	self createACardAndRaiseErrorWithCardNumber: 12345.
	self createACardAndRaiseErrorWithCardNumber: 12345678901234567.! !

!CreditCardTest methodsFor: 'tests' stamp: 'LB 11/2/2021 12:43:47'!
test04CreatingACardWithValidInfoIsCorrect

	|card|
	
	card := testObjects createValidCreditCard.
	
	self assert: testObjects validCardName equals: card name.
	self assert: testObjects validCardNumber equals: card number.
	self assert: testObjects notExpiredMonthOfYear equals: card date.! !


!CreditCardTest methodsFor: 'support' stamp: 'LB 11/2/2021 13:03:22'!
createACardAndRaiseErrorWithCardName: aName

	self 
		createACardWithCardName: aName
		andCardNumber: testObjects validCardNumber
		andRaiseErrorMessage: CreditCard invalidNameErrorMessage.! !

!CreditCardTest methodsFor: 'support' stamp: 'LB 11/2/2021 13:03:51'!
createACardAndRaiseErrorWithCardNumber: aCCNumber

	self 
		createACardWithCardName: testObjects validCardName
		andCardNumber: aCCNumber
		andRaiseErrorMessage: CreditCard invalidNumberErrorMessage.
		
	
	! !

!CreditCardTest methodsFor: 'support' stamp: 'LB 11/2/2021 13:02:49'!
createACardWithCardName: aName andCardNumber: aCCNumber andRaiseErrorMessage: anErrorMessage

	self 
		should:[CreditCard 
				withName:  aName
				withNumber: aCCNumber
				withExpirationDate: testObjects notExpiredMonthOfYear
				] 
		raise: Error - MessageNotUnderstood
		withExceptionDo:[:anError |
			self 
				assert: anError messageText
				equals: anErrorMessage ].
		
	
	! !

!CreditCardTest methodsFor: 'support' stamp: 'LB 11/2/2021 11:18:14'!
setUp
	
	testObjects := StoreTestObjectsMaker new.! !


!classDefinition: #StoreTestObjectsMaker category: 'TusLibros'!
TestCase subclass: #StoreTestObjectsMaker
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsMaker methodsFor: 'cart' stamp: 'LB 11/2/2021 10:11:29'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !

!StoreTestObjectsMaker methodsFor: 'cart' stamp: 'LB 11/2/2021 18:16:53'!
createCartWithAnItem
	
	^self createCart add: self itemSellByTheStore.! !


!StoreTestObjectsMaker methodsFor: 'catalog' stamp: 'LB 11/2/2021 10:24:19'!
defaultCatalog
	
	|dict|
	dict := Dictionary new.
	dict add: (self itemSellByTheStore -> self itemSellByTheStorePrice).
	^dict! !

!StoreTestObjectsMaker methodsFor: 'catalog' stamp: 'LB 11/2/2021 16:42:02'!
itemNotSellByTheStore
	
	^'Growing Object-Oriented Software Guided by Tests'! !

!StoreTestObjectsMaker methodsFor: 'catalog' stamp: 'LB 11/2/2021 16:42:06'!
itemSellByTheStore
	
	^'Smalltalk-80: The Language and its Implementation'! !

!StoreTestObjectsMaker methodsFor: 'catalog' stamp: 'LB 11/2/2021 10:24:19'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsMaker methodsFor: 'credit card' stamp: 'LB 11/2/2021 18:19:58'!
createExpiredCreditCard
	
	^ CreditCard 
		withName: self validCardName
		withNumber: self validCardNumber
		withExpirationDate: self expiredMonthOfYear.! !

!StoreTestObjectsMaker methodsFor: 'credit card' stamp: 'LB 11/2/2021 12:01:23'!
createValidCreditCard
	
	^ CreditCard 
		withName: self validCardName
		withNumber: self validCardNumber
		withExpirationDate: self notExpiredMonthOfYear.! !


!StoreTestObjectsMaker methodsFor: 'credit card data' stamp: 'LB 11/2/2021 11:50:55'!
validCardName
	^'Luis Bustamante'.! !

!StoreTestObjectsMaker methodsFor: 'credit card data' stamp: 'LB 11/2/2021 11:25:25'!
validCardNumber
	^4925969763322864! !


!StoreTestObjectsMaker methodsFor: 'date' stamp: 'LB 11/2/2021 17:26:51'!
expiredMonthOfYear
	
	^ today previous: GregorianMonth oneMonth.! !

!StoreTestObjectsMaker methodsFor: 'date' stamp: 'LB 11/2/2021 17:26:41'!
notExpiredMonthOfYear
	
	^ today next: GregorianMonth oneMonth.! !

!StoreTestObjectsMaker methodsFor: 'date' stamp: 'LB 11/2/2021 16:17:25'!
today
	^today.! !


!StoreTestObjectsMaker methodsFor: 'initialization' stamp: 'LB 11/2/2021 16:20:40'!
initialize
	today := GregorianMonthOfYear 
		yearNumber: (Date today yearNumber)
		monthNumber: (Date today month monthIndex).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LB 11/2/2021 10:04:11'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LB 11/2/2021 10:23:30'!
total
	
	^items sum: [:item| catalog at: item] ifEmpty: [0].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error message' stamp: 'LB 11/4/2021 11:27:27'!
invalidCatalogueErrorMessage
	
	^'Catalog can not have non positive prices'! !


!Cart class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 11:29:28'!
acceptingItemsOf: aCatalog
	
	self assertCatalogHasOnlyPositivePrices: aCatalog.
	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'assertions' stamp: 'LB 11/4/2021 11:32:40'!
assertCatalogHasOnlyPositivePrices: aCatalog 
	
	(aCatalog anySatisfy: [:value | value strictlyPositive not]) 
		ifTrue: [ self error: self invalidCatalogueErrorMessage ]! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard date salesBook used total merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'LB 11/3/2021 12:26:02'!
assertCartHasNotBeenUsedYet

	^ used ifTrue: 
		[ self error: self class cannotCheckoutTwiceErrorMessage ]! !


!Cashier methodsFor: 'checkout' stamp: 'LB 11/4/2021 10:28:12'!
checkout
	
	self assertCartHasNotBeenUsedYet.
	
	total := cart total.
	merchantProcessor charge: total on: creditCard.
	
	^self registerEndOfCheckout.! !

!Cashier methodsFor: 'checkout' stamp: 'LB 11/4/2021 09:42:47'!
registerEndOfCheckout
	
	salesBook add: total.
	used := true.
	^cart total.! !


!Cashier methodsFor: 'initialization' stamp: 'LB 11/4/2021 10:29:12'!
initializeToCheckOut: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook with: aMerchantProcessor  
	
	cart := aCart.
	creditCard := aCreditCard.
	date := aDate.
	salesBook := aSalesBook.
	used := false.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 10:29:00'!
toCheckOut: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook with: aMerchantProcessor  
	
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckOut: aCart 
		charging: aCreditCard 
		on: aDate 
		registeringOn: aSalesBook
		with: aMerchantProcessor ! !


!Cashier class methodsFor: 'assertions' stamp: 'LB 11/2/2021 13:06:22'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self error: self emptyCartMessageError.]! !

!Cashier class methodsFor: 'assertions' stamp: 'LB 11/2/2021 13:08:12'!
assertCreditCardIsNotExpired: aCreditCard on: aDate 
	(aCreditCard isExpiredOn: aDate) 
		ifTrue: [self error: self expiredCreditCardMessageError]! !


!Cashier class methodsFor: 'error message' stamp: 'LB 11/3/2021 12:25:50'!
cannotCheckoutTwiceErrorMessage

	^ 'Can not checkout twice'! !

!Cashier class methodsFor: 'error message' stamp: 'LB 11/2/2021 13:06:53'!
emptyCartMessageError

	^ 'Can not make checkout of empty cart'! !

!Cashier class methodsFor: 'error message' stamp: 'LB 11/2/2021 13:09:13'!
expiredCreditCardMessageError

	^ 'Can not charge sale to a expired credit card'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'date name number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'support' stamp: 'LB 11/2/2021 12:04:05'!
isExpiredOn: aMonthOfYear
	^date < aMonthOfYear! !


!CreditCard methodsFor: 'accessing' stamp: 'LB 11/2/2021 12:03:45'!
date
	^date! !

!CreditCard methodsFor: 'accessing' stamp: 'LB 11/2/2021 12:03:36'!
name 
	^name! !

!CreditCard methodsFor: 'accessing' stamp: 'LB 11/2/2021 12:03:41'!
number
	^number! !


!CreditCard methodsFor: 'initialization' stamp: 'LB 11/2/2021 11:13:35'!
initializeWithName: aString withNumber: aCCNumber withExpirationDate: aDate 
	
	name := aString.
	number := aCCNumber.
	date := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LB 11/2/2021 11:58:33'!
withName: aName withNumber: aCCNumber withExpirationDate: aDate 
	
	self assertCardNameIsNotEmptyAndIsNotLongerThan30Characters: aName.
	self assertCardNumberMustHaveExactly16Digits: aCCNumber.
	
	^self new 
		initializeWithName: aName
		withNumber: aCCNumber
		withExpirationDate: aDate ! !


!CreditCard class methodsFor: 'error message' stamp: 'LB 11/2/2021 12:51:45'!
invalidNameErrorMessage
	
	^'Name can not be empty or have more than 30 characters'! !

!CreditCard class methodsFor: 'error message' stamp: 'LB 11/2/2021 11:55:49'!
invalidNumberErrorMessage
	
	^'Number must have exactly 16 digits'! !


!CreditCard class methodsFor: 'assertions' stamp: 'LB 11/2/2021 12:51:45'!
assertCardNameIsNotEmptyAndIsNotLongerThan30Characters: aName.
	
	(aName size > 30 or: aName isEmpty) 
		ifTrue: [ self error: self invalidNameErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'LB 11/2/2021 12:06:53'!
assertCardNumberMustHaveExactly16Digits: aCCNumber.
	
	((aCCNumber numberOfDigitsInBase: 10) ~= 16) 
		ifTrue: [ self error: self invalidNumberErrorMessage ]! !


!classDefinition: #MPSimulator category: 'TusLibros'!
Object subclass: #MPSimulator
	instanceVariableNames: 'canCheckout errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSimulator methodsFor: 'initialization' stamp: 'LB 11/4/2021 11:14:11'!
initializeSetUpWithFakeCard
	
	canCheckout := false.
	errorMessage := self class canNotChargeOnFakeCardErrorMessage.! !

!MPSimulator methodsFor: 'initialization' stamp: 'LB 11/4/2021 11:14:16'!
initializeSetUpWithNoFoundsCard
	
	canCheckout := false.
	errorMessage := self class canNotChargeOnNoFoundsCardErrorMessage.! !

!MPSimulator methodsFor: 'initialization' stamp: 'LB 11/4/2021 10:36:05'!
initializeSetUpWithOK
	
	canCheckout := true.! !

!MPSimulator methodsFor: 'initialization' stamp: 'LB 11/4/2021 11:14:22'!
initializeSetUpWithStolenCard
	
	canCheckout := false.
	errorMessage := self class canNotChargeOnStolenCardErrorMessage.! !


!MPSimulator methodsFor: 'payment' stamp: 'LB 11/4/2021 10:31:15'!
charge: anAmount on: aCreditCard 
	
	canCheckout ifFalse: [ self error: errorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: 'TusLibros'!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'error message' stamp: 'LB 11/4/2021 11:14:11'!
canNotChargeOnFakeCardErrorMessage
	
	^'Can not charge on a fake card!!'! !

!MPSimulator class methodsFor: 'error message' stamp: 'LB 11/4/2021 11:14:16'!
canNotChargeOnNoFoundsCardErrorMessage
	
	^'Can not charge on a no funds card!!'! !

!MPSimulator class methodsFor: 'error message' stamp: 'LB 11/4/2021 11:14:22'!
canNotChargeOnStolenCardErrorMessage
	
	^'Can not charge on a stolen card!!'! !


!MPSimulator class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 11:04:34'!
setUpWithFakeCard
	
	^self new initializeSetUpWithFakeCard! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 11:07:10'!
setUpWithNoFoundsCard
	
	^self new initializeSetUpWithNoFoundsCard! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 10:25:22'!
setUpWithOK
	^ self new initializeSetUpWithOK.! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'LB 11/4/2021 10:26:43'!
setUpWithStolenCard

	^self new initializeSetUpWithStolenCard! !
