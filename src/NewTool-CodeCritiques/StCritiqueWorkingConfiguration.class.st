"
A CritiqueWorkspace holds the current worspace for the StCritiqueBrowserPresenter.

It's composed of the set of rules to check (as a composite rule) and the environment to work in.
"
Class {
	#name : #StCritiqueWorkingConfiguration,
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
	#category : #'NewTool-CodeCritiques-Utilities'
}

{ #category : #'instance creation' }
StCritiqueWorkingConfiguration class >> current [

	^ Current ifNil: [ Current  := self basicNew initialize ].
]

{ #category : #testing }
StCritiqueWorkingConfiguration class >> exists [

	^ Current notNil
]

{ #category : #'instance creation' }
StCritiqueWorkingConfiguration class >> new [

	^ self shouldNotImplement
]

{ #category : #initialization }
StCritiqueWorkingConfiguration class >> reset [

	Current := nil
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> environment [
	^ environment
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> logInManifest [
	^ logInManifest
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> logInManifest: anObject [
	logInManifest := anObject
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> removeTestCase [
	^ removeTestCase
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> removeTestCase: aBoolean [
	removeTestCase := aBoolean
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> rule [
	^ rule
]

{ #category : #accessing }
StCritiqueWorkingConfiguration >> rule: anObject [
	rule := anObject
]
