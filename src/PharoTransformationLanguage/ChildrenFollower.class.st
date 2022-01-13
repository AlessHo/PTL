Class {
	#name : #ChildrenFollower,
	#superclass : #Object,
	#instVars : [
		'seenObjects'
	],
	#category : #'PharoTransformationLanguage-experiment'
}

{ #category : #initialization }
ChildrenFollower >> fetchChildren: anObject [

	| directObjects |
	directObjects := OrderedCollection new.
	anObject class allSlots do: [ :slot | 
		| o |
		o := slot read: anObject.
		o ifNotNil: [ 
			(seenObjects includes: o) ifFalse: [ 
				directObjects add: o.
				seenObjects add: o ] ] ].

	directObjects addAll:
		(directObjects flatCollect: [ :each | self fetchChildren: each ]).

	^ directObjects
	

]

{ #category : #initialization }
ChildrenFollower >> fetchChildren: anObject fromPath: path [

	| directObjects currentPath |
	directObjects := OrderedCollection new.
	anObject class allSlots do: [ :slot | 
		| o |
		o := slot read: anObject.
		o ifNotNil: [ 
			(seenObjects includes: o) ifFalse: [ 
				currentPath := path ifNotEmpty: [ path , '>' ] ifEmpty: [ '' ].
				directObjects add: currentPath , slot name -> o.
				seenObjects add: o ] ] ].

	directObjects addAll: (directObjects flatCollect: [ :each | 
			 self fetchChildren: each value fromPath: each key ]).

	^ directObjects
]

{ #category : #initialization }
ChildrenFollower >> initialize [
	seenObjects := IdentitySet new.
	
]
