Class {
	#name : #SpResetWindowTest,
	#superclass : #TestCase,
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #test }
SpResetWindowTest >> testOpen [

	| resetWindow |
	resetWindow := CBResetWindow open.
	self assert: resetWindow isBuilt.
	resetWindow close
]
