!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !

!Cart methodsFor: 'assertions' stamp: 'LB 11/20/2021 11:31:36'!
assertOccurrencesOf: anItem areGreaterThan: anAmount
	|count|
	
	count := (items occurrencesOf: anItem).
	(count > 0 and: [anAmount > count ])
		ifTrue: [self error: self class invalidAmountToRemoveErrorMessage]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'remove' stamp: 'LB 11/20/2021 11:33:28'!
remove: anItem
	
	items
		remove: anItem
		ifAbsent: [self error: self class invalidItemErrorMessage].! !

!Cart methodsFor: 'remove' stamp: 'LB 11/20/2021 11:33:46'!
remove: anAmount of: anItem

	self assertIsValidQuantity: anAmount.
	self assertOccurrencesOf: anItem areGreaterThan: anAmount.
	
	anAmount timesRepeat: [self remove: anItem].! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'LB 11/20/2021 11:30:40'!
invalidAmountToRemoveErrorMessage
	
	^'There are not so many elements in the cart'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'LB 11/28/2021 22:39:24'!
owner
	^owner.! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'LB 11/20/2021 11:38:21'!
removeFromCart: anAmount of: aBook

	^cart remove: anAmount of: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'LB 11/18/2021 19:29:27'!
totalOf: anItem quantity: aQuantity

	^((cart catalog at: anItem) at: 'price') * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'LB 11/28/2021 21:49:21'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^Dictionary new 
		add: 'items' -> ticket lineItems; 
		add: 'total' -> ticket total;
		yourself.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'LB 11/15/2021 20:39:40'!
quantity
	
	^quantity.! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MPSimulator category: #'TusLibros-Model'!
MerchantProcessor subclass: #MPSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MPSimulator methodsFor: 'debit' stamp: 'LB 11/15/2021 20:35:32'!
debit: anAmount from: aCreditCard
	! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'LB 11/28/2021 21:48:46'!
lineItems

	^lineItems 
		inject: Dictionary new 
		into: [:anDict :aLineItem|
			anDict add: 
				aLineItem item -> aLineItem quantity;
				yourself.
			].! !

!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosServicesRestInterface category: #'TusLibros-Model'!
Object subclass: #TusLibrosServicesRestInterface
	instanceVariableNames: 'port webServer store'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosServicesRestInterface methodsFor: 'destroy' stamp: 'LB 11/15/2021 20:29:26'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !


!TusLibrosServicesRestInterface methodsFor: 'initialization' stamp: 'LB 11/29/2021 11:27:12'!
initializelisteningOn: aPortNumber 
authenticatingWith: aValidUsersAndPasswords
acceptingItemsOf: aCatalog 
debitingThrought: aMerchantProcessor 
measuringTimeWith: aClock 
withUserCards: aUserCardsDatabase.
	
	port := aPortNumber. 
	webServer := WebServer new listenOn: self port.
	store := TusLibrosSystemFacade 
			authenticatingWith: aValidUsersAndPasswords
			acceptingItemsOf: aCatalog
			registeringOn:  OrderedCollection new
			debitingThrought: aMerchantProcessor
			measuringTimeWith: aClock
			withUserCards: aUserCardsDatabase.
	
	self 
		addService: '/createCart' 
		action: [:request| self setUpCreateCartEndPointFor: request].
	
	self 
		addService: '/addToCart'
		action:[:request |	 self setUpAddToCartEndPointFor: request].
	
	self
		addService: '/listCart'
		action:[:request | self setUpListCartEndPointFor: request].
	
	self
		addService: '/checkOutCart'
		action:[:request |	 self setUpCheckOutCartEndPointFor: request].
	
	self
		addService: '/listPurchases'
		action:[:request |	self setUpListPurchasesEndPointFor: request].
	
	self
		addService: '/listCatalog'
		action:[:request |	self setUpListCatalogEndPointFor: request].
	
	self 
		addService: '/removeFromCart'
		action:[:request |	self setUpRemoveFromCartEndPointFor: request].
	! !


!TusLibrosServicesRestInterface methodsFor: 'server setUp' stamp: 'LB 11/15/2021 21:37:54'!
addService: anUrlFragment action: aBlock
	
	webServer 
		addService: anUrlFragment
		action:[:request | 
			[aBlock value: request]
				on: Error 
				do: [ :anError |
					request send400Response: (anError messageText) ]].! !

!TusLibrosServicesRestInterface methodsFor: 'server setUp' stamp: 'LB 11/15/2021 20:29:55'!
port
	
	^port ifNil: [port:=8080].! !


!TusLibrosServicesRestInterface methodsFor: 'server setUp support' stamp: 'LB 11/20/2021 11:00:01'!
dictionaryFrom: aBag
	
	^aBag asSet 
		inject: Dictionary new
		into: [:aDict :anElem|
			aDict at: anElem put: (aBag occurrencesOf: anElem);
			yourself. ].! !

!TusLibrosServicesRestInterface methodsFor: 'server setUp support' stamp: 'LB 11/15/2021 21:45:44'!
monthOfYearFrom: aMonthOfYearString
	| yearOfCco monthOfCco| 

	monthOfCco := (aMonthOfYearString copyFrom: 1 to: 2) asNumber.
	yearOfCco := (aMonthOfYearString copyFrom: 3 to: 6) asNumber.
	
	^ Month month: monthOfCco year: yearOfCco .
	! !


