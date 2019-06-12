"
# MP2dArrayGrid

I am a container for a grid of cell objects.

## Implementation

Internally my grid is represented as a two dimensional array containing Cell objects.

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

## ToDo

Rename class. Use a name that describes the implementation i.e. 2D Array. Add project prefix `MP`.

## Reference

Mazes for Programmers, Jamis Buck, page 53.
"
Class {
	#name : #MP2dArrayGrid,
	#superclass : #MPGrid,
	#category : #MazesForProgrammers
}

{ #category : #testing }
MP2dArrayGrid class >> linkedEast: aCell [
	
	^ aCell linked: aCell east
]

{ #category : #testing }
MP2dArrayGrid class >> linkedSouth: aCell [ 

	^ aCell linked: aCell south
]

{ #category : #'instance creation' }
MP2dArrayGrid class >> of: totalRows by: totalColumns [
	^ self new totalRows: totalRows totalColumns: totalColumns;
		initializeGrid;
		initializeCellCoordinates; 
		configureCells;
		extent: (totalRows - 1) @ (totalColumns - 1)
		yourself
]

{ #category : #'accessing - private' }
MP2dArrayGrid >> at: rowCoordinate at: columnCoordinate [
	self flag: #fixme. "Bounds checks may already be handled by the public interface. Double check."
	(rowCoordinate between: 1 and: totalRows) ifFalse: [ ^ nil ].
	(columnCoordinate between: 1 and: ((grid at: rowCoordinate) size)) ifFalse: [ ^ nil ].
	^ (grid at: rowCoordinate) at: columnCoordinate 
]

{ #category : #'accessing - private' }
MP2dArrayGrid >> atCoordinates: aPoint [
	
	self signalIfOutOfBounds: aPoint.
	^ self at: (aPoint x + 1) at: (aPoint y + 1)
]

{ #category : #'initialization - private' }
MP2dArrayGrid >> configureCells [
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
MP2dArrayGrid >> displayStringOn: aStream [

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
MP2dArrayGrid >> eachCell [ 
	^ self eachRow flatCollect: [ :cell | cell ifNotNil: [ cell ] ] 
]

{ #category : #contents }
MP2dArrayGrid >> eachRow [
	^ self grid do: [ :row | row ]
]

{ #category : #'initialization - private' }
MP2dArrayGrid >> fillColumn [
	| column |
	column := Array ofSize: totalColumns.
	1 to: totalColumns do: [ :index | column at: index put: MPCell new ].
	
	^ column 
]

{ #category : #'initialization - private' }
MP2dArrayGrid >> initializeCellCoordinates [
	1 to: totalRows do: [ :rowIndex |
		1 to: totalColumns do: [ :columnIndex | 
			(self at: rowIndex at: columnIndex) row: rowIndex column: columnIndex ] ].
]

{ #category : #'initialization - private' }
MP2dArrayGrid >> initializeGrid [
	grid := Array ofSize: totalRows.
	1 to: totalRows do: [ :row | grid at: row put: self fillColumn ]
]

{ #category : #linking }
MP2dArrayGrid >> link: aPoint to: aNeighboringPoint [ 
	
	| firstCell secondCell |
	firstCell := self atCoordinates: aPoint.
	secondCell := self atCoordinates: aNeighboringPoint.
	
	firstCell link: secondCell 
]

{ #category : #testing }
MP2dArrayGrid >> linked: aPoint to: aPoint2 [
	| firstCell secondCell |
	firstCell := self atCoordinates: aPoint.
	secondCell := self atCoordinates: aPoint2.
	^ firstCell linked: secondCell
]

{ #category : #accessing }
MP2dArrayGrid >> size [ 
	^ totalRows * totalColumns 
]
