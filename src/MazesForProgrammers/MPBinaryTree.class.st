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
MPBinaryTree class >> on: aGrid [
	| neighbours neighbour |
	aGrid eachCell do: [ :cell | 
		neighbours := LinkedList new.
		(cell north) ifNotNil: [ neighbours add: cell north ].
		(cell east) ifNotNil: [ neighbours add: cell east ].
		
		"TODO: Could extract to `self linkNeighbours` or `self linkCells`"
		neighbours isEmpty ifFalse: [  
			neighbour := neighbours atRandom.
			neighbour ifNotNil: [ cell link: neighbour ]
			].
		].

	^ aGrid
]
