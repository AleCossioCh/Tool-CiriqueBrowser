Class {
	#name : #CBRewriteCritiqueChangesBrowser,
	#superclass : #RewriteRuleChangesBrowser,
	#instVars : [
		'rule',
		'criticsModel',
		'sourceCodeModel',
		'cache',
		'thread',
		'toolbarModel'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
CBRewriteCritiqueChangesBrowser class >> defaultSpec [

	^ SpBoxLayout newTopToBottom 
			add: (SpPanedLayout  newTopToBottom
			add: #changeTree;
			add: (SpBoxLayout newTopToBottom add: #changeUnifiedView height: 25; add: #diffView; yourself);
		yourself);
		add: (SpBoxLayout newLeftToRight
			addLast: #buttonCancel expand: false fill: true padding: 2;
			addLast: #buttonOk expand: false fill: false padding: 0;
			yourself) 
		expand: false 
		fill: false 
		padding: 2;
		yourself
]

{ #category : #specs }
CBRewriteCritiqueChangesBrowser class >> open [

	<example>
	^ self new openWithSpec
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> changes: anObject [
	changes := anObject.
	selectedChanges := OrderedCollection with: changes first.
	self updateChanges
]
