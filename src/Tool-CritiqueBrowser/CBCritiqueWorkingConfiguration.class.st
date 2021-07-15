Class {
	#name : #CBCritiqueWorkingConfiguration,
	#superclass : #Object,
	#instVars : [
		'rule',
		'environment',
		'removeTestCase',
		'logInManifest'
	],
	#classVars : [
		'Current'
	],
	#category : #'Tool-CritiqueBrowser-Utilities'
}

{ #category : #'instance creation' }
CBCritiqueWorkingConfiguration class >> current [

	^ Current ifNil: [ Current  := self basicNew initialize ].
]

{ #category : #testing }
CBCritiqueWorkingConfiguration class >> exists [

	^ Current notNil
]

{ #category : #'instance creation' }
CBCritiqueWorkingConfiguration class >> new [

	^ self shouldNotImplement
]

{ #category : #initialization }
CBCritiqueWorkingConfiguration class >> reset [

	Current := nil
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> environment [
	^ environment
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> logInManifest [
	^ logInManifest
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> logInManifest: anObject [
	logInManifest := anObject
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> removeTestCase [
	^ removeTestCase
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> removeTestCase: aBoolean [
	removeTestCase := aBoolean
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> rule [
	^ rule
]

{ #category : #accessing }
CBCritiqueWorkingConfiguration >> rule: anObject [
	rule := anObject
]
