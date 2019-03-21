"
# Grid

I am a container for a grid of Cells.

## Colaborators

I contain many instances of Cell.

## Usage

I have a class method for creation of instances with a defined number of rows and columns.
This should be used instead of `new` as the `initializeGrid` method will use the value of the
`totalRows` and `totalColumns` instance variables.

```
Grid of: 4 by: 4 
```

The **contents** protocol contains methods that return individual rows or cells of the grid.
The **enumeration** protocol contains methods for iterating over each row or cell.

```
grid eachCell.

grid eachCell: [ :cell | Transcript show: cell ]
```

## Instance Variables

- totalRows, totalColumns: The total number of rows and columns in this Grid.
- grid: A two dimensional array of Cells.

## Reference

Mazes for Programmers, Jamis Buck, page 68.
"
Class {
	#name : #Grid,
	#superclass : #Object,
	#instVars : [
		'grid',
		'totalRows',
		'totalColumns'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
Grid class >> of: totalRows by: totalColumns [
	^ self new totalRows: totalRows totalColumns: totalColumns;
		initializeGrid;
		configureCells;
		yourself
]

{ #category : #accessing }
Grid >> at: rowCoordinate at: columnCoordinate [
	(rowCoordinate between: 1 and: totalRows) ifFalse: [ ^ nil ].
	(columnCoordinate between: 1 and: ((grid at: rowCoordinate) size)) ifFalse: [ ^ nil ].
	^ (grid at: rowCoordinate) at: columnCoordinate 
]

{ #category : #'initialization - private' }
Grid >> configureCells [
	| rowCoordinate columnCoordinate |
	self eachCell: [ :cell |
		rowCoordinate := cell row.
		columnCoordinate := cell column.
		cell 
			north: (self at: rowCoordinate - 1 at: columnCoordinate);
			south: (self at: rowCoordinate + 1 at: columnCoordinate);
			west: (self at: rowCoordinate at: columnCoordinate - 1);
			east: (self at: rowCoordinate at: columnCoordinate + 1).
			].
		
	self initializeCellCoordinates 
]

{ #category : #contents }
Grid >> eachCell [ 
	^ self eachCell: [ :cell | cell ifNotNil: [ cell ] ] 
]

{ #category : #enumeration }
Grid >> eachCell: aBlock [
	^ self eachRow flatCollect: aBlock
]

{ #category : #contents }
Grid >> eachRow [
	^ self eachRow: [ :row | row ]
]

{ #category : #enumeration }
Grid >> eachRow: aBlock [
	^ grid do: aBlock
]

{ #category : #'initialization - private' }
Grid >> fillColumn [
	| column |
	column := Array ofSize: totalRows.
	1 to: totalRows do: [ :index | column at: index put: Cell new ].
	
	^ column 
]

{ #category : #accessing }
Grid >> grid [
	^ grid
]

{ #category : #'initialization - private' }
Grid >> initializeCellCoordinates [
	1 to: totalRows do: [ :rowIndex |
		1 to: totalColumns do: [ :columnIndex | 
			(self at: rowIndex at: columnIndex) row: rowIndex column: columnIndex ] ].
]

{ #category : #'initialization - private' }
Grid >> initializeGrid [
	grid := Array ofSize: totalColumns.
	1 to: totalColumns do: [ :row | grid at: row put: self fillColumn ]
]

{ #category : #accessing }
Grid >> randomCell [
	| row column random |
	random := Random new.
	row := random nextInt: totalRows.
	column := random nextInt: ((grid at: row) size).
	
	^ grid at: row at: column 
]

{ #category : #accessing }
Grid >> size [ 
	^ totalRows * totalColumns 
]

{ #category : #accessing }
Grid >> totalColumns [
	^ totalColumns
]

{ #category : #accessing }
Grid >> totalRows [
	^ totalRows
]

{ #category : #accessing }
Grid >> totalRows: amountOfRows totalColumns: amountOfColumns [
	totalRows := amountOfRows.
	totalColumns := amountOfColumns
]
