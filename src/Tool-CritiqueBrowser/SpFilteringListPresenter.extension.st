Extension { #name : #SpFilteringListPresenter }

{ #category : #'*Tool-CritiqueBrowser' }
SpFilteringListPresenter >> unfilteredItems [

    ^ unfilteredItems ifNil: [ unfilteredItems := self items ]
]
