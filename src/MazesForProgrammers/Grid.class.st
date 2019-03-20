"
# Grid

I am a container for a grid of Cells.

## Colaborators

I contain many instances of Cell.

## Usage

I have a class method for creation of instances with a defined number of rows and columns.
This should be used instead of `new` as the `prepareGrid` method will use the value of the
`rows` and `columns` instance variables.

```
Grid rows: 4 columns: 4 
```

## Instance Variables

- rows, columns: The number of rows and columns in this Grid.
- grid: A two dimensional array of Cells.

## Reference

Mazes for Programmers, Jamis Buck, page 68.
"
Class {
	#name : #Grid,
	#superclass : #Object,
	#instVars : [
		'rows',
		'columns',
		'grid'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
Grid class >> rows: anInteger columns: anInteger2 [
	| instance |
	instance := self new.
	instance rows: anInteger columns: anInteger2.
	instance prepareGrid.
	instance configureCells
]

{ #category : #accessing }
Grid >> columns [
	^ columns
]

{ #category : #'initialization - private' }
Grid >> configureCells [
	self eachCell do: [ :each | 
		| row column |
		row := each row.
		column := each column.
		each north: (self row: (row - 1) column: column). 
		each south: (self row: (row + 1) column: column).
		each west: (self row: row column: (column - 1)).
		each east: (self row: row column: (column + 1))
		]
]

{ #category : #enumerating }
Grid >> eachRow [
	"TODO: might be some extra work here. The Ruby version uses `yield`."
	grid do: [ :row | ^ row  ]
]

{ #category : #'initialization - private' }
Grid >> prepareGrid [
	^ (Array new: rows) do: [ :row | 
		(Array new: columns) do: [ :column |
			Cell row: row column: column ] ] 
]

{ #category : #accessing }
Grid >> randomCell [
	| row column random |
	random := Random new.
	row := random nextInt: rows.
	column := random nextInt: ((grid at: row) size).
	
	^ grid at: row at: column 
]

{ #category : #accessing }
Grid >> row: rowCoordinate column: columnCoordinate [
	(rowCoordinate between: 0 and: rows - 1) ifFalse: [ ^ nil ].
	(columnCoordinate between: 0 and: ((grid at: rowCoordinate) size - 1)) ifFalse: [ ^ nil ].
	^ (grid at: rowCoordinate) at: columnCoordinate 
]

{ #category : #accessing }
Grid >> rows [
	^ rows
]

{ #category : #accessing }
Grid >> size [ 
	^ rows * columns
]
