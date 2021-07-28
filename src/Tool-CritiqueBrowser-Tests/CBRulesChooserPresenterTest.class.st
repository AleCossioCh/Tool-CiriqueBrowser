Class {
	#name : #CBRulesChooserPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'rulesChooserPresenter'
	],
	#category : #'Tool-CritiqueBrowser-Tests'
}

{ #category : #tests }
CBRulesChooserPresenterTest >> setUp [

	super setUp.
	rulesChooserPresenter := CBRulesChooserPresenter new.

]

{ #category : #tests }
CBRulesChooserPresenterTest >> testOpen [

	| window |
	window := CBRulesChooserPresenter open.
	self assert: window isBuilt.
	window close
]
