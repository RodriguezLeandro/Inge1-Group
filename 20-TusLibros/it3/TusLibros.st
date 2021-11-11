!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreFacadeTest category: 'TusLibros'!
TestCase subclass: #StoreFacadeTest
	instanceVariableNames: 'shouldAuthenticate testObjects canCheckout clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 12:01:54'!
test01CreateACartWithWrongUserOrPaswordRaisesError
	| store |
	
	shouldAuthenticate := false.
	store := self createStore.
	
	self
		should: [ store createCartFor: 'hacker' with: 1234 ]
		raise: Error
		withExceptionDo: [:error |
			self
				assert: error messageText 
				equals: self class invalidUserErrorMessage ].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 10:24:27'!
test02CreateACartWithValidUserAndPasswordCreatesAnEmptyCart
	| store idCart |
	
	store := self createStore.
	
	idCart := store 
		createCartFor: testObjects validClientId 
		with: testObjects validPassword.
	
	self assert: (store listCart: idCart) isEmpty.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:57:49'!
test03AddAnItemToCartWithValidIdMakesItemAppearsOnItsList
	| store idCart cartList |
	
	store := self createStore.
	idCart := self createCartForSampleClientIn: store.
	
	store add: 1 of: testObjects itemSellByTheStore toCart: idCart.
	
	cartList := store listCart: idCart.
	
	self assert: cartList includes: testObjects itemSellByTheStore.
	self assert: 1 equals: (cartList 		occurrencesOf: testObjects itemSellByTheStore).! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:57:49'!
test04NewStoreCartsHaveDifferentId
	| store idCart1 idCart2 |
	
	store := self createStore.
	
	idCart1 := self createCartForSampleClientIn: store.
	idCart2 := self createCartForSampleClientIn: store.
	
	store add: 1 of: testObjects itemSellByTheStore toCart: idCart1.
	store add: 1 of: testObjects itemSellByTheStore toCart: idCart2.
	
	self deny: idCart1 = idCart2.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 12:02:40'!
test05AddAnItemToAnInvalidCartRaisesError

	self
		should: [ self createStore add: 1 of: testObjects itemSellByTheStore toCart: 1000. ]
		raise: Error
		withExceptionDo: [:error |
			self 
				assert: error messageText
				equals: StoreFacade invalidCartIdErrorMessage].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 12:02:48'!
test06ListAnInvalidCartIdRaisesError

	self
		should: [ self createStore listCart: 1000]
		raise: Error
		withExceptionDo: [:error |
			self 
				assert: error messageText
				equals: StoreFacade invalidCartIdErrorMessage].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:17:06'!
test07CheckoutAnInvalidCartIdRaisesError

	self
		should: [ self 
					createStore checkoutCart: 1000
					with: testObjects validCardNumber 
					expiringOn: testObjects validExpirationDate 
					ownedBy: testObjects validOwnerName]
		raise: Error
		withExceptionDo: [:error |
			self 
				assert: error messageText
				equals: StoreFacade invalidCartIdErrorMessage].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:35:46'!
test08ListAnExpiredCartRaisesError
	
	self shouldRaiseErrorWhenAnExpiredCartTriesToExecute: 
		[:anStore :anCartId | anStore listCart: anCartId].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:47:50'!
test09AddToAExpiredCartRaisesError
	
	self shouldRaiseErrorWhenAnExpiredCartTriesToExecute: 
		[:anStore :anCartId | 
			anStore add: 1 of: testObjects itemSellByTheStore toCart: anCartId]! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:47:55'!
test10CheckoutAnExpiredCartRaisesError
	
	self shouldRaiseErrorWhenAnExpiredCartTriesToExecute: 
		[:anStore :anCartId | 
			anStore
				checkoutCart: anCartId
				with: testObjects validCardNumber 
				expiringOn: testObjects validExpirationDate 
				ownedBy: testObjects validOwnerName]! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 14:58:12'!
