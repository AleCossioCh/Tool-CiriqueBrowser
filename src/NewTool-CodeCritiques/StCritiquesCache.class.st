"
I am a cache for the critiques, false positives critiques and to-do critiques.

"
Class {
	#name : #StCritiquesCache,
	#superclass : #Object,
	#instVars : [
		'critics',
		'toDos',
		'falsePositives',
		'checker',
		'browser',
		'falsePositiveRules',
		'falsePositiveClasses',
		'packages',
		'change'
	],
	#category : #'NewTool-CodeCritiques-Utilities'
}

{ #category : #private }
StCritiquesCache >> addAllCriticToFalsePositive: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId  criticss |
	criticss := aCollectionOfCritic 
						reject: [ :c | falsePositiveClasses includes: c criticTheNonMetaclassClass ].
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasFalsePositiveOf: ruleId version: versionId) 
		ifFalse: [ aManifestBuilder installFalsePositiveOf: ruleId version: versionId ].		
	 aManifestBuilder addAllFalsePositive: criticss of: ruleId version: versionId

	
]

{ #category : #private }
StCritiquesCache >> addAllCriticToToDo: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId  |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasToDoOf: ruleId version: versionId) 
		ifFalse: [ aManifestBuilder installToDoOf: ruleId version: versionId ].		
	 aManifestBuilder addAllToDo: aCollectionOfCritic of: ruleId version: versionId

	
]

