"
A CBCritiqueToolbarTest is a test class for testing the behaivor of CBCritiqueToolbar
"
Class {
	#name : #StCritiqueToolbarPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'critiqueToolbar'
	],
	#category : #'NewTool-CodeCritiques-Tests'
}

{ #category : #running }
StCritiqueToolbarPresenterTest >> setUp [

	super setUp.
	critiqueToolbar := StCritiqueToolbarPresenter new.
]

{ #category : #initialization }
StCritiqueToolbarPresenterTest >> testInitialize [

	self assert: critiqueToolbar criticHolder value isNil.
	self assert: critiqueToolbar ruleHolder value isNil.
	
]

{ #category : #initialization }
StCritiqueToolbarPresenterTest >> testOpen [

	| window |
	window := StCritiqueToolbarPresenter open.
	self assert: window isBuilt.
	window close
]
