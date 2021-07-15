Class {
	#name : #SpCritiqueBrowserTest,
	#superclass : #TestCase,
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #tests }
SpCritiqueBrowserTest >> testOpen [

	| critiqueBrowserWindow |
	critiqueBrowserWindow := CBCritiqueBrowser open.
	self assert: critiqueBrowserWindow isBuilt.
	critiqueBrowserWindow close
]
