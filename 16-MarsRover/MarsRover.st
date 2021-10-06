!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:16:05'!
test01processAMarsRoverWithEmptyStringDoNothing
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:24:01'!
test02processAMarsRoverPointingNorthWithCommandFMoveForwardOneStepToNorth
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: North).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:24:26'!
test03processAMarsRoverPointingNorthWithCommandBMoveBackwardOneStepToNorth
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:25:58'!
test04processAMarsRoverPointingNorthWithCommandLRotateOnceToLeft
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: West).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:26:21'!
test05processAMarsRoverPointingNorthWithCommandRRotateOnceToRight
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:27:12'!
test05processAMarsRoverPointingSouthWithCommandLRotateOnceToLeft
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:27:49'!
test07processAMarsRoverPointingSouthWithCommandRRotateOnceToRight
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: West)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:28:56'!
test08processAMarsRoverPointingEastWithCommandFMoveForwardOneStepToEast
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: East)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:29:48'!
test09processAMarsRoverPointingWestWithCommandFMoveForwardOneStepToWest
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 heading: West)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:30:31'!
test10processAMarsRoverPointingSouthWithCommandFMoveForwardOneStepToSouth
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 heading: South)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:31:00'!
test11processAMarsRoverPointingSouthWithCommandBMoveBackwardOneStepToSouth
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@3 heading: South)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:31:17'!
test12processAMarsRoverPointingWestWithCommandBMoveBackwardOneStepToWest
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 2@2 heading: West)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'LB 10/6/2021 10:32:11'!
test13processAMarsRoverWithAnErrorCommandStopsProcessing

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'fwf'.
	
	self assert: (marsRover isAt: 1@3 heading: North)! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:02:22'!
rotateLeft

	^self subclassResponsibility.! !

!CardinalDirection class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:02:15'!
rotateRight

	^self subclassResponsibility.! !


!CardinalDirection class methodsFor: 'coordinates' stamp: 'sm 10/5/2021 14:26:17'!
stepCoordinate

	^self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:02:05'!
rotateLeft
	^North.! !

!East class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:02:00'!
rotateRight

	^South.! !


!East class methodsFor: 'coordinates' stamp: 'sm 10/5/2021 14:27:01'!
stepCoordinate

	^(1@0).! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:55'!
rotateLeft
	^West.! !

!North class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:49'!
rotateRight

	^East.! !


!North class methodsFor: 'coordinates' stamp: 'sm 10/5/2021 14:27:12'!
stepCoordinate

	^(0@1).! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:42'!
rotateLeft
	^East.! !

!South class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:17'!
rotateRight

	^West.! !


!South class methodsFor: 'coordinates' stamp: 'sm 10/5/2021 14:27:32'!
stepCoordinate

	^(0@-1).! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:34'!
rotateLeft
	^South.! !

!West class methodsFor: 'rotations' stamp: 'sm 10/5/2021 14:01:29'!
rotateRight

	^North.! !


!West class methodsFor: 'coordinates' stamp: 'sm 10/5/2021 14:27:54'!
stepCoordinate

	^(-1@0).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'LB 10/4/2021 21:15:30'!
initializeAt: aPosition heading: aDirection 
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'movement' stamp: 'sm 10/5/2021 14:38:00'!
moveBackward
		position := position - (direction stepCoordinate).! !

!MarsRover methodsFor: 'movement' stamp: 'sm 10/5/2021 14:30:55'!
moveForward
		position := position + (direction stepCoordinate).! !


!MarsRover methodsFor: 'position and direction' stamp: 'LB 10/4/2021 21:16:17'!
isAt: aPosition heading: aDirection 
	^(position = aPosition) and: (direction = aDirection).
	! !


!MarsRover methodsFor: 'processing' stamp: 'LB 10/5/2021 22:43:27'!
process: aSequenceOfCommands 
	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ifInvalid: [^self]		].! !

!MarsRover methodsFor: 'processing' stamp: 'LB 10/5/2021 22:43:09'!
processCommand: aCommand ifInvalid: anErrorBlock
	(aCommand = $f) ifTrue: [^self moveForward.].
	(aCommand = $b) ifTrue: [^self moveBackward.]. 
	(aCommand = $l) ifTrue: [^self turnLeft.].
	(aCommand = $r) ifTrue: [^self turnRight.].
	anErrorBlock value.! !


!MarsRover methodsFor: 'turn' stamp: 'sm 10/5/2021 13:53:15'!
turnLeft

	direction:=direction rotateLeft.! !

!MarsRover methodsFor: 'turn' stamp: 'sm 10/5/2021 13:53:30'!
turnRight

	direction:=direction rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LB 10/4/2021 20:53:14'!
at: aPoint heading: aSymbol 
	^self new initializeAt: aPoint heading: aSymbol ! !
