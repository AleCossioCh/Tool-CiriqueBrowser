"
I am a presenter that allows to select items from a list of packages in my left column and put that items on a selected list in my rigth column. I support selection for checkBox. 

If you click on 'Next', I will open the CBRulesChooserPresenter.
I send selected packages from selected list to CBCritiqueBrowser. 

You can open me whit:
`CBPackagesChooserPresenter open`


"
Class {
	#name : #CBPackagesChooserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'nextButton',
		'chooserPackages'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #'instance creation' }
CBPackagesChooserPresenter class >> open [

	<example>
	^ self new openWithSpec
]

{ #category : #'as yet unclassified' }
CBPackagesChooserPresenter >> chooserPackages [

	^chooserPackages 
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			add: #chooserPackages;
			add: (SpBoxLayout newLeftToRight
					  addLast: #nextButton;
					  yourself)
			 height: 25;
			 yourself)
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializeNextButton [

	nextButton := self newButton.
	nextButton
		icon: (self iconNamed: #smallOk);
		label: 'Next';
		action: [ self nextAction ]
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializePresenters [

	chooserPackages := self setChooserPackages.
	self initializeNextButton.
	self initializeLayout
]

{ #category : #initialization }
CBPackagesChooserPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: 450@360
]

{ #category : #adding }
CBPackagesChooserPresenter >> nextAction [

	| packages env |
	packages := chooserPackages targetList items.
	env := RBPackageEnvironment new packages: packages.
	CBRulesChooserPresenter openWithEnvironment: env removeTestCase: false.
	self delete
]

{ #category : #initialization }
CBPackagesChooserPresenter >> nextButton [

	^nextButton
]

{ #category : #initialization }
CBPackagesChooserPresenter >> setChooserPackages [
	
	| chooser |
	chooser := SpChooserPresenter
		   sourceItems: RPackageOrganizer default packages
		   chosenItems:
		   {  }
		   displayBlock: #packageName.
	chooser sourceList displayIcon: [ self iconNamed: #packageIcon ].
	chooser targetList displayIcon: [ self iconNamed: #packageIcon ].
	^ chooser 
]

{ #category : #initialization }
CBPackagesChooserPresenter >> title [

	^ 'Select packages'
]
