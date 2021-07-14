Class {
	#name : #SpCritiqueBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'criticModel',
		'rulesModel',
		'checker',
		'title',
		'rbEnvironment',
		'removeTestCase',
		'cache',
		'resetButton',
		'logButton',
		'updateButton',
		'textInputFieldModel',
		'criticsModel',
		'sourceCodeModel',
		'browseButton',
		'falsePositiveButton',
		'transformButton',
		'selectDiffButton'
	],
	#category : #'Tool-CritiqueBrowser-Base'
}

{ #category : #menu }
SpCritiqueBrowser class >> criticsBrowserMenuOn: aBuilder [ 
	<worldMenu>
	
	(aBuilder item: 'Critique Browser')
		action: [ self openOnCurrentWorkingConfiguration];
		order: 2;
		parent: #Browsing;
		help: 'To manage rule checks.';
		icon: self icon
]

{ #category : #specs }
SpCritiqueBrowser class >> defaultSpec [

	^ SpPanedLayout newTopToBottom
		  add: (SpPanedLayout newLeftToRight
				   add: (SpBoxLayout newTopToBottom
						    add: #rulesModel;
						    add: (SpBoxLayout newLeftToRight
								     add: #resetButton;
								     add: #updateButton;
								     add: #logButton;
								     yourself)
						    height: 25;
						    yourself);
				   add: (SpBoxLayout newTopToBottom
						    add: #textInputFieldModel height: 20;
						    add: #criticsModel;
						    add: (SpBoxLayout newLeftToRight
								     add: #browseButton;
								     add: #falsePositiveButton;
								     add: #transformButton;
								     add: #selectDiffButton;
								     yourself)
						    height: 25;
						    yourself);
						yourself);
		  add: #sourceCodeModel;
		  yourself
]

{ #category : #icons }
SpCritiqueBrowser class >> icon [

	"Answer an icon for the receiver."

	^ self iconNamed: #error
]

{ #category : #'instance creation' }
SpCritiqueBrowser class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #menu }
SpCritiqueBrowser class >> openOnCurrentWorkingConfiguration [

	<script>
	SpCriticWorkingConfiguration exists
		ifTrue: [ SpResetWindow new openWithSpec ]
		ifFalse: [ SpSelectPackageBrowser open ]
]

{ #category : #'instance creation' }
SpCritiqueBrowser class >> openOnRule: aRule onEnvironment: aEnv [

	| cbr |
	cbr :=  self new rules: aRule;
		environment: aEnv;
		removeTestCase: false;
		yourself.
		
	cbr openWithSpec.
	cbr applyRules. 
	cbr rulesModel changed:  #listElementAt:
]

{ #category : #'instance creation' }
SpCritiqueBrowser class >> openOnWorkingConfiguration: aWorkingConfiguration [

	| cbr |
	cbr := self new 
		rules: aWorkingConfiguration rule;
		environment: aWorkingConfiguration environment;
		removeTestCase: aWorkingConfiguration removeTestCase;
		yourself.

	cbr openWithSpec.
	cbr applyRules. 
	cbr rulesModel  changed:  #listElementAt:
]

{ #category : #'instance creation' }
SpCritiqueBrowser class >> openWindow [
	<script>
	
	| env rules |
	rules :=  RBCompositeLintRule allGoodRules rules.
	env := RBBrowserEnvironment default.
	self openOnRule: rules onEnvironment: env
	
	
]

{ #category : #icons }
SpCritiqueBrowser class >> taskbarIconName [

	^#smallWarningIcon
]

{ #category : #'user interface' }
SpCritiqueBrowser >> addModelItemsToWindowMenu: aMenu [
	"Add model-related items to the window menu"

	aMenu
		addLine;
		add: 'Clean all manifest' target: checker selector: #cleanAllManifest;
		add: 'Reapply all  rules' target: self selector: #reapplyAllRules
]

{ #category : #private }
SpCritiqueBrowser >> addRuleToFalsePositive [

	rulesModel selectedItem ifNotNil: [ :rule | 
		rule leaves do: [ :r | 
			rbEnvironment packages do: [ :package | 
				cache addFalsePositiveRule: r forPackage: package ] ] ]
]

{ #category : #private }
SpCritiqueBrowser >> allRules [
	^ rulesModel roots flatCollect: #rules
]

{ #category : #private }
SpCritiqueBrowser >> applyRules [
	| packageCount nbPackage process rules |
	rules := self allRules.
	nbPackage := rbEnvironment packages size.
	packageCount := 0.
	self updateTree.
	process := [ rbEnvironment packages
		do: [ :package | 
			| windowTitle |
			packageCount := packageCount + 1.
			windowTitle := String
				streamContents: [ :s | 
					s << 'run rules on ' << package packageName << ' ('
						<< packageCount asString << '/' << nbPackage asString << ')' ].
			self setTitle: windowTitle.
			checker
				runRules: rules
				onPackage: package
				withoutTestCase: removeTestCase ].
	checker rule: rules.
	self setTitle: self defaultTitle.
	cache packages: rbEnvironment.
	cache initCache.
	self updateTree.
	self registerToAnnouncements ] newProcess.
	process name: 'SmallLint'.
	process resume
]

{ #category : #accessing }
SpCritiqueBrowser >> browseButton [

	^ criticModel browseButton 
]

{ #category : #private }
SpCritiqueBrowser >> browseRule [

	rulesModel selectedItem ifNotNil: [ :item | item browse ]
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> classAdded: aClass [

	| rules |

	(rbEnvironment definesClass: aClass) ifFalse: [ ^ self ].

	rules := self allRules.
	checker
		resetResult;
		checkClass: aClass.
		
	rules do: [ :rule |		
		(checker criticsOf: rule) do:	[ :crit |
			cache addCritic: crit forRule: rule ].
		(checker falsePositiveOf: rule) do:	[ :crit |
			cache addFalsePositive: crit forRule: rule ].
		(checker toDoOf: rule) do:	[ :crit |
			cache addToDo: crit forRule: rule ] ].
	
	cache updateBrowser.
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> classRemoved: aClass [

	(rbEnvironment definesClass: aClass)
		ifTrue: [ cache itemRemoved: aClass ].
		
	cache updateBrowser
]

{ #category : #private }
SpCritiqueBrowser >> colorForRule: aRule [
	| total |
	^ (total := cache criticsOf: aRule)
		ifEmpty: [ criticModel falsePositiveColor ]
		ifNotEmpty: [ (cache falsePositiveOf: aRule) = total
				ifTrue: [ criticModel falsePositiveColor ]
				ifFalse: [ self class theme textColor  ]]
]

{ #category : #initialization }
SpCritiqueBrowser >> connectPresenters [

	rulesModel whenSelectedItemChangedDo: [ :rule | 
		(rule isNil or: [ rule isComposite ]) ifFalse: [ 
			criticModel
				resetSelection;
				rule: rule;
				setTextModelForNil ].
		self setTitle:
			(rule ifNil: [ self defaultTitle ] ifNotNil: [ rule name ]) ]
]

{ #category : #accessing }
SpCritiqueBrowser >> criticModel [
	^ criticModel
]

{ #category : #accessing }
SpCritiqueBrowser >> criticsModel [

	^ criticModel criticsModel
]

{ #category : #api }
SpCritiqueBrowser >> defaultTitle [

	^ 'Critique Browser'
]

{ #category : #accessing }
SpCritiqueBrowser >> environment [
	^ rbEnvironment

]

{ #category : #accessing }
SpCritiqueBrowser >> environment: aEnv [
	rbEnvironment := aEnv

]

{ #category : #accessing }
SpCritiqueBrowser >> falsePositiveButton [
	^ criticModel falsePositiveButton
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleClassAdded: anAnnouncement [

	self classAdded: anAnnouncement classAdded

]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleClassModified: anAnnouncement [

	self
		classRemoved: anAnnouncement oldClassDefinition;
		classAdded: anAnnouncement newClassDefinition
	
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleClassRemoved: anAnnouncement [

	self classRemoved: anAnnouncement classRemoved

]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleMethodAdded: anAnnouncement [

	self methodAdded: anAnnouncement methodAdded

]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleMethodModified: anAnnouncement [

	self
		methodRemoved: anAnnouncement oldMethod;
		methodAdded: anAnnouncement newMethod
	

]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> handleMethodRemoved: anAnnouncement [

	self methodRemoved: anAnnouncement methodRemoved

]

{ #category : #initialization }
SpCritiqueBrowser >> initialize [
	
	super initialize.
	cache := ReCriticsCache new.
	checker := ReSmalllintChecker new.
	cache checker: checker.
	cache browser: self.
	criticModel cache: cache
]

{ #category : #initialization }
SpCritiqueBrowser >> initializePresenters [
	
	title := self defaultTitle.
	rulesModel := self newTreeTable.
	resetButton := self newButton.
	updateButton := self newButton.
	logButton := self newButton.

	self setLogButton.
	self setResetButton.
	self setUpdateButton.

	criticModel := SpSingleCodeCriticResultList new.
	textInputFieldModel := self textInputFieldModel.
	criticsModel := self criticsModel.
	sourceCodeModel := self sourceCodeModel.
	selectDiffButton := self selectDiffButton.
	transformButton := self transformButton.
	falsePositiveButton := self falsePositiveButton.
	browseButton := self browseButton.
	rulesModel children: [ :rule | 
		rule isComposite
			ifTrue: [ rule rules asArray ]
			ifFalse: [ #(  ) ] ].
	
	rulesModel addColumn: ((SpStringTableColumn evaluated: [ :rule |
			 self stringMorphForRule: rule ]) title: 'Rules Group').
	rulesModel contextMenu: self ruleMenu.

	self focusOrder
		add: rulesModel;
		add: criticModel
]

{ #category : #'user interface' }
SpCritiqueBrowser >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self defaultTitle;
		initialExtent: 760 @ 370
]

{ #category : #accessing }
SpCritiqueBrowser >> logButton [
	^ logButton 
]

{ #category : #private }
SpCritiqueBrowser >> logInManifest [
	cache logInManifest
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> methodAdded: aMethod [

	| rules |

	(rbEnvironment includesMethod: aMethod) ifFalse: [ ^ self ].

	rules := self allRules.
	checker
		resetResult;
		getCritiquesAbout: aMethod by: (rules select: [ :r | r class checksMethod ]).

	rules do: [ :rule |		
		(checker criticsOf: rule) do:	[ :crit |
			cache addCritic: crit forRule: rule ].
		(checker falsePositiveOf: rule) do:	[ :crit |
			cache addFalsePositive: crit forRule: rule ].
		(checker toDoOf: rule) do:	[ :crit |
			cache addToDo: crit forRule: rule ] ].
	
	cache updateBrowser.
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> methodRemoved: aMethod [

	(rbEnvironment includesMethod: aMethod)
		ifTrue: [ cache itemRemoved: aMethod ].
		
	cache updateBrowser
]

{ #category : #api }
SpCritiqueBrowser >> onWindowClosed [

	self unregisterFromAnnouncements.

	cache cacheChange 
		ifTrue: [	
			(UIManager default confirm: 'Do you want log all wrong violations in the Manifests
before closing the Critics Browser ?')
				ifTrue: [ cache logInManifest ]].
	

]

{ #category : #display }
SpCritiqueBrowser >> open [

	^ self openWithSpec
]

{ #category : #private }
SpCritiqueBrowser >> reapplyAllRules [
	
	cache initialize.
	self applyRules 
]

{ #category : #private }
SpCritiqueBrowser >> reapplyRule: aRule [

	cache removeRule: aRule.
	checker resetResult.
	rbEnvironment packages do: [ :package | 
		checker runRules: { aRule } onPackage: package withoutTestCase: removeTestCase ]. 
	(checker criticsOf: aRule) do:	[ :crit |
		cache addCritic: crit forRule: aRule ].
	(checker falsePositiveOf: aRule) do:	[ :crit |
		cache addFalsePositive: crit forRule: aRule ].
	(checker toDoOf: aRule) do:	[ :crit |
		cache addToDo: crit forRule: aRule ].	
	
	cache updateBrowser
]

{ #category : #private }
SpCritiqueBrowser >> reapplyThisRule [

	| rule |
	rulesModel selectedItem ifNil: [ ^ self ].
	rule := rulesModel selectedItem.
	rule isComposite 
		ifTrue: [ rule rules do: [ :each | self reapplyRule: each ] ]
		ifFalse: [ self reapplyRule: rule ]
	

]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> registerToAnnouncements [
	
	self unregisterFromAnnouncements.
	
	SystemAnnouncer uniqueInstance weak
		when: ClassAdded send: #handleClassAdded: to: self;
		when: ClassModifiedClassDefinition send: #handleClassModified: to: self;
		when: ClassRemoved send: #handleClassRemoved: to: self;
		when: MethodAdded send: #handleMethodAdded: to: self;
		when: MethodModified send: #handleMethodModified: to: self;
		when: MethodRemoved send: #handleMethodRemoved: to: self.
	self window window announcer when: WindowClosed send: #onWindowClosed to: self
]

{ #category : #private }
SpCritiqueBrowser >> removeRuleToFalsePositive [

	rulesModel selectedItem ifNotNil: [ :rule |
		rule leaves do: [ :r |
			rbEnvironment packages do: [ :package |
				 cache removeFalsePositiveRule: r forPackage: package ]]]

	
	
]

{ #category : #accessing }
SpCritiqueBrowser >> removeTestCase: aBoolean [
	removeTestCase :=  aBoolean
]

{ #category : #accessing }
SpCritiqueBrowser >> resetButton [
	^ resetButton 
]

{ #category : #private }
SpCritiqueBrowser >> ruleMenu [

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Browse rule' translated;
						  action: [ self browseRule ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Reapply this rule' translated;
					  action: [ self reapplyThisRule ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'Ban from selected packages' translated;
					  action: [ self addRuleToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Unban from selected packages' translated;
					  action: [ self removeRuleToFalsePositive ] ] ];
		  yourself
]

{ #category : #accessing }
SpCritiqueBrowser >> rules: rulesCollection [

	self rulesModel roots:
		(((rulesCollection groupedBy: #group) associations collect: [ :as | 
			  SpCriticBrowserRulesGroup named: as key rules: as value ]) sorted: [ 
			 :a 
			 :b | a name < b name ])
]

{ #category : #accessing }
SpCritiqueBrowser >> rulesModel [

	^ rulesModel
]

{ #category : #accessing }
SpCritiqueBrowser >> selectDiffButton [
	^ criticModel selectDiffButton 
]

{ #category : #initialization }
SpCritiqueBrowser >> setActionLogButton [
	^ [ (UIManager default
		confirm:
			'Do you want to save all false positive and toDo in the Manifests ?
(this action may generate new manifest classes and make dirty your package)')
		ifTrue: [ cache logInManifest ] ]
]

{ #category : #initialization }
SpCritiqueBrowser >> setActionResetButton [

	^ [ 
	  (UIManager default confirm:
		   'Do you want to delete the current configuration
 and create a new configuration ?') ifTrue: [ 
		  self delete.
		  SpSelectPackageBrowser open ] ]
]

{ #category : #initialization }
SpCritiqueBrowser >> setActionUpdateButton [
	^ [ self reapplyAllRules ]
]

{ #category : #initialization }
SpCritiqueBrowser >> setLogButton [

	logButton 
		state: false;
		label: 'Save Critics';
		action: self setActionLogButton 
]

{ #category : #initialization }
SpCritiqueBrowser >> setResetButton [

	resetButton 
		state: false;
		label: 'Run new configuration';
		action: self setActionResetButton
]

{ #category : #api }
SpCritiqueBrowser >> setTitle: aTitle [

	title := aTitle.
	self withWindowDo: [ :w | w title: aTitle ]
]

{ #category : #initialization }
SpCritiqueBrowser >> setUpdateButton [

	updateButton 
		state: false;
		label: 'Update';
		action: self setActionUpdateButton.
]

{ #category : #accessing }
SpCritiqueBrowser >> sourceCodeModel [

	^ criticModel sourceCodeModel
]

{ #category : #private }
SpCritiqueBrowser >> stringMorphForRule: rule [
	| unclassified falsePositives toDos text total |
	falsePositives := (cache falsePositiveOf: rule) size.
	toDos := (cache toDosOf: rule) size.
	total := (cache criticsOf: rule) size.
	unclassified := total - falsePositives - toDos.
	text := String
		streamContents: [ :s | 
			s
				<< rule name;
				<< ' (To sort: ';
				print: unclassified;
				<< ', ToDo: ';
				print: toDos;
				<< ', Wrong: ';
				print: falsePositives;
				<< ')' ].
	^ text asMorph
		color: (self colorForRule: rule);
		yourself
		
]

{ #category : #accessing }
SpCritiqueBrowser >> textInputFieldModel [

	^ criticModel textInputFieldModel
]

{ #category : #accessing }
SpCritiqueBrowser >> transformButton [
	^ criticModel transformButton 
]

{ #category : #'system annoucements' }
SpCritiqueBrowser >> unregisterFromAnnouncements [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #accessing }
SpCritiqueBrowser >> updateButton [
	^ updateButton 
]

{ #category : #thread }
SpCritiqueBrowser >> updateTree [
	criticModel updateList. 
	rulesModel update
]
