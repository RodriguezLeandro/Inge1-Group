!classDefinition: #ErrorMessageWindow category: 'TusLibros-Client'!
Panel subclass: #ErrorMessageWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!ErrorMessageWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 11:05:48'!
buildMorphicWindowAlerting: aMessage
	| message |
	
	message := LabelMorph contents: aMessage.
	message font: (FontFamily defaultFamilyPointSize: 20).
	message color: Color red.
	self layoutMorph beColumn;
		axisEdgeWeight: 0.5;
		addMorph: message.! !

!ErrorMessageWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 11:06:20'!
defaultExtent
	
	^1000@100! !


!ErrorMessageWindow methodsFor: 'initialization' stamp: 'LB 11/27/2021 11:05:27'!
initializeAlerting: aMessage
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Oops, something went wrong...'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindowAlerting: aMessage.
	self openInWorld.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorMessageWindow class' category: 'TusLibros-Client'!
ErrorMessageWindow class
	instanceVariableNames: ''!

!ErrorMessageWindow class methodsFor: 'accessing' stamp: 'LB 11/27/2021 10:54:07'!
alerting: aMessage
	
	^self new initializeAlerting: aMessage.! !

!ErrorMessageWindow class methodsFor: 'accessing' stamp: 'LB 11/27/2021 10:00:57'!
handler
	
	^[:errorMessage | ErrorMessageWindow alerting: errorMessage ]! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Client'!
Panel subclass: #LoginWindowModel
	instanceVariableNames: 'interface username password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!LoginWindowModel methodsFor: 'actions' stamp: 'LB 11/27/2021 13:29:31'!
createCartRequest

	interface createCartFor: self username and: self password;
		onSuccess: [:cartId |
			self 
				triggerEvent: #validLogin 
				with: (CartWindowModel with: cartId) ].! !

!LoginWindowModel methodsFor: 'actions' stamp: 'LB 11/28/2021 19:17:43'!
listPurchases
	
	interface listPurchasesOf: username with: password;
		onSuccess: [:unused | 
			self 
				triggerEvent: #listPurchases
				with: (TicketWindowModel 
					listingPurchasesOf: username with: password). ]
	
	! !


!LoginWindowModel methodsFor: 'initialization' stamp: 'LB 11/27/2021 10:26:46'!
initialize

	interface := TusLibrosClientRestInterface errorHandling: ErrorMessageWindow handler.
	username := ''.
	password := ''.! !


!LoginWindowModel methodsFor: 'input text' stamp: 'LB 11/18/2021 13:49:42'!
password
	^password! !

!LoginWindowModel methodsFor: 'input text' stamp: 'LB 11/18/2021 13:49:59'!
password: aPassword
	password := aPassword.! !

!LoginWindowModel methodsFor: 'input text' stamp: 'LB 11/18/2021 13:49:11'!
username
	^username! !

!LoginWindowModel methodsFor: 'input text' stamp: 'LB 11/18/2021 13:49:16'!
username: anUsername
	username := anUsername.! !


!classDefinition: #TusLibrosWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 16:58:21'!
createButtonLabeled: aStringLabel withAction: anAction.

	^(PluggableButtonMorph
		model: self model
		stateGetter: nil
		action: anAction 
		label: aStringLabel) morphHeight: 50.
	! !

!TusLibrosWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:28:08'!
createListFor: aGetter withIndexGetter: anIndexGetter andIndexSetter: anIndexSetter
	| catalogListMorph |
	
	catalogListMorph := PluggableListMorph
		model: self model
		listGetter: aGetter
		indexGetter: anIndexGetter
		indexSetter: anIndexSetter.
	catalogListMorph borderColor: Color skyBlue;
		borderWidth: 1;
		morphWidth: 750;
		morphHeight: 400.
	^catalogListMorph! !


!classDefinition: #CartWindow category: 'TusLibros-Client'!
TusLibrosWindow subclass: #CartWindow
	instanceVariableNames: 'cartListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:45:26'!
