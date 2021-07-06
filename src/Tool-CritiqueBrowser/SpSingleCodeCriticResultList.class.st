Class {
	#name : #SpSingleCodeCriticResultList,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'criticsModel',
		'toolbarModel',
		'sourceCodeModel',
		'textInputFieldModel',
		'cache',
		'thread'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
SpSingleCodeCriticResultList class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #criticsModel;
		  add: #toolbarModel height: 25;
		  add: #sourceCodeModel;
		  yourself
]

{ #category : #icons }
SpSingleCodeCriticResultList class >> exclamationIcon [ 

	^  icons
			at: #'exclamationIcon'
			ifAbsentPut:[ Form fromBinaryStream: self exclamationIconContents base64Decoded readStream ].

]

{ #category : #icons }
SpSingleCodeCriticResultList class >> exclamationIconContents [
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
SpSingleCodeCriticResultList class >> initialize [
	
	icons := IdentityDictionary new
]

{ #category : #specs }
SpSingleCodeCriticResultList class >> title [

	^ 'Critic Browser'
]

{ #category : #icons }
SpSingleCodeCriticResultList class >> wrenchOrangeIcon [

	^  icons
			at: #'wrenchOrangeIcon'
			ifAbsentPut:[ Form fromBinaryStream: self wrenchOrangeIconContents base64Decoded readStream ].

]

{ #category : #icons }
SpSingleCodeCriticResultList class >> wrenchOrangeIconContents [
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
SpSingleCodeCriticResultList >> addCriticToFalsePositive [
	
	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addFalsePositive: item
				forRule: rule ]].
	
	
]

{ #category : #menu }
SpSingleCodeCriticResultList >> addCriticToToDo [

	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addToDo: item
				forRule: rule ]].
		

]

{ #category : #menu }
SpSingleCodeCriticResultList >> addMarkingMenuItemsTo: aMenu [
	(criticsModel selectedItems anySatisfy: [ :critic | cache isFalsePositive: critic forRule: rule ]) 
		ifTrue: [ aMenu add: 'Unmark as wrong' target: self selector: #removeCriticToFalsePositive ].
	(criticsModel selectedItems anySatisfy: [ :critic | (cache isFalsePositive: critic forRule: rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as wrong' target: self selector: #addCriticToFalsePositive ].
	(criticsModel selectedItems anySatisfy: [ :critic | cache isToDo: critic forRule: rule ]) 
		ifTrue: [ aMenu add: 'Unmark as TODO' target: self selector: #removeCriticToToDo ].
	(criticsModel selectedItems anySatisfy: [ :critic | (cache isToDo: critic forRule: rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as TODO' target: self selector: #addCriticToToDo ].
	
]

{ #category : #menu }
SpSingleCodeCriticResultList >> addNavigationMenuItemsTo: aMenu [

	criticsModel selectedItem ifNotNil: [ :critique |
		critique sourceAnchor entity populateCBMenu: aMenu ]
]

{ #category : #menu }
SpSingleCodeCriticResultList >> addRuleToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache addFalsePositiveRule: rule forPackage: critic mcWorkingCopy]].
]

{ #category : #menu }
SpSingleCodeCriticResultList >> browseCritic [
	criticsModel selectedItem
		ifNotNil: [ :element |
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior 
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ] 
]

{ #category : #menu }
SpSingleCodeCriticResultList >> browseDependencies [
	criticsModel selectedItems ifNotNil: [ :packages |
		(DAPackageAnalyzerPackageDependenciesWindow onPackagesNamed: (packages collect: [:aPackage | aPackage packageName])) open ]
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> buildMenu [

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Browse' translated;
						  action: [ self browseCritic ] ].
			  group addItem: [ :item | 
				  item
					  name: 'References to...' translated;
					  action: [  ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'Mark as wrong' translated;
					  action: [ self addCriticToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Mark as TODO' translated;
					  action: [  ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'View rationale behind the rule' translated;
					  action: [  ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Automatically resolve the issue' translated;
					  action: [  ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Ban this rule' translated;
					  action: [  ] ] ];
		  yourself
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> cache:  acache [ 
	cache := acache
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> connectPresenters [

	self whenSelectedItemChangesOnListModel
]

{ #category : #menu }
SpSingleCodeCriticResultList >> criticMenu [

	| aMenu |
	aMenu := self buildMenu.
	(rule notNil and: [ criticsModel selectedItems notEmpty ]) ifFalse: [ 
		^ aMenu ].

	self addNavigationMenuItemsTo: aMenu.
	self addMarkingMenuItemsTo: aMenu.

	criticsModel selectedItem ifNotNil: [ :critique | 
		critique actions ifNotEmpty: [ :actions | 
			aMenu addLine.
			actions do: [ :action | 
				aMenu
					add: action description
					target: action
					selector: #actOnCritic:ofEntity:
					argumentList: { 
							critique.
							critique sourceAnchor entity } ] ] ].

	^ aMenu
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> criticsModel [
	^ criticsModel
]

{ #category : #private }
SpSingleCodeCriticResultList >> criticsModelContains: aCritic [

	^ criticsModel listItems anySatisfy: [ :each |
			 each sourceAnchor entity name = aCritic name]
]

{ #category : #private }
SpSingleCodeCriticResultList >> criticsOf: aRule [
	cache ifNil: [^ {}].
	criticsModel items: ((cache criticsOf: aRule)
				sorted: [ :a :b | 
					a printString < b printString ]).
]

{ #category : #private }
SpSingleCodeCriticResultList >> defaultColor [
	^ Color red
]

{ #category : #private }
SpSingleCodeCriticResultList >> diffSeparator [

	^ '——————————————————
	
'
]

{ #category : #private }
SpSingleCodeCriticResultList >> diffTextForChange: aRefactoryChange [
	| text builder |

	text := Text new.
	builder := PrettyTextDiffBuilder new.
	aRefactoryChange changes
		do: [ :chng |
			builder
				from: chng oldVersionTextToDisplay
				to: chng textToDisplay.
			text append: builder buildDisplayPatch ]
		separatedBy: [ text append: self diffSeparator ].
	
	^ text
]

{ #category : #private }
SpSingleCodeCriticResultList >> falsePositiveColor [
	^ Color darkGray
]

{ #category : #private }
SpSingleCodeCriticResultList >> formatCritic: aCritic [
	
	^  String streamContents: [:s | aCritic sourceAnchor entity criticNameOn: s ]

]

{ #category : #private }
SpSingleCodeCriticResultList >> iconFor: anItem [
	
	^  (cache isFalsePositive: anItem forRule: rule) 
			ifFalse: [(cache isToDo: anItem forRule: rule)
				ifTrue: [ self class wrenchOrangeIcon ]
				ifFalse: [ self class exclamationIcon ] ]
]

{ #category : #menu }
SpSingleCodeCriticResultList >> implementorsOfCritic [
	criticsModel selectedItem ifNotNil: [ :item | item browse] 

]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initialize [

	super initialize.
	self initializeShortcuts
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initializeActionToPerformOnTextModel [
	
	| selectedItem |
	sourceCodeModel acceptDrop:  [ :text | 	
		selectedItem := criticsModel selectedItem sourceAnchor entity.
		(selectedItem isCompiledMethod and: [ rule isTransformationRule not ])
			ifTrue: [ selectedItem methodClass compile: text ] 
			ifFalse: [ Smalltalk compiler evaluate:  text ]]
	

]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initializeDisplayCritic: aCritic forRule: aRule [

	| criticRepresentation |
	criticRepresentation := (self formatCritic: aCritic) asMorph.
	^ (cache isFalsePositive: aCritic forRule: aRule)
		  ifTrue: [ criticRepresentation color: self falsePositiveColor ]
		  ifFalse: [ 
			  (cache isToDo: aCritic forRule: aRule)
				  ifTrue: [ criticRepresentation color: self toDoColor ]
				  ifFalse: [ criticRepresentation color: self defaultColor ] ]
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initializePresenters [

	| name |
	criticsModel := self newList.
	sourceCodeModel := self newCode.
	toolbarModel := self instantiate: SpCriticToolbar.
	textInputFieldModel := self newTextInput.

	criticsModel beMultipleSelection.
	self initializeTextInputFieldModel.
	self initializeToolBar.
	self initializeActionToPerformOnTextModel.
	criticsModel display: [ :selec | 
		self initializeDisplayCritic: selec forRule: rule ].
	name := criticsModel selectedItems.
	criticsModel contextMenu: self criticMenu.
	criticsModel displayIcon: [ :item | self iconFor: item ].
	self focusOrder
		add: criticsModel;
		add: toolbarModel;
		add: sourceCodeModel
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initializeShortcuts [
	criticsModel bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> initializeTextInputFieldModel [

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
SpSingleCodeCriticResultList >> initializeToolBar [
	
	self toolbarModel whenFalsePositiveClickedDo: [ self addCriticToFalsePositive ].


]

{ #category : #menu }
SpSingleCodeCriticResultList >> removeCriticToFalsePositive [
	
	criticsModel selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache removeFalsePositive: item forRule: rule ]].
	
]

{ #category : #menu }
SpSingleCodeCriticResultList >> removeCriticToToDo [

	criticsModel selectedItems
		ifNotNil: [:items | items do: [ :item |
			cache removeToDo: item forRule: rule ]].
	
	
]

{ #category : #menu }
SpSingleCodeCriticResultList >> removeRuleToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache removeFalsePositiveRule: rule forPackage: critic sourceAnchor entity mcWorkingCopy]].
]

{ #category : #api }
SpSingleCodeCriticResultList >> resetSelection [
	self criticsModel resetListSelection
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> rule [
	^ rule
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> rule: aRule [

	rule := aRule.
	(rule isNil or: [ rule isComposite ]) 
		ifTrue: [ ^ self ].	
	self criticsOf:  aRule.
	toolbarModel rule: rule.
]

{ #category : #'smartSuggestions - support' }
SpSingleCodeCriticResultList >> selectedMessage [
	^ nil
]

{ #category : #private }
SpSingleCodeCriticResultList >> selectionIntervalFor: aString [
	^ rule result selectionIntervalFor: aString
]

{ #category : #menu }
SpSingleCodeCriticResultList >> sendersOfCritic [
	criticsModel selectedItem
		ifNotNil: [ :elem | 
			elem isBehavior
				ifTrue: [ self systemNavigation browseAllCallsOnClass: elem ]
				ifFalse: [ self systemNavigation browseAllSendersOf: elem selector ] ]
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> setTextModelForClassOrMethod: aCritique [

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
		sourceCodeModel setSelection: aCritique sourceAnchor interval ]
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> setTextModelForNil [

	| text |
	text := rule rationale isEmpty 
		ifTrue: [ rule name ]
		ifFalse: [ rule rationale ]. 
	"sourceCodeModel aboutToStyle: false."
	sourceCodeModel text: text.
	sourceCodeModel behavior: nil.
	toolbarModel critic: nil 
	
	
					
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> setTextModelForTransformationRule: selection [
	
	sourceCodeModel behavior: nil.
	sourceCodeModel text: (
		self diffTextForChange: selection change).
	sourceCodeModel aboutToStyle: false.

									
					
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> sourceCodeModel [

	^ sourceCodeModel
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> textInputFieldModel [
	^ textInputFieldModel
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> textModel [
	^ sourceCodeModel
]

{ #category : #private }
SpSingleCodeCriticResultList >> toDoColor [
	^ Color orange
]

{ #category : #accessing }
SpSingleCodeCriticResultList >> toolbarModel [
	^ toolbarModel
]

{ #category : #menu }
SpSingleCodeCriticResultList >> transformCritic [
	
	criticsModel selectedItems ifNotNil: [ :items |
		items do: [:critic | critic change execute ]  displayingProgress: [:critic|]]
]

{ #category : #thread }
SpSingleCodeCriticResultList >> updateList [

	self criticsOf: rule.
	thread ifNotNil: [ thread terminate ].
	thread := [ UIManager default defer:  [ criticsModel updateList ]] fork.
]

{ #category : #initialization }
SpSingleCodeCriticResultList >> whenSelectedItemChangesOnListModel [

	criticsModel whenSelectionChangedDo: [ :aSelection | 
		| critique |
		critique := aSelection selectedItem.
		sourceCodeModel selectionInterval: (0 to: 0).
		rule ifNotNil: [ 
			critique ifNil: [ self setTextModelForNil ] ifNotNil: [ 
				toolbarModel critic: critique.
				critique providesChange
					ifTrue: [ self setTextModelForTransformationRule: critique ]
					ifFalse: [ self setTextModelForClassOrMethod: critique ] ] ] ]
]
