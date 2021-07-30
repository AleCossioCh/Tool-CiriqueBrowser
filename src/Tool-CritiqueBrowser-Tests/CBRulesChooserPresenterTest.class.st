Class {
	#name : #CBRulesChooserPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'rulesChooserPresenter',
		'rulesChooserWithItems',
		'rules',
		'rulesByGroup'
	],
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #running }
CBRulesChooserPresenterTest >> setUp [

	super setUp.
	rulesChooserPresenter := CBRulesChooserPresenter new.
	rules := (ReRuleManager visibleRuleClasses collect: [ :aClass | 
		          aClass new ]) sorted: [ :a :b | a name < b name ].
	rulesByGroup := (rules groupedBy: #group) associations collect: [ :as | 
		                CBCritiqueBrowserRulesGroup
			                named: as key
			                rules: as value ]
]

{ #category : #running }
CBRulesChooserPresenterTest >> tearDown [ 

	super tearDown.
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testAddAll [

	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter addAllButton click.
	self assert: rulesChooserPresenter selectedRules equals: rules asSet
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testAddSelectedComposite [

	| bugsGroup bugsRules |
	bugsGroup := rulesByGroup select: [ :item | item name = 'Bugs' ].
	bugsRules := bugsGroup first rules.
	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter list selectPath: (rulesChooserPresenter list pathIndexOf: bugsGroup).
	rulesChooserPresenter addButton click.
	self assert: rulesChooserPresenter selectedRules equals: bugsRules asSet 
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testAddSelectedSingleRule [

	| bugsGroup bugsRule |
	bugsGroup := rulesByGroup select: [ :item | item name = 'Bugs' ].
	bugsRule := bugsGroup first rules first.
	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter list selectItem: bugsRule.
	rulesChooserPresenter addButton click.
	self
		assert: rulesChooserPresenter selectedRules
		equals: { bugsRule } asSet
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testInitialize [

	| window |
	self assert: rulesChooserPresenter list roots isEmpty.
	self assert: rulesChooserPresenter selectedList roots isEmpty.
	window := rulesChooserPresenter openWithSpec.
	self assert: window isBuilt.
	window close
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testOpen [

	| window |
	window := CBRulesChooserPresenter open.
	self assert: window isBuilt.
	window close
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testRemoveAll [

	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter selectedRules: rules.
	rulesChooserPresenter removeAllButton click.
	self assert: rulesChooserPresenter selectedRules isEmpty
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testRemoveSelectedComposite [

	| styleGroup styleRules |
	rulesChooserPresenter := CBRulesChooserPresenter new.
	styleGroup := rulesByGroup select: [ :item | item name = 'Style' ].
	styleRules := styleGroup first rules.
	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter selectedList selectPath:
 		(rulesChooserPresenter selectedList pathIndexOf: styleGroup).
	rulesChooserPresenter selectedRules: styleRules.
	rulesChooserPresenter removeButton click.
	self assert: rulesChooserPresenter selectedRules isEmpty
]

{ #category : #tests }
CBRulesChooserPresenterTest >> testRemoveSelectedRule [

	| apiGroup apiRule |
	rulesChooserPresenter := CBRulesChooserPresenter new.
	apiGroup := rulesByGroup select: [ :item | item name = 'API Hints' ].
	apiRule := apiGroup first rules first.
	rulesChooserPresenter items: rulesByGroup.
	rulesChooserPresenter selectedRules: { apiRule } asSet.
	rulesChooserPresenter selectedList selection selectItem: apiRule.
	self
		assert: rulesChooserPresenter selectedRules
		equals: { apiRule } asSet.
	rulesChooserPresenter removeButton click.
	self assert: rulesChooserPresenter selectedRules isEmpty
]
