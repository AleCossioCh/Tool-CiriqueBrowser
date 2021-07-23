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

{ #category : #'instance creation' }
CBAbstractChoosePresenter class >> openOn: aCollection [

	^ (self on: aCollection) openWithSpec 
]

{ #category : #'instance creation' }
CBAbstractChoosePresenter class >> openOn: aCollection onAccept: aBlock [
	^ (self on: aCollection)
		onAccept: aBlock;
		openModalWithSpec
]

{ #category : #adding }
CBAbstractChoosePresenter >> addAll [

	selectedList items:
		(selectedList unfilteredItems , list unfilteredItems sorted:
			 self methodName ascending).
	list items: #(  ).
	list selectItems: #(  )
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

	selectedList items: 
		(selectedList items, 
		(list selectedItems sorted: self methodName ascending)).
	list items: ((list unfilteredItems \ list selectedItems) sorted: self methodName ascending).
	list applyFilter: list filterText.
	list selectItems: #()
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

	<script: 'self new openWithSpec'>
	self initializeLayout.
	self initializeList.
	self initalizeSelectedList.
	self initializeButtons.
	self initializeButtonBar.
		self initializeNextButton.
]

{ #category : #initialization }
CBAbstractChoosePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: 700@500
]

{ #category : #accessing }
CBAbstractChoosePresenter >> items [

	^ items ifNil: [ items := {  } ]
]

{ #category : #accessing }
CBAbstractChoosePresenter >> list [
	
	^ list
]

{ #category : #accessing }
CBAbstractChoosePresenter >> methodName [

	^ methodName
]

{ #category : #adding }
CBAbstractChoosePresenter >> nextAction [
	self subclassResponsibility
]

{ #category : #actions }
CBAbstractChoosePresenter >> removeAll [

	selectedList items: #().
	list items: self items
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

{ #category : #actions }
CBAbstractChoosePresenter >> removeSelected [

	list items: ((list unfilteredItems, selectedList selectedItems) sorted: self methodName ascending).
	list applyFilter: list filterText.
	selectedList items: ((selectedList unfilteredItems \ selectedList selectedItems) sorted: self methodName ascending).
	selectedList applyFilter: selectedList filterText.
	selectedList selectItems: #()
]

{ #category : #accessing }
CBAbstractChoosePresenter >> removeSelectedMessage [

	^ 'Remove selected items from selected list.'
]

{ #category : #accessing }
CBAbstractChoosePresenter >> selectedItems [

	^ selectedItems ifNil: [ selectedItems := {  } ]
]

{ #category : #accessing }
CBAbstractChoosePresenter >> selectedList [

	^ selectedList
]

{ #category : #actions }
CBAbstractChoosePresenter >> setModelBeforeInitialization: aCollection [

	items := aCollection first.
	selectedItems := aCollection second.
	methodName :=  aCollection third.
]

{ #category : #accessing }
CBAbstractChoosePresenter >> title [

	^ 'Choose items'
]

{ #category : #adding }
CBAbstractChoosePresenter >> updatePresenter [

	list items: self items \ self selectedItems.
	selectedList items: self selectedItems.
]
