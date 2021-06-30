Class {
	#name : #SpCriticToolbar,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleHolder',
		'criticHolder',
		'browseModel',
		'falsepositiveModel',
		'transformModel'
	],
	#category : #'Tool-CritiqueBrowser-Parts'
}

{ #category : #specs }
SpCriticToolbar class >> defaultSpec [

	^ 
	SpBoxLayout newTopToBottom
	 		add: (SpBoxLayout newLeftToRight
			   add: #browseModel;
			   add: #transformModel;
			   add: #falsepositiveModel;
			   yourself) height: 25;
			yourself 
]

{ #category : #private }
SpCriticToolbar >> browseCritic [

	criticHolder value ifNotNil: [ :elem | elem sourceAnchor entity browse ] 
]

{ #category : #accessing }
SpCriticToolbar >> browseModel [

	^ browseModel
]

{ #category : #api }
SpCriticToolbar >> critic: aCritic [

	criticHolder value: aCritic.
	transformModel enabled: (aCritic isNotNil and: [ aCritic providesChange ])
]

{ #category : #accessing }
SpCriticToolbar >> falsepositiveModel [

	^ falsepositiveModel
]

{ #category : #initialization }
SpCriticToolbar >> initialize [

	super initialize.
	criticHolder := nil asValueHolder.
	ruleHolder := nil asValueHolder.
	browseModel := self instantiate: SpButtonPresenter.
	transformModel := self instantiate: SpButtonPresenter.
	falsepositiveModel := self instantiate: SpButtonPresenter.
	self setFocusOrder.	
	self setBrowseModel.
	self setTransformModel.
	self setFalsepositiveModel.
	self registerForChanges
]

{ #category : #initialization }
SpCriticToolbar >> initializePresenters [

	
]

{ #category : #initialization }
SpCriticToolbar >> registerForChanges [

	criticHolder whenChangedDo: [ :contents |
		| boolean |
		boolean := contents notNil.
		browseModel state: (boolean and: [ browseModel enabled ]).
		transformModel state: (boolean and: [ transformModel enabled ]).
		falsepositiveModel state: (boolean and: [ falsepositiveModel enabled ]) 
		]

]

{ #category : #api }
SpCriticToolbar >> rule: aRule [
	
	ruleHolder value: aRule. 
	

]

{ #category : #initialization }
SpCriticToolbar >> setBrowseModel [
	
	browseModel
		state: false;
		label: 'Browse';
		action: [ self browseCritic ]
	

]

{ #category : #initialization }
SpCriticToolbar >> setFalsepositiveModel [
	
	falsepositiveModel
		state: false;
		label: 'Mark as wrong';
		action: [  ]
	

]

{ #category : #initialization }
SpCriticToolbar >> setFocusOrder [

	self focusOrder
		add: browseModel;
		add: transformModel;
		add: falsepositiveModel
		
]

{ #category : #initialization }
SpCriticToolbar >> setTransformModel [
	
	transformModel
		state: false;
		label: 'Transform';
		action: [ self transformCritic ]
	

]

{ #category : #private }
SpCriticToolbar >> transformCritic [
	 criticHolder value
		ifNotNil: [:critic | critic change execute ]
	

]

{ #category : #accessing }
SpCriticToolbar >> transformModel [

	^ transformModel
]

{ #category : #initialization }
SpCriticToolbar >> whenFalsePositiveClickedDo: aBlock [

	self falsepositiveModel whenActionPerformedDo: aBlock
]
