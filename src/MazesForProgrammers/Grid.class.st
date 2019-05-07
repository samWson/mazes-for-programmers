"
# Grid

I am a container for a grid of Cells.

## Colaborators

I contain many instances of Cell. 

## Usage

My public API is documented in my superclass MPGrid in the **Usage** section.

```
MPGrid comment inspect.
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

## ToDo

Rename class. Use a name that describes the implementation i.e. 2D Array. Add project prefix `MP`.

## Reference

Mazes for Programmers, Jamis Buck, page 53.
"
Class {
	#name : #Grid,
	#superclass : #MPGrid,
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
Grid class >> of: totalRows by: totalColumns [
	^ self new totalRows: totalRows totalColumns: totalColumns;
		initializeGrid;
		initializeCellCoordinates; 
		configureCells;
		extent: (totalRows - 1) @ (totalColumns - 1)
		yourself
]

{ #category : #'accessing - private' }
Grid >> at: rowCoordinate at: columnCoordinate [
	self flag: #fixme. "Bounds checks may already be handled by the public interface. Double check."
	(rowCoordinate between: 1 and: totalRows) ifFalse: [ ^ nil ].
	(columnCoordinate between: 1 and: ((grid at: rowCoordinate) size)) ifFalse: [ ^ nil ].
	^ (grid at: rowCoordinate) at: columnCoordinate 
]

{ #category : #'accessing - private' }
Grid >> atCoordinates: aPoint [
	
	self signalIfOutOfBounds: aPoint.
	^ self at: (aPoint x + 1) at: (aPoint y + 1)
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
	self flag: #todo. "This functionality might be worth extracting into a trait."
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

{ #category : #linking }
Grid >> link: aPoint to: aPoint2 [ 
	
	| firstCell secondCell |
	firstCell := self atCoordinates: aPoint.
	secondCell := self atCoordinates: aPoint2.
	
	firstCell link: secondCell 
]

{ #category : #testing }
Grid >> linked: aPoint to: aPoint2 [
	| firstCell secondCell |
	firstCell := self atCoordinates: aPoint.
	secondCell := self atCoordinates: aPoint2.
	^ firstCell linked: secondCell
]

{ #category : #accessing }
Grid >> size [ 
	^ totalRows * totalColumns 
]
