Class {
	#name : #BaselineOfToolCritiqueBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfToolCritiqueBrowser
}

{ #category : #baselines }
BaselineOfToolCritiqueBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: #'NewTools-CodeCritiques'; package: #'NewTools-CodeCritiques-Tests' ]
]
