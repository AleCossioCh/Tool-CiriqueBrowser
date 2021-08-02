"
I am a presenter that allows to select items from a list in my left column and put that items on a selected list on my rigth column. I am an abstract class.

* If you select an item or many items from list and click on '>', I will add selected items to selected list.
* If you click on '>>', I will add all items to selected list.
* If you select an item or many items from list and click on '<', I will remove selected items from selected list.
* If you click on '<<', I will add all items from selected list.

"
Class {
	#name : #CBAbstractChoosePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'selectedList',
		'selectedItems',
		'list',
		'addAllButton',
		'methodName',
		'addButton',
		'removeAllButton',
		'buttonBar',
		'removeButton',
		'items',
		'nextButton'
	],
	#category : #'Tool-CritiqueBrowser-Applier'
}

{ #category : #accessing }
CBAbstractChoosePresenter >> addAll [
self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractChoosePresenter >> addAllButton [

	^ addAllButton
]

{ #category : #accessing }
CBAbstractChoosePresenter >> addAllMessage [ 
	^ 'Add all items to selected list.'
]

{ #category : #accessing }
CBAbstractChoosePresenter >> addButton [

	^ addButton
]

{ #category : #adding }
CBAbstractChoosePresenter >> addSelected [

	self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractChoosePresenter >> addSelectedMessage [
	^ 'Add selected items to selected list.'
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initalizeSelectedList [

	self subclassResponsibility
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeButtonBar [

	buttonBar 
		add: self addButton 
			expand: false;
		add: self addAllButton
			expand: false;
		add: self removeButton
			expand: false;
		add: self removeAllButton
			expand: false
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeButtons [

	addButton := self newButton
				addStyle: 'small';
				label: '>';
				help: self addSelectedMessage;
				action: [ self addSelected ];
				yourself.

	addAllButton := self newButton
				addStyle: 'small';
				label: '>>';
				help: self addAllMessage;
				action: [ self addAll ];
				yourself.

	removeButton := self newButton
				addStyle: 'small';
				label: '<';
				help: self removeSelectedMessage;
				action: [ self removeSelected ];
				yourself.

	removeAllButton := self newButton
				addStyle: 'small';
				label: '<<';
				help: self removeAllMessage;
				action: [ self removeAll ];
				yourself
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeDialogWindow: aWindowPresenter [

	aWindowPresenter
		addButton: 'Accept' do: [ :presenter |
			self doAccept.
			presenter
				beOk;
				close];
		addButton: 'Cancel' do: [ :presenter | 
			presenter
				beCancel;
				close ]
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			 add: (SpBoxLayout newTopToBottom
					  spacing: 5;
					  add: (SpPanedLayout newLeftToRight
							   add: (SpBoxLayout newLeftToRight
									    spacing: 5;
									    add: #list;
									    add: (buttonBar := SpBoxLayout newTopToBottom)
									    expand: false;
									    yourself);
							   add: #selectedList;
							   yourself);
					  yourself);
			 add: (SpBoxLayout newLeftToRight
					  addLast: #nextButton;
					  yourself)
			 height: 25;
			 yourself)
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeList [

	self subclassResponsibility
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeNextButton [

	nextButton := self newButton.
	nextButton
		icon: (self iconNamed: #smallOk);
		label: 'Next';
		action: [ self nextAction ]
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializePresenters [

	self initializeLayout.
	self initializeList.
	self initalizeSelectedList.
	self initializeButtons.
	self initializeButtonBar.
	self initializeNextButton
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: 450@360
]

{ #category : #accessing }
CBAbstractChoosePresenter >> list [
	
	^ list
]

{ #category : #accessing }
CBAbstractChoosePresenter >> list: anObject [

	list := anObject
]

{ #category : #accessing }
CBAbstractChoosePresenter >> methodName [

	^ methodName
]

{ #category : #adding }
CBAbstractChoosePresenter >> nextAction [
	self subclassResponsibility
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeAll [
self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeAllButton [

	^ removeAllButton
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeAllMessage [

	^ 'Remove all items from selected list.'
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeButton [

	^ removeButton
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeSelected [
self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeSelectedMessage [

	^ 'Remove selected items from selected list.'
]

{ #category : #accessing }
CBAbstractChoosePresenter >> selectedItems [

	self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractChoosePresenter >> selectedList [

	^ selectedList
]

{ #category : #accessing }
CBAbstractChoosePresenter >> selectedList: anObject [

	selectedList := anObject
]

{ #category : #actions }
CBAbstractChoosePresenter >> setModelBeforeInitialization: aCollection [

	items := aCollection first.
	selectedItems := aCollection second.
	methodName := aCollection third
]

{ #category : #accessing }
CBAbstractChoosePresenter >> title [

	^ 'Choose items'
]
