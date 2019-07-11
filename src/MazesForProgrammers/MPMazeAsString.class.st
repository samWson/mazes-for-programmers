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
- topHalfStream: A `WriteStream`, the top half of a row of cells is written
	to this and then added to the outputStream.
- bottomHalfStrea: A `WriteStream`, the bottom half of a row of cells is written
	to this and then added to the outputStrea.
"
Class {
	#name : #MPMazeAsString,
	#superclass : #Object,
	#instVars : [
		'outputStream',
		'rows',
		'grid',
		'topHalfStream',
		'bottomHalfStream'
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
	self streamTopBoundary.
	
	rows do: [ :row | 
		self initializeStreamsForRow.
		
		row do: [ :cell | 
			self streamUpperHalfOf: cell.
			self streamLowerHalfOf: cell. 
			].

			self streamCarriageReturns.
			
			outputStream
				<< topHalfStream contents;
				<< bottomHalfStream contents. 
				]
]

{ #category : #accessing }
MPMazeAsString >> contents [
	
	^ outputStream contents
]

{ #category : #accessing }
MPMazeAsString >> grid: anMPGrid [

	grid := anMPGrid
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> initializeStreamsForRow [

	| bottomHalf topHalf |
	topHalfStream := String new writeStream.
	bottomHalfStream := String new writeStream.
	topHalf := '|'.
	bottomHalf := '+'.
	topHalfStream << topHalf.
	bottomHalfStream << bottomHalf
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
MPMazeAsString >> streamCarriageReturns [

	topHalfStream cr.
	bottomHalfStream cr
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> streamLowerHalfOf: aCell [

	| southCellBoundary |
	southCellBoundary := aCell 
		ifNil: [ self class unlinkedHorizontalCellBoundary ]
		ifNotNil: [ 
			(grid class linkedSouth: aCell) 
				ifTrue: [ self class linkedHorizontalCellBoundary ] 
				ifFalse: [ self class unlinkedHorizontalCellBoundary ] 
			].

	bottomHalfStream
		<< southCellBoundary;
		<< self class cellCorner.
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> streamTopBoundary [

	outputStream
		<< self class cellCorner;
		<< (self class horizontalCellBoundary repeat: self totalColumns);
		cr.
]

{ #category : #'streaming - helpers' }
MPMazeAsString >> streamUpperHalfOf: aCell [
	
	| eastCellBoundry |
	eastCellBoundry := aCell
		ifNil: [ self class unlinkedVerticalCellBoundary ]
		ifNotNil: [
			(grid class linkedEast: aCell)
				ifTrue: [ self class linkedVerticalCellBoundary ] 
				ifFalse: [ self class unlinkedVerticalCellBoundary ] 
			].

	topHalfStream
		<< self class cellBody;
		<< eastCellBoundry
]

{ #category : #accessing }
MPMazeAsString >> totalColumns [

	^ rows first size
]
