"
# MPBinaryTree

I am a maze implemented with a binary tree algorithm.

## Usage

My public API is documented in my superclass MPMazeAlgorithm in the **Usage** section.

```
MPMazeAlgorithm comment.
```

## Reference

Mazes for Programmers, Jamis Buck, page 58.
"
Class {
	#name : #MPBinaryTree,
	#superclass : #MPMazeAlgorithm,
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPBinaryTree class >> applyTo: aGrid [

	| extent |
	extent := aGrid extent.
	
	0 to: extent x do: [ :x | 
		0 to: extent y do: [ :y | | coordinate neighbours neighbour |
			neighbours := LinkedList new.
			coordinate := x@y.
			[ neighbours add: (aGrid northNeighbourOf: coordinate) ] on: OutOfGridBounds do: [ :ex | ex return ].
			[ neighbours add: (aGrid eastNeighbourOf: coordinate) ] on: OutOfGridBounds do: [ :ex | ex return ].

			neighbours isEmpty ifFalse: [
			neighbour := neighbours atRandom.
			aGrid link: coordinate to: neighbour.
			].
		].
	].

	^ aGrid
]
