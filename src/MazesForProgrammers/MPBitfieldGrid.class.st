"
# MPBitfieldGrid

I am a container for a grid. Cells of my grid are represented as bytes. 

## Implementation

The grid is represented as a `ByteArray` containing all the cells of the grid in sequence. Each
cell is a four bit value. 

### Bit Values

The four bits show which of the cells neighbors it is linked to. A value of 1 shows that the cell
is linked with that neighbor. A value of 0 shows no link. Cells must be linked bidirectionally 
i.e. is a cell is linked to its neighbor then the neighbor must also be linked to the first cell.

Notation for Bytes values is represented as binary literals. Bit values are mapped to directions as follows:
- north = 2r0001
- east = 2r0010
- south = 2r0100
- west = 2r1000

#### Examples

A cell linked to its eastern neighbor:
`2r0010 ""Value of 2""`

A cell linked to its northern and western neighbors:
`2r1001 ""Value of 9""`

The value of the byte gives an indication of which neighboring cells are linked e.g. `2r1101` has a value of
13 which is 1, 4, and 8 added together, indicating links to the north, south, and west. The neighbor to the
east is not linked so the bit is 0.

### Mapping Protocol

The public interface presents a grid of cells that can be accessed with X and Y coordinates using 
instances of `Point`. Internally the cells are all held in a single dimension instance of `ByteArray`.

Methods of the `mapping` protocol are used for accessing the correct element of the array for a given
set of coordinates. The protocol also contains methods for mapping byte values to cardinal directions
to aid linking cells.

The methods in this protocol are not intended to be a part of the public interface.

#### Dependencies

When finding which direction a cell is when compared to its neighbor a key method is
`Point>>#fourNeighbors`. The implementation depends on the ordering of the elements in the returned
collection as each index relates to a direction from the `Point` instance.

The test `MPBitfieldGridTest>>#testPointFourNeighbors` exist to monitor changes in this dependency.
A passing test indicates that the dependency is working as expected.

## Usage

### Printing (Not implemented yet)

I override `#displayStringOn:` to allow an ASCII art style string representation of my grid to be 
streamed. I have a number of helper methods on my class side in the `streaming - helpers` protocol
that are used to make up the individual components of my grid in string form. 

```
grid displayStringOn: Transcript. ""Or any other stream object.""
```

## Class Variables

- CardinalDirectionMappings: A collection of directions arranged so that the indexes map to
  a specific element. This mapping is dependent on the result of `Point>>#fourNeighbors`.
- OppositeCardinatlDirections: A dictionary where the keys point to their opposite direction.
- North: A binary value of 1. Represents a cell linked to its northern neighbor.
- East: A binary value of 2. Represents a cell linked to its eastern neighbor.
- South: A binary value of 4. Represents a cell linked to its southern neighbor.
- West: A binary value of 8. Represents a cell linked to its western neighbor.
- UnlinkedCell: A binary value of 0. Represents a cell with no links to its neighbors.

## Reference

