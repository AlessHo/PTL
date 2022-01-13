Class {
	#name : #PTLAllChildrenPath,
	#superclass : #PTLPath,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #initialization }
PTLAllChildrenPath >> initialize [
	path := '_>>'
]

{ #category : #initialization }
PTLAllChildrenPath >> recursivePath [
	^ true
]

{ #category : #initialization }
PTLAllChildrenPath >> resolveOn: anObject [

	| follower children |
	follower := ChildrenFollower new.
	children := follower fetchChildren: anObject.
	^ children
]

{ #category : #initialization }
PTLAllChildrenPath >> yieldCollection [
	^ true
]
