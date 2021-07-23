Class {
	#name : #CBPackagesSelectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packagesListWithFilter',
		'rulesGroupListWithFilter',
		'nextButton'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBPackagesSelectorPresenter class >> open [

	<script>
	^ self new openWithSpec
]

{ #category : #actions }
CBPackagesSelectorPresenter >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
					  add: #packagesListWithFilter;
			 add: (SpBoxLayout newLeftToRight
					  addLast: #nextButton;
					  yourself)
			 height: 25;
			 yourself)
]

{ #category : #initialization }
CBPackagesSelectorPresenter >> initializeNextButton [

	nextButton := self newButton.
	nextButton
		icon: (self iconNamed: #smallOk);
		label: 'Next';
		action: [self nextAction]
]

{ #category : #initialization }
CBPackagesSelectorPresenter >> initializePackagesList [

	packagesListWithFilter := SpChooserPresenter on:{(RPackageOrganizer default packages sorted: #packageName ascending) . 
        {  } . 
        #packageName}.
	"packagesListWithFilter items: RBBrowserEnvironment new packages.
	packagesListWithFilter listPresenter
		headerTitle: 'Packages';
		display: [ :item | item name ];
		displayIcon: [ self iconNamed: #packageIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		whenSelectionChangedDo: [ self packagesChanged ];
		beMultipleSelection"
]

{ #category : #initialization }
CBPackagesSelectorPresenter >> initializePresenters [

	self initializePackagesList.
	self initializeRulesGroupList.
	self initializeNextButton.
	self initializeLayout
]

{ #category : #initialization }
CBPackagesSelectorPresenter >> initializeRulesGroupList [

	rulesGroupListWithFilter := self newFilteringList.
 	rulesGroupListWithFilter listPresenter
 		headerTitle: 'Rules group';
 		display: [ :item | item name ];
 		"displayIcon: [ iconFor: '#warning'];"sortingBlock: [ :a :b | 
 			a name < b name ];
 		"whenSelectionChangedDo: [ :selection | self classesChanged ];"
 			beMultipleSelection

]

{ #category : #initialization }
CBPackagesSelectorPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Select packages';
		initialExtent: 450 @ 360;
		windowIcon: self windowIcon
]

{ #category : #initialization }
CBPackagesSelectorPresenter >> nextAction [

	| packages env |
	packages := packagesListWithFilter selectedList items.
	env := RBPackageEnvironment new packages: packages.
	CBSelectRuleBrowser openWithEnvironment: env removeTestCase: true.
	self delete
]
