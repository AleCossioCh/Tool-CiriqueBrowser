"
I am a presenter that allows to select items from a list of rules organized by group in my left column and put that items on a selected list in my rigth column. I support selection for SpTreeTablePresenter. 

If you click on '>', I can add a group rules or a singe rule to selected list.
If you click on '<', I can remove a group rules or a singe rule from selected list.

If you click on 'Next', I will open the CBCritiqueBrowser.
I send selected rules from selected list to CBCritiqueBrowser. 

You can open me whit:
`CBRulesChooserPresenter open`

"
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

	<example>
	| packages env |
	packages := RPackageOrganizer default packages.
	env := RBPackageEnvironment new packages: packages.
	^ (self openWithEnvironment: env removeTestCase: false)
]

{ #category : #'instance creation' }
CBRulesChooserPresenter class >> openWithEnvironment: anEnvironment removeTestCase: aBoolean [

	^ self new
		items: self items;
		environment: anEnvironment;
		removeTestCase: aBoolean;
		updateTree;
		openWithSpec
		
]

{ #category : #adding }
CBRulesChooserPresenter >> addAll [

	selectedList roots do: [ :group | selectedRules addAll: group rules ].
	self update.
	nextButton enabled: selectedRules isNotEmpty.
]

{ #category : #adding }
CBRulesChooserPresenter >> addSelected [

	list selectedItem ifNotNil: [ :item | 
		item isComposite
			ifFalse: [ selectedRules add: item ]
			ifTrue: [ selectedRules addAll: item rules ] ].
	self update.
	nextButton enabled: selectedRules isNotEmpty.
]

{ #category : #initialization }
CBRulesChooserPresenter >> environment: aEnviroment [

	environment := aEnviroment
]

{ #category : #initialization }
CBRulesChooserPresenter >> groupRules [
	^ #(
	#'API Change'
	#'API Hints'
	#'Architectural'
	#'Bugs'
	#'Coding Idiom Violation'
	#'Design Flaws'
	#'Optimization'
	#'Potential Bugs'
	#'Rubric'
	#'SUnit'
	#'Style'
	#'Unclassified rules'  )
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
	self update.
	nextButton enabled: selectedRules isNotEmpty
]

{ #category : #accessing }
CBRulesChooserPresenter >> removeSelected [

	selectedList selectedItem ifNotNil: [ :item | 
		(self groupRules includes: item name)
			ifTrue: [ selectedRules removeAll: item rules ]
			ifFalse: [ selectedRules remove: item ] ].
	self update.
	nextButton enabled: selectedRules isNotEmpty
]

{ #category : #initialization }
CBRulesChooserPresenter >> removeTestCase: aBoolean [

	removeTestCase := aBoolean
]

{ #category : #accessing }
CBRulesChooserPresenter >> selectedItems [

	^ selectedItems ifNil: [ selectedItems := #() ]
]

{ #category : #accessing }
CBRulesChooserPresenter >> selectedRules [

	^ selectedRules
]

{ #category : #accessing }
CBRulesChooserPresenter >> selectedRules: anObject [

	selectedRules := anObject
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
