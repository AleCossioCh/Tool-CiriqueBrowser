Class {
	#name : #SpResetWindow,
	#superclass : #SpPresenter,
	#instVars : [
		'resetModel',
		'currentConfigurationModel'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
SpResetWindow class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #resetModel;
				   add: #currentConfigurationModel;
				   yourself)
		  height: 25
]

{ #category : #specs }
SpResetWindow class >> open [

	<example>
	^ self new openWithSpec
]

{ #category : #specs }
SpResetWindow class >> title [
	^ 'Critique Browser' 
]

{ #category : #accessing }
SpResetWindow >> currentConfigurationModel [
	^ currentConfigurationModel
]

{ #category : #initialization }
SpResetWindow >> initializePresenters [

	resetModel := self newButton.
	currentConfigurationModel := self newButton.

	self setFocusOrder.
	self setResetModel.
	self setCurrentConfigurationModel
]

{ #category : #api }
SpResetWindow >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title:  self title;
		initialExtent: 450@30
]

{ #category : #accessing }
SpResetWindow >> resetModel [
	^ resetModel
]

{ #category : #initialization }
SpResetWindow >> setCurrentConfigurationModel [

	currentConfigurationModel
		state: false;
		label: 'Uses Current Configuration';
		action: [ 
			SpCritiqueBrowser openOnWorkingConfiguration:
					SpCriticWorkingConfiguration current.
			self delete ]
]

{ #category : #initialization }
SpResetWindow >> setFocusOrder [

	self focusOrder
		add: resetModel;
		add: currentConfigurationModel
]

{ #category : #initialization }
SpResetWindow >> setResetModel [

	resetModel
		state: false;
		label: 'Reset Current Configurartion';
		action: [ 
			SpSelectPackageBrowser open.
			self delete ]
]
