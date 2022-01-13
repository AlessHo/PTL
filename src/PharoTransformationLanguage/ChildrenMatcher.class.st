Class {
	#name : #ChildrenMatcher,
	#superclass : #Object,
	#instVars : [
		'sourceMatcher',
		'childrenMatcher'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'instance creation' }
ChildrenMatcher class >> from: aSourceMatcher to: aChildMatcher [
	^ self new from: aSourceMatcher; to: aChildMatcher 
]

{ #category : #'instance creation' }
ChildrenMatcher >> applyChildMatch: childMatcher from: anObject withContext: aContext [

	(PTLAllChildrenPath new resolveOn: anObject) do: [ :child | 
		(childMatcher match: child withInitialContext: aContext) isMatch ifTrue: [ 
			^ aContext ] ].
	aContext isMatch: false.
	^ aContext
]

{ #category : #'instance creation' }
ChildrenMatcher >> from [

	^ sourceMatcher
]

{ #category : #'instance creation' }
ChildrenMatcher >> from: aSourceMatcher [
	sourceMatcher := aSourceMatcher 
]

{ #category : #'instance creation' }
ChildrenMatcher >> match2: anObject [

	| initialContext copyContext |
	initialContext := sourceMatcher match: anObject.
	initialContext isMatch ifFalse: [ ^ {  } ].


copyContext := initialContext copy.
	childrenMatcher
		  allSatisfy: [ :matcher | 
			
			  (self
				  applyChildMatch: matcher
				  from: anObject
				  withContext: copyContext ) isMatch].
	^ copyContext
		  
]

{ #category : #'instance creation' }
ChildrenMatcher >> match: anObject [

	| initialContext |
	initialContext := sourceMatcher match: anObject.
	initialContext isMatch ifFalse: [ ^ {  } ].

	^ (PTLAllChildrenPath new resolveOn: anObject)
		  collect: [ :child | 
		  self matchChildren: child withContext: initialContext ]
		  thenSelect: [ :each | each isMatch ]
]

{ #category : #'instance creation' }
ChildrenMatcher >> matchChildren: child withContext: aContext [

	| copyContext |
	copyContext := aContext copy.

	childrenMatcher do: [ :childMatcher | 
		(childMatcher match: child withInitialContext: copyContext) isMatch 
			ifFalse: [ 
				copyContext isMatch: false.
				^ copyContext ] ].
	^ copyContext
]

{ #category : #'instance creation' }
ChildrenMatcher >> to [

	^ childrenMatcher
]

{ #category : #'instance creation' }
ChildrenMatcher >> to: aChildMatcher [

	childrenMatcher := aChildMatcher
]
