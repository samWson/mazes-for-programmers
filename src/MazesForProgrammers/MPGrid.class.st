"
# MPGrid

I am an abstract class. I represent a grid of cells intended for use 
in making mazes. I define a public interface. Implementation is to be
defined by subclasses.

## Colaborators

I use OutOfGridBounds as an exception when an attempt to access a coordinate 
outside my boundaries is made.

### Linking Strategy

I use an instance of `MPMazeAlgorithm` to link the cells of my grid. This is 
assigned to the instance variable `linkingStrategy`. This follows the 
Strategy Pattern of object oriented design.

## Usage

I have a class method for creation of instances with a defined number of rows and columns.
This should be used instead of `new`. Subclasses will override this method.

```
MPGrid of: 4 by: 4 
```

### Access

I make use of instances of `Point` to access the cells of my grid. The x and y coordinates of the
`Point` instance match the cell of the same position. The first poisition is `0@0` so the grid
can be considered zero indexed. An `OutOfGridBounds exception is signaled if an attempt is made
to access coordinates outside the grid.

```
grid eastNeighbourOf: 2@2.
```

```
grid northNeighbourOf: 2@2.
```

### Linking

Coordinates can be linked together and tested to see if they are linked. Linked coordinates 
form the passages of a maze.

```
grid link: 2@2 to: 2@3.
```

```
grid liked: 2@2 to: 2@3. ""true""
```

### Boundaries

Boolean methods are available for testing if a coordinate is adjacent to a boundary.

```
grid atEastBoundary: 3@3.
```

```
grid atNorthBoundary: 3@3.
```

## Instance Variables

- extent: A `Point` instance representing the maximum coordinates of the grid. Zero based index.
- grid: A container for a grid defined by x and y coordinates. Implementation is a subclass responsibility.
- linkingStrategy: The algorithm that will link the grid cells to create passages.
- totalRows, totalColumns: The total number of rows and columns in this Grid.

## TODO

- Nil cells might be possible according to the book. Instead of doing nil checks on cells
	normalize the grid before hand.
- Customize the inspector to display the grid.

Mazes for Programmers, Jamis Buck, page 53.
"
Class {
	#name : #MPGrid,
	#superclass : #Object,
	#instVars : [
		'extent',
		'grid',
		'totalColumns',
		'totalRows',
		'linkingStrategy'
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
MPGrid class >> cellBody [
	^ CellBody 
]

{ #category : #'streaming - helpers' }
MPGrid class >> cellBottomOn: aWriteStream for: aCell [
	
	| southCellBoundary |
	southCellBoundary := aCell 
		ifNil: [ self unlinkedHorizontalCellBoundary ]
		ifNotNil: [ (aCell linked: aCell south) ifTrue: [ self linkedHorizontalCellBoundary ] ifFalse: [ self unlinkedHorizontalCellBoundary ] ].
		
	aWriteStream
		<< southCellBoundary;
		<< self cellCorner.
]

{ #category : #constants }
MPGrid class >> cellCorner [
	^ CellCorner 
]

{ #category : #'streaming - helpers' }
MPGrid class >> cellTopOn: aWriteStream for: aCell [ 
	| eastCellBoundry |
	eastCellBoundry := aCell
		ifNil: [ self unlinkedVerticalCellBoundary ]
		ifNotNil: [ (aCell linked: aCell east) ifTrue: [ self linkedVerticalCellBoundary ] ifFalse: [ self unlinkedVerticalCellBoundary ] ].
	
	aWriteStream
		<< self cellBody;
		<< eastCellBoundry.
]

{ #category : #constants }
MPGrid class >> horizontalCellBoundary [
	^ HorizontalCellBoundary 
]

{ #category : #'class initialization' }
MPGrid class >> initialize [

	CellBody := Character space asString repeat: 3.
	CellCorner := '+'.
	HorizontalCellBoundary := '---+'. 
	LinkedVerticalCellBoundary := Character space asString.
	UnlinkedVerticalCellBoundary := '|'.
	UnlinkedHorizontalCellBoundary := '---'.
	LinkedHorizontalCellBoundary := Character space asString repeat: 3
	
	
]

{ #category : #constants }
MPGrid class >> linkedHorizontalCellBoundary [
	^ LinkedHorizontalCellBoundary 
]

{ #category : #constants }
MPGrid class >> linkedVerticalCellBoundary [
	^ LinkedVerticalCellBoundary 
]

{ #category : #'instance creation' }
MPGrid class >> of: totalRows by: totalColumns [
	
	self subclassResponsibility 
]

{ #category : #'streaming - helpers' }
MPGrid class >> topBoundaryOn: aWriteStream length: totalColumns [
	aWriteStream
		nextPutAll: self cellCorner;
		nextPutAll: (self horizontalCellBoundary repeat: totalColumns);
		cr.
]

{ #category : #constants }
MPGrid class >> unlinkedHorizontalCellBoundary [
	^ UnlinkedHorizontalCellBoundary
]

{ #category : #constants }
MPGrid class >> unlinkedVerticalCellBoundary [
	^ UnlinkedVerticalCellBoundary 
]

{ #category : #testing }
MPGrid >> atEastBoundary: aPoint [ 
	
	^ (aPoint x) = (extent x)
]

{ #category : #testing }
MPGrid >> atNorthBoundary: aPoint [ 
	
	^ (aPoint y) = (extent y)
]

{ #category : #accessing }
MPGrid >> eastNeighbourOf: aPoint [ 
	
	| eastNeighbour |
	self signalIfOutOfBounds: aPoint.
	eastNeighbour := (aPoint x + 1) @ (aPoint y).
	self signalIfOutOfBounds: eastNeighbour. 
	^ eastNeighbour
]

{ #category : #accessing }
MPGrid >> extent [

	^ extent
]

{ #category : #accessing }
MPGrid >> extent: aPoint [ 

	extent := aPoint
]

{ #category : #accessing }
MPGrid >> grid [
	^ grid
]

{ #category : #linking }
MPGrid >> link: aPoint to: aPoint2 [

	self subclassResponsibility 
]

{ #category : #linking }
MPGrid >> linkCells [

	linkingStrategy applyAlgorithm
	
]

{ #category : #linking }
MPGrid >> linked: aPoint to: aPoint2 [

	self subclassResponsibility
]

{ #category : #accessing }
MPGrid >> linkingStrategy: anMPMazeAlgorithm [
	
	linkingStrategy := anMPMazeAlgorithm
]

{ #category : #accessing }
MPGrid >> northNeighbourOf: aPoint [ 

	| northNeighbour |
	self signalIfOutOfBounds: aPoint.
	northNeighbour := (aPoint x) @ (aPoint y + 1).
	self signalIfOutOfBounds: northNeighbour.
	^ northNeighbour
]

{ #category : #signaling }
MPGrid >> signalIfOutOfBounds: aPoint [ 

	((aPoint x < 0) or: (aPoint y < 0))
		 ifTrue: [ 
			OutOfGridBounds new
				coordinate: aPoint;
				minBound: 0@0;
				maxBound: extent;
				signal
			 ].
		
	((aPoint x > extent x) or: (aPoint y > extent y))
		ifTrue: [ 
			OutOfGridBounds new
				coordinate: aPoint;
				minBound: 0@0;
				maxBound: extent;
				signal
			 ]
]

{ #category : #accessing }
MPGrid >> totalColumns [
	^ totalColumns
]

{ #category : #accessing }
MPGrid >> totalRows [
	^ totalRows
]

{ #category : #accessing }
MPGrid >> totalRows: amountOfRows totalColumns: amountOfColumns [
	totalRows := amountOfRows.
	totalColumns := amountOfColumns
]