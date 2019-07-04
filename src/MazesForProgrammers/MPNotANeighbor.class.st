"
# MPNotANeighbor

I am an exception. I am used when an operation is made on a subject point
and second point where the second point is not a neighbor of the subject
as defined by Point>>#fourNeighbors.

## Instance Variables

- subjectPoint: The `Point` on which the operation was made.
- exceptionalPoint: The `Point` which was not included in the subject 
  points four neighbors.
- neighbors: The neighboring points of the subject point.
"
Class {
	#name : #MPNotANeighbor,
	#superclass : #Error,
	#instVars : [
		'subjectPoint',
		'exceptionalPoint',
		'neighbors'
	],
	#category : #MazesForProgrammers
}

{ #category : #accessing }
MPNotANeighbor >> exceptionalPoint [

	^ exceptionalPoint
]

{ #category : #accessing }
MPNotANeighbor >> exceptionalPoint: aPoint [

	exceptionalPoint := aPoint
]

{ #category : #accessing }
MPNotANeighbor >> neighbors [

	^ neighbors
]

{ #category : #accessing }
MPNotANeighbor >> neighbors: aCollection [

	neighbors := aCollection
]

{ #category : #accessing }
MPNotANeighbor >> subjectPoint [

	^ subjectPoint
]

{ #category : #accessing }
MPNotANeighbor >> subjectPoint: aPoint [

	subjectPoint := aPoint
]
