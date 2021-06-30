Class {
	#name : #SpSelectBrowser,
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
SpSelectBrowser class >> defaultSpec [
	
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
SpSelectBrowser >> addAllButtonModel [
	^ addAllButtonModel
]

{ #category : #private }
SpSelectBrowser >> addAllItems [

	self subclassResponsibility 
]

{ #category : #accessing }
SpSelectBrowser >> addButtonModel [
	^ addButtonModel
]

{ #category : #api }
SpSelectBrowser >> initialExtent [
	^   450@360
]

{ #category : #initialization }
SpSelectBrowser >> initializePresenters [

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
SpSelectBrowser >> items: aCollection [
	"Set the elements to be analysed"
	toSelectModel items: (self sort: aCollection)

]

{ #category : #api }
SpSelectBrowser >> nextAction [
	self subclassResponsibility

]

{ #category : #accessing }
SpSelectBrowser >> nextButtonModel [
	^ nextButtonModel
]

{ #category : #accessing }
SpSelectBrowser >> removeAllButtonModel [
	^ removeAllButtonModel
]

{ #category : #accessing }
SpSelectBrowser >> removeButtonModel [
	^ removeButtonModel
]

{ #category : #accessing }
SpSelectBrowser >> selectedModel [
	^ selectedModel
]

{ #category : #initialization }
SpSelectBrowser >> setAddAllButtonModel [
	
	addAllButtonModel
		state: false;
		label: 'Add All';
		action: [ self addAllItems]
	

]

{ #category : #initialization }
SpSelectBrowser >> setAddButtonModel [
	
	addButtonModel
		state: false;
		label: 'Add';
		action: [ self addItems ].
	

]

{ #category : #initialization }
SpSelectBrowser >> setFocusOrder [

	self focusOrder
		add: addButtonModel;
		add: addAllButtonModel;
		add: removeButtonModel;
		add: removeAllButtonModel.
		
]

{ #category : #initialization }
SpSelectBrowser >> setNextButtonModel [
	
	nextButtonModel
		state: false;
		label: 'Next';
		action: [ self  nextAction ].
	

]

{ #category : #initialization }
SpSelectBrowser >> setRemoveAllButtonModel [
	
	removeAllButtonModel
		state: false;
		label: 'Remove All';
		action: [ self  removeAllItems ].
	

]

{ #category : #initialization }
SpSelectBrowser >> setRemoveButtonModel [
	
	removeButtonModel
		state: false;
		label: 'Remove';
		action: [ self removeItems ].
	

]

{ #category : #private }
SpSelectBrowser >> sort: aCollection [
	^ aCollection asOrderedCollection sort: [:e1 :e2 | (e1 asString) < (e2 asString)].
]

{ #category : #accessing }
SpSelectBrowser >> toSelectModel [
	^ toSelectModel
]