!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/27/2021 13:42:59'!
setUpAddToCartEndPointFor: aRequest
	| cartId bookIsbn bookQuantity | 

	cartId := aRequest fields at: 'cartId'.
	bookIsbn := aRequest fields at: 'bookIsbn'.
	bookQuantity := aRequest fields at: 'bookQuantity'.
		
	store 
		add: bookQuantity asNumber
		of: bookIsbn
		toCartIdentifiedAs: cartId asNumber.
		
	aRequest send200Response: (WebUtils jsonEncode: 'Ok').
	! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/28/2021 22:37:19'!
setUpCheckOutCartEndPointFor: aRequest
	| cartId ticket | 
	
	cartId := aRequest fields at: 'cartId'.
	
	ticket := store
		checkOutCartIdentifiedAs: cartId asNumber.
	
	aRequest send200Response: (WebUtils jsonEncode: ticket).! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/15/2021 21:41:31'!
setUpCreateCartEndPointFor: aRequest
	| clientId password idCart | 	
	
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	idCart := store createCartFor: clientId authenticatedWith: password.
	
	aRequest send200Response: idCart asString.! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/20/2021 10:57:02'!
setUpListCartEndPointFor: aRequest
	| cartId bag dict | 
	
	cartId := aRequest fields at: 'cartId'.
	bag := store listCartIdentifiedAs: cartId asNumber.
	dict := self dictionaryFrom: bag.
	
	aRequest send200Response: (WebUtils jsonEncode: dict).! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/20/2021 11:01:03'!
setUpListCatalogEndPointFor: aRequest
	| dict |
	
	dict := store listCatalog.
	
	aRequest send200Response: (WebUtils jsonEncode: dict).! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/20/2021 11:01:30'!
setUpListPurchasesEndPointFor: aRequest
	| clientId password books | 
	
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	books := store listPurchasesOf: clientId authenticatingWith: password.
	
	aRequest send200Response: (WebUtils jsonEncode: books).! !

!TusLibrosServicesRestInterface methodsFor: 'endpoints' stamp: 'LB 11/27/2021 14:59:15'!
setUpRemoveFromCartEndPointFor: aRequest
	| cartId bookIsbn bookQuantity | 

	cartId := aRequest fields at: 'cartId'.
	bookIsbn := aRequest fields at: 'bookIsbn'.
	bookQuantity := aRequest fields at: 'bookQuantity'.
		
	store 
		remove: bookQuantity asNumber
		of: bookIsbn
		toCartIdentifiedAs: cartId asNumber.
		
	aRequest send200Response: (WebUtils jsonEncode: 'Ok').
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServicesRestInterface class' category: #'TusLibros-Model'!
TusLibrosServicesRestInterface class
	instanceVariableNames: ''!

!TusLibrosServicesRestInterface class methodsFor: 'as yet unclassified' stamp: 'LB 11/29/2021 10:02:42'!
listeningOn: aPortNumber 
authenticatingWith: aValidUsersAndPasswords
acceptingItemsOf: aCatalog 
debitingThrought: aMerchantProcessor 
measuringTimeWith: aClock 
withUserCards: aUserCardsDatabase

	^self new 
		initializelisteningOn: aPortNumber 
		authenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog 
		debitingThrought: aMerchantProcessor 
		measuringTimeWith: aClock 
		withUserCards: aUserCardsDatabase.! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions usersCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'LB 11/28/2021 22:40:01'!
checkOutCartIdentifiedAs: aCartId 
	| cartSession creditCard creditCardExpiration creditCardNumber username |
	
	cartSession := cartSessions at: aCartId.
	username := cartSession owner.
	creditCard := usersCards at: username.
	
	creditCardNumber := creditCard key.
	creditCardExpiration := creditCard value.
	
	^self 
		checkOutCartIdentifiedAs: aCartId 
		withCreditCardNumbered: creditCardNumber 
		ownedBy: username 
		expiringOn: creditCardExpiration.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'LB 11/28/2021 20:14:53'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'LB 11/29/2021 11:25:11'!
listCatalog
	
	^ catalog copy.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'LB 11/20/2021 14:45:12'!
listPurchasesOf: aUser authenticatingWith: aPassword
	| items |
	
	items := self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ].
	
	^ Dictionary new 
		at: 'items' put: items;
		at: 'total' put: (self totalToPayFrom: aUser);
		yourself.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'LB 11/20/2021 11:38:57'!
remove: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: anAmount of: aBook ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'LB 11/15/2021 20:42:53'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldQuantity newQuantity |
		oldQuantity := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newQuantity := oldQuantity + aLineItem quantity.
		"Cambio la version de Hernan para que devuelva la cantidad en vez del total".
		salesOrderedByBook at: aLineItem item put: newQuantity ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'LB 11/15/2021 20:41:51'!
totalToPayFrom: anUser

	^ (self salesDoneBy: anUser) sum: [:aSale| aSale total] ifEmpty: 0.! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'LB 11/28/2021 22:35:46'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock 
	withUserCards: aUserCardsDatabase 

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	usersCards := aUserCardsDatabase.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'LB 11/29/2021 11:27:24'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock 
	withUserCards: aUserCardsDatabase 
	
	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock 
		withUserCards: aUserCardsDatabase! !
