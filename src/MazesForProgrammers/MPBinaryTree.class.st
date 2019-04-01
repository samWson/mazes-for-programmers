"
# Binary Tree Maze

I am a maze implemented with a binary tree algorithm.

## Colaborators

I make use of the Grid and Cell classes to implement the components of a
maze.

## Usage

My API consists only of class methods. `defaultMaze` returns a maze with a 4 x 4 grid.
A different sized maze can be created by using the `mazeOf:by:` method.

```
MPBinaryTree defaultMaze.

MPBinaryTree mazeOf: 6 by: 6
```

## Reference

Mazes for Programmers, Jamis Buck, page 58.
"
Class {
	#name : #MPBinaryTree,
	#superclass : #Object,
	#category : #MazesForProgrammers
}

{ #category : #examples }
MPBinaryTree class >> defaultMaze [
	self mazeOf: 4 by: 4
]

{ #category : #'instance creation' }
MPBinaryTree class >> mazeOf: totalRows by: totalColumns [
	| grid |
	grid := Grid of: totalRows by: totalColumns.
	self on: grid.
	grid displayStringOn: Transcript.
	Transcript flush
]

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
