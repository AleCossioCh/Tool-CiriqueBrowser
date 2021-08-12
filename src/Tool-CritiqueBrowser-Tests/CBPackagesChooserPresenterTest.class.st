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
	
]

{ #category : #initialization }
CBPackagesChooserPresenterTest >> testOpen [

	| window |
	window := CBPackagesChooserPresenter open.
	self assert: window isBuilt.
	window close
]
