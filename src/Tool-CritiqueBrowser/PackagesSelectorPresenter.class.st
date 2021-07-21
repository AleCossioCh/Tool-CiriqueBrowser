Class {
	#name : #PackagesSelectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packagesListWithFilter'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
PackagesSelectorPresenter class >> openWindow [

	<script>
	^ self new openWithSpec
]

{ #category : #actions }
PackagesSelectorPresenter >> initializeLayout [

	self layout: (SpBoxLayout newLeftToRight
			 add: #packagesListWithFilter;
			 spacing: 5;
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
		beMultipleSelection
]

{ #category : #initialization }
PackagesSelectorPresenter >> initializePresenters [

	self initializePackagesList.
	self initializeLayout
]
