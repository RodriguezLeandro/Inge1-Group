!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:37:55'!
test01ANewPortfolioBalanceIsZero
	| portfolio balance |
	
	portfolio := Portfolio new.
	
	balance := portfolio balance.
	
	self assert: 0 equals: balance.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:38:16'!
test02
	| portfolio balance account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	balance := portfolio balance.
	
	self assert: 100 equals: balance.
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:38:38'!
test03
	| portfolio portfolioAAgregar balance |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	portfolio addPortfolio: portfolioAAgregar.
	
	balance := portfolio balance.
	
	self assert: 0 equals: balance.
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:45:02'!
test04
	| portfolio balance account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	balance := portfolio balance.
	
	self assert: 150 equals: balance.
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:43:46'!
test05
	| portfolio portfolioAAgregar balance account1 |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	portfolioAAgregar addAccount: account1.
	
	portfolio addPortfolio: portfolioAAgregar.
	
	balance := portfolio balance.
	
	self assert: 100 equals: balance.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:47:26'!
test06
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions) isEmpty.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:49:13'!
test07
	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: account transactions equals: portfolio transactions.
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 10:57:54'!
test08
	| portfolio portfolioAAgregar account |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolioAAgregar addAccount: account.
	
	portfolio addPortfolio: portfolioAAgregar.
	
	self assert: account transactions equals: portfolio transactions.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 11:08:47'!
test09
	| portfolio portfolioAAgregar account1 account2 |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolioAAgregar addAccount: account1.	
	portfolio addAccount: account2.
	
	portfolio addPortfolio: portfolioAAgregar.
	
	self assert: (account1 transactions, account2 transactions) equals: portfolio transactions.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 11:19:54'!
test10
	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: (account1 transactions, account2 transactions) equals: portfolio transactions.
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 11:30:29'!
test11
	| portfolio portfolioToAdd1 portfolioToAdd2 account1 account2 |
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	portfolioToAdd2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	
	portfolioToAdd1 addAccount: account1.	
	portfolioToAdd2 addAccount: account2.	
	
	portfolio addPortfolio: portfolioToAdd1.
	portfolio addPortfolio: portfolioToAdd2.
	
	self assert: (account1 transactions, account2 transactions) equals: portfolio transactions.! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/12/2021 11:36:59'!
test12
	| portfolio aTransaction account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aTransaction := (account transactions) first.
	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/13/2021 18:25:52'!
test13
	| portfolio aTransaction account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aTransaction := (account transactions) first.
	
	portfolio addAccount: account.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/13/2021 18:25:12'!
test14
	| portfolio aTransaction1 account1 aTransaction2 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	aTransaction1 := (account1 transactions) first.
	aTransaction2 := (account2 transactions) first.
	
	portfolio addAccount: account1.
	
	self deny: (portfolio hasRegistered: aTransaction2).! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/13/2021 18:25:07'!
test15
	| portfolio portfolioAAgregar account aTransaction |
	
	portfolio := Portfolio new.
	portfolioAAgregar := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	aTransaction := (account transactions) first.
	
	portfolioAAgregar addAccount: account.
	
	portfolio addPortfolio: portfolioAAgregar.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/13/2021 18:37:19'!
test16
	| portfolio aTransaction1 account1 aTransaction2 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	aTransaction1 := (account1 transactions) first.
	aTransaction2 := (account2 transactions) first.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: (portfolio hasRegistered: aTransaction2).! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'LB 10/13/2021 18:37:38'!
test17
	| portfolio portfolioAAgregar1 portfolioAAgregar2 account1 account2 aTransaction1 aTransaction2 |
	
	portfolio := Portfolio new.
	portfolioAAgregar1 := Portfolio new.
	portfolioAAgregar2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	aTransaction1 := (account1 transactions) first.
	portfolioAAgregar1 addAccount: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	aTransaction2 := (account2 transactions) first.
	portfolioAAgregar2 addAccount: account2.
	
	portfolio addPortfolio: portfolioAAgregar1.
	portfolio addPortfolio: portfolioAAgregar2.
	
	self assert: (portfolio hasRegistered: aTransaction2).! !


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

!AccountTransaction methodsFor: 'value' stamp: 'LB 10/12/2021 09:17:43'!
isRegisteredOnReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'LB 10/12/2021 09:08:16'!
registerToReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !

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


!Deposit methodsFor: 'value' stamp: 'LB 10/12/2021 09:21:13'!
isRegisteredOnReceptiveAccount: aReceptiveAccount

	^aReceptiveAccount hasRegisteredADeposit: self.! !

!Deposit methodsFor: 'value' stamp: 'LB 10/12/2021 09:09:07'!
registerToReceptiveAccount: aReceptiveAccount

	aReceptiveAccount registerADeposit: self.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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


!Withdraw methodsFor: 'value' stamp: 'LB 10/12/2021 09:21:06'!
isRegisteredOnReceptiveAccount: aReceptiveAccount

	^aReceptiveAccount hasRegisteredAWithdraw: self.! !

