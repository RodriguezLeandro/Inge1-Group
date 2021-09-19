!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'LB 9/16/2021 21:10:28'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'LR 9/19/2021 15:56:04'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:57:30'!
test01SentenceFinderPrefixCannotBeEmpty

	|sentenceFinder stack |
	
	stack := OOStack new.
	stack push: 'Sentence 1'.
	stack push: 'Sentence 2'.
	stack push: 'Sentence 3'.
	stack push: 'Sentence 4'.
			
	sentenceFinder := SentenceFinderByPrefix with: stack.
	
	self
		should: [ sentenceFinder find:'' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:28:04'!
test02SentenceFinderFilterByWintPrefix

	|sentenceFinder stack res |
	
	stack := OOStack new.
	stack push: 'Winter is coming'.
	stack push: 'winter is not coming'.
	stack push: 'Windows 10 better than linux'.
	stack push: 'Winning Inge1 promotion by team 4'.
			
	sentenceFinder := SentenceFinderByPrefix with: stack.
	
	res := sentenceFinder find:'Wint'.
	self assert: res first equals: 'Winter is coming'.
	self assert: res size equals: 1.		! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:36:47'!
test03SentenceFinderPrefixCannotHaveSpaces

	|sentenceFinder stack |
	
	stack := OOStack new.
	stack push: 'Sentence 1'.
	stack push: 'Sentence 2'.
	stack push: 'Sentence 3'.
	stack push: 'Sentence 4'.
			
	sentenceFinder := SentenceFinderByPrefix with: stack.
	
	self
		should: [ sentenceFinder find:'This prefix has spaces' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:46:07'!
test04SentenceFinderIsCaseSensitive

	|sentenceFinder stack res |
	
	stack := OOStack new.
	stack push: 'Winter is coming'.
	stack push: 'Winter is not coming'.
	stack push: 'Windows 10 better than linux'.
	stack push: 'Winning Inge1 promotion by team 4'.
			
	sentenceFinder := SentenceFinderByPrefix with: stack.
	
	res := sentenceFinder find:'wint'.
	self assert: res size equals: 0.		! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:50:10'!
initialize
	size := 0.
	top := HanoiBase new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:51:51'!
isEmpty
	^size = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:12:15'!
pop
	|prev|
	size := size - 1.
	prev := top.
	top := top previous.
	
	^prev value.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:05:20'!
push: anElement
	size := size + 1.
	top := HanoiElement with: anElement and: top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:58:09'!
size
	^size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:13:10'!
top
	^top value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'LB 9/16/2021 20:54:57'!
stackEmptyErrorDescription
	
	^ 'this collection is empty'! !


!classDefinition: #OOStackHanoi category: 'Stack-Exercise'!
Object subclass: #OOStackHanoi
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #HanoiBase category: 'Stack-Exercise'!
OOStackHanoi subclass: #HanoiBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!HanoiBase methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:31:43'!
previous
	self error: OOStack stackEmptyErrorDescription.! !

!HanoiBase methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:31:48'!
value
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #HanoiElement category: 'Stack-Exercise'!
OOStackHanoi subclass: #HanoiElement
	instanceVariableNames: 'previous value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!HanoiElement methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:57:46'!
initializeWith: aValue and: aPrevious
	value := aValue.
	previous := aPrevious.! !

!HanoiElement methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:43:27'!
previous
	^previous.! !

!HanoiElement methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 16:43:35'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HanoiElement class' category: 'Stack-Exercise'!
HanoiElement class
	instanceVariableNames: ''!

!HanoiElement class methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:10:30'!
with: value and: previous
	^HanoiElement new initializeWith: value and: previous.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:32:49'!
InitializeWith: anOOStack
	stack := anOOStack.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:44:36'!
find: aPrefix

	|anOrderedCollection sentence|

	aPrefix isEmpty ifTrue: [self error: SentenceFinderByPrefix prefixEmptyErrorDescription].
	
	(aPrefix allSatisfy: [:a | a isAlphaNumeric ]) ifFalse: [self error: SentenceFinderByPrefix prefixWithSpacesErrorDescription].
	
	anOrderedCollection := OrderedCollection new.
	
	[stack size > 0] whileTrue: [
			sentence := stack pop	.
			
			(sentence copyFrom: 1 to: aPrefix size) = aPrefix ifTrue: [
				anOrderedCollection addFirst: sentence.
				].
		].
	
	^ anOrderedCollection.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:58:49'!
prefixEmptyErrorDescription
	^'this prefix is empty'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 18:37:09'!
prefixWithSpacesErrorDescription
	^'this prefix has spaces'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LR 9/19/2021 17:49:41'!
with: anOOStack
	^SentenceFinderByPrefix new InitializeWith: anOOStack.! !
