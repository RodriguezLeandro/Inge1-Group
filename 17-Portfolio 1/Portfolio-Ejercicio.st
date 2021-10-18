!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'tests - balance' stamp: 'LB 10/12/2021 10:37:55'!
test01ANewPortfolioBalanceIsZero
	| portfolio balance |
	
	portfolio := Portfolio new.
	
	balance := portfolio balance.
	
	self assert: 0 equals: balance.! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'LB 10/18/2021 12:57:06'!
test02APortfolioWithAccountBalanceIsEqualToAccountBalance
	| portfolio balance account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	balance := portfolio balance.
	
	self assert: 100 equals: balance.
! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'LB 10/18/2021 12:57:44'!
test03ANewPorfolioWithOtherNewPortfolioBalanceIsZero
	| portfolio portfolioAAgregar balance |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	portfolio add: portfolioAAgregar.
	
	balance := portfolio balance.
	
	self assert: 0 equals: balance.
! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'LB 10/18/2021 12:59:56'!
test04APortfolioWithMoreThanOneAccountsBalanceIsEqualToSumOfAccountBalance
	| portfolio balance account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	balance := portfolio balance.
	
	self assert: 150 equals: balance.
! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'LB 10/18/2021 13:00:59'!
test05APortfolioWithAPortfolioWithAnAccountBalanceIsAccountBalance
	| portfolio portfolioAAgregar balance account1 |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	portfolioAAgregar add: account1.
	
	portfolio add: portfolioAAgregar.
	
	balance := portfolio balance.
	
	self assert: 100 equals: balance.! !


!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:01:55'!
test06ANewPortfolioTransactionsIsEmpty
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions) isEmpty.! !

!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:02:43'!
test07APortfolioWithAnAccountTransactionsIsEqualToAccountTransactions
	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	self assert: account transactions equals: portfolio transactions.
! !

!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:03:43'!
test08APortfolioWithAPortfolioWithAnAccountTransactionsIsEqualToAccountTransactions
	| portfolio portfolioAAgregar account |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolioAAgregar add: account.
	
	portfolio add: portfolioAAgregar.
	
	self assert: account transactions equals: portfolio transactions.! !

!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:04:52'!
test09APortfolioWithAPortfolioWithMoreThanOneAccountsTransactionsIsEqualToTransactionsOfAllAccounts
	| portfolio portfolioAAgregar account1 account2 |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolioAAgregar add: account1.	
	portfolio add: account2.
	
	portfolio add: portfolioAAgregar.
	
	self assert: (account2 transactions, account1 transactions) equals: portfolio transactions.! !

!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:05:36'!
test10APortfolioWithMoreThanOneAccountTransactionsIsEqualToTransactionsOfAllAccounts
	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: (account1 transactions, account2 transactions) equals: portfolio transactions.
! !

!PortfolioTests methodsFor: 'tests - transactions' stamp: 'LB 10/18/2021 13:07:40'!
test11APortfolioWithMoreThanOnePortfoliosWhereEachOneHasAnAccountTransactionsIsEqualToTransactionsOfAllAccounts
	| portfolio portfolioToAdd1 portfolioToAdd2 account1 account2 |
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	portfolioToAdd2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	
	portfolioToAdd1 add: account1.	
	portfolioToAdd2 add: account2.	
	
	portfolio add: portfolioToAdd1.
	portfolio add: portfolioToAdd2.
	
	self assert: (account1 transactions, account2 transactions) equals: portfolio transactions.! !


!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:10:20'!
test12APortfolioWithoutAnAccountWithATransactionHasNotRegisteredTheTransaction
	| portfolio aTransaction account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aTransaction := (account transactions) first.
	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:10:00'!
test13APortfolioWithAnAccountWithATransactionHasRegisteredTheTransaction
	| portfolio aTransaction account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aTransaction := (account transactions) first.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:11:34'!
test14APortfolioWithoutMoreThanOneAccountWhereEachOneHasAtransactionHasNotRegisteredAnyTransaction
	| portfolio aTransaction1 account1 aTransaction2 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	aTransaction1 := (account1 transactions) first.
	aTransaction2 := (account2 transactions) first.
	
	portfolio add: account1.
	
	self deny: (portfolio hasRegistered: aTransaction2).! !