!Withdraw methodsFor: 'value' stamp: 'LB 10/12/2021 09:09:19'!
registerToReceptiveAccount: aReceptiveAccount

	aReceptiveAccount registerAWithdraw: self.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'LB 10/12/2021 10:33:27'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
! !


!Portfolio methodsFor: 'adding' stamp: 'LB 10/12/2021 10:33:37'!
addAccount: aReceptiveAccount 
	
	accounts add: aReceptiveAccount.! !

!Portfolio methodsFor: 'adding' stamp: 'LB 10/12/2021 10:33:41'!
addPortfolio: aPortfolio 
	
	portfolios add: aPortfolio.! !


!Portfolio methodsFor: 'balance' stamp: 'LB 10/13/2021 19:45:46'!
accountsBalance
	
	^self makeBalanceOf: accounts.! !

!Portfolio methodsFor: 'balance' stamp: 'LB 10/13/2021 19:41:33'!
balance
	^ self accountsBalance + self portfoliosBalance.! !

!Portfolio methodsFor: 'balance' stamp: 'LB 10/13/2021 19:59:22'!
makeBalanceOf: aPortfolioColaborator
	^(aPortfolioColaborator 
		sum: [:anElementOfColaborator| anElementOfColaborator balance ] 
		ifEmpty: [0]).! !

!Portfolio methodsFor: 'balance' stamp: 'LB 10/13/2021 19:45:46'!
portfoliosBalance
	
	^self makeBalanceOf: portfolios.! !


!Portfolio methodsFor: 'testing' stamp: 'LB 10/13/2021 20:25:20'!
accountsHasRegistered: aTransaction

	^ self checkTransaction: aTransaction in: accounts! !

!Portfolio methodsFor: 'testing' stamp: 'LB 10/13/2021 20:21:36'!
checkTransaction: aTransaction in: aColaborator
	
	^aColaborator 
		anySatisfy: [:aColaboratorElement | aColaboratorElement hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'testing' stamp: 'LB 10/13/2021 20:25:20'!
hasRegistered: aTransaction 
	
	^(self portfoliosHasRegistered: aTransaction) 
	or: [self accountsHasRegistered: aTransaction].! !

!Portfolio methodsFor: 'testing' stamp: 'LB 10/13/2021 20:24:41'!
portfoliosHasRegistered: aTransaction

	^ self checkTransaction: aTransaction in: portfolios! !


!Portfolio methodsFor: 'transactions' stamp: 'LB 10/13/2021 20:16:19'!
accountsTransactions
	
	^self gettransactionsOf: accounts.! !

!Portfolio methodsFor: 'transactions' stamp: 'LB 10/13/2021 20:14:14'!
gettransactionsOf: aCollaborator
	| colaboratorTransactions |
	
	colaboratorTransactions := OrderedCollection new.

	aCollaborator do:[:aCollaboratorElement| 
		colaboratorTransactions := (colaboratorTransactions, aCollaboratorElement transactions)
		].
	
	^colaboratorTransactions! !

!Portfolio methodsFor: 'transactions' stamp: 'LB 10/13/2021 20:16:10'!
portfoliosTransactions
	
	^self gettransactionsOf: portfolios.! !

!Portfolio methodsFor: 'transactions' stamp: 'LB 10/13/2021 20:16:38'!
transactions

	^(self portfoliosTransactions ,self accountsTransactions)! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'deposits withdraws'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LB 10/12/2021 08:54:39'!
initialize

	deposits := OrderedCollection new.
	withdraws := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'LB 10/12/2021 09:10:33'!
register: aTransaction

	aTransaction registerToReceptiveAccount: self.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LB 10/12/2021 09:09:48'!
registerADeposit: aDeposit

	deposits add: aDeposit.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LB 10/12/2021 09:10:07'!
registerAWithdraw: aWithdraw

	withdraws add: aWithdraw.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LB 10/12/2021 08:58:33'!
transactions 

	^ (deposits, withdraws) copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LB 10/12/2021 09:43:02'!
balance
	
	^(self depositsBalance - self withdrawsBalance).! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'LB 10/12/2021 09:31:52'!
depositsBalance
	
	^self sumOfTransactions: deposits.
	
! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'LB 10/12/2021 09:33:11'!
sumOfTransactions: aListOfTransactions
	
	^aListOfTransactions sum: [ :aTransaction | aTransaction value		] 
	ifEmpty: [ 0 ].
	
! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'LB 10/12/2021 09:31:42'!
withdrawsBalance

	^self sumOfTransactions: withdraws.
	
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 10/12/2021 09:20:58'!
hasRegistered: aTransaction

	^aTransaction isRegisteredOnReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 10/12/2021 09:19:25'!
hasRegisteredADeposit: aDeposit

	^deposits includes: aDeposit.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 10/12/2021 09:20:08'!
hasRegisteredAWithdraw: aWithdraw

	^withdraws includes: aWithdraw.! !
