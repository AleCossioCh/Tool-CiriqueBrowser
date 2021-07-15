Class {
	#name : #CBSingleCodeCritiqueResultList,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'criticsModel',
		'buttonBar',
		'sourceCodeModel',
		'textInputFieldModel',
		'cache',
		'thread',
		'selectDiffButton',
		'transformButton',
		'falsePositiveButton',
		'browseButton',
		'unifiedPresenter',
		'splitPresenter'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
CBSingleCodeCritiqueResultList class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #criticsModel;
		  add: #sourceCodeModel;
		  yourself
]

{ #category : #icons }
CBSingleCodeCritiqueResultList class >> exclamationIcon [ 

	^  icons
			at: #'exclamationIcon'
			ifAbsentPut:[ Form fromBinaryStream: self exclamationIconContents base64Decoded readStream ].

]

{ #category : #icons }
CBSingleCodeCritiqueResultList class >> exclamationIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJPSURBVDjLpZPLS5RhFMYfv9QJ
lelTQZwRb2OKlKuINuHGLlBEBEOLxAu46oL0F0QQFdWizUCrWnjBaDHgThCMoiKkhUONTqmj
mDp2GZ0UnWbmfc/ztrC+GbM2dXbv4ZzfeQ7vefKMMfifyP89IbevNNCYdkN2kawkCZKfSPZT
OGTf6Y/m1uflKlC3LvsNTWArr9BT2LAf+W73dn5jHclIBFZyfYWU3or7T4K7AJmbl/yG7EtX
1BQXNTVCYgtgbAEAYHlqYHlrsTEVQWr63RZFuqsfDAcdQPrGRR/JF5nKGm9xUxMyr0YBAEXX
HgIANq/3ADQobD2J9fAkNiMTMSFb9z8ambMAQER3JC1XttkYGGZXoyZEGyTHRuBuPgBTUu7V
SnUAgAUAWutOV2MjZGkehgYUA6O5A0AlkAyRnotiX3MLlFKduYCqAtuGXpyH0XQmOj+TIURt
51OzURTYZdBKV2UBSsOIcRp/TVTT4ewK6idECAihtUKOArWcjq/B8tQ6UkUR31+OYXP4sTOd
isivrkMyHodWejlXwcC38Fvs8dY5xaIId89VlJy7ACpCNCFCuOp8+BJ6A631gANQSg1mVmOx
xGQYRW2nHMha4B5WA3chsv22T5/B13AIicWZmNZ6cMchTXUe81Okzz54pLi0uQWp+TmkZqMw
xsBV74Or3od4OISPr0e3SHa3PX0f3HXKofNH/UIG9pZ5PeUth+CyS2EMkEqs4fPEOBJLsysk
e48/+xD8oxcAYPzs4QaS7RR2kbLTTOTQieczfzfTv8QPldGvTGoF6/8AAAAASUVORK5CYII='
]

{ #category : #'class initialization' }
CBSingleCodeCritiqueResultList class >> initialize [
	
	icons := IdentityDictionary new
]

{ #category : #specs }
CBSingleCodeCritiqueResultList class >> title [

	^ 'Critic Browser'
]

{ #category : #icons }
CBSingleCodeCritiqueResultList class >> wrenchOrangeIcon [

	^  icons
			at: #'wrenchOrangeIcon'
			ifAbsentPut:[ Form fromBinaryStream: self wrenchOrangeIconContents base64Decoded readStream ].

]

{ #category : #icons }
CBSingleCodeCritiqueResultList class >> wrenchOrangeIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHaSURBVDjLlZO7a1NRHMfzfzhI
KQ5OHR1ddRRBLA6lg4iTd5PSas37YR56Y2JiHgg21uoFxSatCVFjbl5iNBBiMmUJgWwZhCB4
pR9/V4QKfSQdDufF5/v7nu85xwJYprV0Oq0kk8luIpEw4vG48f/eVDiVSikCTobDIePxmGg0
yokEBO4OBgNGoxH5fJ5wOHwygVgsZpjVW60WqqqWzbVgMIjf78fn8xlTBcTy736/T7VaJRQK
fQoEArqmafR6Pdxu9/ECkUjkglje63Q6NBoNisUihUKBcrlMpVLB6XR2D4df3VQnmRstsWzU
63WazSZmX6vV0HWdUqmEw+GY2Gw25SC8dV1l1wrZNX5s3qLdbpPL5fB6vXumZalq2O32rtVq
VQ6GuGnCd+HbFnx9AZrC+MkSHo/np8vlmj/M7f4ks6yysyawgB8fwPv70HgKG8v8cp/7fFRO
/+AllewqNJ/DhyBsi9A7J1QTkF4E69mXRws8u6ayvSJwRqoG4K2Md+ygxyF5FdbPaMfdlIXU
ZfiyAUWx/OY25O4JHBP4CtyZ16a9EwuRi1CXs+5K1ew6lB9DXERX517P8tEsPDzfNIP6C5Ye
QewSrJyeCd4P0bnwXYISy3MCn5oZNtsf3pH46e7XBJcAAAAASUVORK5CYII='
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> addCriticToFalsePositive [
	
	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addFalsePositive: item
				forRule: rule ]].
	
	
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> addCriticToToDo [

	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addToDo: item
				forRule: rule ]].
		

]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> addRuleToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache addFalsePositiveRule: rule forPackage: critic mcWorkingCopy]].
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> applyTransformation [

	| crit changesBrowser |
	crit := criticsModel selectedItem.
	changesBrowser := (ChangesBrowser changes: { crit change })
		                  extent: 500 @ 400;
		                  yourself.

	changesBrowser openDialogWithSpec
		okAction: [ changesBrowser accept ];
		centered
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> banRule [

	| crit |
						  crit := criticsModel selectedItem.
						  crit guidedBan
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> browseButton [

	^ browseButton
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> browseCritic [
	criticsModel selectedItem
		ifNotNil: [ :element |
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior 
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ] 
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> browseDependencies [
	criticsModel selectedItems ifNotNil: [ :packages |
		(DAPackageAnalyzerPackageDependenciesWindow onPackagesNamed: (packages collect: [:aPackage | aPackage packageName])) open ]
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> buildMenuCritique [ 

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Browse' translated;
						  action: [ self browseCritic ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'Mark as wrong' translated;
					  visibleIf: [ self isCritiqueFalsePositive not ];
					  action: [ self addCriticToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Unmark as wrong' translated;
					  visibleIf: [ self isCritiqueFalsePositive ];
					  action: [ self removeCriticToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Unmark as To Do' translated;
					  visibleIf: [ self isCritiqueToDo ];
					  action: [ self removeCriticToToDo ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Mark as To Do' translated;
					  visibleIf: [ self isCritiqueToDo not ];
					  action: [ self addCriticToToDo ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'View rationale behind the rule' translated;
					  action: [ self rationaleOfRule ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Automatically resolve the issue' translated;
					  visibleIf: [ criticsModel selectedItem providesChange ];
					  action: [ self applyTransformation ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Ban this rule' translated;
					  action: [ self banRule ] ] ];
		  yourself
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> buttonBar [

	^ buttonBar
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> cache:  acache [ 
	cache := acache
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> connectPresenters [

	self whenSelectedItemChangesOnListModel
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> criticsModel [
	^ criticsModel
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> criticsModelContains: aCritic [

	^ criticsModel listItems anySatisfy: [ :each |
			 each sourceAnchor entity name = aCritic name]
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> criticsOf: aRule [
	cache ifNil: [^ {}].
	criticsModel items: ((cache criticsOf: aRule)
				sorted: [ :a :b | 
					a printString < b printString ]).
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> defaultColor [
	^ Color red 
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> diffSeparator [

	^ '——————————————————
	
'
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> diffTextForChange: aRefactoryChange [

	| text builder |
	text := Text new.
	builder := PrettyTextDiffBuilder new.
	aRefactoryChange changes
		do: [ :chng | 
			builder from: chng oldVersionTextToDisplay to: chng textToDisplay.
			text append: builder buildDisplayPatch ]
		separatedBy: [ text append: self diffSeparator ].

	^ text
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> falsePositiveButton [

	^ falsePositiveButton
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> falsePositiveColor [
	^ Color darkGray
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> formatCritic: aCritic [
	
	^  String streamContents: [:s | aCritic sourceAnchor entity criticNameOn: s ]

]

{ #category : #private }
CBSingleCodeCritiqueResultList >> iconFor: anItem [

	^ (cache isFalsePositive: anItem forRule: rule) ifFalse: [ 
		  (cache isToDo: anItem forRule: rule)
			  ifTrue: [ self class wrenchOrangeIcon ]
			  ifFalse: [ 
				  | severity |
				  severity := rule severity.
				  severity == #information
					  ifTrue: [ self iconNamed: #smallInfo ]
					  ifFalse: [ 
						  severity == #warning
							  ifTrue: [ self iconNamed: #smallWarning ]
							  ifFalse: [ self iconNamed: #smallError ] ] ] ]
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> implementorsOfCritic [
	criticsModel selectedItem ifNotNil: [ :item | item browse] 

]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> initialize [

	super initialize.
	self initializeShortcuts
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> initializeDisplayCritic: aCritic forRule: aRule [

	| criticRepresentation |
	criticRepresentation := (self formatCritic: aCritic) asMorph.
	^ (cache isFalsePositive: aCritic forRule: aRule)
		  ifTrue: [ criticRepresentation color: self falsePositiveColor ]
		  ifFalse: [ 
			  (cache isToDo: aCritic forRule: aRule)
				  ifTrue: [ criticRepresentation color: self toDoColor ]
				  ifFalse: [ criticRepresentation color: self class theme textColor ] ]
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> initializePresenters [

	criticsModel := self newList.
	sourceCodeModel := self newCode.
	sourceCodeModel beNotEditable.
	self instantiateCriticsToolbar.
	textInputFieldModel := self newTextInput.
	criticsModel beMultipleSelection.
	self initializeTextInputFieldModel.
	criticsModel display: [ :selec | 
		self initializeDisplayCritic: selec forRule: rule ].
	criticsModel contextMenu: self buildMenuCritique.
	criticsModel displayIcon: [ :item | self iconFor: item ].
	self focusOrder
		add: criticsModel;
		add: buttonBar;
		add: sourceCodeModel
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> initializeShortcuts [
	criticsModel bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> initializeTextInputFieldModel [

	|critics|
	textInputFieldModel 
		autoAccept: true;
		placeholder: 'Search field';
		text: ' ';
		removeEntryCompletion.	
	textInputFieldModel acceptDrop: [ :text | |matchText|
		critics :=cache criticsOf: rule.
		matchText := '*', text, '*'.
		criticsModel items: (text isEmpty 
			ifTrue: [ critics ]
			ifFalse: [ critics select: [ :critic |
				matchText match: (self formatCritic: critic)]]).
		criticsModel updateList ]

]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> instantiateCriticsToolbar [

	selectDiffButton := self newSelectDiffButton.
	transformButton := self newTransformButton.
	falsePositiveButton := self newFalsePositiveButton.
	browseButton := self newBrowseButton.
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> isCritiqueFalsePositive [ 
	^ criticsModel selectedItems anySatisfy: [ :critic | 
								  (cache isFalsePositive: critic forRule: rule)]
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> isCritiqueToDo [
^ criticsModel selectedItems anySatisfy: [ :critic | 
		 cache isToDo: critic forRule: rule ]
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> newBrowseButton [

	^ self newButton
		  label: 'Browse';
		  icon: (self iconNamed: #nautilus);
		  help: 'Explore and modify in System Browser';
		  action: [ self browseCritic ];
		  yourself
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> newFalsePositiveButton [

	^ self newButton
		  label: 'Mark as wrong';
		  icon: (self iconNamed: #stop);
		  action: [ self addCriticToFalsePositive ];
		  yourself
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> newSelectDiffButton [

	^ self newDropList
		  display: [:options | options name ]; 
		  help: 'Select diff view';
		  whenSelectedItemChangedDo: [ :aClass | aClass crTrace ];
		  yourself
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> newTransformButton [

	^ self newButton
		  label: 'Transform';
		  icon: (self iconNamed: #repair);
		  help: 'Apply changes to solve issue';
		  action: [ self transformCritic ];
		  yourself
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> rationaleOfRule [

	| crit |
						  crit := criticsModel selectedItem.
						  crit popDescriptionUp.
						  ReSystemAnnouncer uniqueInstance
							  notifyCritique: crit
							  descriptionViewedFor: crit sourceAnchor entity 
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> removeCriticToFalsePositive [
	
	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache removeFalsePositive: item forRule: rule ]].
	
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> removeCriticToToDo [

	criticsModel selectedItems
		ifNotNil: [:items | items do: [ :item |
			cache removeToDo: item forRule: rule ]].
	
	
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> removeRuleToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache removeFalsePositiveRule: rule forPackage: critic sourceAnchor entity mcWorkingCopy]].
]

{ #category : #api }
CBSingleCodeCritiqueResultList >> resetSelection [
	self criticsModel resetListSelection
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> rule [
	^ rule
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> rule: aRule [

	rule := aRule.
	(rule isNil or: [ rule isComposite ]) 
		ifTrue: [ ^ self ].	
	self criticsOf:  aRule.
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> selectDiffButton [

	^ selectDiffButton
]

{ #category : #'smartSuggestions - support' }
CBSingleCodeCritiqueResultList >> selectedMessage [
	^ nil
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> selectionIntervalFor: aString [
	^ rule result selectionIntervalFor: aString
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> sendersOfCritic [
	criticsModel selectedItem
		ifNotNil: [ :elem | 
			elem isBehavior
				ifTrue: [ self systemNavigation browseAllCallsOnClass: elem ]
				ifFalse: [ self systemNavigation browseAllSendersOf: elem selector ] ]
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> setTextModelForClassOrMethod: aCritique [

	| entity |
	entity := aCritique sourceAnchor entity.
	self flag:
		'Another hack. We need a better way to display entities (because now we may get not only classes and methods. Maybe something like GTInspector presentations could work)'.
	sourceCodeModel text: ((entity respondsTo: #definition)
			 ifTrue: [ entity definitionString ]
			 ifFalse: [ entity asString ]).
	sourceCodeModel behavior: (entity isCompiledMethod
			 ifTrue: [ entity methodClass ]
			 ifFalse: [ nil ]).
	aCritique sourceAnchor providesInterval ifTrue: [ 
		sourceCodeModel selectionInterval: aCritique sourceAnchor interval ]
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> setTextModelForNil [

	| text |
	text := rule rationale isEmpty
		        ifTrue: [ rule name ]
		        ifFalse: [ rule rationale ].
	sourceCodeModel text: text.
	sourceCodeModel behavior: nil
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> setTextModelForTransformationRule: selection [
	
	sourceCodeModel behavior: nil.
	sourceCodeModel text: (
		self diffTextForChange: selection change).

									
					
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> sourceCodeModel [ 

	^ sourceCodeModel
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> textInputFieldModel [
	^ textInputFieldModel
]

{ #category : #private }
CBSingleCodeCritiqueResultList >> toDoColor [
	^ Color orange
]

{ #category : #accessing }
CBSingleCodeCritiqueResultList >> transformButton [

	^ transformButton
]

{ #category : #menu }
CBSingleCodeCritiqueResultList >> transformCritic [

	criticsModel selectedItem ifNotNil: [ :element | 
		element change execute
		]
]

{ #category : #thread }
CBSingleCodeCritiqueResultList >> updateList [

	self criticsOf: rule.
	thread ifNotNil: [ thread terminate ].
	thread := [ UIManager default defer:  [ criticsModel updateList ]] fork.
]

{ #category : #initialization }
CBSingleCodeCritiqueResultList >> whenSelectedItemChangesOnListModel [

	criticsModel whenSelectionChangedDo: [ :aSelection | 
		| critique |
		critique := aSelection selectedItem.
		sourceCodeModel selectionInterval: (0 to: 0).
		rule ifNotNil: [ 
			critique ifNil: [ self setTextModelForNil ] ifNotNil: [ 
				critique providesChange
					ifTrue: [ self setTextModelForTransformationRule: critique ]
					ifFalse: [ self setTextModelForClassOrMethod: critique ] ] ] ]
]