!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:12:18'!
test15APortfolioWithAnAccountWithATransactionHasRegisteredTheTransaction
	| portfolio portfolioAAgregar account aTransaction |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	aTransaction := (account transactions) first.
	
	portfolioAAgregar add: account.
	
	portfolio add: portfolioAAgregar.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:12:54'!
test16APortfolioWithMoreThanOneAccountWhereEachOneHasATransactionHasRegisteredTheLastAddedAccountTransaction
	| portfolio aTransaction1 account1 aTransaction2 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	aTransaction1 := (account1 transactions) first.
	aTransaction2 := (account2 transactions) first.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: (portfolio hasRegistered: aTransaction2).! !

!PortfolioTests methodsFor: 'tests - has registered' stamp: 'LB 10/18/2021 13:14:01'!
test17APortfolioWithMoreThanOnPortfolioWhereEachOneHasAnAccountWhereEachOneHasATransactionHasRegisteredTheLastTransaction
	| portfolio portfolioAAgregar1 portfolioAAgregar2 account1 account2 aTransaction1 aTransaction2 |
	
	portfolio := Portfolio new.
	portfolioAAgregar1 := Portfolio new.
	portfolioAAgregar2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	aTransaction1 := (account1 transactions) first.
	portfolioAAgregar1 add: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	aTransaction2 := (account2 transactions) first.
	portfolioAAgregar2 add: account2.
	
	portfolio add: portfolioAAgregar1.
	portfolio add: portfolioAAgregar2.
	
	self assert: (portfolio hasRegistered: aTransaction2).! !


