Class {
	#name : #CBRulesChooserPresenter,
	#superclass : #CBAbstractChoosePresenter,
	#instVars : [
		'selectedRules',
		'environment',
		'removeTestCase'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBRulesChooserPresenter class >> items [

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
CBRulesChooserPresenter class >> open [

	self openOn: { 
			(RPackageOrganizer default packages sorted: #packageName ascending).
			{ (RPackageOrganizer default packageNamed: 'Refactoring-Core') }.
			#packageName }
]

{ #category : #'instance creation' }
CBRulesChooserPresenter class >> openWithEnvironment: anEnvironment removeTestCase: aBoolean [

	self new
		items: self items;
		environment: anEnvironment;
		removeTestCase: aBoolean;
		openWithSpec;
		updateTree
]

{ #category : #adding }
CBRulesChooserPresenter >> addAll [

	selectedList roots do: [ :group | selectedRules addAll: group rules ].
	self update
]

{ #category : #adding }
CBRulesChooserPresenter >> addSelected [

	selectedList selectedItem ifNotNil: [ :item | 
		self halt.
		item isComposite
			ifFalse: [ selectedRules add: item ]
			ifTrue: [ selectedRules addAll: item rules ] ].
	self update
]

{ #category : #initialization }
CBRulesChooserPresenter >> environment: aEnviroment [

	environment := aEnviroment
]

{ #category : #initialization }
CBRulesChooserPresenter >> initalizeSelectedList [

	selectedList := self instantiate: SpTreePresenter
]

{ #category : #initialization }
CBRulesChooserPresenter >> initialize [

	| wrappingBlock selectedRulesChildrenBlock rulesToSelectChildrenBlock |
	super initialize.
	self initializeList.
	self initalizeSelectedList.
	selectedRules := Set new.
	selectedRulesChildrenBlock := [ :rule | 
	                              rule isComposite
		                              ifTrue: [ 
			                              rule rules select: [ :r | 
				                              (self isSelected: r) or: [ 
					                              r isComposite ] ] ]
		                              ifFalse: [ #(  ) ] ].
	rulesToSelectChildrenBlock := [ :rule | 
	                              rule isComposite
		                              ifTrue: [ 
			                              rule rules select: [ :r | 
				                              (self isSelected: r) not or: [ 
					                              r isComposite ] ] ]
		                              ifFalse: [ #(  ) ] ].
	list children: rulesToSelectChildrenBlock.
	selectedList children: selectedRulesChildrenBlock.
	wrappingBlock := [ :rule | rule name ].
	list display: wrappingBlock.
	selectedList display: wrappingBlock
]

{ #category : #initialization }
CBRulesChooserPresenter >> initializeList [

	list := self instantiate: SpTreePresenter.
]

{ #category : #initialization }
CBRulesChooserPresenter >> isSelected: aRule [

	"Check the rule identifier to not run twice the same rule"

	^ selectedRules anySatisfy: [ :rule | 
		  rule class uniqueIdentifierName = aRule class uniqueIdentifierName ]
]

{ #category : #initialization }
CBRulesChooserPresenter >> items: aCollection [

	list roots: aCollection.
	selectedList roots: aCollection
]

{ #category : #initialization }
CBRulesChooserPresenter >> nextAction [

	self delete.

	CBCritiqueWorkingConfiguration current
		rule: selectedRules;
		environment: environment;
		removeTestCase: removeTestCase.
	CBCritiqueBrowser openOnWorkingConfiguration:
		CBCritiqueWorkingConfiguration current
]

{ #category : #accessing }
CBRulesChooserPresenter >> removeAll [

	selectedList roots do: [ :item | 
		selectedRules removeAllFoundIn: item value ].
	self update
]

{ #category : #actions }
CBRulesChooserPresenter >> removeSelected [

	list selectedItem ifNotNil: [ :item | 
		selectedRules removeAllFoundIn: item ].
	self update
]

{ #category : #initialization }
CBRulesChooserPresenter >> removeTestCase: aBoolean [

	removeTestCase := aBoolean
]

{ #category : #initialization }
CBRulesChooserPresenter >> title [

	^ 'Select rules'
]

{ #category : #initialization }
CBRulesChooserPresenter >> updateTree [

	list update.
	selectedList update
]
