Class {
	#name : #CBResetWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'resetWindow'
	],
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #running }
CBResetWindowTest >> setUp [

	super setUp.
	resetWindow := CBResetWindow new
]

{ #category : #tests }
CBResetWindowTest >> testOpen [

	| resetWindow |
	resetWindow := CBResetWindow open.
	self assert: resetWindow isBuilt.
	resetWindow close
]

{ #category : #tests }
CBResetWindowTest >> testOpenPackagesChooser [

	| applier |
	applier := resetWindow openPackagesChooser.
	self assert: applier isBuilt.
	applier window close
]
