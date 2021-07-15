Class {
	#name : #CBResetWindow,
	#superclass : #SpPresenter,
	#instVars : [
		'resetModel',
		'currentConfigurationModel'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
CBResetWindow class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #resetModel;
				   add: #currentConfigurationModel;
				   yourself)
		  height: 25
]

{ #category : #specs }
CBResetWindow class >> open [

	<example>
	^ self new openWithSpec
]

{ #category : #specs }
CBResetWindow class >> title [
	^ 'Critique Browser' 
]

{ #category : #accessing }
CBResetWindow >> currentConfigurationModel [
	^ currentConfigurationModel
]

{ #category : #initialization }
CBResetWindow >> initializePresenters [

	resetModel := self newButton.
	currentConfigurationModel := self newButton.

	self setFocusOrder.
	self setResetModel.
	self setCurrentConfigurationModel
]

{ #category : #api }
CBResetWindow >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title:  self title;
		initialExtent: 450@30
]

{ #category : #accessing }
CBResetWindow >> resetModel [
	^ resetModel
]

{ #category : #initialization }
CBResetWindow >> setCurrentConfigurationModel [

	currentConfigurationModel
		state: false;
		label: 'Uses Current Configuration';
		action: [ 
			CBCritiqueBrowser openOnWorkingConfiguration:
					CBCritiqueWorkingConfiguration current.
			self delete ]
]

{ #category : #initialization }
CBResetWindow >> setFocusOrder [

	self focusOrder
		add: resetModel;
		add: currentConfigurationModel
]

{ #category : #initialization }
CBResetWindow >> setResetModel [

	resetModel
		state: false;
		label: 'Reset Current Configurartion';
		action: [ 
			CBSelectPackageBrowser open.
			self delete ]
]
