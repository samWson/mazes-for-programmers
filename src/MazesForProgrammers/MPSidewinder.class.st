"
# MPSidewinder

I am a maze implemented with a sidewinder algorithm.

## Usage

My public API is documented in my superclass MPMazeAlgorithm in the **Usage** section.

```
MPMazeAlgorithm comment.
```

## Instance Variables

- atEastBoundary, atNorthBoundary: Boolean. Set to `true` when the current coordinate is at the maximum
  x and y values of the grid, east and north respectively.
- run: A `LinkedList`. Cell coordinates are collected and linked together. When the run has ended the 
  list is emptied and the process starts again.

## Reference

Mazes for Programmers, Jamis Buck, page 86.
"
Class {
	#name : #MPSidewinder,
	#superclass : #MPLinkingAlgorithm,
	#instVars : [
		'run',
		'atEastBoundary',
		'atNorthBoundary'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPSidewinder class >> applyTo: aGrid [
	
	| extent |
	self flag: #todo. "Refactor to use an instance so behaviour can easily factored out into methods, making this more understandable."
	extent := aGrid extent.
	0 to: extent y do: [ :y | | run | "Do each row."
		run := LinkedList new.
		
		0 to: extent x do: [ :x | | coordinate atEastBoundary atNorthBoundary shouldCloseRun | "Each cell."
			coordinate := x@y.
			run add: coordinate.
			atEastBoundary := aGrid atEastBoundary: coordinate.
			atNorthBoundary := aGrid atNorthBoundary: coordinate.
			shouldCloseRun := (atEastBoundary or: (atNorthBoundary not and: (2 atRandom = 1))).			
			shouldCloseRun
				ifTrue: [ | member neighbour |
					member := run atRandom.
					(atEastBoundary and: atNorthBoundary)
						ifFalse: [
							neighbour := aGrid northNeighbourOf: member.
							neighbour ifNotNil: [ aGrid link: member to: neighbour ].
							].
					run removeAll.
					]
				ifFalse: [ 
					aGrid link: coordinate to: (aGrid eastNeighbourOf: coordinate)
					].
			].
		].

	^ aGrid
]

{ #category : #operations }
MPSidewinder >> advanceRun: aPoint [
	"Prepare the algorithm at the next collected coordinate i.e. aPoint"
	
	run add: aPoint.
	atEastBoundary := grid atEastBoundary: aPoint.
	atNorthBoundary := grid atNorthBoundary: aPoint
]

{ #category : #operations }
MPSidewinder >> applyAlgorithm [

	| extent |
	extent := grid extent.
	0 to: extent y do: [ :y | 
		0 to: extent x do: [ :x | | coordinate |
			coordinate := x @ y.

			self advanceRun: coordinate.

			self shouldCloseRun
				ifTrue: [ self closeRun ]
				ifFalse: [ self linkEast: coordinate ] 
				]. 
			]
]

{ #category : #operations }
MPSidewinder >> closeRun [

	| coordinate |
	coordinate := run atRandom.
	(atEastBoundary and: atNorthBoundary)
		ifFalse:
			[ self linkNorth: coordinate ].
	run removeAll
]

{ #category : #initialization }
MPSidewinder >> initialize [
	
	super initialize.
	run := LinkedList new.
]

{ #category : #'linking - private' }
MPSidewinder >> linkEast: aPoint [

	grid link: aPoint to: (grid eastNeighbourOf: aPoint)
]

{ #category : #'linking - private' }
MPSidewinder >> linkNorth: aPoint [

	| neighbour |
	neighbour := grid northNeighbourOf: aPoint.
	neighbour ifNotNil: [ grid link: aPoint to: neighbour ]
]

{ #category : #operations }
MPSidewinder >> shouldCloseRun [
	
	^ atEastBoundary or: (atNorthBoundary not and: 2 atRandom = 1).
]
