"
# GridTest

I am the TestCase for Grid.
"
Class {
	#name : #GridTest,
	#superclass : #TestCase,
	#instVars : [
		'asciiDisplayStream',
		'grid4x4',
		'firstCell',
		'secondCell',
		'subjectClass'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
GridTest >> setUp [
	super setUp.
	subjectClass := Grid.
	grid4x4 := Grid of: 4 by: 4. 
	firstCell := Cell new.
	secondCell := Cell new.
	asciiDisplayStream := String new writeStream
]

{ #category : #tests }
GridTest >> testAtEastBoundaryFalse [

	| coordinate actual |
	coordinate := 2@0.
	actual := grid4x4 atEastBoundary: coordinate.
	
	self deny: actual
]

{ #category : #tests }
GridTest >> testAtEastBoundaryTrue [

	| coordinate actual |
	coordinate := 3@0.
	actual := grid4x4 atEastBoundary: coordinate.
	
	self assert: actual
]

{ #category : #tests }
GridTest >> testAtNorthBoundaryFalse [

	| coordinate actual |
	coordinate := 0@2.
	actual := grid4x4 atNorthBoundary: coordinate.
	
	self deny: actual
]

{ #category : #tests }
GridTest >> testAtNorthBoundaryTrue [

	| coordinate actual |
	coordinate := 0@3.
	actual := grid4x4 atNorthBoundary: coordinate.
	
	self assert: actual
]

{ #category : #tests }
GridTest >> testCellBottomOnForLinked [

	| expected actual |
	firstCell south: secondCell.
	firstCell link: secondCell.
	expected := subjectClass linkedHorizontalCellBoundary , subjectClass cellCorner.
	
	grid4x4 class cellBottomOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
]

{ #category : #tests }
GridTest >> testCellBottomOnForNil [

	| expected actual |
	expected := subjectClass unlinkedHorizontalCellBoundary , subjectClass cellCorner.
	
	grid4x4 class cellBottomOn: asciiDisplayStream for: nil.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
]

{ #category : #tests }
GridTest >> testCellBottomOnForUnlinked [

	| expected actual |
	firstCell south: secondCell.	
	expected := subjectClass unlinkedHorizontalCellBoundary , subjectClass cellCorner.
	
	grid4x4 class cellBottomOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
]

{ #category : #tests }
GridTest >> testCellTopOnForLinked [
	
	| expected actual |
	firstCell east: secondCell.
	firstCell link: secondCell.
	
	expected := subjectClass cellBody , subjectClass linkedVerticalCellBoundary.
	
	grid4x4 class cellTopOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
	
	
]

{ #category : #tests }
GridTest >> testCellTopOnForNil [

	| expected actual |
	expected := subjectClass cellBody , subjectClass unlinkedVerticalCellBoundary.
	
	grid4x4 class cellTopOn: asciiDisplayStream for: nil.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
	
	
]

{ #category : #tests }
GridTest >> testCellTopOnForUnlinked [

	| expected actual |
	firstCell east: secondCell.
	expected := subjectClass cellBody , subjectClass unlinkedVerticalCellBoundary.
	
	grid4x4 class cellTopOn: asciiDisplayStream for: firstCell.
	
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected
]

{ #category : #tests }
GridTest >> testEachCell [
	| grid actual allAreCells |
	grid := Grid of: 2 by: 2.
	
	actual := grid eachCell.
	allAreCells := actual allSatisfy: [ :each | each class = Cell ].
	
	self assert: actual size equals: 4.
	self assert: allAreCells 
]

{ #category : #tests }
GridTest >> testEastNeighbourOf [

	| coordinate expected actual |
	coordinate := 2@2.
	expected := 3@2.
	actual := grid4x4 eastNeighbourOf: coordinate.
	self assert: actual equals: expected
]

{ #category : #tests }
GridTest >> testLinkTo [

	| firstCoordinate secondCoordinate actual |
	firstCoordinate := 2@2.
	secondCoordinate := 2@1.
	
	grid4x4 link: firstCoordinate to: secondCoordinate.
	
	actual := grid4x4 linked: firstCoordinate to: secondCoordinate.
	self assert: actual
]

{ #category : #tests }
GridTest >> testNorthNeighbourOf [

	| coordinate expected actual |
	coordinate := 2@2.
	expected := 2@3.
	actual := grid4x4 northNeighbourOf: coordinate.
	self assert: actual equals: expected
]

{ #category : #tests }
GridTest >> testOfByRectangularGrid [
	| numberOfRows numberOfColumns grid totalCells correctNumberOfRows correctNumberOfColumns |
	numberOfRows := 3.
	numberOfColumns := 5.
	grid := Grid of: numberOfRows by: numberOfColumns.
	
	correctNumberOfRows := grid grid size = numberOfRows.
	correctNumberOfColumns := grid eachRow allSatisfy: [ :row | row size = numberOfColumns ].
	totalCells := grid eachCell size.
	
	self assert: totalCells equals: 15. 
	self assert: correctNumberOfRows.
	self assert: correctNumberOfColumns
]

{ #category : #tests }
GridTest >> testOfBySquareGrid [
	| numberOfRows numberOfColumns grid totalCells correctNumberOfRows correctNumberOfColumns |
	numberOfRows := 4.
	numberOfColumns := 4.
	grid := Grid of: numberOfRows by: numberOfColumns.
	
	correctNumberOfRows := grid grid size = numberOfRows.
	correctNumberOfColumns := grid eachRow allSatisfy: [ :row | row size = numberOfColumns ].
	totalCells := grid eachCell size.
	
	self assert: totalCells equals: 16. 
	self assert: correctNumberOfRows.
	self assert: correctNumberOfColumns 
]

{ #category : #tests }
GridTest >> testSignalIfOutOfBoundsNoException [
	
	| inBoundsCoordinate |
	inBoundsCoordinate := 2@2.

	self
		shouldnt: [ grid4x4 signalIfOutOfBounds: inBoundsCoordinate ]
		raise: OutOfGridBounds
]

{ #category : #tests }
GridTest >> testSignalIfOutOfBoundsSignalException [
	
	| outOfMaxBounds outOfMinBounds |
	outOfMaxBounds := 4@4.
	outOfMinBounds := -1@(-1).

	self
		should: [ grid4x4 signalIfOutOfBounds: outOfMaxBounds ]
		raise: OutOfGridBounds.
		
	self 
		should: [ grid4x4 signalIfOutOfBounds: outOfMinBounds ]
		raise: OutOfGridBounds
]

{ #category : #tests }
GridTest >> testTopBoundaryOn [
	| expected actual |
	expected := subjectClass cellCorner , (subjectClass horizontalCellBoundary repeat: grid4x4 totalColumns) , Character cr asString.
	
	grid4x4 class topBoundaryOn: asciiDisplayStream length: grid4x4 totalColumns.
	
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected  
]
