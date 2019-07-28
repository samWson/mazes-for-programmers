"
# MPGrid

I am an abstract class. I represent a grid of cells intended for use 
in making mazes. I define a public interface. Implementation is to be
defined by subclasses.

## Colaborators

I use `MPOutOfGridBounds` as an exception when an attempt to access a coordinate 
outside my boundaries is made.

Making a string representation of myself is delegated to `MPMazeAsString`.

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
can be considered zero indexed. An `MPOutOfGridBounds` exception is signaled if an attempt is made
to access coordinates outside the grid.

The first postition of the grid, `0@0`, starts at the top left corner as the user is looking at it.
An increase in the x axis moves the position to the right, or east, across the grid. An increase
to the y axis moves the position down, or south, across the grid. This design was chosen to aid
string building of the maze so it can be a series of appended strings. It also follows the 
convetion of the `Form` class which is used for writing image files.

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

### Testing Protocol

On my class side I have the methods `MPGrid class>>#linkedSouth:` and `MPGrid class>>#linkedEast:`.
These test if a cell is linked in their respective direction. These are abstract methods and are 
implemented in subclasses.

### Boundaries

Boolean methods are available for testing if a coordinate is adjacent to a boundary.

```
grid atEastBoundary: 3@3.
```

```
grid atNorthBoundary: 3@3.
```

### Printing

I override `#displayStringOn:` to allow an ASCII art style string representation of my grid to be 
streamed. Building of the string is delegated to instances of `MPMazeAsString`.

```
grid displayStringOn: Transcript. ""Or any other stream object.""
```

The method `#contentsOf:` returns the visual contents of a cell in the grid and is part of the
ASCII art style display. It can be overriden by subclasses to change what is displayed.

### Contents

The method `#eachRow` will return a collection where each element is one row of the grid.
The first element of the first row should be the cell at position `0@0` of the grid.

```
grid eachRow. ""A collection of rows.""
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
	#category : #MazesForProgrammers
}

{ #category : #testing }
MPGrid class >> linkedEast: aCell [

	self subclassResponsibility 
]

{ #category : #testing }
MPGrid class >> linkedSouth: aCell [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
MPGrid class >> of: totalRows by: totalColumns [
	
	self subclassResponsibility 
]

{ #category : #testing }
MPGrid >> atEastBoundary: aPoint [ 
	
	^ (aPoint x) = (extent x)
]

{ #category : #testing }
MPGrid >> atSouthBoundary: aPoint [ 

	^ (aPoint y) = (extent y)
]

{ #category : #displaying }
MPGrid >> contentsOf: aCell [

	^ Character space asString
]

{ #category : #displaying }
MPGrid >> displayStringOn: aStream [

	| stringBuilder |
	stringBuilder := MPMazeAsString newFrom: self.
	stringBuilder build.
	stringBuilder contents displayStringOn: aStream
]

{ #category : #contents }
MPGrid >> eachRow [

	self subclassResponsibility 
]

{ #category : #accessing }
MPGrid >> eastNeighborOf: aPoint [ 
	
	| eastNeighbor |
	self signalIfOutOfBounds: aPoint.
	eastNeighbor := (aPoint x + 1) @ (aPoint y).
	self signalIfOutOfBounds: eastNeighbor. 
	^ eastNeighbor
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

{ #category : #'initialization - private' }
MPGrid >> initializeGrid [

	^ self subclassResponsibility
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
MPGrid >> linkingStrategy: anMPLinkingAlgorithm [
	
	linkingStrategy := anMPLinkingAlgorithm
]

{ #category : #signaling }
MPGrid >> signalIfOutOfBounds: aPoint [ 

	((aPoint x < 0) or: (aPoint y < 0))
		 ifTrue: [ 
			MPOutOfGridBounds new
				coordinate: aPoint;
				minBound: 0@0;
				maxBound: extent;
				signal
			 ].
		
	((aPoint x > extent x) or: (aPoint y > extent y))
		ifTrue: [ 
			MPOutOfGridBounds new
				coordinate: aPoint;
				minBound: 0@0;
				maxBound: extent;
				signal
			 ]
]

{ #category : #accessing }
MPGrid >> southNeighborOf: aPoint [ 

	| northNeighbor |
	self signalIfOutOfBounds: aPoint.
	northNeighbor := (aPoint x) @ (aPoint y + 1).
	self signalIfOutOfBounds: northNeighbor.
	^ northNeighbor
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
