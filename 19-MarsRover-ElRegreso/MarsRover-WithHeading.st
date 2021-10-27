!classDefinition: #MarsRoverObserverTester category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTester
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:17:25'!
test01OnePositionChangeIsObservedByPositionLogger
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger := MarsRoverLogger new.
	marsRover addPositionObserver: logger.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: (logger at: 1).
	self assert: 1 equals: logger size.! !

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:17:19'!
test02MultiplePositionChangesAreObservedByPositionLogger
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger := MarsRoverLogger new.
	marsRover addPositionObserver: logger.
	
	marsRover process: 'ff'.
	
	self assert: 1@2 equals: (logger at: 1).
	self assert: 1@3 equals: (logger at: 2).
	self assert: 2 equals: logger size.! !

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:17:35'!
test03OnePositionChangeIsNotObservedByHeadingLogger
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger := MarsRoverLogger new.
	marsRover addHeadingObserver: logger.
	
	marsRover process: 'f'.
	
	self assert: 0 equals: logger size.! !

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:18:22'!
test04OneRotationChangeIsObservedByRotationLogger
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger := MarsRoverLogger new.
	marsRover addHeadingObserver: logger.
	
	marsRover process: 'r'.
	
	self assert: 'East' equals: (logger at: 1).
	self assert: 1 equals: logger size.! !

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:19:17'!
test05MultipleChangesAreObservedByPositionAndHeadingObservers
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger := MarsRoverLogger new.
	marsRover addPositionObserver: logger.
	marsRover addHeadingObserver: logger.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: (logger at: 1).
	self assert: 'East' equals: (logger at: 2).
	self assert: 2 equals: logger size.! !

!MarsRoverObserverTester methodsFor: 'tests - logger' stamp: 'LB 10/27/2021 20:22:01'!
test06PositionAndHeadingLoggerCanObserveAllHeadingChanges
	
	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	logger := MarsRoverLogger new.
	marsRover addPositionObserver: logger.
	marsRover addHeadingObserver: logger.
	
	marsRover process: 'frfrfr'.
	
	self assert: 2@1 equals: (logger at: 1).
	self assert: 'South' equals: (logger at: 2).
	self assert: 2@0 equals: (logger at: 3).
	self assert: 'West' equals: (logger at: 4).
	self assert: 1@0 equals: (logger at: 5).
	self assert: 'North' equals: (logger at: 6).
	self assert: 6 equals: logger size.! !


!MarsRoverObserverTester methodsFor: 'tests - window' stamp: 'LB 10/27/2021 20:41:13'!
test07OnePositionChangeIsObservedByWindow
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: window positionField.! !

!MarsRoverObserverTester methodsFor: 'tests - window' stamp: 'LB 10/27/2021 20:41:46'!
test08EmptyPositionFieldOfWindowRaisesPositionHasNotBeenUpdatedYetError
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.
	
	marsRover process: 'r'.
	
	self should: [window positionField]  
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 	[:error| self assert: MarsRoverWindow positionHasNotBeenUpdatedYet equals: error messageText]! !

!MarsRoverObserverTester methodsFor: 'tests - window' stamp: 'LB 10/27/2021 20:41:57'!
test09EmptyHeadingFieldOfWindowRaisesHeadingHasNotBeenUpdatedYetError
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	marsRover addHeadingObserver: window.
	
	marsRover process: 'f'.
	
	self should: [window headingField]  
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 	[:error| self assert: MarsRoverWindow headingHasNotBeenUpdatedYet equals: error messageText]! !

!MarsRoverObserverTester methodsFor: 'tests - window' stamp: 'LB 10/27/2021 20:42:06'!
test10OneHeadingChangeIsObservedByWindow
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	marsRover addHeadingObserver: window.
	
	marsRover process: 'r'.
	
	self assert: 'East' equals: window headingField.! !

!MarsRoverObserverTester methodsFor: 'tests - window' stamp: 'LB 10/27/2021 20:44:36'!
test11WindowObservesCorrectlySimultaneousPositionAndHeadingChange
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.
	marsRover addHeadingObserver: window.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: window positionField.
	self assert: 'East' equals: window headingField.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LB 10/27/2021 20:07:11'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionObservers := OrderedCollection new.
	headingObservers  := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 18:47:37'!