Mazes for Programmers, Jamis Buck, page 74.
"
Class {
	#name : #MPBitfieldGrid,
	#superclass : #MPGrid,
	#classVars : [
		'CardinalDirectionMappings',
		'East',
		'North',
		'OppositeCardinatlDirections',
		'South',
		'UnlinkedCell',
		'West'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
MPBitfieldGrid class >> cardinalDirectionMappings [
	
	^ CardinalDirectionMappings
]

{ #category : #constants }
MPBitfieldGrid class >> east [

	^ East
]

{ #category : #'class initialization' }
MPBitfieldGrid class >> initialize [

	CardinalDirectionMappings := { self east. self south. self west. self north. }.
	OppositeCardinatlDirections := Dictionary newFromPairs: 
		{ 
			self east. self west. 
			self west. self east. 
			self north. self south. 
			self south. self north.
		}.
	North := 2r0001.
	East := 2r0010.
	South := 2r0100.
	West := 2r1000.
	UnlinkedCell := 2r0000
]

{ #category : #testing }
MPBitfieldGrid class >> linkedEast: anInteger [
	self flag: #limitation. "A bitfield cell will know if it is linked in a direction but we have no way of knowing if the link is bidirectional because the cell knows nothing of its neighbors."
	^ (anInteger bitAnd: 2r0010) = 2r0010
]

{ #category : #testing }
MPBitfieldGrid class >> linkedSouth: anInteger [
	self flag: #limitation. "A bitfield cell will know if it is linked in a direction but we have no way of knowing if the link is bidirectional because the cell knows nothing of its neighbors."
	^ (anInteger bitAnd: 2r0100) = 2r0100
]

{ #category : #constants }
MPBitfieldGrid class >> north [

	^ North
]

{ #category : #'instance creation' }
MPBitfieldGrid class >> of: totalRows by: totalColumns [
	^ self new totalRows: totalRows totalColumns: totalColumns;
		flag: #review; "Is this around the right way?"
		extent: (totalColumns - 1) @ (totalRows - 1);
		initializeGrid;
		yourself
]

{ #category : #constants }
MPBitfieldGrid class >> oppositeCardinalDirections [

	^ OppositeCardinatlDirections 
]

{ #category : #constants }
MPBitfieldGrid class >> south [
	
	^ South
]

{ #category : #constants }
MPBitfieldGrid class >> unlinkedCell [
	
	^ UnlinkedCell
]

{ #category : #constants }
MPBitfieldGrid class >> west [
	
	^ West
]

{ #category : #mapping }
MPBitfieldGrid >> cardinalDirectionOfIndex: anInteger [

	^ self class cardinalDirectionMappings at: anInteger
]

{ #category : #mapping }
MPBitfieldGrid >> directionFrom: aPoint to: aNeighboringPoint [
	"Return which cardinal direction i.e. #north, #east, #south, #west, aNeighboringPoint is from aPoint"
	
	"The mappings of indexes to cardinal directions is dependent on the ordering of the collection returned by Point>>#fourNeighbors. A test MPBitfieldGridTest>>#testPointFourNeighbors exists to detect any breaking changes to this dependency."
	
	| index |
	index := aPoint fourNeighbors indexOf: aNeighboringPoint.
	^ self cardinalDirectionOfIndex: index
]

{ #category : #contents }
MPBitfieldGrid >> eachRow [

	| cells rowLength rows |
	rowLength := totalColumns. 
	cells := ReadStream on: grid.
	rows := LinkedList new. 
	[ cells atEnd ] whileFalse: [ rows add: (cells next: rowLength) ].
	^ rows
]

{ #category : #mapping }
MPBitfieldGrid >> indexAtCoordinates: aPoint [
	"Map aPoint to the internal implementation index."

	| rowLength yAxisShift |
	rowLength := totalColumns.
	yAxisShift := rowLength * aPoint y.
	^ (aPoint x + 1) + yAxisShift
]

{ #category : #'initialization - private' }
MPBitfieldGrid >> initializeGrid [
	
	grid := ByteArray new: (totalColumns * totalRows) withAll: self class unlinkedCell
]

{ #category : #mapping }
MPBitfieldGrid >> invertDirection: anInteger [
	"Map anInteger to the opposite internal implementation direction."

	^ self class oppositeCardinalDirections at: anInteger
]

{ #category : #linking }
MPBitfieldGrid >> link: aPoint to: aNeighboringPoint [ 
	
	| index neighboringIndex linkDirection |
	self signalIfInvalid: aPoint neighboringPoint: aNeighboringPoint. 
	
	index := self indexAtCoordinates: aPoint.
	neighboringIndex := self indexAtCoordinates: aNeighboringPoint.
	
	linkDirection := self directionFrom: aPoint to: aNeighboringPoint.

	self link: index to: neighboringIndex direction: linkDirection
]

{ #category : #'linking - private' }
MPBitfieldGrid >> link: index to: neighboringIndex direction: aByte [

	| cell neighboringCell inverseDirection |
	cell := grid at: index.
	grid at: index put: (cell bitOr: aByte).
	
	neighboringCell := grid at: neighboringIndex.
	inverseDirection := self invertDirection: aByte.
	grid at: neighboringIndex put: (neighboringCell bitOr: inverseDirection)
]

{ #category : #linking }
MPBitfieldGrid >> linked: aPoint to: aNeighboringPoint [
	"Return true if the two points are linked bidirectionally."
	
	| directionToNeighbor cell linkedToNeighbor neighboringCell directionToPoint linkedToPoint |
	self signalIfInvalid: aPoint neighboringPoint: aNeighboringPoint.
	
	directionToNeighbor := self directionFrom: aPoint to: aNeighboringPoint.
	directionToPoint := self invertDirection: directionToNeighbor.

	cell := grid at: (self indexAtCoordinates: aPoint).
	neighboringCell := grid at: (self indexAtCoordinates: aNeighboringPoint).
	
	linkedToNeighbor := (cell bitAnd: directionToNeighbor) = directionToNeighbor.
	linkedToPoint := (neighboringCell bitAnd: directionToPoint) = directionToPoint.
	
	^ linkedToNeighbor and: linkedToPoint
]

{ #category : #signalling }
MPBitfieldGrid >> signalIf: aNeighboringPoint NotANeighborOf: aPoint [

	| neighbors |
	neighbors := aPoint fourNeighbors.
	
	(neighbors includes: aNeighboringPoint)
		ifFalse: [ 
			MPNotANeighbor new
				subjectPoint: aPoint;
				exceptionalPoint: aNeighboringPoint;
				neighbors: neighbors;
				signal 
			]
]

{ #category : #signalling }
MPBitfieldGrid >> signalIfInvalid: aPoint neighboringPoint: aNeighboringPoint [
	
	self signalIfOutOfBounds: aPoint.
	self signalIfOutOfBounds: aNeighboringPoint.
	self signalIf: aNeighboringPoint NotANeighborOf: aPoint 
]
