Class {
	#name : #SpCriticBrowserRulesGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'rules'
	],
	#category : #'Tool-CritiqueBrowser-Utilities'
}

{ #category : #'instance creation' }
SpCriticBrowserRulesGroup class >> named: aString rules: aCollection [

	^ self new
		  name: aString;
		  rules: aCollection;
		  yourself
]

{ #category : #enumerating }
SpCriticBrowserRulesGroup >> do: aBlock [

	rules do: aBlock
]

{ #category : #testing }
SpCriticBrowserRulesGroup >> isComposite [

	^ true
]

{ #category : #accessing }
SpCriticBrowserRulesGroup >> name [
	^ name
]

{ #category : #accessing }
SpCriticBrowserRulesGroup >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SpCriticBrowserRulesGroup >> rules [
	^ rules
]

{ #category : #accessing }
SpCriticBrowserRulesGroup >> rules: anObject [
	rules := anObject
]
