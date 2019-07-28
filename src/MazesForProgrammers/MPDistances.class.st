"
# MPDistances

I keep track of the relative distances between cells.

## Description

I keep a collection of cells. Each cell is associated with a distance
from the *root* cell which is the first cell that the instance is
initialized with. The root cells distance is always 0.

## Usage

My class method `#newFrom:` is used for creating new instances. It 
takes an instance of `MPCell` as an argument which will be the root
cell.

```
MPDistances newFrom: aCell.
```

Access to cell distances can be treated the same as a dictionary.
`#at:put:` can be used to insert a new distance while `#at:` can
be used to get the distance of a specific cell. 

```
| distances rootCell nextCell |
rootCell := MPCell new.
nextCell := MPCell new.
distances := MPDistances newFrom: rootCell.
distances at: nextCell put: 1.
ditstances at: nextCell. ""1""
```

The method `#cells` returns all the cell instances I am tracking.

## Instance Variables
- root: the first cell from which all other distances are measured.
- cells: a `Dictionary` of cells and their distances from `root`.
"
Class {
	#name : #MPDistances,
	#superclass : #Object,
	#instVars : [
		'root',
		'cells'
	],
	#classVars : [
		'RootDistance'
	],
	#category : #MazesForProgrammers
}

{ #category : #'class initialization' }
MPDistances class >> initialize [

	RootDistance := 0
]

{ #category : #'instance creation' }
MPDistances class >> newFrom: aCell [
	
	^ self new
		root: aCell;
		at: aCell put: self rootDistance;
		yourself
]

{ #category : #constants }
MPDistances class >> rootDistance [

	^ RootDistance
]

{ #category : #accessing }
MPDistances >> at: aCell [

	^ cells at: aCell
]

{ #category : #accessing }
MPDistances >> at: aMPCell ifAbsentPut: aBlockClosure [ 

	cells at: aMPCell ifAbsentPut: aBlockClosure
]

{ #category : #accessing }
MPDistances >> at: aCell put: anInteger [

	cells at: aCell put: anInteger
]

{ #category : #accessing }
MPDistances >> cells [

	^ cells keys
]

{ #category : #initialization }
MPDistances >> initialize [

	cells := Dictionary new
]

{ #category : #accessing }
MPDistances >> root: aCell [

	root := aCell
]
