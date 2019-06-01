"
# MPLinkingAlgorithm

I am an abstraction of a maze generating algorithm. I am an Abstract class.

## Colaborators

I am used by the `MPGrid` class to generate the passages of a maze. This relationship
is based on the Strategy Pattern where I am the algorithm (strategy) and `MPGrid` is
the client.

## Usage

For creating instances the class method `for:` should be used with an `MPGrid` 
instance argument.

The instance method `applyAlgorithm` is sent by clients to run an algorithm over my
`grid` instance variable. It is the responsibility of subclasses to define the
algorithm.

```
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
	#name : #MPLinkingAlgorithm,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPLinkingAlgorithm class >> applyTo: aGrid [
	"Generate a maze on aGrid with the class algorithm."
	
	self subclassResponsibility 
]

{ #category : #'instance creation' }
MPLinkingAlgorithm class >> for: anMPGrid [

	^ self new grid: anMPGrid
]

{ #category : #operations }
MPLinkingAlgorithm >> applyAlgorithm [
	
	self subclassResponsibility 
]

{ #category : #accessing }
MPLinkingAlgorithm >> grid: aCollection [ 

	grid := aCollection
]