changeHeadTo: aNewHeading.
	
	head := aNewHeading.
	self notifyHeadingObservers.! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:11:08'!
headEast
	
	self changeHeadTo: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:11:14'!
headNorth
	
	self changeHeadTo: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:11:19'!
headSouth
	
	self changeHeadTo: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:11:24'!
headWest
	
	self changeHeadTo: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:10:26'!
rotateLeft
	
	head rotateLeft.! !

!MarsRover methodsFor: 'heading' stamp: 'LB 10/27/2021 14:10:30'!
rotateRight
	
	head rotateRight.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:22'!
moveBackward
	
	head moveBackward.! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:06'!
moveEast
	
	self movePositionWith: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:28'!
moveForward
	
	head moveForward.! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:00'!
moveNorth
	
	self movePositionWith: (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 18:43:31'!
movePositionWith: anOffset
	
	position := position + anOffset.
	self notifyPositionObservers.! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:11'!
moveSouth
	
	self movePositionWith: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'LB 10/27/2021 14:08:16'!
moveWest
	
	self movePositionWith: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'LB 10/27/2021 20:04:36'!
addHeadingObserver: aHeadingObserver 
	
	headingObservers add: aHeadingObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'LB 10/27/2021 20:04:24'!
addPositionObserver: aPositionObserver 
	
	positionObservers add: aPositionObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'LB 10/27/2021 19:23:10'!
notifyHeadingObservers
	
	headingObservers do: [:anObserver | anObserver updateHeading: head printString].! !

!MarsRover methodsFor: 'observers' stamp: 'LB 10/27/2021 19:20:52'!
notifyPositionObservers

	positionObservers do: [:anObserver | anObserver updatePosition: position].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'print' stamp: 'LB 10/27/2021 15:24:11'!
printString

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'print' stamp: 'LB 10/27/2021 15:24:11'!
printString

	^'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'print' stamp: 'LB 10/27/2021 15:24:11'!
printString

	^'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'print' stamp: 'LB 10/27/2021 15:24:11'!
printString

	^'South'.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'print' stamp: 'LB 10/27/2021 15:24:11'!
printString

	^'West'.! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'update' stamp: 'LB 10/27/2021 19:29:07'!
updateHeading: aMarsRoverHeadingAsString
	
	self subclassResponsibility.! !

!MarsRoverObserver methodsFor: 'update' stamp: 'LB 10/27/2021 19:29:20'!
updatePosition: aPosition
	
	self subclassResponsibility.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'LB 10/27/2021 17:24:59'!
initialize

	log := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'update' stamp: 'LB 10/27/2021 19:02:57'!
updateHeading: aMarsRoverHeadingAsString
	
	log add: aMarsRoverHeadingAsString.! !

!MarsRoverLogger methodsFor: 'update' stamp: 'LB 10/27/2021 18:53:21'!
updatePosition: aPosition
	
	log add: aPosition.! !


!MarsRoverLogger methodsFor: 'accessing' stamp: 'LB 10/27/2021 18:54:12'!
at: anIndex
	
	^log at: anIndex.! !

!MarsRoverLogger methodsFor: 'accessing' stamp: 'LB 10/27/2021 18:54:43'!
size
	
	^log size.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'update' stamp: 'LB 10/27/2021 19:16:35'!
updateHeading: aMarsRoverHeadingAsString
	
	heading := aMarsRoverHeadingAsString.! !

!MarsRoverWindow methodsFor: 'update' stamp: 'LB 10/27/2021 19:12:02'!
updatePosition: aPosition 
	
	position := aPosition.! !


!MarsRoverWindow methodsFor: 'accessing' stamp: 'LB 10/27/2021 20:37:02'!
headingField
	
	heading ifNotNil: [^heading].
	self error: self class headingHasNotBeenUpdatedYet.! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'LB 10/27/2021 20:31:18'!
positionField
	
	position ifNotNil: [^position].
	self error: self class positionHasNotBeenUpdatedYet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'LB 10/27/2021 20:29:14'!
headingHasNotBeenUpdatedYet
	
	^'Heading has not been updated yet'.! !

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'LB 10/27/2021 20:29:22'!
positionHasNotBeenUpdatedYet
	
	^'Position has not been updated yet'.! !
