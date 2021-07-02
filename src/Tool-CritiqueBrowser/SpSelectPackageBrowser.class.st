Class {
	#name : #SpSelectPackageBrowser,
	#superclass : #SpSelectBrowser,
	#instVars : [
		'addTestCaseClassesModel',
		'removeTestPackageModel',
		'testPackage'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
SpSelectPackageBrowser class >> defaultSpec [
	
	^ SpBoxLayout newTopToBottom
		add:	(SpBoxLayout newLeftToRight
					add: #toSelectModel; 
					add: #selectedModel; yourself);
		add: (SpBoxLayout newLeftToRight 
					add: #removeTestPackageModel; 
					add: #addTestCaseClassesModel; yourself) height: 25;
		add: (SpBoxLayout newLeftToRight 
					add: #addButtonModel;
					add: #addAllButtonModel;
					add: #removeButtonModel;
					add: #removeAllButtonModel;
					add: #nextButtonModel; yourself ) height: 25;
		yourself 
]

{ #category : #'instance creation' }
SpSelectPackageBrowser class >> open [
	<script>
	
	self new items: RPackageOrganizer default packages;
		openWithSpec 
]

{ #category : #specs }
SpSelectPackageBrowser class >> title [
	^ 'Select packages'
]

{ #category : #private }
SpSelectPackageBrowser >> addAllItems [
	| tmp |
	tmp := self 
		sort: selectedModel items
		withAll: toSelectModel items.
	selectedModel items: tmp.
	toSelectModel items: #().
	toSelectModel updateList.
	selectedModel updateList 	  
]

{ #category : #private }
SpSelectPackageBrowser >> addItems [
	toSelectModel selectedItems
		ifNotNil: [ :items |  
			selectedModel items: (self sort: selectedModel items withAll: items).
			toSelectModel items: (self sort: toSelectModel items withoutAll: items) ].
	toSelectModel updateList.
	selectedModel updateList  	  
]

{ #category : #accessing }
SpSelectPackageBrowser >> addTestCaseClasses [
	^ addTestCaseClassesModel

]

{ #category : #accessing }
SpSelectPackageBrowser >> addTestCaseClassesModel [
	^ addTestCaseClassesModel

]

{ #category : #initialization }
SpSelectPackageBrowser >> initialize [
	
	| wrappingBlock |
	super initialize.
	toSelectModel := self newList.
	selectedModel := self newList.
	selectedModel beMultipleSelection.
	toSelectModel beMultipleSelection.
	testPackage := OrderedCollection new.
	wrappingBlock := [ :package | package packageName ].
	toSelectModel display: wrappingBlock.
	selectedModel display: wrappingBlock
]

{ #category : #initialization }
SpSelectPackageBrowser >> initializePresenters [

	super initializePresenters.
	addTestCaseClassesModel := self newCheckBox.
	removeTestPackageModel := self newButton.
	self setRemoveTestPackageModel.
	addTestCaseClassesModel label: 'remove all TestCase Classes'.
	addTestCaseClassesModel state: true
]

{ #category : #api }
SpSelectPackageBrowser >> nextAction [

	| env packages |
	packages := selectedModel items.
	env := RBPackageEnvironment new packages: packages.
	SpSelectRuleBrowser
		openWithEnvironment: env
		removeTestCase: self addTestCaseClasses state.
	self delete
]

{ #category : #private }
SpSelectPackageBrowser >> removeAllItems [
	| tmp |
	tmp := self 
		sort: toSelectModel items
		withAll: selectedModel items.
	toSelectModel items: tmp.
	selectedModel items: #().
	toSelectModel updateList.
	selectedModel updateList  	  
]

{ #category : #private }
SpSelectPackageBrowser >> removeItems [
	selectedModel selectedItems
		ifNotNil: [:items | 
			toSelectModel items: (self sort: toSelectModel items withAll: items).
			selectedModel items: (self sort: selectedModel items withoutAll: items) ].
	toSelectModel updateList.
	selectedModel updateList 	  
]

{ #category : #initialization }
SpSelectPackageBrowser >> removeTestPackage [

	| matchText  |
	testPackage isEmpty
		ifTrue: [
			removeTestPackageModel label: 'Add All Packages Tests'.
			matchText := '*Test*'.
			testPackage :=MCWorkingCopy allManagers select: [ :package | matchText match:  package packageName ].
			selectedModel items: (self sort:(selectedModel listItems \ testPackage)).
			toSelectModel items: (self sort:(toSelectModel  listItems \ testPackage)) ]
		ifFalse: [
			removeTestPackageModel label: 'Remove All Packages Tests'.		
			toSelectModel items: (self sort: (toSelectModel listItems asOrderedCollection addAll: testPackage; yourself)).
			testPackage := OrderedCollection new ]. 
	toSelectModel updateList.
	selectedModel updateList  	
]

{ #category : #initialization }
SpSelectPackageBrowser >> removeTestPackageModel [

	^ removeTestPackageModel
	
	
]

{ #category : #initialization }
SpSelectPackageBrowser >> setRemoveTestPackageModel [

	removeTestPackageModel
		state: false;
		label: 'Remove All Packages Tests';
		action: [ self  removeTestPackage ]
	
]

{ #category : #private }
SpSelectPackageBrowser >> sort: aCollection withAll: anotherCollection [
	^ self sort: 
		(aCollection asOrderedCollection 
			addAll: (anotherCollection);
			yourself)
]

{ #category : #private }
SpSelectPackageBrowser >> sort: aCollection withoutAll: anotherCollection [
	^ self sort: 
		(aCollection asOrderedCollection 
			removeAll: (anotherCollection);
			yourself)
]
