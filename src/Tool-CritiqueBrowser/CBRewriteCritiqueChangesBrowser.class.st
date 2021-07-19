Class {
	#name : #CBRewriteCritiqueChangesBrowser,
	#superclass : #RewriteRuleChangesBrowser,
	#instVars : [
		'textCode',
		'changeUnifiedView'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
CBRewriteCritiqueChangesBrowser class >> defaultSpec [

	^ SpBoxLayout newTopToBottom 
			add: (SpPanedLayout  newTopToBottom
			add: #changeTree;
			add: (SpBoxLayout newTopToBottom add: (SpBoxLayout newLeftToRight add: #changeUnifiedOption; add: #changeSplitOption; yourself) height: 25; add: #diffView; yourself);
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
CBRewriteCritiqueChangesBrowser >> applyChangesUnified [
	textCode text: ( self buildUnifiedDiffFor: changeTree selectedItem ) . 
	textCode openWithSpec.
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> buildUnifiedDiffFor: aChange [

	^ aChange
		ifNil: [ '' ]
		ifNotNil: [
			PrettyTextDiffBuilder 
				buildDisplayPatchFrom: aChange oldVersionTextToDisplay 
				to: aChange textToDisplay ].
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> changes: anObject [
	changes := anObject.
	selectedChanges := OrderedCollection with: changes first.
	self updateChanges
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> connectPresenters [
	super connectPresenters.
	changeUnifiedView whenActivatedDo: [ self applyChangesUnified ]
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> initializePresenters [
	super initializePresenters.
	textCode := self newCode.
	changeUnifiedView:= self newCheckBox.
	changeUnifiedView label: 'Unified View';
		state: false.
	diffView showOptions: false.
]
