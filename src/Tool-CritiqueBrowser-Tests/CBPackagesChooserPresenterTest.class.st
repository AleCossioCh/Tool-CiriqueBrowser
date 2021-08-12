"
A CBPackagesChooserPresenterTest is a test class for testing the behaivor of CBPackagesChooserPresenter
"
Class {
	#name : #CBPackagesChooserPresenterTest,
	#superclass : #TestCase,
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #running }
CBPackagesChooserPresenterTest >> setUp [

	super setUp.
	
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testInitializePresenters [

	| packagesChooserPresenter |
	
	packagesChooserPresenter := CBPackagesChooserPresenter new.
	self
		assert: packagesChooserPresenter chooserPackages class
		equals: SpChooserPresenter.
	self
		assert: packagesChooserPresenter nextButton class
		equals: SpButtonPresenter.
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testOpen [

	| window |
	window := CBPackagesChooserPresenter open.
	self assert: window isBuilt.
	window close
]
