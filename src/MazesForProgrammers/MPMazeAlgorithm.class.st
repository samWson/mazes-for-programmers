"
# MPMazeAlgorithm

I am an abstraction of a maze generating algorithm. I am an Abstract class.

## Colaborators

I make use of the Grid and Cell classes to generate the passages of a maze.

## Usage

Instances of me should not be created. Instead subclasses should override my `on:` 
class side method and implement their own generation algorithm in there.

My API consists only of class methods. `defaultMaze` returns a maze with a 4 x 4 grid.
A different sized maze can be created by using the `mazeOf:by:` method.

```
MPBinaryTree defaultMaze.

MPBinaryTree mazeOf: 6 by: 6
```

## Reference

Mazes for Programmers, Jamis Buck.
"
Class {
	#name : #MPMazeAlgorithm,
	#superclass : #Object,
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPMazeAlgorithm class >> applyTo: aGrid [
	"Generate a maze on aGrid with the class algorithm."
	
	self subclassResponsibility 
]

{ #category : #examples }
MPMazeAlgorithm class >> defaultMaze [
	self mazeOf: 4 by: 4
]

{ #category : #'instance creation' }
MPMazeAlgorithm class >> mazeOf: totalRows by: totalColumns [

	| grid |
	grid := Grid of: totalRows by: totalColumns.
	self on: grid.
	grid displayStringOn: Transcript.
	Transcript flush
]