test11ListPurchasesOfAClientWithoutPurchasestReturnNoPurchases
	| store purchases|

	store := self createStore.
	self createCartForSampleClientIn: store.
	
	purchases := self purchasesForSampleClientIn: store.
	
	self assert: 0 equals: (purchases at: 'total').
	self assert: (purchases at: 'items') isEmpty.
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 22:21:18'!
test12ListPurchasesOfAUserWithOnePurchaseReturnThatPurchase
	| store |
		
	store := self createStore.
	
	self
		createACartWithAnItemFor: testObjects validClientId
		with: testObjects validPassword
		andCheckoutThatCartIn: store.
	
	self 
		assertListPurchasesFor: testObjects validClientId
		with: testObjects validPassword  
		returnsHisPurchasesOf: store.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 22:12:52'!
test13ListPurchasesOfAUserWithManyPurchaseReturnAllPurchases
	| store purchases purchasedItems |
		
	store := self createStore.
	
	1 to: 2 do: [ :aNumber | self
		createACartWithAnItemFor: testObjects validClientId
		with: testObjects validPassword
		andCheckoutThatCartIn: store].
	
	purchases := self purchasesForSampleClientIn: store.
	purchasedItems := purchases at: 'items'.
	
	self assert: testObjects itemSellByTheStorePrice * 2
		equals: (purchases at: 'total') .
	self assert: 2 
		equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore).
	self assert: 2 equals: purchasedItems size.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'LB 11/10/2021 22:19:10'!
test14ListPurchasesOfMoreThanOneClientReturnTheirRespectivePurchases
	| store |
		
	store := self createStore.
	
	self
		createACartWithAnItemFor: 'Seba'
		with: testObjects validPassword 
		andCheckoutThatCartIn: store.
		
	self
		createACartWithAnItemFor: 'Luis'
		with: testObjects validPassword 
		andCheckoutThatCartIn: store.
	
	self 
		assertListPurchasesFor: 'Seba' 
		with: testObjects validPassword  
		returnsHisPurchasesOf: store.
	
	self 
		assertListPurchasesFor: 'Luis' 
		with: testObjects validPassword  
		returnsHisPurchasesOf: store.
	! !


!StoreFacadeTest methodsFor: 'setUp' stamp: 'LB 11/10/2021 18:27:26'!
setUp
	
	testObjects := StoreTestObjectsFactory new.
	canCheckout := true.
	shouldAuthenticate := true.
	clock := Clock new.! !


!StoreFacadeTest methodsFor: 'merchant processor' stamp: 'LB 11/10/2021 11:49:14'!
debit: anAmount from: aCreditCard 

	canCheckout 
		ifFalse: [ self error: 'Can not charge on a invalid card!!' ]! !


!StoreFacadeTest methodsFor: 'authenticator' stamp: 'LB 11/10/2021 12:01:48'!
login: aClientId with: aPassword
	
	shouldAuthenticate ifFalse:
		[self error: self class invalidUserErrorMessage].	! !


!StoreFacadeTest methodsFor: 'assertions' stamp: 'LB 11/10/2021 22:19:10'!
assertListPurchasesFor: aClient with: aPassword returnsHisPurchasesOf: aStore
	| purchasedItems purchases |
		
	purchases := aStore		listPurchasesFor: aClient 		with: aPassword.
	purchasedItems := purchases at: 'items'.
	self assert: testObjects itemSellByTheStorePrice
		equals: (purchases at: 'total') .
	self assert: 1
		equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore).
	self assert: 1 equals: purchasedItems size.
	! !

!StoreFacadeTest methodsFor: 'assertions' stamp: 'LB 11/10/2021 15:04:45'!
shouldRaiseErrorWhenAnExpiredCartTriesToExecute: aClosure
	| store idCart |
	
	store := self createStore.
	idCart := self createCartForSampleClientIn: store.
	
	clock pass30minutes.
	
	self
		should: [aClosure value: store value: idCart]
		raise: Error
		withExceptionDo: [:error |
			self 
				assert: error messageText
				equals: StoreFacade timeoutErrorMessage].! !


!StoreFacadeTest methodsFor: 'support' stamp: 'LB 11/10/2021 15:42:50'!
createACartWithAnItemFor: aClient with: aPassword andCheckoutThatCartIn: aStore
	| cartId |
		
	cartId := aStore 		createCartFor: aClient 		with: aPassword.
	aStore add: 1 of: testObjects itemSellByTheStore toCart: cartId.
	aStore 
		checkoutCart: cartId
		with: testObjects validCardNumber 
		expiringOn: testObjects validExpirationDate 
		ownedBy: testObjects validOwnerName. ! !

