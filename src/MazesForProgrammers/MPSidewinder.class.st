"
# Sidewinder Maze

I am a maze implemented with a sidewinder algorithm.

## Colaborators

I make use of the Grid and Cell classes to implement the components of a
maze.

## Usage

My API consists only of class methods. `defaultMaze` returns a maze with a 4 x 4 grid.
A different sized maze can be created by using the `mazeOf:by:` method.

```
MPSidewinder defaultMaze.

MPSidewinder mazeOf: 6 by: 6
```

## TODO

Extract methods in common with MPBinaryTree into Abstract superclass.

## Reference

Mazes for Programmers, Jamis Buck, page 86.
"
Class {
	#name : #MPSidewinder,
	#superclass : #Object,
	#category : #MazesForProgrammers
}

{ #category : #examples }
MPSidewinder class >> defaultMaze [
	self mazeOf: 4 by: 4
]

{ #category : #'instance creation' }
MPSidewinder class >> mazeOf: totalRows by: totalColumns [

	| grid |
	grid := Grid of: totalRows by: totalColumns.
	self on: grid.
	grid displayStringOn: Transcript.
	Transcript flush
]

{ #category : #'instance creation' }
MPSidewinder class >> on: aGrid [
	
	aGrid eachRow do: [ :row | | run |
		run := LinkedList new.
		row do: [ :cell | | atEasternBoundary atNorthernBoundary shouldCloseOut member |
			run add: cell.
			atEasternBoundary := cell east isNil.
			atNorthernBoundary := cell north isNil.
			shouldCloseOut := (atEasternBoundary or: (atNorthernBoundary not and: (2 atRandom = 1))).
			shouldCloseOut 
				ifTrue: [ 
					member := run atRandom.
					member north ifNotNil: [ member link: member north ].
					run removeAll.
					 ] 
				ifFalse: [ 
					cell link: cell east 
					].
			]. 		
		 ].
	^ aGrid
]
