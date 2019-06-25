"
# MPMazeAsString

I am responsible for taking a maze as data and returning it as a string 
suitable for display.

## Usage

I have a class side method for creation of fully initialized instances.
It expects the grid of the maze to be provided as an argument. The grids
rows are assigned to the `rows` instance variable.

The `#build` method will construct the string which can then be 
accessed with the `#contents` method.

```
| stringBuilder |
stringBuilder := MPMazeAsString newFrom: aMazeGridInstance.
stringBuilder build.
stringBuilder contents.
```

## Instance Variables

- grid: The `MPGrid` instance for which I am creating the maze string. 
- outputStream: A `WriteStream` to which all string data will be added
	and returned from.
- rows: A multidimensional collection representing the contents of a maze 
	where each element in the collection is a row of cells.
"
Class {
	#name : #MPMazeAsString,
	#superclass : #Object,
	#instVars : [
		'outputStream',
		'rows',
		'grid'
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
MPMazeAsString class >> cellBody [

	^ CellBody
]

{ #category : #constants }
MPMazeAsString class >> cellCorner [

	^ CellCorner
]

{ #category : #constants }
MPMazeAsString class >> horizontalCellBoundary [

	^ HorizontalCellBoundary
]

{ #category : #'class initialization' }
MPMazeAsString class >> initialize [

	CellBody := Character space asString repeat: 3.
	CellCorner := '+'.
	HorizontalCellBoundary := '---+'. 
	LinkedVerticalCellBoundary := Character space asString.
	UnlinkedVerticalCellBoundary := '|'.
	UnlinkedHorizontalCellBoundary := '---'.
	LinkedHorizontalCellBoundary := Character space asString repeat: 3
	
	
]

{ #category : #constants }
MPMazeAsString class >> linkedHorizontalCellBoundary [

	^ LinkedHorizontalCellBoundary
]

{ #category : #constants }
MPMazeAsString class >> linkedVerticalCellBoundary [

	^ LinkedVerticalCellBoundary
]

{ #category : #'instance creation' }
MPMazeAsString class >> newFrom: anMPGrid [

	^ self new
		grid: anMPGrid;
		outputStream: String new writeStream;
		rows: anMPGrid eachRow;
		yourself
]

{ #category : #constants }
MPMazeAsString class >> unlinkedHorizontalCellBoundary [

	^ UnlinkedHorizontalCellBoundary
]

{ #category : #constants }
MPMazeAsString class >> unlinkedVerticalCellBoundary [

	^ UnlinkedVerticalCellBoundary
]

{ #category : #building }
MPMazeAsString >> build [

	outputStream := String new writeStream.
	self topBoundaryOn: outputStream length: self totalColumns.

	rows do: [ :row | | topHalf bottomHalf topHalfStream bottomHalfStream |
		topHalfStream := String new writeStream.
		bottomHalfStream := String new writeStream.
		topHalf := '|'.
		bottomHalf := '+'.
		topHalfStream << topHalf.
		bottomHalfStream << bottomHalf.

		row do: [ :cell |
			self cellTopOn: topHalfStream for: cell.
			self cellBottomOn: bottomHalfStream for: cell.
			].

		topHalfStream cr.
		bottomHalfStream cr.
		
		outputStream 
			<< topHalfStream contents;
			<< bottomHalfStream contents.
		 ].
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> cellBottomOn: aWriteStream for: aCell [
	
	| southCellBoundary |
	southCellBoundary := aCell 
		ifNil: [ self class unlinkedHorizontalCellBoundary ]
		ifNotNil: [ 
			(grid class linkedSouth: aCell) 
				ifTrue: [ self class linkedHorizontalCellBoundary ] 
				ifFalse: [ self class unlinkedHorizontalCellBoundary ] 
			].
		
	aWriteStream
		<< southCellBoundary;
		<< self class cellCorner.
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> cellTopOn: aWriteStream for: aCell [
	"Write the ASCII representation of the top half of aCell to aWriteStream."
	
	| eastCellBoundry |
	eastCellBoundry := aCell
		ifNil: [ self class unlinkedVerticalCellBoundary ]
		ifNotNil: [
			(grid class linkedEast: aCell)
				ifTrue: [ self class linkedVerticalCellBoundary ] 
				ifFalse: [ self class unlinkedVerticalCellBoundary ] 
			].
	
	aWriteStream
		<< self class cellBody;
		<< eastCellBoundry.
]

{ #category : #accessing }
MPMazeAsString >> contents [
	
	^ outputStream contents
]

{ #category : #accessing }
MPMazeAsString >> grid: anMPGrid [

	grid := anMPGrid
]

{ #category : #accessing }
MPMazeAsString >> outputStream: aWriteStream [

	outputStream := aWriteStream
]

{ #category : #accessing }
MPMazeAsString >> rows: aCollection [ 

	rows := aCollection
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> topBoundaryOn: aWriteStream length: totalColumns [

	aWriteStream
		nextPutAll: self class cellCorner;
		nextPutAll: (self class horizontalCellBoundary repeat: totalColumns);
		cr.
]

{ #category : #accessing }
MPMazeAsString >> totalColumns [

	^ rows first size
]
