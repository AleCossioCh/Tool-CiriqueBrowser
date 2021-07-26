Class {
	#name : #CBPackagesChooserPresenter,
	#superclass : #CBAbstractChoosePresenter,
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> open [

	self openOn: { 
			(RPackageOrganizer default packages sorted: #packageName ascending).
			{ }.
			#packageName }
]

{ #category : #adding }
CBPackagesChooserPresenter >> addAll [

	selectedList items:
		(selectedList unfilteredItems , list unfilteredItems sorted:
			 self methodName ascending).
	list items: #(  ).
	list selectItems: #(  )
]

{ #category : #adding }
CBPackagesChooserPresenter >> addSelected [

	selectedList items: selectedList items
		, (list selectedItems sorted: self methodName ascending).
	list items: (list unfilteredItems \ list selectedItems sorted:
			 self methodName ascending).
	list applyFilter: list filterText.
	list selectItems: #(  )
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initalizeSelectedList [

	selectedList := SpFilteringSelectableListPresenter new.
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
CBPackagesChooserPresenter >> items [

	^ items ifNil: [ items := {  } ]
]

{ #category : #initialization }
CBPackagesChooserPresenter >> nextAction [

	| packages env |
	packages := selectedList items.
	env := RBPackageEnvironment new packages: packages.
	CBRulesChooserPresenter openWithEnvironment: env removeTestCase: true.
	self delete
]

{ #category : #actions }
CBPackagesChooserPresenter >> removeAll [

	selectedList items: #().
	list items: self items
]

{ #category : #actions }
CBPackagesChooserPresenter >> removeSelected [

	list items: ((list unfilteredItems, selectedList selectedItems) sorted: self methodName ascending).
	list applyFilter: list filterText.
	selectedList items: ((selectedList unfilteredItems \ selectedList selectedItems) sorted: self methodName ascending).
	selectedList applyFilter: selectedList filterText.
	selectedList selectItems: #()
]

{ #category : #initialization }
CBPackagesChooserPresenter >> title [

	^ 'Select packages'
]

{ #category : #adding }
CBPackagesChooserPresenter >> updatePresenter [

	list items: self items \ self selectedItems.
	selectedList items: self selectedItems.
]
