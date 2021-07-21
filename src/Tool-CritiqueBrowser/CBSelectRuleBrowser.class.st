Class {
	#name : #CBSelectRuleBrowser,
	#superclass : #CBSelectBrowser,
	#instVars : [
		'environment',
		'removeTestCase',
		'selectedRules'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBSelectRuleBrowser class >> items [

	| rules rulesByGroup |
	rules := (ReRuleManager visibleRuleClasses collect: [ :aClass | 
		          aClass new ]) sorted: [ :a :b | a name < b name ].
	rulesByGroup := (rules groupedBy: #group) associations collect: [ :as | 
		                CBCritiqueBrowserRulesGroup
			                named: as key
			                rules: as value ].
	rulesByGroup sort: [ :a :b | a name < b name ].
	^ rulesByGroup
]

{ #category : #'instance creation' }
CBSelectRuleBrowser class >> openWithEnvironment: anEnvironment removeTestCase: aBoolean [

	self new
		items: self items;
		environment: anEnvironment;
		removeTestCase: aBoolean;
		openWithSpec;
		updateTree
]

{ #category : #specs }
CBSelectRuleBrowser class >> title [
	^ 'Select rules'
]

{ #category : #private }
CBSelectRuleBrowser >> addAllItems [
	
	toSelectModel roots do: [ :group | selectedRules addAll: group rules].
	self updateTree  	  
]

{ #category : #private }
CBSelectRuleBrowser >> addItems [
	toSelectModel selectedItem
		ifNotNil:
			[ :item |
			item isComposite
				ifFalse: [ selectedRules add: item ]
				ifTrue: [ selectedRules addAll: item rules ] ].
	self update
]

{ #category : #private }
CBSelectRuleBrowser >> defaultRulesRootName [
	^ 'Selected Rules'
]

{ #category : #accessing }
CBSelectRuleBrowser >> environment: aEnv [
	environment := aEnv
]

{ #category : #initialization }
CBSelectRuleBrowser >> initialize [
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
CBSelectRuleBrowser >> isSelected: aRule [
	"Check the rule identifier to not run twice the same rule"

	^ selectedRules
		anySatisfy: [ :rule | rule class uniqueIdentifierName = aRule class uniqueIdentifierName ]
]

{ #category : #accessing }
CBSelectRuleBrowser >> items: aCollection [
	
	toSelectModel roots: aCollection.
	selectedModel roots: aCollection

]

{ #category : #api }
CBSelectRuleBrowser >> nextAction [

	self delete.

	CBCritiqueWorkingConfiguration current
		rule: selectedRules;
		environment: environment;
		removeTestCase: removeTestCase.
	CBCritiqueBrowser openOnWorkingConfiguration:
		CBCritiqueWorkingConfiguration current
]

{ #category : #api }
CBSelectRuleBrowser >> removeAllItems [
	
	selectedModel roots do: [ :item |  
		selectedRules removeAllFoundIn: item value ].
	self updateTree 	  
]

{ #category : #api }
CBSelectRuleBrowser >> removeItems [
	
	selectedModel selectedItem
		ifNotNil: [ :item | selectedRules removeAllFoundIn: item leaves ].
	self updateTree  	  
]

{ #category : #accessing }
CBSelectRuleBrowser >> removeTestCase: aBoolean [
	removeTestCase := aBoolean
]

{ #category : #api }
CBSelectRuleBrowser >> updateTree [

	toSelectModel update.
	selectedModel update
]