{ #category : #'add/remove' }
StCritiquesCache >> addCritic: aCritic forRule: aRule [

	(critics includesKey: aRule) 
		ifFalse: [ critics at:aRule put: IdentitySet new ].
	(critics at: aRule) add: aCritic. 
	self updateBrowser
]

{ #category : #'add/remove' }
StCritiquesCache >> addFalsePositive: aCritic forRule: aRule [

	(falsePositives includesKey: aRule) 
		ifFalse: [ falsePositives at: aRule put: IdentitySet new ].
	(falsePositives at: aRule) add: aCritic. 
	self updateBrowser 	
]

{ #category : #'add/remove' }
StCritiquesCache >> addFalsePositiveClass: aClass [ 
	
	| fp |
	falsePositiveClasses add: aClass instanceSide. 
	critics keysAndValuesDo: [ :rule :criticss |
		fp := criticss select: [ :critic | aClass = critic criticTheNonMetaclassClass ].
		fp do: [ :each | self addFalsePositive: each forRule: rule] ].
	self updateBrowser	

]

{ #category : #'add/remove' }
StCritiquesCache >> addFalsePositiveRule: aRule forPackage: aPackage [
	
	| fp |
	(falsePositiveRules includesKey: aPackage) 
		ifFalse: [ falsePositiveRules at: aPackage put: Set new ].
	(falsePositiveRules at: aPackage) add: (aRule class uniqueIdentifierName). 
	fp := (critics at: aRule ifAbsent: [^ self])
				select: [ :c |  (self packageOf: c) package name = aPackage packageName ].	
	fp do: [ :c | self addFalsePositive: c forRule: aRule ]
]

{ #category : #'add/remove' }
StCritiquesCache >> addToDo: aCritic forRule: aRule [

	(toDos includesKey: aRule) 
		ifFalse: [ toDos at:aRule put: IdentitySet new ].
	(toDos at: aRule) add: aCritic. 
	self updateBrowser
]

{ #category : #accessing }
StCritiquesCache >> browser: aCodeCritiicBrowser [
	browser := aCodeCritiicBrowser 
]

{ #category : #private }
StCritiquesCache >> builderManifestClass [
	^ TheManifestBuilder
]

{ #category : #accessing }
StCritiquesCache >> cacheChange [
	^ change
]

{ #category : #private }
StCritiquesCache >> cacheChanged [ 
	change := true
]

{ #category : #private }
StCritiquesCache >> cacheNotChanged [ 
	change := false
]

{ #category : #accessing }
StCritiquesCache >> checker: aSmallLintChercker [
	checker := aSmallLintChercker
]

{ #category : #protocol }
StCritiquesCache >> criticsOf: aRule [

	aRule ifNil: [ ^ {} ].	
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [ :rule | self criticsOf: rule ]]
		ifFalse: [ critics at: aRule ifAbsent: [ {} ]]
]

{ #category : #protocol }
StCritiquesCache >> falsePositiveOf: aRule [
	
	aRule ifNil: [ ^ {}].
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [ :rule | self falsePositiveOf: rule ]]
		ifFalse: [ falsePositives at: aRule ifAbsent: [ {} ]]
	
	
]

{ #category : #initialization }
StCritiquesCache >> initCache [


	checker rule do: [ :rule | 
		falsePositives at: rule put: (IdentitySet newFrom: (checker falsePositiveOf: rule)).
		toDos at: rule put: (IdentitySet newFrom: (checker toDoOf: rule)).
		critics at: rule put: (IdentitySet newFrom: (checker criticsOf: rule)) 
	].
	packages do: [ :package |	
		falsePositiveRules at: package put: (checker rejectRulesOf: package) asSet.
		falsePositiveClasses addAll: (checker rejectClassesOf: package) asIdentitySet.
	]
]

{ #category : #initialization }
StCritiquesCache >> initialize [
	
	super initialize.
	falsePositives := Dictionary new.
	toDos := Dictionary new.	
	critics := Dictionary new.	
	falsePositiveRules := Dictionary new.
	falsePositiveClasses := IdentitySet new.
	change := false	

]

{ #category : #testing }
StCritiquesCache >> isFalsePositive: aCritic forRule: aRule [
	^ (self falsePositiveOf: aRule) includes: aCritic
]

{ #category : #testing }
StCritiquesCache >> isToDo: aCritic forRule: aRule [
	^ (self toDosOf: aRule) includes: aCritic
]

{ #category : #'add/remove' }
StCritiquesCache >> itemRemoved: anItem [

	{ critics . toDos . falsePositives } do: [ :ruleDict |
		ruleDict valuesDo: [ :crits |
			crits removeAllSuchThat: [ :crit |
				crit sourceAnchor entity = anItem ]]]
	
]

{ #category : #private }
StCritiquesCache >> logFalsePositiveClassInManifest [
	| manifestBuilder |
	packages
		do: [ :package | 
			manifestBuilder := self builderManifestClass ofPackageNamed: package packageName.
			manifestBuilder rejectClasses \ falsePositiveClasses do: [ :cl | manifestBuilder removeRejectClass: cl ].
			falsePositiveClasses \ manifestBuilder rejectClasses do: [ :cl | manifestBuilder addRejectClass: cl ] ]
]

{ #category : #private }
StCritiquesCache >> logFalsePositiveInManifest [
	| removeFp addFp |
	falsePositives
		keysAndValuesDo: [ :rule :criticss | 
			removeFp := (checker falsePositiveOf: rule) \ criticss.
			removeFp := removeFp collect: [ :c | c sourceAnchor entity ].
			addFp := criticss \ (checker falsePositiveOf: rule).
			addFp := addFp collect: [ :c | c sourceAnchor entity ].			
			(removeFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | self removeAllCriticToFalsePositive: value forRule: rule on: manifestBuilder ].
			(addFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | 
					(manifestBuilder rejectRules includes: rule class uniqueIdentifierName)
						ifFalse: [ self addAllCriticToFalsePositive: value forRule: rule on: manifestBuilder ] ] ]
]

{ #category : #private }
StCritiquesCache >> logFalsePositiveRulesInManifest [
	| manifestBuilder |
	falsePositiveRules
		keysAndValuesDo: [:package :rules | 
			manifestBuilder := self builderManifestClass ofPackageNamed: package packageName.
			manifestBuilder rejectRules \ rules do: [ :rule | manifestBuilder removeRejectRule: rule ].
			rules \ manifestBuilder rejectRules do: [ :rule | manifestBuilder addRejectRule: rule ]]
]

{ #category : #protocol }
StCritiquesCache >> logInManifest [

	self cacheChange 
		ifFalse: [^ self].
	self logFalsePositiveRulesInManifest.
	self logFalsePositiveClassInManifest.
	self logFalsePositiveInManifest.
	self logToDosInManifest.
	self cacheNotChanged. 		
	self initCache
	
]

{ #category : #private }
StCritiquesCache >> logToDosInManifest [
	| removeFp addFp |
	toDos
		keysAndValuesDo: [ :rule :criticss | 
			removeFp := (checker toDoOf: rule) \ criticss.
			removeFp := removeFp collect: [ :c | c sourceAnchor entity ].
			addFp := criticss \ (checker toDoOf: rule).
			addFp := addFp collect: [ :c | c sourceAnchor entity ].	
			(removeFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | self removeAllCriticToToDo: value forRule: rule on: manifestBuilder ].
			(addFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | 
					(manifestBuilder rejectRules includes: rule class uniqueIdentifierName)
						ifFalse: [ self addAllCriticToToDo: value forRule: rule on: manifestBuilder ] ] ]
]

{ #category : #private }
StCritiquesCache >> packageOf: aCritc [
	^ aCritc mcWorkingCopy 
]

{ #category : #accessing }
StCritiquesCache >> packages: aPackageEnv [
	
	packages := aPackageEnv packages
]

{ #category : #private }
StCritiquesCache >> removeAllCriticToFalsePositive: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasFalsePositiveOf: ruleId version: versionId) 
		ifTrue: [ aManifestBuilder removeAllFalsePositive: aCollectionOfCritic of: ruleId version: versionId ]	
	 

	
]

{ #category : #private }
StCritiquesCache >> removeAllCriticToToDo: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasToDoOf: ruleId version: versionId) 
		ifTrue: [ aManifestBuilder removeAllToDo: aCollectionOfCritic of: ruleId version: versionId ]		
	

	
]

{ #category : #'add/remove' }
StCritiquesCache >> removeCritic: aCritic forRule: aRule [

	(critics includesKey: aRule) 
		ifFalse: [^ self].
	(critics at: aRule) remove: aCritic ifAbsent: [^ self].
	self updateBrowser
	
]

{ #category : #'add/remove' }
StCritiquesCache >> removeFalsePositive: aCritic forRule: aRule [

	(falsePositives includesKey: aRule) 
		ifFalse: [^ self ].
	[ (falsePositiveClasses includes: aCritic sourceAnchor entity criticTheNonMetaclassClass) 
			ifTrue: [^ self] ]
		on: MessageNotUnderstood 
		do: [ ^ self "#criticTheNonMetaclassClass makes no sense on a Package, ignore"].
	(falsePositives at: aRule) remove: aCritic ifAbsent: [^ self].
	self updateBrowser
]

{ #category : #'add/remove' }
StCritiquesCache >> removeFalsePositiveClass: aClass [
	
	| fp |
	falsePositiveClasses remove: aClass ifAbsent: [^ self]. 
	critics keysAndValuesDo: [ :rule :criticss |
		fp := criticss select: [ :critic | aClass = critic criticTheNonMetaclassClass].
		fp do: [ :each | self removeFalsePositive: each forRule: rule ]]
]

{ #category : #'add/remove' }
StCritiquesCache >> removeFalsePositiveRule: aRule forPackage: aPackage [
	| fp |
	
	(falsePositiveRules includesKey: aPackage) 
		ifFalse: [^ self].
	
	(falsePositiveRules at:aPackage) remove: (aRule class uniqueIdentifierName) ifAbsent: [^ self]. 

	fp := (critics at: aRule ifAbsent: [^ self])
		select: [:c | ((self packageOf: c) package name) = (aPackage packageName) and: [
						(falsePositiveClasses includes: c criticTheNonMetaclassClass) not]].			
	fp do: [:c | self removeFalsePositive: c forRule: aRule]. 
	
	self updateBrowser 
]

{ #category : #'add/remove' }
StCritiquesCache >> removeRule: aRule [

	{ critics . toDos . falsePositives } do: [ :ruleDict |
		ruleDict removeKey: aRule ]
]

{ #category : #'add/remove' }
StCritiquesCache >> removeToDo: aCritic forRule: aRule [

	(toDos includesKey: aRule) 
		ifFalse: [^ self].
			
	(toDos at:aRule) remove: aCritic ifAbsent: [^ self].
	self updateBrowser
	
]

{ #category : #protocol }
StCritiquesCache >> replaceAll: oldMethod by: newMethod [

	critics valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]].
		
	falsePositives valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]].

	toDos valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]]
	
]

{ #category : #protocol }
StCritiquesCache >> toDosOf: aRule [

	aRule ifNil: [ ^{} ].
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [:rule | self toDosOf: rule ]]
		ifFalse: [toDos at: aRule ifAbsent: [ {} ]]
]

{ #category : #private }
StCritiquesCache >> updateBrowser [

	self cacheChanged.
	browser updateTree 
]
