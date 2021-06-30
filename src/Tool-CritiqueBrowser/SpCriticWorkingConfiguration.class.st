Class {
	#name : #SpCriticWorkingConfiguration,
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
SpCriticWorkingConfiguration class >> current [

	^ Current ifNil: [ Current  := self basicNew initialize ].
]

{ #category : #testing }
SpCriticWorkingConfiguration class >> exists [

	^ Current notNil
]

{ #category : #'instance creation' }
SpCriticWorkingConfiguration class >> new [

	^ self shouldNotImplement
]

{ #category : #initialization }
SpCriticWorkingConfiguration class >> reset [

	Current := nil
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> environment [
	^ environment
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> logInManifest [
	^ logInManifest
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> logInManifest: anObject [
	logInManifest := anObject
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> removeTestCase [
	^ removeTestCase
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> removeTestCase: aBoolean [
	removeTestCase := aBoolean
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> rule [
	^ rule
]

{ #category : #accessing }
SpCriticWorkingConfiguration >> rule: anObject [
	rule := anObject
]
