Extension { #name : #Class }

{ #category : #'*PharoTransformationLanguage' }
Class >> asMatcher [

	^ PTLObjectMatcher
		  onClass: self
]

{ #category : #'*PharoTransformationLanguage' }
Class >> exactAs: anAssociationArray [

	^ (self suchAs: anAssociationArray) matchExactClass
]

{ #category : #'*PharoTransformationLanguage' }
Class >> named: aString [

	^ self asMatcher
		  savedSelector: aString;
		  yourself
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: anAssociationArray [

	"^ PTLObjectMatcher
		  onClass: self
		  withMatchers:
		  (anAssociationArray do: [ :entry |
					entry key: entry key asPTLPath.
			   entry value: entry value asMatcher ])"

	| matchers sourceMatcher childrenPath |
	matchers := anAssociationArray do: [ :entry | entry asMatcher ].

	sourceMatcher := PTLObjectMatcher
		                 onClass: self
		                 withMatchers:
		                 (matchers reject: [ :each | each key recursivePath ]).

	childrenPath := matchers select: [ :each | each key recursivePath ] thenCollect: [ :each | each value].
	childrenPath ifEmpty: [ ^ sourceMatcher ].
	^ ChildrenMatcher from: sourceMatcher to: childrenPath
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: aCollection like: aFullBlockClosure [

	^ (self suchAs: aCollection) like: aFullBlockClosure
]

{ #category : #'*PharoTransformationLanguage' }
Class >> unique [

	^ (PTLObjectMatcher onClass: self)
]
