"
I represent a group of rules in StCritiqueBrowserPresenter tree view.
"
Class {
	#name : #StCritiqueBrowserRulesGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'rules'
	],
	#category : #'NewTool-CodeCritiques-Utilities'
}

{ #category : #'instance creation' }
StCritiqueBrowserRulesGroup class >> named: aString rules: aCollection [
	^ self new
		  name: aString;
		  rules: (aCollection sorted: [ :a :b | a name < b name ]);
		  yourself
]

{ #category : #enumerating }
StCritiqueBrowserRulesGroup >> do: aBlock [

	rules do: aBlock
]

{ #category : #testing }
StCritiqueBrowserRulesGroup >> isComposite [

	^ true
]

{ #category : #accessing }
StCritiqueBrowserRulesGroup >> name [
	^ name
]

{ #category : #accessing }
StCritiqueBrowserRulesGroup >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StCritiqueBrowserRulesGroup >> rules [
	^ rules
]

{ #category : #accessing }
StCritiqueBrowserRulesGroup >> rules: anObject [
	rules := anObject
]
