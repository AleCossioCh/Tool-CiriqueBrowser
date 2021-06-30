Class {
	#name : #BaselineOfToolCritiqueBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfToolCritiqueBrowser
}

{ #category : #baselines }
BaselineOfToolCritiqueBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: #'Tool-CritiqueBrowser' ]
]
