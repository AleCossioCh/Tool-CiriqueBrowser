Class {
	#name : #PackagesSelectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packagesListWithFilter',
		'rulesGroupListWithFilter',
		'addAllPackagesButton',
		'removeAllPackagesButton',
		'addAllRulesButton',
		'removeAllRulesButton'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
PackagesSelectorPresenter class >> items [

	| rules rulesByGroup |
	rules := (ReRuleManager visibleRuleClasses collect: [:aClass | aClass new]) sorted: [ :a :b |
		a name < b name ].
	rulesByGroup := ((rules groupedBy: #group) associations collect: [ :as |
		CriticBrowserRulesGroup named: as key rules: as value ]).
	rulesByGroup sort: [ :a :b | a name < b name ].
	^ rulesByGroup
]

{ #category : #'instance creation' }
PackagesSelectorPresenter class >> openWindow [

	<script>
	^ self new openWithSpec
]

{ #category : #actions }
PackagesSelectorPresenter >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			 add: (SpBoxLayout newLeftToRight
					  add: (SpBoxLayout newTopToBottom
							   add: #packagesListWithFilter;
							   spacing: 5;
							   add: (SpBoxLayout newLeftToRight
									    add: #addAllPackagesButton;
									    add: #removeAllPackagesButton;
									    yourself)
							   height: 25;
							   yourself);
					  add: (SpBoxLayout newTopToBottom
							   add: #rulesGroupListWithFilter;
							   spacing: 5;
							   add: (SpBoxLayout newLeftToRight
									    add: #addAllRulesButton;
									    add: #removeAllRulesButton;
									    yourself)
							   height: 25;
							   yourself);
					  yourself);
			 yourself)
]

{ #category : #initialization }
PackagesSelectorPresenter >> initializePackagesList [

	packagesListWithFilter := self newFilteringList.
	packagesListWithFilter items: RBBrowserEnvironment new packages.
	packagesListWithFilter listPresenter
		headerTitle: 'Packages';
		display: [ :item | item name ];
		displayIcon: [ self iconNamed: #packageIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		whenSelectionChangedDo: [ self packagesChanged ];
		beMultipleSelection
]

{ #category : #initialization }
PackagesSelectorPresenter >> initializePresenters [

	self initializePackagesList.
	self initializeRulesGroupList.
	self initializeSelectionButtons.
	self initializeLayout
]

{ #category : #initialization }
PackagesSelectorPresenter >> initializeRulesGroupList [

	rulesGroupListWithFilter := self newFilteringList.
	rulesGroupListWithFilter listPresenter
		headerTitle: 'Rules group';
		display: [ :item | item name ];
		displayIcon: [ self iconNamed: #group ];
		sortingBlock: [ :a :b | a name < b name ];
		"whenSelectionChangedDo: [ :selection | self classesChanged ];"
			beMultipleSelection
]

{ #category : #actions }
PackagesSelectorPresenter >> initializeSelectionButtons [

	addAllPackagesButton := self newButton.
	removeAllPackagesButton := self newButton.
	addAllRulesButton := self newButton.
	removeAllRulesButton := self newButton.
	self setAddAllPackagesButton.
	self setRemoveAllPackagesButton.
	self setAddAllRulesButton.
	self setRemoveAllRulesButton.
]

{ #category : #actions }
PackagesSelectorPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Critique Browser applier';
		initialExtent: 450 @ 360;
		windowIcon: self windowIcon
]

{ #category : #actions }
PackagesSelectorPresenter >> packagesChanged [

	rulesGroupListWithFilter items: self class items.
	rulesGroupListWithFilter listPresenter resetListSelection
]

{ #category : #actions }
PackagesSelectorPresenter >> setAddAllPackagesButton [
	addAllPackagesButton label:'Add all';
	action: [  ]
]

{ #category : #actions }
PackagesSelectorPresenter >> setAddAllRulesButton [

	addAllRulesButton
		label: 'Add all';
		action: [  ]
]

{ #category : #actions }
PackagesSelectorPresenter >> setRemoveAllPackagesButton [

	removeAllPackagesButton
		label: 'Remove all';
		action: [  ]
]

{ #category : #actions }
PackagesSelectorPresenter >> setRemoveAllRulesButton [

	removeAllRulesButton 
		label: 'Remove all';
		action: [  ]
]