!StoreFacadeTest methodsFor: 'support' stamp: 'LB 11/10/2021 15:43:10'!
createCartForSampleClientIn: aStore
	
	^aStore 
		createCartFor: testObjects validClientId 
		with: testObjects validPassword.! !

!StoreFacadeTest methodsFor: 'support' stamp: 'LB 11/11/2021 00:23:16'!
createStore
	^StoreFacade 
		authenticateWith: self
		andCatalog: testObjects defaultCatalog
		andMerchantProcesor: self
		andClock: clock.! !

!StoreFacadeTest methodsFor: 'support' stamp: 'LB 11/10/2021 14:58:12'!
purchasesForSampleClientIn: anStore

	^anStore 
		listPurchasesFor: testObjects validClientId 
		with: testObjects validPassword! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreFacadeTest class' category: 'TusLibros'!
StoreFacadeTest class
	instanceVariableNames: ''!

!StoreFacadeTest class methodsFor: 'as yet unclassified' stamp: 'LB 11/10/2021 12:01:35'!
invalidUserErrorMessage

	^ 'Invalid user or invalid password'! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'LB 11/10/2021 13:51:05'!
listItems
	^items 
		inject: Bag new 
		into: [:aBag :anItem| 
				aBag add: anItem withOccurrences: (self occurrencesOf: anItem); yourself ].! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'incrementorTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'LB 11/10/2021 10:08:24'!
initialize
	
	incrementorTime := Duration minutes: 0.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'LB 11/10/2021 10:08:39'!
now
	
	^(DateAndTime now) + incrementorTime.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'LB 11/10/2021 10:08:18'!
pass30minutes
	
	incrementorTime := Duration minutes: 31.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreFacade category: 'TusLibros'!
Object subclass: #StoreFacade
	instanceVariableNames: 'clientAuthenticator catalog carts clock mercantProcessor clientsPurchasesRecord lastTimeActive idCartGenerator clientIdByCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacade methodsFor: 'initialization' stamp: 'LB 11/11/2021 00:23:04'!
initializeAuthenticateWith: aClientAuthenticator andCatalog: aCatalog andMerchantProcesor: aMerchantProcessor andClock: aClock 
	
	clientAuthenticator := aClientAuthenticator.
	catalog := aCatalog.
	mercantProcessor := aMerchantProcessor.
	clock := aClock.
	carts := Dictionary new.
	clientIdByCartId := Dictionary new.
	lastTimeActive := Dictionary new.
	clientsPurchasesRecord := Dictionary new.
	idCartGenerator := Random new seed: 1.! !


!StoreFacade methodsFor: 'assertions' stamp: 'LB 11/10/2021 11:55:57'!
assertCartIdIsIncluded: aCartId

	^ (carts includesKey: aCartId) 
		ifFalse: [ self error: self class invalidCartIdErrorMessage ]! !

!StoreFacade methodsFor: 'assertions' stamp: 'LB 11/10/2021 11:57:57'!
assertCartIsNotExpired: aCartId

	^ (self hasPassed30MinutesTo: aCartId) 
		ifTrue: [self error: self class timeoutErrorMessage].! !

!StoreFacade methodsFor: 'assertions' stamp: 'LB 11/10/2021 14:21:22'!
assertCartIsValid: aCartId

	self assertCartIdIsIncluded: aCartId.
	self assertCartIsNotExpired: aCartId! !


!StoreFacade methodsFor: 'interface' stamp: 'LB 11/11/2021 00:15:40'!
add: aBookQuantity of: aBookName toCart: aCartId 
	
	self assertCartIsValid: aCartId.
	
	self updateLastTimeActiveOf: aCartId.
	(carts at: aCartId) add: aBookQuantity of: aBookName.! !

!StoreFacade methodsFor: 'interface' stamp: 'LB 11/11/2021 00:25:37'!
checkoutCart: aCartId with: aCardNumber expiringOn: aMonthOfYear ownedBy: aClientName
	| total |
	
	self assertCartIsValid: aCartId.
	
	total := (Cashier 
		toCheckout: (carts at: aCartId)
		charging: (CreditCard expiringOn: aMonthOfYear)
		throught: mercantProcessor 
		on: DateAndTime now date
		registeringOn: OrderedCollection new) checkOut.
	
	self updateClientPurchasesRecordFor: aCartId withTotal: total.
	
	! !

