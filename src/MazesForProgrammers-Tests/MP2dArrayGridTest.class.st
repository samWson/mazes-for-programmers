"
# MP2dArrayGridTest

I am the TestCase for MP2dArrayGrid.
"
Class {
	#name : #MP2dArrayGridTest,
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
MP2dArrayGridTest >> setUp [
	super setUp.
	subjectClass := MP2dArrayGrid.
	grid4x4 := MP2dArrayGrid of: 4 by: 4. 
	firstCell := MPCell new.
	secondCell := MPCell new.
	asciiDisplayStream := String new writeStream
]

{ #category : #tests }
MP2dArrayGridTest >> testAtEastBoundaryFalse [

	| coordinate actual |
	coordinate := 2@0.
	actual := grid4x4 atEastBoundary: coordinate.
	
	self deny: actual
]

{ #category : #tests }
MP2dArrayGridTest >> testAtEastBoundaryTrue [

	| coordinate actual |
	coordinate := 3@0.
	actual := grid4x4 atEastBoundary: coordinate.
	
	self assert: actual
]

{ #category : #tests }
MP2dArrayGridTest >> testAtSouthBoundaryFalse [

	| coordinate actual |
	coordinate := 0@2.
	actual := grid4x4 atSouthBoundary: coordinate.
	
	self deny: actual
]

{ #category : #tests }
MP2dArrayGridTest >> testAtSouthBoundaryTrue [

	| coordinate actual |
	coordinate := 0@3.
	actual := grid4x4 atSouthBoundary: coordinate.
	
	self assert: actual
]

{ #category : #tests }
MP2dArrayGridTest >> testEachCell [
	| grid actual allAreCells |
	grid := MP2dArrayGrid of: 2 by: 2.
	
	actual := grid eachCell.
	allAreCells := actual allSatisfy: [ :each | each class = MPCell ].
	
	self assert: actual size equals: 4.
	self assert: allAreCells 
]

{ #category : #tests }
MP2dArrayGridTest >> testEastNeighbourOf [

	| coordinate expected actual |
	coordinate := 2@2.
	expected := 3@2.
	actual := grid4x4 eastNeighborOf: coordinate.
	self assert: actual equals: expected
]

{ #category : #tests }
MP2dArrayGridTest >> testLinkTo [

	| firstCoordinate secondCoordinate actual |
	firstCoordinate := 2@2.
	secondCoordinate := 2@1.
	
	grid4x4 link: firstCoordinate to: secondCoordinate.
	
	actual := grid4x4 linked: firstCoordinate to: secondCoordinate.
	self assert: actual
]

{ #category : #tests }
MP2dArrayGridTest >> testLinkedEastFalse [

	firstCell east: secondCell.
	self assert: (grid4x4 class linkedEast: firstCell) equals: false
]

{ #category : #tests }
MP2dArrayGridTest >> testLinkedEastTrue [

	firstCell east: secondCell.
	firstCell link: secondCell.

	self assert: (grid4x4 class linkedEast: firstCell) equals: true
]

{ #category : #tests }
MP2dArrayGridTest >> testLinkedSouthFalse [

	firstCell south: secondCell.
	self assert: (grid4x4 class linkedSouth: firstCell) equals: false
]

{ #category : #tests }
MP2dArrayGridTest >> testLinkedSouthTrue [

	firstCell south: secondCell.
	firstCell link: secondCell.
	
	self assert: (grid4x4 class linkedSouth: firstCell) equals: true
]

{ #category : #tests }
MP2dArrayGridTest >> testOfByRectangularGrid [
	| numberOfRows numberOfColumns grid totalCells correctNumberOfRows correctNumberOfColumns |
	numberOfRows := 3.
	numberOfColumns := 5.
	grid := MP2dArrayGrid of: numberOfRows by: numberOfColumns.
	
	correctNumberOfRows := grid grid size = numberOfRows.
	correctNumberOfColumns := grid eachRow allSatisfy: [ :row | row size = numberOfColumns ].
	totalCells := grid eachCell size.
	
	self assert: totalCells equals: 15. 
	self assert: correctNumberOfRows.
	self assert: correctNumberOfColumns
]

{ #category : #tests }
MP2dArrayGridTest >> testOfBySquareGrid [
	| numberOfRows numberOfColumns grid totalCells correctNumberOfRows correctNumberOfColumns |
	numberOfRows := 4.
	numberOfColumns := 4.
	grid := MP2dArrayGrid of: numberOfRows by: numberOfColumns.
	
	correctNumberOfRows := grid grid size = numberOfRows.
	correctNumberOfColumns := grid eachRow allSatisfy: [ :row | row size = numberOfColumns ].
	totalCells := grid eachCell size.
	
	self assert: totalCells equals: 16. 
	self assert: correctNumberOfRows.
	self assert: correctNumberOfColumns 
]

{ #category : #tests }
MP2dArrayGridTest >> testSignalIfOutOfBoundsNoException [
	
	| inBoundsCoordinate |
	inBoundsCoordinate := 2@2.

	self
		shouldnt: [ grid4x4 signalIfOutOfBounds: inBoundsCoordinate ]
		raise: MPOutOfGridBounds
]

{ #category : #tests }
MP2dArrayGridTest >> testSignalIfOutOfBoundsSignalException [
	
	| outOfMaxBounds outOfMinBounds |
	outOfMaxBounds := 4@4.
	outOfMinBounds := -1@(-1).

	self
		should: [ grid4x4 signalIfOutOfBounds: outOfMaxBounds ]
		raise: MPOutOfGridBounds.
		
	self 
		should: [ grid4x4 signalIfOutOfBounds: outOfMinBounds ]
		raise: MPOutOfGridBounds
]

{ #category : #tests }
MP2dArrayGridTest >> testSouthNeighborOf [

	| coordinate expected actual |
	coordinate := 2@2.
	expected := 2@3.
	actual := grid4x4 southNeighborOf: coordinate.
	self assert: actual equals: expected
]
