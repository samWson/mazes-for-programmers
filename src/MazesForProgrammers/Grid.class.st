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

The **contents** protocol contains the `eachCell` method which return individual cells of the grid
as a collection.

```
grid eachCell. 
```

### Printing

I override `#displayStringOn:` to allow an ASCII art style string representation of my grid to be 
streamed. I have a number of helper methods on my class side in the `streaming - helpers` protocol
that are used to make up the individual components of my grid in string form. 

```
grid displayStringOn: Transcript. ""Or any other stream object.""
```

## Instance Variables

- totalRows, totalColumns: The total number of rows and columns in this Grid.
- grid: A two dimensional array of Cells.

## TODO

- Nil cells might be possible according to the book. Instead of doing nil checks on cells
	normalize the grid before hand.
- Customize the inspector to display the grid.

## Reference

Mazes for Programmers, Jamis Buck, page 53.
"
Class {
	#name : #Grid,
	#superclass : #Object,
	#instVars : [
		'grid',
		'totalRows',
		'totalColumns'
	],
	#classVars : [
		'CellBody',
		'CellCorner',
		'HorizontalCellBoundary',
		'LinkedHorizontalCellBoundary',
		'LinkedVerticalCellBoundary',
		'UnlinkedHorizontalCellBoundary',
		'UnlinkedVerticalCellBoundary'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
Grid class >> cellBody [
	^ CellBody 
]

{ #category : #'streaming - helpers' }
Grid class >> cellBottomOn: aWriteStream for: aCell [
	
	| southCellBoundary |
	southCellBoundary := aCell 
		ifNil: [ self unlinkedHorizontalCellBoundary ]
		ifNotNil: [ (aCell linked: aCell south) ifTrue: [ self linkedHorizontalCellBoundary ] ifFalse: [ self unlinkedHorizontalCellBoundary ] ].
		
	aWriteStream
		<< southCellBoundary;
		<< self cellCorner.
]

{ #category : #constants }
Grid class >> cellCorner [
	^ CellCorner 
]

{ #category : #'streaming - helpers' }
Grid class >> cellTopOn: aWriteStream for: aCell [ 
	| eastCellBoundry |
	eastCellBoundry := aCell
		ifNil: [ self unlinkedVerticalCellBoundary ]
		ifNotNil: [ (aCell linked: aCell east) ifTrue: [ self linkedVerticalCellBoundary ] ifFalse: [ self unlinkedVerticalCellBoundary ] ].
	
	aWriteStream
		<< self cellBody;
		<< eastCellBoundry.
]

{ #category : #constants }
Grid class >> horizontalCellBoundary [
	^ HorizontalCellBoundary 
]

{ #category : #'class initialization' }
Grid class >> initialize [
	CellBody := Character space asString repeat: 3.
	CellCorner := '+'.
	
	self flag: #fixme. "HorizontalCellBoundary is kind of redundant thanks to the other constants."
	HorizontalCellBoundary := '---+'. 
	LinkedVerticalCellBoundary := Character space asString.
	UnlinkedVerticalCellBoundary := '|'.
	UnlinkedHorizontalCellBoundary := '---'.
	LinkedHorizontalCellBoundary := Character space asString repeat: 3
	
	
]

{ #category : #constants }
Grid class >> linkedHorizontalCellBoundary [
	^ LinkedHorizontalCellBoundary 
]

{ #category : #constants }
Grid class >> linkedVerticalCellBoundary [
	^ LinkedVerticalCellBoundary 
]

{ #category : #'instance creation' }
Grid class >> of: totalRows by: totalColumns [
	^ self new totalRows: totalRows totalColumns: totalColumns;
		initializeGrid;
		initializeCellCoordinates; 
		configureCells;
		yourself
]

{ #category : #'streaming - helpers' }
Grid class >> topBoundaryOn: aWriteStream length: totalColumns [
	aWriteStream
		nextPutAll: self cellCorner;
		nextPutAll: (self horizontalCellBoundary repeat: totalColumns);
		cr.
]

{ #category : #constants }
Grid class >> unlinkedHorizontalCellBoundary [
	^ UnlinkedHorizontalCellBoundary
]

{ #category : #constants }
Grid class >> unlinkedVerticalCellBoundary [
	^ UnlinkedVerticalCellBoundary 
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
	self eachCell do: [ :cell |
		rowCoordinate := cell row.
		columnCoordinate := cell column.
		cell 
			north: (self at: rowCoordinate - 1 at: columnCoordinate);
			south: (self at: rowCoordinate + 1 at: columnCoordinate);
			west: (self at: rowCoordinate at: columnCoordinate - 1);
			east: (self at: rowCoordinate at: columnCoordinate + 1).
			].		

]

{ #category : #displaying }
Grid >> displayStringOn: aStream [
	| outputStream |
	outputStream := String new writeStream.
	self class topBoundaryOn: outputStream length: totalColumns.
	
	self eachRow do: [ :row | | topHalf bottomHalf topHalfStream bottomHalfStream |
		topHalfStream := String new writeStream.
		bottomHalfStream := String new writeStream.
		topHalf := '|'.
		bottomHalf := '+'.
		topHalfStream << topHalf.
		bottomHalfStream << bottomHalf.

		row do: [ :cell |
			self class cellTopOn: topHalfStream for: cell.
			self class cellBottomOn: bottomHalfStream for: cell. 
			].

		topHalfStream cr.
		bottomHalfStream cr.
		
		outputStream 
			<< topHalfStream contents;
			<< bottomHalfStream contents.
		 ].
	
	outputStream contents displayStringOn: aStream
]

{ #category : #contents }
Grid >> eachCell [ 
	^ self eachRow flatCollect: [ :cell | cell ifNotNil: [ cell ] ] 
]

{ #category : #contents }
Grid >> eachRow [
	^ self grid do: [ :row | row ]
]

{ #category : #'initialization - private' }
Grid >> fillColumn [
	| column |
	column := Array ofSize: totalColumns.
	1 to: totalColumns do: [ :index | column at: index put: Cell new ].
	
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
	grid := Array ofSize: totalRows.
	1 to: totalRows do: [ :row | grid at: row put: self fillColumn ]
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