!StoreFacade methodsFor: 'interface' stamp: 'LB 11/11/2021 00:12:23'!
createCartFor: aClientId with: aPassword 
	| newId |
	
	self authenticate: aClientId with: aPassword.
	self initializePurchasesRecordFor: aClientId.	
	
	newId := self generateNewId.
	carts add: newId -> (Cart acceptingItemsOf: catalog).
	clientIdByCartId add: newId -> aClientId.
	self updateLastTimeActiveOf: newId.
	
	^newId.! !

!StoreFacade methodsFor: 'interface' stamp: 'LB 11/11/2021 00:15:32'!
listCart: aCartId 
	
	self assertCartIsValid: aCartId.
	
	self updateLastTimeActiveOf: aCartId.
	^(carts at: aCartId) listItems.! !

!StoreFacade methodsFor: 'interface' stamp: 'LB 11/11/2021 00:15:07'!
listPurchasesFor: aClientId with: aPassword
	
	self authenticate: aClientId with: aPassword.
	
	^clientsPurchasesRecord at: aClientId.! !


!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/10/2021 13:57:24'!
authenticate: aClientId with: aPassword

	clientAuthenticator login: aClientId with: aPassword! !

!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/10/2021 18:33:24'!
generateNewId

	^ idCartGenerator nextInteger: 1000! !

!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/10/2021 11:57:31'!
hasPassed30MinutesTo: aCartId

	^ ((lastTimeActive at: aCartId) + (Duration minutes:30) < clock now)! !

!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/11/2021 00:15:07'!
initializePurchasesRecordFor: aClientId
	| initialRecord |
	
	initialRecord := Dictionary new 
					add: 'total' -> 0;
					add: 'items' -> Bag new;
					yourself.	
	
	(clientsPurchasesRecord includesKey: aClientId) 
		ifFalse:[ clientsPurchasesRecord add: aClientId -> initialRecord ]! !

!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/11/2021 00:25:37'!
updateClientPurchasesRecordFor: aCartId withTotal: anAmount
	| cart clientId record prevItems prevTotal newItems |
	
	cart := carts at: aCartId.
	clientId := clientIdByCartId at: aCartId.
	record := clientsPurchasesRecord at: clientId.
	
	prevTotal := record			at: 'total'.
	prevItems := record			at: 'items'.
	
	newItems := prevItems addAll: cart listItems; yourself.
	
	record at: 'total' put: prevTotal + anAmount.
	record at: 'items' put: newItems.
	
	! !

!StoreFacade methodsFor: 'interface - private' stamp: 'LB 11/10/2021 13:55:16'!
updateLastTimeActiveOf: aCartId

	lastTimeActive add: aCartId -> clock now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreFacade class' category: 'TusLibros'!
StoreFacade class
	instanceVariableNames: ''!

!StoreFacade class methodsFor: 'instance creation' stamp: 'LB 11/11/2021 00:23:16'!
authenticateWith: aClientAuthenticator andCatalog: aCatalog andMerchantProcesor: aMerchantProcessor andClock: aClock 
	
	^self new initializeAuthenticateWith: aClientAuthenticator andCatalog: aCatalog andMerchantProcesor: aMerchantProcessor andClock: aClock ! !


!StoreFacade class methodsFor: 'error message' stamp: 'LB 11/10/2021 11:54:09'!
invalidCartIdErrorMessage

	^ 'Invalid Cart ID'! !

!StoreFacade class methodsFor: 'error message' stamp: 'LB 11/10/2021 11:58:50'!
timeoutErrorMessage

	^ 'Timeout: Your cart has been inactive for more than 30 minutes'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'store facade' stamp: 'LB 11/10/2021 11:11:00'!
validClientId
	^'Luis Bustamante'! !

!StoreTestObjectsFactory methodsFor: 'store facade' stamp: 'LB 11/10/2021 10:15:30'!
validPassword
	^'1234'! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LB 11/10/2021 11:07:12'!
validCardNumber
	^1234567890123456! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LB 11/10/2021 11:10:30'!
validExpirationDate
	
	^Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LB 11/10/2021 11:11:46'!
validOwnerName
	
	^'LUIS R BUSTAMANTE'.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
