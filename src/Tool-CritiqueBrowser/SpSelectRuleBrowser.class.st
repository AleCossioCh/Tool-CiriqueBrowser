Class {
	#name : #SpSelectRuleBrowser,
	#superclass : #SpSelectBrowser,
	#instVars : [
		'environment',
		'removeTestCase',
		'selectedRules'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #'instance creation' }
SpSelectRuleBrowser class >> items [

	| rules rulesByGroup |
	rules := (ReRuleManager visibleRuleClasses collect: [ :aClass | 
		          aClass new ]) sorted: [ :a :b | a name < b name ].
	rulesByGroup := (rules groupedBy: #group) associations collect: [ :as | 
		                SpCriticBrowserRulesGroup
			                named: as key
			                rules: as value ].
	rulesByGroup sort: [ :a :b | a name < b name ].
	^ rulesByGroup
]

{ #category : #'instance creation' }
SpSelectRuleBrowser class >> openWithEnvironment: anEnvironment removeTestCase: aBoolean [

	self new
		items: self items;
		environment: anEnvironment;
		removeTestCase: aBoolean;
		openWithSpec;
		updateTree
]

{ #category : #specs }
SpSelectRuleBrowser class >> title [
	^ 'Select rules'
]

{ #category : #private }
SpSelectRuleBrowser >> addAllItems [
	
	toSelectModel roots do: [ :group | selectedRules addAll: group rules].
	self updateTree  	  
]

{ #category : #private }
SpSelectRuleBrowser >> addItems [
	toSelectModel selectedItem
		ifNotNil:
			[ :item |
			item content isComposite
				ifFalse: [ selectedRules add: item content ]
				ifTrue: [ selectedRules addAll: item content rules ] ].
	self updateTree
]

{ #category : #private }
SpSelectRuleBrowser >> defaultRulesRootName [
	^ 'Selected Rules'
]

{ #category : #accessing }
SpSelectRuleBrowser >> environment: aEnv [
	environment := aEnv
]

{ #category : #initialization }
SpSelectRuleBrowser >> initialize [
	| wrappingBlock selectedRulesChildrenBlock rulesToSelectChildrenBlock |
	super initialize.
	toSelectModel := self instantiate: SpTreePresenter.
	selectedModel := self instantiate: SpTreePresenter.
	selectedRules := Set new.
	selectedRulesChildrenBlock := [ :rule | 
		rule isComposite
			ifTrue: [ rule rules
				select: [:r | (self isSelected: r) or: [ r isComposite ]]]
			ifFalse: [ #() ]].
	rulesToSelectChildrenBlock := [ :rule | 
		rule isComposite
			ifTrue: [ rule rules
				select: [:r | (self isSelected: r) not or: [ r isComposite ]]]
			ifFalse: [ #() ]].
	toSelectModel children: rulesToSelectChildrenBlock.
	selectedModel children: selectedRulesChildrenBlock.
	wrappingBlock := [:rule | rule name ].
	toSelectModel display: wrappingBlock.
	selectedModel display: wrappingBlock
]

{ #category : #private }
SpSelectRuleBrowser >> isSelected: aRule [
	"Check the rule identifier to not run twice the same rule"

	^ selectedRules
		anySatisfy: [ :rule | rule class uniqueIdentifierName = aRule class uniqueIdentifierName ]
]

{ #category : #accessing }
SpSelectRuleBrowser >> items: aCollection [
	
	toSelectModel roots: aCollection.
	selectedModel roots: aCollection

]

{ #category : #api }
SpSelectRuleBrowser >> nextAction [

	self delete.

	SpCriticWorkingConfiguration current
		rule: selectedRules;
		environment: environment;
		removeTestCase: removeTestCase.
	SpCritiqueBrowser openOnWorkingConfiguration:
		SpCriticWorkingConfiguration current
]

{ #category : #api }
SpSelectRuleBrowser >> removeAllItems [
	
	selectedModel roots do: [ :item |  
		selectedRules removeAllFoundIn: item value ].
	self updateTree 	  
]

{ #category : #api }
SpSelectRuleBrowser >> removeItems [
	
	selectedModel selectedItem
		ifNotNil: [ :item | selectedRules removeAllFoundIn: item content leaves ].
	self updateTree  	  
]

{ #category : #accessing }
SpSelectRuleBrowser >> removeTestCase: aBoolean [
	removeTestCase := aBoolean
]

{ #category : #api }
SpSelectRuleBrowser >> updateTree [

	toSelectModel updateTree.
	selectedModel updateTree
]
