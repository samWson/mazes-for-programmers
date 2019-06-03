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
	#superclass : #MPLinkingAlgorithm,
	#category : #MazesForProgrammers
}

{ #category : #operations }
MPBinaryTree >> applyAlgorithm [

	| extent |
	extent := grid extent.

	0 to: extent x do: [ :x | 
		0 to: extent y do: [ :y | | neighbors |
			neighbors := self neighborsOf: x@y.
			self link: x@y toRandomNeighbor: neighbors.
		].
	]
]

{ #category : #'linking - private' }
MPBinaryTree >> link: coordinate toRandomNeighbor: neighbors [
	
	| neighbor |
	^ neighbors isEmpty 
		ifFalse: [ 
			neighbor := neighbors atRandom.
			grid link: coordinate to: neighbor 
			]
]

{ #category : #'as yet unclassified' }
MPBinaryTree >> neighborsOf: aPoint [

	| neighbors |
	neighbors := LinkedList new.
	[ neighbors add: (grid northNeighbourOf: aPoint) ] on: OutOfGridBounds do: [ :ex | ex return ].
	[ neighbors add: (grid eastNeighbourOf: aPoint) ] on: OutOfGridBounds do: [ :ex | ex return ].

	^ neighbors
]
