"
# OutOfGridBounds

I am an exception to be used when an attempt to access a coordinate outside the 
boundaries of a grid is made.

## Instance Variables

- coordinate: The `Point` for which an access attempt was made.
- minBound: The minimum allowable coordinates of the grid.
- maxBound: The maximum allowable coordinates of the grid.
"
Class {
	#name : #OutOfGridBounds,
	#superclass : #Error,
	#instVars : [
		'coordinate',
		'minBound',
		'maxBound'
	],
	#category : #MazesForProgrammers
}

{ #category : #accessing }
OutOfGridBounds >> coordinate [
	^ coordinate
]

{ #category : #accessing }
OutOfGridBounds >> coordinate: anObject [
	coordinate := anObject
]

{ #category : #accessing }
OutOfGridBounds >> maxBound [
	^ maxBound
]

{ #category : #accessing }
OutOfGridBounds >> maxBound: anObject [
	maxBound := anObject
]

{ #category : #accessing }
OutOfGridBounds >> minBound [
	^ minBound
]

{ #category : #accessing }
OutOfGridBounds >> minBound: anObject [
	minBound := anObject
]