build1stRow
	
	^LayoutMorph newRow
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: self build1stRow1stColumn;
		addMorph: self build1stRow2ndColumn.! !

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 11:41:34'!
build1stRow1stColumn
	| catalogListMorph buttonMorph |
	
	catalogListMorph := self createListFor: #adaptCatalogToStringList
		withIndexGetter: #catalogSelectedIndex
		andIndexSetter: #catalogSelectedIndex:.
	
	buttonMorph :=
		self createButtonLabeled: 'Add a book to cart'
			withAction: 	#askForQuantityToAdd.
	
	^LayoutMorph newColumn
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Catalog');
		addMorph: catalogListMorph;
		addMorph: buttonMorph.! !

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 14:51:27'!
build1stRow2ndColumn
	| buttonMorph |
	
	cartListMorph := self createListFor: #adaptCartToStringList
		withIndexGetter: #cartSelectedIndex
		andIndexSetter: #cartSelectedIndex:.
	
	buttonMorph :=
		self createButtonLabeled: 'Remove selected book from cart'
			withAction: 	#removeItemFromCart.
		
	^LayoutMorph newColumn
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Current Cart');
		addMorph: cartListMorph;
		addMorph: buttonMorph.! !

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 15:08:01'!
build2ndRow

	^self
		createButtonLabeled: 'Checkout'
		withAction: #checkOutCart. ! !

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:21:31'!
buildMorphicWindow
	
	self layoutMorph
		beColumn;
		separation: 5;
		axisEdgeWeight: 0;
		addMorph: (self build1stRow);
		addMorph: (self build2ndRow).! !

!CartWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 17:00:23'!
defaultExtent

	^ 1700@800! !


!CartWindow methodsFor: 'events' stamp: 'LB 11/27/2021 13:21:17'!
askForQuantityWindow	

	| askForQuantityWindow |
	askForQuantityWindow := PositiveIntegerEntryPanel default: 1 label: '  Cantidad'.
	askForQuantityWindow 	morphExtent: (300@140);
		showButtonsNamed: #( close );
		model: self model;
		openInWorld.! !

!CartWindow methodsFor: 'events' stamp: 'LB 11/27/2021 14:12:10'!
cartItemsChanged

	cartListMorph updateList.! !

!CartWindow methodsFor: 'events' stamp: 'LB 11/27/2021 15:10:18'!
eventListeners

	self model when: #askForQuantityToAdd send: #askForQuantityWindow to: self.
	self model when: #cartItemsChanged send: #cartItemsChanged to: self.
	self model when: #openTicket send: #openTicket: to: self.! !

!CartWindow methodsFor: 'events' stamp: 'LB 11/28/2021 21:52:05'!
openTicket: aTicketModel
	
	TicketWindow open: aTicketModel.
	self closeButtonClicked.! !


!CartWindow methodsFor: 'initialization' stamp: 'LB 11/27/2021 11:15:46'!
initializeWith: aTitle andModel: aModel
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	self eventListeners.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartWindow class' category: 'TusLibros-Client'!
CartWindow class
	instanceVariableNames: ''!

!CartWindow class methodsFor: 'as yet unclassified' stamp: 'LB 11/27/2021 10:24:04'!
open: aModel
	
	^self new initializeWith: 'Tus-Libros Selling Window' andModel: aModel.! !


!classDefinition: #LoginWindow category: 'TusLibros-Client'!
TusLibrosWindow subclass: #LoginWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:56:27'!
build1stRow

	^self 
		createTextFieldLabeled: 'User:'
		withGetter: #username
		andSetter: #username:.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:56:27'!
build2ndRow

	^self 
		createTextFieldLabeled: 'Password:'
		withGetter: #password
		andSetter: #password:.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/26/2021 20:34:02'!
build3rdRow
	| createCartButton listPurchasesButton |
	
	createCartButton := self
			createButtonLabeled: 'Create Cart'
			withAction: #createCartRequest.
			
	listPurchasesButton := self
			createButtonLabeled: 'List Purchases'
			withAction: #listPurchases.
	
	^LayoutMorph newRow
		separation: 50;
		axisEdgeWeight: 0.5;
		addMorph: createCartButton;
		addMorph: listPurchasesButton.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/18/2021 13:17:21'!
buildMorphicWindow
	
	self layoutMorph
		beColumn;
		separation: 5;
		axisEdgeWeight: 0;
		addMorph: (self build1stRow);
		addMorph: (self build2ndRow);
		addMorph: (self build3rdRow).! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:56:27'!
