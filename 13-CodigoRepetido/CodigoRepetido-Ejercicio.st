!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/8/2021 20:31:22'!
executionOf: aBlock takesLessThan: aTimeDifference

| millisecondsBeforeRunning millisecondsAfterRunning difference | 
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	difference := millisecondsAfterRunning  - millisecondsBeforeRunning.
	
	^ difference < aTimeDifference.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/8/2021 20:09:33'!
tryToExecute: aBlock raises: anException

	[aBlock value. self fail.]
		on: anException
		do: [ :anError | ^anError]! !


!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:32:34'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addCustomerJohnLennon |
	
	customerBook := CustomerBook new.
	
	addCustomerJohnLennon := [customerBook addCustomerNamed: 'John Lennon'].

	self assert: (self executionOf: addCustomerJohnLennon takesLessThan: 50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:33:06'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook removeCustomerPaul paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	removeCustomerPaul := [customerBook removeCustomerNamed: paulMcCartney.].
	
	self assert: (self executionOf: removeCustomerPaul takesLessThan: 100 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:12:29'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook addCustomerWithEmptyName errorMessage|
			
	customerBook := CustomerBook new.

	addCustomerWithEmptyName := [ customerBook addCustomerNamed: ''].
	errorMessage := self tryToExecute: addCustomerWithEmptyName raises: Error.

	self assert: errorMessage messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:19:39'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon removeInvalidCustomer |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	removeInvalidCustomer := [ customerBook removeCustomerNamed: 'Paul McCartney'.].
	self tryToExecute: removeInvalidCustomer raises: NotFound.
	
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:24:55'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon suspendInvalidCustomer |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	suspendInvalidCustomer := [ customerBook suspendCustomerNamed: 'George Harrison'.].
	
	self tryToExecute: suspendInvalidCustomer raises: CantSuspend.
	
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/8/2021 20:26:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon suspendInvalidCustomer |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	suspendInvalidCustomer := [ customerBook suspendCustomerNamed: johnLennon.].
	
	self tryToExecute: suspendInvalidCustomer raises: CantSuspend.
	
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon).
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'LR 9/8/2021 20:49:50'!
initialize

	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/8/2021 21:02:54'!
addCustomerNamed: aName

	self checkNotEmptyName: aName.
	self checkCustomerNotExists: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/8/2021 21:02:54'!
checkCustomerNotExists: aName

	^ (self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/8/2021 21:02:17'!
checkNotEmptyName: aName

	^ aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/8/2021 21:39:14'!
removeCustomer: aName from: aList ifAbsent: aClosure
 
	1 to: aList size do: 
	[ :index |
		aName = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				^aName 
			] 
	].

	aClosure value.! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/8/2021 21:47:51'!
removeCustomerNamed: aName 

	^ self removeCustomer: aName  from: active  ifAbsent: [self removeCustomer: aName from: suspended ifAbsent: [ ^ NotFound signal. ] ].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
