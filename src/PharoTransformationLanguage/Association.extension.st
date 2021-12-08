Extension { #name : #Association }

{ #category : #'*PharoTransformationLanguage' }
Association >> asMatcher [

	| matcher |
	matcher := self value asMatcher.
	self value = #@ ifTrue: [ matcher named: self key ].
	self value: matcher.
	self key: self key asPTLPath.
]

{ #category : #'*PharoTransformationLanguage' }
Association >> named: aString [

	self value: (self value named: aString)
]

{ #category : #'*PharoTransformationLanguage' }
Association >> suchAs: aCollection [

	self value: (self value suchAs: aCollection)
]