createTextFieldLabeled: aStringLabel withGetter: aGetter andSetter: aSetter
	| textBoxMorph |
	
	textBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: aGetter 
		textSetter: aSetter. 
	textBoxMorph innerTextMorph
		setProperty: #keyStroke:
		toValue: [:key| textBoxMorph innerTextMorph acceptContents].
	textBoxMorph  
		borderWidth: 1;
		borderColor: Color skyBlue;
		morphWidth: 250; morphHeight: 10. 
	
	^LayoutMorph newRow
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: aStringLabel);
		addMorph: textBoxMorph.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/20/2021 15:18:53'!
defaultExtent

	^ 500@400! !

!LoginWindow methodsFor: 'GUI building' stamp: 'LB 11/27/2021 10:11:50'!
eventListeners

	self model when: #validLogin send: #openCartWindow: to: self.
	self model when: #listPurchases send: #openListPurchasesWindow: to: self! !


!LoginWindow methodsFor: 'events' stamp: 'LB 11/27/2021 10:11:27'!
openCartWindow: aModel
	
	CartWindow open: aModel.
	self closeButtonClicked.! !

!LoginWindow methodsFor: 'events' stamp: 'LB 11/28/2021 19:15:10'!
openListPurchasesWindow: aTicketModel
	
	TicketWindow open: aTicketModel.
	self closeButtonClicked.! !


!LoginWindow methodsFor: 'initialization' stamp: 'LB 11/26/2021 20:26:27'!
initializeWith: aTitle
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LoginWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	self eventListeners.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Client'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'as yet unclassified' stamp: 'LB 11/17/2021 19:52:09'!
open
	
	^self new initializeWith: 'Tus-Libros Client Window'.! !


!classDefinition: #TicketWindow category: 'TusLibros-Client'!
TusLibrosWindow subclass: #TicketWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TicketWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:39:15'!
build1stRow
	
	^ self 
		createListFor: #adaptTicketToItemsList
		withIndexGetter: #productIndex
		andIndexSetter: #productIndex:
	:: morphHeight: 300;
		morphWidth: 900.! !

!TicketWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:33:15'!
build2ndRow
	
	^LabelMorph contents: 'Total: $', (self model total asString) ! !

!TicketWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:34:08'!
build3rdRow
	
	^self createButtonLabeled: 'Cerrar' withAction: #close.! !

!TicketWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:27:25'!
buildMorphicWindow
	
	self layoutMorph beColumn;
		separation: 15;
		axisEdgeWeight: 0;
		addMorph: self build1stRow;
		addMorph: self build2ndRow;
		addMorph: self build3rdRow.! !

!TicketWindow methodsFor: 'GUI building' stamp: 'LB 11/28/2021 19:39:04'!
defaultExtent

	^ 1000@500! !


!TicketWindow methodsFor: 'events' stamp: 'LB 11/28/2021 19:40:21'!
closeTicketAndOpenLogin
	
	LoginWindow open.
	self closeButtonClicked.! !

!TicketWindow methodsFor: 'events' stamp: 'LB 11/28/2021 19:40:57'!
eventListeners 
	
	self model 
		when: #closeTicketAndOpenLogin 
		send: #closeTicketAndOpenLogin
		to: self.! !


!TicketWindow methodsFor: 'initialization' stamp: 'LB 11/28/2021 19:40:40'!
initializeWith: aTitle andModel: aModel
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	self eventListeners.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketWindow class' category: 'TusLibros-Client'!
TicketWindow class
	instanceVariableNames: ''!

!TicketWindow class methodsFor: 'as yet unclassified' stamp: 'LB 11/28/2021 19:25:08'!
open: aModel
	
	self new initializeWith: 'Ticket' andModel: aModel.! !


!classDefinition: #CartWindowModel category: 'TusLibros-Client'!
Object subclass: #CartWindowModel
	instanceVariableNames: 'catalogSelectedIndex interface cartSelectedIndex catalog cartId itemToAdd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CartWindowModel methodsFor: 'actions' stamp: 'LB 11/27/2021 13:15:36'!