!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:16:55'!
test18APortfolioCanNotHaveHisUniqueChildAssetDuplicated
	| portfolio account |
	
	"	|p|
		/ \
		|a|    "
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [portfolio add: account.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:16:48'!
test19APortfolioCanNotHaveAnyOfHisChildAssetsDuplicated
	| portfolio account1 account2 |
	
	"	 |p|
		/ \ \
	 |a1| |a2|   "
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account1.
	portfolio add: account2.
	
	self should: [portfolio add: account2.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:17:25'!
test20APortfolioCanNotHaveItselfAsChildAsset
	| portfolio |
	
	"	|p|
		 |
		|p|    "
	
	portfolio := Portfolio new.
	
	
	self should: [portfolio add: portfolio.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:19:56'!
test21APortfolioCanNothaveALoopWithHisChild
	| rootPortfolio childPortfolio |
	
	"	|rP|
	     | ^
		 v |
		 |cP|    "
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	rootPortfolio add: childPortfolio.
	
	self should: [childPortfolio add: rootPortfolio.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:21:52'!
test22APortfolioCanNotBeFatherOfAnyOfHisDescendentsAppartFromHisChilds
	| rootPortfolio childPortfolio middlePortfolio |
	
	"	|rP|_
		 |   \
		|mP| |   
		 |   / 
		|cP|<   	"
	
	rootPortfolio := Portfolio new.
	middlePortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	middlePortfolio add: childPortfolio.
	rootPortfolio add: middlePortfolio.
	
	self should: [rootPortfolio add: childPortfolio.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:21:20'!
test23APortfolioCantNotBeChildOfAnyOfHisDescendents
	| rootPortfolio childPortfolio middlePortfolio |
	
	"	|rP|<
		 |   \
		|mP| |   
		 |   / 
		|cP|	/	"
		
	rootPortfolio := Portfolio new.
	middlePortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	middlePortfolio add: childPortfolio.
	rootPortfolio add: middlePortfolio.
	
	self should: [childPortfolio add: rootPortfolio.] raise: Error withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:22:39'!
test24APortfolioCanNotHaveAChildAsHisGrandchild
	| rootPortfolio childPortfolio anotherChildPortfolio |
	
	"	|rP|
		/  \
	 |cP|--|aP| "
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	anotherChildPortfolio := Portfolio new.
	
	rootPortfolio add: childPortfolio.
	rootPortfolio add: anotherChildPortfolio.
	
	self
		should: [	childPortfolio add: anotherChildPortfolio]
		raise: Error
		withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 13:23:39'!
test25ManyRootsPortfoliosCanNotHaveADuplicatedAccountInTheirHierarchy
	| leftRootPortfolio rightRootPortfolio middlePortfolio account|
	"  |lP|  |rP|
	  	 \   /  \
	  	 |mP|   |a|
		  |
	  	 |a| 
	"
	leftRootPortfolio := Portfolio new.
	middlePortfolio := Portfolio new.
	rightRootPortfolio := Portfolio new.
	account  := ReceptiveAccount  new.
	
	rightRootPortfolio add: middlePortfolio.
	leftRootPortfolio add: middlePortfolio.

	rightRootPortfolio add: account.
	
	self
		should: [	middlePortfolio add: account]
		raise: Error
		withMessageText: Portfolio cantAddDuplicatedBankAssets.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 11:14:46'!
test26AddPortfolioToRootPortfolioUpdatesRootsToRootPortfolio
	| rootPortfolio lowerPortfolio middlePortfolio |
	rootPortfolio := Portfolio  new.
	middlePortfolio := Portfolio  new.
	lowerPortfolio := Portfolio  new.
	
	middlePortfolio add: lowerPortfolio.
	rootPortfolio add: middlePortfolio.
	
	self assert: 1 equals: lowerPortfolio roots size.
	self assert: lowerPortfolio roots includes: rootPortfolio.! !

!PortfolioTests methodsFor: 'tests - roots' stamp: 'LB 10/18/2021 11:16:18'!
test27AddSecondRootToChildPortfolioUpdatesRootsToMany

	| leftRootPortfolio rightRootPortfolio middlePortfolio |

	leftRootPortfolio := Portfolio new.
	middlePortfolio := Portfolio new.
	rightRootPortfolio := Portfolio new.
	
	rightRootPortfolio add: middlePortfolio.
	leftRootPortfolio add: middlePortfolio.
	
	self assert: 2 equals: middlePortfolio roots size.
	self assert: middlePortfolio roots includes: leftRootPortfolio.
	self assert: middlePortfolio roots includes: rightRootPortfolio.
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'sm 10/17/2021 21:40:24'!
sumToBalance: currentSum 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value - private' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'sm 10/17/2021 21:41:58'!
sumToBalance: aCurrentBalance 

	^aCurrentBalance + (self value). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value - private' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'operations' stamp: 'sm 10/17/2021 21:42:11'!
sumToBalance: aCurrentBalance 

	^aCurrentBalance - (self value).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BankAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAsset methodsFor: 'balance' stamp: 'LB 10/18/2021 11:51:52'!
balance
	
	self subclassResponsibility.! !


!BankAsset methodsFor: 'transactions' stamp: 'LB 10/18/2021 11:52:09'!
hasRegistered: aTransaction
	
	self subclassResponsibility.! !

!BankAsset methodsFor: 'transactions' stamp: 'LB 10/18/2021 11:52:48'!
transactions
	
	self subclassResponsibility.! !


!BankAsset methodsFor: 'comparing' stamp: 'LB 10/18/2021 11:52:33'!
includesAsset: aBankAsset
	
	self subclassResponsibility.! !


!BankAsset methodsFor: 'roots - private' stamp: 'LB 10/18/2021 11:53:02'!
updateRoots: aSetOfNewRoots
	
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAsset subclass: #Portfolio
	instanceVariableNames: 'bankAssets roots'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'LB 10/18/2021 11:51:11'!
add: aBankAsset 

	self assertIsValidToStore: aBankAsset.
	self safeAdd: aBankAsset.! !


!Portfolio methodsFor: 'adding - private' stamp: 'LB 10/18/2021 11:05:08'!
safeAdd: aBankAssetToStore

	bankAssets add: aBankAssetToStore.
	aBankAssetToStore updateRoots: roots.! !


!Portfolio methodsFor: 'assertions' stamp: 'LB 10/18/2021 11:34:15'!
assert: aRootPortfolio doesNotInclude:aBankAssetToStore
	
	(aRootPortfolio includesAsset: aBankAssetToStore)
		ifTrue: 		[self error: self class cantAddDuplicatedBankAssets].! !

!Portfolio methodsFor: 'assertions' stamp: 'LB 10/18/2021 11:34:10'!
assertIsValidToStore: aBankAssetToStore

	roots do: [:aRoot| self assert: aRoot doesNotInclude: aBankAssetToStore]! !


!Portfolio methodsFor: 'balance' stamp: 'sm 10/17/2021 22:34:16'!
balance

	^ bankAssets sum: [:aBankAsset| aBankAsset balance ] ifEmpty: [0].! !


!Portfolio methodsFor: 'comparing' stamp: 'LB 10/18/2021 11:27:08'!
any: bankAssetsToSearch includes: aBankAsset

	^bankAssetsToSearch anySatisfy: [:asset| asset includesAsset: aBankAsset].! !

!Portfolio methodsFor: 'comparing' stamp: 'LB 10/18/2021 11:02:01'!
includesAsset: 	aBankAsset
	
	(self = aBankAsset) ifTrue: [^true].
	^self any: bankAssets includes: aBankAsset.! !


!Portfolio methodsFor: 'initialization' stamp: 'LB 10/18/2021 11:08:19'!
initialize

	bankAssets := OrderedCollection new.
	roots := Set with: self.! !


!Portfolio methodsFor: 'roots - private' stamp: 'LB 10/18/2021 11:07:42'!
deleteRootsThatAreChildrenOf: aSetOfNewRoots

	^ roots do: 
		[:anOldRoot| (self any: aSetOfNewRoots includes: anOldRoot) 
			ifTrue: [roots remove: anOldRoot] ]! !

!Portfolio methodsFor: 'roots - private' stamp: 'LB 10/18/2021 11:27:29'!
updateChildrenRoots: aRootSet

	^bankAssets do: [:aBankAsset| aBankAsset updateRoots: aRootSet]! !

!Portfolio methodsFor: 'roots - private' stamp: 'LB 10/18/2021 11:07:25'!
updateRoots:		aSetOfNewRoots

	self deleteRootsThatAreChildrenOf: aSetOfNewRoots.
	roots addAll: aSetOfNewRoots.
	self updateChildrenRoots: aSetOfNewRoots.! !


!Portfolio methodsFor: 'testing' stamp: 'sm 10/17/2021 22:41:39'!
hasRegistered: aTransaction

	^bankAssets anySatisfy: [:aBankAsset | aBankAsset hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'testing - private' stamp: 'LB 10/18/2021 11:15:00'!
roots 
	
	^roots.! !


!Portfolio methodsFor: 'transactions' stamp: 'LB 10/18/2021 11:49:14'!
transactions
	
	^bankAssets inject: OrderedCollection new into:[:current :aBankAsset| current, aBankAsset transactions].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sm 10/17/2021 23:51:55'!
cantAddDuplicatedBankAssets

	^'cant add duplicated bank asset'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'sm 10/17/2021 21:49:15'!
initialize

	transactions := OrderedCollection new.
	! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'sm 10/17/2021 21:53:01'!
register: aTransaction

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'sm 10/17/2021 21:50:20'!
transactions 

	^ transactions copy.! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'sm 10/17/2021 21:48:08'!
balance
	
	^self sumOfTransactions: transactions.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'sm 10/17/2021 22:05:02'!
sumOfTransactions: aListOfTransactions
	
	^aListOfTransactions inject: 0 into: [:total :aTransaction | aTransaction sumToBalance: total].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'sm 10/17/2021 21:51:38'!
hasRegistered: aTransaction

	^transactions includes: aTransaction.! !


!ReceptiveAccount methodsFor: 'comparing' stamp: 'LB 10/18/2021 11:13:04'!
includesAsset: aReceptiveAccount
	^self = aReceptiveAccount! !


!ReceptiveAccount methodsFor: 'roots - private' stamp: 'LB 10/18/2021 11:11:29'!
updateRoots:		aSetOfNewRoots
	! !
