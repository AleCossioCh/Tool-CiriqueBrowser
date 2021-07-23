Class {
	#name : #CBPackagesChooserPresenter,
	#superclass : #CBAbstractChoosePresenter,
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> open [

	self openOn: { 
			(RPackageOrganizer default packages sorted: #packageName ascending).
			{ (RPackageOrganizer default packageNamed: 'Refactoring-Core') }.
			#packageName }
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initalizeSelectedList [

	selectedList := SpFilteringListPresenter new.
	selectedList display: [ :each | each perform: self methodName ]
	
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializeList [

	list := SpFilteringSelectableListPresenter new.
	list display: [ :each | each perform: self methodName ]
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializePresenters [

	super initializePresenters.
	self initializeList.
	self initalizeSelectedList.
]

{ #category : #initialization }
CBPackagesChooserPresenter >> nextAction [

	| packages env |
	packages := selectedList items.
	env := RBPackageEnvironment new packages: packages.
	CBSelectRuleBrowser openWithEnvironment: env removeTestCase: true.
	self delete
]
