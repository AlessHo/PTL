Class {
	#name : #A,
	#superclass : #Object,
	#instVars : [
		'toB',
		'att'
	],
	#category : #'PharoTransformationLanguage-experiment'
}

{ #category : #accessing }
A >> att [

	^ att
]

{ #category : #accessing }
A >> att: anObject [

	att := anObject
]

{ #category : #accessing }
A >> toB [

	^ toB
]

{ #category : #accessing }
A >> toB: anObject [

	toB := anObject
]