addItemToCart: anAmount
	
	interface add: anAmount of: itemToAdd toCart: 	cartId;
		onSuccess: [:unused | self triggerEvent: #cartItemsChanged]
	! !

!CartWindowModel methodsFor: 'actions' stamp: 'LB 11/28/2021 22:48:16'!
checkOutCart
	
	interface checkOutCart: cartId;
		onSuccess: [:ticket | 
			self 
				triggerEvent: #openTicket 
				with: (TicketWindowModel listingReceipt: ticket) ].! !

!CartWindowModel methodsFor: 'actions' stamp: 'LB 11/29/2021 10:51:08'!
listCart
	
	interface listCart: cartId;
		onSuccess: [:aCart | ^aCart ]! !

!CartWindowModel methodsFor: 'actions' stamp: 'LB 11/29/2021 10:51:08'!
removeItemFromCart
	| cart itemToRemove |
	
	cart := self listCart.
	cart isEmpty ifFalse:[
		itemToRemove := cart keys at: self cartSelectedIndex.
		interface 
			remove: (cart at: itemToRemove)
			of: itemToRemove
			toCart: cartId;
			onSuccess: [:unused | self triggerEvent: #cartItemsChanged ]
		].
	! !


!CartWindowModel methodsFor: 'actions support' stamp: 'LB 11/27/2021 14:53:18'!
askForQuantityToAdd
	
	itemToAdd := catalog keys at: self catalogSelectedIndex.
	
	self triggerEvent: #askForQuantityToAdd.! !

!CartWindowModel methodsFor: 'actions support' stamp: 'LB 11/27/2021 13:15:31'!
propertyValue: anAmount

	self addItemToCart: anAmount
	
	"Needed for the PositiveIntegerEntryPanel".! !


!CartWindowModel methodsFor: 'adapters' stamp: 'LB 11/29/2021 10:51:08'!
adaptCartToStringList
	
	^self listCart associations
		inject: OrderedCollection new 
		into: [:aList :anAsoc| 
			aList add: 
				anAsoc key , ' - Cantidad: ', anAsoc value asString;
			yourself ].! !

!CartWindowModel methodsFor: 'adapters' stamp: 'LB 11/27/2021 11:35:28'!
adaptCatalogToStringList
	
	^catalog associations 
		inject: OrderedCollection new 
		into: [:aList :aDict| 
			aList add: 
				aDict key, ' - ',
				(aDict value at: 'title'), ' --> Price: ',
				(aDict value at: 'price') asString;
			yourself ].! !


!CartWindowModel methodsFor: 'initialization' stamp: 'LB 11/29/2021 11:24:28'!
initializeWith: aCartId
	
	cartId:=aCartId.
	
	interface := TusLibrosClientRestInterface 
		errorHandling: ErrorMessageWindow handler.
	
	interface listCatalog;
		onSuccess: [:aCatalog | catalog := aCatalog ].
	
	catalogSelectedIndex := 1.
	cartSelectedIndex := 1.

	! !


!CartWindowModel methodsFor: 'list indexes' stamp: 'LB 11/20/2021 16:23:47'!
cartSelectedIndex
	^cartSelectedIndex! !

!CartWindowModel methodsFor: 'list indexes' stamp: 'LB 11/20/2021 16:23:56'!
cartSelectedIndex: anIndex
	cartSelectedIndex := anIndex.! !

!CartWindowModel methodsFor: 'list indexes' stamp: 'LB 11/20/2021 16:13:17'!
catalogSelectedIndex
	^catalogSelectedIndex.! !

!CartWindowModel methodsFor: 'list indexes' stamp: 'LB 11/20/2021 16:13:32'!
catalogSelectedIndex: anIndex
	catalogSelectedIndex := anIndex.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartWindowModel class' category: 'TusLibros-Client'!
CartWindowModel class
	instanceVariableNames: ''!

!CartWindowModel class methodsFor: 'instance creation' stamp: 'LB 11/27/2021 10:13:23'!
with: aCartId 
	
	^self new initializeWith: aCartId ! !


!classDefinition: #TicketWindowModel category: 'TusLibros-Client'!
Object subclass: #TicketWindowModel
	instanceVariableNames: 'productIndex interface catalogue ticket total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TicketWindowModel methodsFor: 'list indexes' stamp: 'LB 11/28/2021 19:20:50'!
productIndex
	
	^productIndex! !

!TicketWindowModel methodsFor: 'list indexes' stamp: 'LB 11/28/2021 19:21:04'!
productIndex: anIndex
	
	productIndex := anIndex.! !


!TicketWindowModel methodsFor: 'initialization' stamp: 'LB 11/28/2021 19:54:28'!
initializeListingPurchasesOf: aClientId with: aPassword 
	
	self initializeTicket.
	interface listPurchasesOf: aClientId with: aPassword;
		onSuccess: [:purchases | 
			ticket := purchases at: 'items'.
			(purchases includesKey: 'total') 
				ifTrue:[total := purchases at: 'total']
				ifFalse:[total := 0]
			].! !

!TicketWindowModel methodsFor: 'initialization' stamp: 'LB 11/28/2021 19:58:10'!
initializeTicket
	
	productIndex := 1.
	interface := TusLibrosClientRestInterface 
		errorHandling: ErrorMessageWindow handler.
	interface listCatalog;
		onSuccess: [:aCatalog | 
			catalogue := aCatalog].! !

!TicketWindowModel methodsFor: 'initialization' stamp: 'LB 11/28/2021 20:31:23'!
initializelistingReceipt: aTicket
	
	self initializeTicket.
	ticket := aTicket at: 'items'.
			(aTicket includesKey: 'total') 
				ifTrue:[total := aTicket at: 'total']
				ifFalse:[total := 0]! !


!TicketWindowModel methodsFor: 'closing' stamp: 'LB 11/28/2021 19:40:05'!
close
	
	self triggerEvent: #closeTicketAndOpenLogin! !


!TicketWindowModel methodsFor: 'accessing' stamp: 'LB 11/28/2021 19:21:12'!
ticket
	
	^ticket! !

!TicketWindowModel methodsFor: 'accessing' stamp: 'LB 11/28/2021 19:21:22'!
total
	
	^total! !


!TicketWindowModel methodsFor: 'support' stamp: 'LB 11/28/2021 19:58:21'!
nameOf: itemISBN
	| item |
	item := catalogue associations 
		detect: [:anAsoc | anAsoc key = itemISBN] 
		ifNone: [^''].
	^item value at: 'title'.! !

!TicketWindowModel methodsFor: 'support' stamp: 'LB 11/28/2021 19:58:29'!
priceOf: itemISBN
	| item |
	item := catalogue associations 
		detect: [:anAsoc | anAsoc key = itemISBN] 
		ifNone: [^0].
	^item value at: 'price'.! !


!TicketWindowModel methodsFor: 'adapters' stamp: 'LB 11/28/2021 19:57:32'!
adaptTicketToItemsList
	
	^ticket keys 
		inject: OrderedCollection new 
		into: [:aList :item |
			aList add: 'Cantidad: ', (ticket at: item) asString , ' - ',
			 'Precio (c/u): $', (self priceOf: item) asString, ' - ', 
			(self nameOf: item) 
			;yourself.
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketWindowModel class' category: 'TusLibros-Client'!
TicketWindowModel class
	instanceVariableNames: ''!

!TicketWindowModel class methodsFor: 'instance creation' stamp: 'LB 11/28/2021 19:16:45'!
listingPurchasesOf: aClientId with: aPassword 
	
	^self new initializeListingPurchasesOf: aClientId with: aPassword ! !

!TicketWindowModel class methodsFor: 'instance creation' stamp: 'LB 11/28/2021 20:30:15'!
listingReceipt: aTicket
	
	^self new initializelistingReceipt: aTicket. ! !


!classDefinition: #TusLibrosClientRestInterface category: 'TusLibros-Client'!
Object subclass: #TusLibrosClientRestInterface
	instanceVariableNames: 'port requestWasSuccessful handler requestResponse'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientRestInterface methodsFor: 'request handling' stamp: 'LB 11/29/2021 10:34:30'!
adaptResponseToErrorText: aResponse
	| commonPrefixes errorMessage |
	
	errorMessage := aResponse content asUnHtml.
	commonPrefixes := #('400 Bad Request400 Bad Request' '404 Not Found404 Not Found' ).
	commonPrefixes do: [:prefix|
		(errorMessage beginsWith: prefix) 
			ifTrue: [errorMessage := errorMessage withoutPrefix: prefix]	
	].
	^errorMessage
	
	
	
	! !

!TusLibrosClientRestInterface methodsFor: 'request handling' stamp: 'LB 11/27/2021 13:29:50'!
onSuccess: aSuccessBehaviour 

	requestWasSuccessful 
		ifTrue: [aSuccessBehaviour value: requestResponse	].! !

!TusLibrosClientRestInterface methodsFor: 'request handling' stamp: 'LB 11/28/2021 22:45:11'!
sendRequestTo: anEndpoint with: aParametersDictionary method: aHttpMethod 
	| resp |
	
	resp := WebClient
		htmlSubmit: (self url , anEndpoint)
		fields: (self santitizeValuesOf: aParametersDictionary)
		method: aHttpMethod. 
	
	resp isSuccess 
		ifTrue:[ 
			requestWasSuccessful := true.
			requestResponse := WebUtils jsonDecode: resp content readStream ] 
		ifFalse:[ 
			requestWasSuccessful := false.
			handler value: (self adaptResponseToErrorText: resp) ].! !


!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/27/2021 13:35:34'!
add: anAmount of: anItem toCart: aCartId
	| fieldDict |
	
	fieldDict := Dictionary new
		add: 'cartId' -> aCartId;
		add: 'bookIsbn' -> anItem;
		add: 'bookQuantity' -> anAmount;
		yourself.
	
	self sendRequestTo: '/addToCart' with: fieldDict method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/28/2021 20:28:13'!
checkOutCart: aCartId
	| fieldDict |
	
	fieldDict := Dictionary new
		add: 'cartId' -> aCartId;
		yourself.
	
	self sendRequestTo: '/checkOutCart' with: fieldDict method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/27/2021 13:29:31'!
createCartFor: username and: password
	| fieldDict |

	fieldDict := Dictionary new.
	fieldDict add:'clientId' -> username.
	fieldDict add:'password' -> password.		
	
	self sendRequestTo: '/createCart' with: fieldDict method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/27/2021 14:17:27'!
listCart: aCartId
	| fieldDict |
	
	fieldDict := Dictionary new
		add: 'cartId' -> aCartId;
		yourself.
	
	self sendRequestTo: '/listCart' with: fieldDict method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/20/2021 16:48:28'!
listCatalog
	
	self sendRequestTo: '/listCatalog' with: Dictionary new method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/28/2021 19:13:17'!
listPurchasesOf: username with: password
	| fieldDict |

	fieldDict := Dictionary new.
	fieldDict add:'clientId' -> username.
	fieldDict add:'password' -> password.		
	
	self sendRequestTo: '/listPurchases' with: fieldDict method: 'GET'.! !

!TusLibrosClientRestInterface methodsFor: 'request sending' stamp: 'LB 11/27/2021 14:58:07'!
remove: anAmount of: anItem toCart: aCartId
	| fieldDict |
	
	fieldDict := Dictionary new
		add: 'cartId' -> aCartId;
		add: 'bookIsbn' -> anItem;
		add: 'bookQuantity' -> anAmount;
		yourself.
	
	self sendRequestTo: '/removeFromCart' with: fieldDict method: 'GET'.! !


!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'LB 11/27/2021 10:02:18'!
initializeErrorHandling: aHandler 
	
	handler := aHandler.! !

!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'LB 11/18/2021 14:07:33'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'LB 11/18/2021 14:07:33'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosClientRestInterface methodsFor: 'support' stamp: 'LB 11/27/2021 13:27:54'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	aParameter isString
		ifTrue: [^aParameter copyReplaceAll: ' ' with: '%20' ].
	^aParameter.! !

!TusLibrosClientRestInterface methodsFor: 'support' stamp: 'LB 11/20/2021 16:45:43'!
santitizeValuesOf: aParametersDictionary

	^aParametersDictionary 
		collect: [:aValue| 		self correctlyEncodeSpacesForUrlRequestParameter: aValue]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientRestInterface class' category: 'TusLibros-Client'!
TusLibrosClientRestInterface class
	instanceVariableNames: ''!

!TusLibrosClientRestInterface class methodsFor: 'instance creation' stamp: 'LB 11/27/2021 10:02:06'!
errorHandling: aHandler 
	
	^self new initializeErrorHandling: aHandler ! !
