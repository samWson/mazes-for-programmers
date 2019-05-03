"
# MPSidewinder

I am a maze implemented with a sidewinder algorithm.

## Usage

My public API is documented in my superclass MPMazeAlgorithm in the **Usage** section.

```
MPMazeAlgorithm comment.
```

## Reference

Mazes for Programmers, Jamis Buck, page 86.
"
Class {
	#name : #MPSidewinder,
	#superclass : #MPMazeAlgorithm,
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPSidewinder class >> applyTo: aGrid [
	
	| extent |
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
