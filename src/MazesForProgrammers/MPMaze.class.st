"
# MPMaze

I am the *Main* class for the `MazesForProgrammers` project. I am an
entry point for easy generation of mazes.

## Usage

To allow for the creation of mazes of varying size, implementation, and design, I have
the class method `fromConfiguration:` that takes the maze configuration in the form of
a `Dictionary`. The configuration must have values for the following keys:
- #rows: an `Integer` 
- #columns: an `Integer`
- #algorithm: a subclass of `MPMazeAlgorithm`
- #grid: a subclass of `MPGrid`

The instance method `#printAscii` is provided for easy display of the maze on the
Transcript.

```
configuration := Dictionary newFrom: { #rows -> 14. #columns -> 14. #algorithm -> MPBinaryTree. #grid -> Grid. }.
maze := MPMaze fromConfiguration: configuration.

maze printAscii ""Outputs to Transcript""
```

## Instance Variables

- grid: an `MPGrid`

## Reference

Mazes for Programmers, Jamis Buck
"
Class {
	#name : #MPMaze,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPMaze class >> fromConfiguration: aDictionary [
	
	| instance gridInstance strategy |
	gridInstance := (aDictionary at: #grid) of: (aDictionary at: #rows) by: (aDictionary at: #columns).
	strategy := (aDictionary at: #algorithm) for: gridInstance.
	
	instance := self new.
	instance grid: gridInstance.
	instance 	grid linkingStrategy: strategy.
	instance 	grid linkCells.
	^ instance
]

{ #category : #'instance creation' }
MPMaze class >> mazeOf: totalRows by: totalColumns [

	| grid |
	grid := Grid of: totalRows by: totalColumns.
	grid linkingStrategy: (MPBinaryTree for: grid).
	grid linkCells.
	grid displayStringOn: Transcript.
	Transcript flush
]

{ #category : #accessing }
MPMaze >> grid [

	^ grid
]

{ #category : #accessing }
MPMaze >> grid: anMPGrid [
	
	grid := anMPGrid 
]

{ #category : #printing }
MPMaze >> printAscii [
	
	grid displayStringOn:Transcript.
	Transcript flush
]