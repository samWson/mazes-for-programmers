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
