Class {
	#name : #CBSelectBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'toSelectModel',
		'selectedModel',
		'addButtonModel',
		'addAllButtonModel',
		'removeButtonModel',
		'removeAllButtonModel',
		'nextButtonModel'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
CBSelectBrowser class >> defaultSpec [
	
	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
					add: #toSelectModel;
					add: #selectedModel; yourself); 
		add: (SpBoxLayout newLeftToRight
					add: #addButtonModel;
					add: #addAllButtonModel;
					add: #removeButtonModel;
					add: #removeAllButtonModel;
					add: #nextButtonModel; yourself) height: 25;
		yourself 
]

{ #category : #accessing }
CBSelectBrowser >> addAllButtonModel [
	^ addAllButtonModel
]

{ #category : #private }
CBSelectBrowser >> addAllItems [

	self subclassResponsibility 
]

{ #category : #accessing }
CBSelectBrowser >> addButtonModel [
	^ addButtonModel
]

{ #category : #api }
CBSelectBrowser >> initialExtent [
	^   450@360
]

{ #category : #initialization }
CBSelectBrowser >> initializePresenters [

	addButtonModel := self newButton.
	addAllButtonModel := self newButton.
	removeButtonModel := self newButton.
	removeAllButtonModel := self newButton.
	nextButtonModel := self newButton.

	self setFocusOrder.

	self setAddButtonModel.
	self setAddAllButtonModel.
	self setRemoveButtonModel.
	self setRemoveAllButtonModel.
	self setNextButtonModel
]

{ #category : #accessing }
CBSelectBrowser >> items: aCollection [
	"Set the elements to be analysed"
	toSelectModel items: (self sort: aCollection)

]

{ #category : #api }
CBSelectBrowser >> nextAction [
	self subclassResponsibility

]

{ #category : #accessing }
CBSelectBrowser >> nextButtonModel [
	^ nextButtonModel
]

{ #category : #accessing }
CBSelectBrowser >> removeAllButtonModel [
	^ removeAllButtonModel
]

{ #category : #accessing }
CBSelectBrowser >> removeButtonModel [
	^ removeButtonModel
]

{ #category : #accessing }
CBSelectBrowser >> selectedModel [
	^ selectedModel
]

{ #category : #initialization }
CBSelectBrowser >> setAddAllButtonModel [
	
	addAllButtonModel
		state: false;
		label: 'Add All';
		action: [ self addAllItems]
	

]

{ #category : #initialization }
CBSelectBrowser >> setAddButtonModel [
	
	addButtonModel
		state: false;
		label: 'Add';
		action: [ self addItems ].
	

]

{ #category : #initialization }
CBSelectBrowser >> setFocusOrder [

	self focusOrder
		add: addButtonModel;
		add: addAllButtonModel;
		add: removeButtonModel;
		add: removeAllButtonModel.
		
]

{ #category : #initialization }
CBSelectBrowser >> setNextButtonModel [
	
	nextButtonModel
		state: false;
		label: 'Next';
		action: [ self  nextAction ].
	

]

{ #category : #initialization }
CBSelectBrowser >> setRemoveAllButtonModel [
	
	removeAllButtonModel
		state: false;
		label: 'Remove All';
		action: [ self  removeAllItems ].
	

]

{ #category : #initialization }
CBSelectBrowser >> setRemoveButtonModel [
	
	removeButtonModel
		state: false;
		label: 'Remove';
		action: [ self removeItems ].
	

]

{ #category : #private }
CBSelectBrowser >> sort: aCollection [
	^ aCollection asOrderedCollection sort: [:e1 :e2 | (e1 asString) < (e2 asString)].
]

{ #category : #accessing }
CBSelectBrowser >> toSelectModel [
	^ toSelectModel
]
