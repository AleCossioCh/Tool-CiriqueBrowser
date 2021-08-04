"
I am a presenter that allows to select items from a list of packages in my left column and put that items on a selected list in my rigth column. I support selection for checkBox. 

If you click on 'Next', I will open the CBRulesChooserPresenter.
I send selected packages from selected list to CBCritiqueBrowser. 

You can open me whit:
`CBPackagesChooserPresenter open`


"
Class {
	#name : #CBPackagesChooserPresenter,
	#superclass : #CBAbstractChoosePresenter,
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> items [

	^ { 
		  (RBBrowserEnvironment new packages sorted: #packageName ascending).
		  { }.
		  #packageName }
]

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> open [

	<example>
	^ (self on: self items) openWithSpec
]

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> openWithSelectedItems [

	^ self on: { 
			  (RPackageOrganizer default packages sorted:
				   #packageName ascending).
			  { (RPackageOrganizer default packageNamed: 'AST-Core') }.
			  #packageName }
]

{ #category : #adding }
CBPackagesChooserPresenter >> addAll [
	
	selectedList items:
		(selectedList unfilteredItems , list items sorted:
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
	selectedList display: [ :each | each perform: self methodName ].
	selectedList displayIcon: [ self iconNamed: #packageIcon ]
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializeList [

	list := SpFilteringSelectableListPresenter new.
	list display: [ :each | each perform: self methodName ].
	list displayIcon: [ self iconNamed: #packageIcon ].
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
	CBRulesChooserPresenter openWithEnvironment: env removeTestCase: false.
	self delete
]

{ #category : #actions }
CBPackagesChooserPresenter >> removeAll [

	selectedList items: #().
	list items: self items
]

{ #category : #actions }
CBPackagesChooserPresenter >> removeSelected [
	list items:
		(list unfilteredItems , selectedList selectedItems sorted:
			 self methodName ascending).
	list applyFilter: list filterText.
	selectedList items:
		(selectedList unfilteredItems \ selectedList selectedItems sorted:
			 self methodName ascending).
	selectedList applyFilter: selectedList filterText.
	selectedList selectItems: #(  )
]

{ #category : #accessing }
CBPackagesChooserPresenter >> selectedItems [

	^ selectedItems ifNil: [ selectedItems := {  } ]
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
