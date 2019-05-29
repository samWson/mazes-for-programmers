"
# MPMazeAlgorithm

I am an abstraction of a maze generating algorithm. I am an Abstract class.

## Colaborators

I make use of the Grid class to generate the passages of a maze.

## Usage

Instances of me should not be created. Instead subclasses should override my `on:` 
class side method and implement their own generation algorithm in there.

My API consists only of class methods. `defaultMaze` returns a maze with a 4 x 4 grid.
A different sized maze can be created by using the `mazeOf:by:` method.

For creating instances the class method `for:` should be used with an `MPGrid` 
instance argument.

The instance method `applyAlgorithm` is sent by clients to run an algorithm over my
`grid` instance variable. It is the responsibility of subclasses to define the
algorithm.
```
MPBinaryTree defaultMaze.

MPBinaryTree mazeOf: 6 by: 6.

MPBinaryTree for: anMPGrid.

anMPBinaryTree applyAlgorithm.
```

## Instance Variables

- grid: The `MPGrid` instance to which my algorithm will be applied.

## ToDo

I am to be changed to work with `MPGrid` according to the Strategy Pattern.
- Maze creation is to be moved to another class.
- The public instance creation interface will be left at `MPMazeAlgorithm class>>#for:`.
- Consider renaming the class to `MPLinkingAlgorithm`.

## Reference

Mazes for Programmers, Jamis Buck.
"
Class {
	#name : #MPMazeAlgorithm,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
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
MPMazeAlgorithm class >> for: anMPGrid [

	^ self new grid: anMPGrid
]

{ #category : #'instance creation' }
MPMazeAlgorithm class >> mazeOf: totalRows by: totalColumns [

	| grid |
	grid := Grid of: totalRows by: totalColumns.
	self applyTo: grid.
	grid displayStringOn: Transcript.
	Transcript flush
]

{ #category : #operations }
MPMazeAlgorithm >> applyAlgorithm [
	
	self subclassResponsibility 
]
