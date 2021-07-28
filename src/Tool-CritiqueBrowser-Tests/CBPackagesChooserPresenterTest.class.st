"
A CBPackagesChooserPresenterTest is a test class for testing the behaivor of CBPackagesChooserPresenter
"
Class {
	#name : #CBPackagesChooserPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'packagesChooserPresenter',
		'packagesChooserWithSelectedItems'
	],
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #running }
CBPackagesChooserPresenterTest >> setUp [

	super setUp.
	packagesChooserPresenter := CBPackagesChooserPresenter new.
	packagesChooserPresenter setModelBeforeInitialization: CBPackagesChooserPresenter items.
	packagesChooserWithSelectedItems := CBPackagesChooserPresenter openWithSelectedItems.
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testAddAll [

	| selectedList |
	selectedList := RBBrowserEnvironment new packages sorted: #packageName ascending.
	packagesChooserPresenter list items: selectedList.
	packagesChooserPresenter addAllButton click.
	self
		assertCollection: packagesChooserPresenter selectedList items
		equals: selectedList
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testAddSelected [

	| packageSelected |
	packageSelected := RPackageOrganizer default packageNamed: 'AST-Core-Tests'.
	self assert:
		(packagesChooserWithSelectedItems list items includes: packageSelected).
	packagesChooserWithSelectedItems list selectItem: packageSelected.
	packagesChooserWithSelectedItems addButton click.
	self deny:
		(packagesChooserWithSelectedItems list items includes: packageSelected)
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testInitializePresenters [

	| window |
	self assert: packagesChooserPresenter list items isEmpty.
	self assert: packagesChooserPresenter selectedList items isEmpty.
	window := packagesChooserPresenter openWithSpec.
	self assert: window isBuilt.
	window close
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testOpen [

	| window |
	window := CBPackagesChooserPresenter open.
	self assert: window isBuilt.
	window close
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testRemoveAll [

	| emptyList packagesSelected |
	emptyList := #().
	packagesSelected := RBBrowserEnvironment new forPackageNames:
		                   (Array
			                    with: 'Epicea'
			                    with: 'Kernel'
			                    with: 'Files').
	packagesChooserPresenter selectedList items: packagesSelected.
	packagesChooserPresenter removeAllButton click.
	self
		assertCollection: packagesChooserPresenter selectedList items
		equals: emptyList
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testRemoveSelected [

	| packageSelected |
	packageSelected := RPackageOrganizer default packageNamed: 'AST-Core'.
	"packagesChooserWithSelectedItems selectedList selectedItem: packageSelected."
	self deny:
		(packagesChooserWithSelectedItems list items includes: packageSelected).
	packagesChooserWithSelectedItems selectedList selectItem:
		packagesChooserWithSelectedItems selectedList items first.
	packagesChooserWithSelectedItems removeButton click.
	self assert:
		(packagesChooserWithSelectedItems items includes:
			 packageSelected)
]
