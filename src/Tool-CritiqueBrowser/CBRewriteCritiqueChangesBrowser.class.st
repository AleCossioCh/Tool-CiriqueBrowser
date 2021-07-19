Class {
	#name : #CBRewriteCritiqueChangesBrowser,
	#superclass : #RewriteRuleChangesBrowser,
	#instVars : [
		'changeUnifiedOption',
		'changeSplitOption'
	],
	#category : #'Tool-CritiqueBrowser-Transform '
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
CBRewriteCritiqueChangesBrowser >> applyChangesInSplit [
	diffView := self newDiff.
	self buildDiffFor: changeTree selectedItem.
	self update.  
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> applyChangesInUnified [
	diffView := SpMorphPresenter new morph:(UnifiedDiffChangesMorph from: changeTree selectedItem oldVersionTextToDisplay to: changeTree selectedItem textToDisplay).
	self update. 
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
	changeUnifiedOption whenActivatedDo: [ self applyChangesInUnified. changeSplitOption disable ].
	changeUnifiedOption whenDeactivatedDo: [ changeSplitOption enable ].
	changeSplitOption whenActivatedDo: [ self applyChangesInSplit. changeUnifiedOption disable ].
	changeSplitOption whenDeactivatedDo: [ changeUnifiedOption enable ]
]

{ #category : #initialization }
CBRewriteCritiqueChangesBrowser >> initializePresenters [
	super initializePresenters.
	changeUnifiedOption:= self newCheckBoxUnified.
	changeSplitOption := self newCheckBoxSplit.
	diffView showOptions: false.
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> newCheckBoxSplit [
	^ self newCheckBox
	label: 'Split View';
	state: false.
]

{ #category : #accessing }
CBRewriteCritiqueChangesBrowser >> newCheckBoxUnified [
	^ self newCheckBox
	label: 'Unified View';
		state: false.
]
