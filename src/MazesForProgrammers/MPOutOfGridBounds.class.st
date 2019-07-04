"
# MPOutOfGridBounds

I am an exception to be used when an attempt to access a coordinate outside the 
boundaries of a grid is made.

## Instance Variables

- coordinate: The `Point` for which an access attempt was made.
- minBound: The minimum allowable coordinates of the grid.
- maxBound: The maximum allowable coordinates of the grid.
"
Class {
	#name : #MPOutOfGridBounds,
	#superclass : #Error,
	#instVars : [
		'coordinate',
		'minBound',
		'maxBound'
	],
	#category : #MazesForProgrammers
}

{ #category : #accessing }
MPOutOfGridBounds >> coordinate [
	^ coordinate
]

{ #category : #accessing }
MPOutOfGridBounds >> coordinate: anObject [
	coordinate := anObject
]

{ #category : #accessing }
MPOutOfGridBounds >> maxBound [
	^ maxBound
]

{ #category : #accessing }
MPOutOfGridBounds >> maxBound: anObject [
	maxBound := anObject
]

{ #category : #accessing }
MPOutOfGridBounds >> minBound [
	^ minBound
]

{ #category : #accessing }
MPOutOfGridBounds >> minBound: anObject [
	minBound := anObject
]
