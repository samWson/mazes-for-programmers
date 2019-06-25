"
# MPMazeAsStringTest

I am the test case for `MPMazeAsString`.

## TODO

The streaming helper tests need to be refactored as they test the contents
of an external stream instance. Technically correct but it might be more
correct if it checks the result on the internal instance variable stream
on the MazeAsString object.
"
Class {
	#name : #MPMazeAsStringTest,
	#superclass : #TestCase,
	#instVars : [
		'firstCell',
		'secondCell',
		'subjectClass',
		'grid4x4',
		'asciiDisplayStream',
		'instance'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
MPMazeAsStringTest >> setUp [

	super setUp.
	subjectClass := MPMazeAsString.
	grid4x4 := MP2dArrayGrid of: 4 by: 4.
	instance := subjectClass newFrom: grid4x4.
	firstCell := MPCell new.
	secondCell := MPCell new.
	asciiDisplayStream := String new writeStream
]

{ #category : #tests }
MPMazeAsStringTest >> testCellBottomOnForLinked [

	| expected actual |
	firstCell south: secondCell.
	firstCell link: secondCell.
	expected := subjectClass linkedHorizontalCellBoundary , subjectClass cellCorner.
	
	instance cellBottomOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
]

{ #category : #tests }
MPMazeAsStringTest >> testCellBottomOnForNil [

	| expected actual |
	expected := subjectClass unlinkedHorizontalCellBoundary , subjectClass cellCorner.
	
	instance cellBottomOn: asciiDisplayStream for: nil.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
]

{ #category : #tests }
MPMazeAsStringTest >> testCellBottomOnForUnlinked [

	| expected actual |
	firstCell south: secondCell.	
	expected := subjectClass unlinkedHorizontalCellBoundary , subjectClass cellCorner.
	
	instance cellBottomOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected
]

{ #category : #tests }
MPMazeAsStringTest >> testCellTopOnForLinked [
	
	| expected actual |
	firstCell east: secondCell.
	firstCell link: secondCell.
	
	expected := subjectClass cellBody , subjectClass linkedVerticalCellBoundary.
	
	instance cellTopOn: asciiDisplayStream for: firstCell.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected
]

{ #category : #tests }
MPMazeAsStringTest >> testCellTopOnForNil [

	| expected actual |
	expected := subjectClass cellBody , subjectClass unlinkedVerticalCellBoundary.
	
	instance cellTopOn: asciiDisplayStream for: nil.
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected 
	
	
]

{ #category : #tests }
MPMazeAsStringTest >> testCellTopOnForUnlinked [

	| expected actual |
	firstCell east: secondCell.
	expected := subjectClass cellBody , subjectClass unlinkedVerticalCellBoundary.
	
	instance cellTopOn: asciiDisplayStream for: firstCell.
	
	actual := asciiDisplayStream contents.
	
	self assert: actual equals: expected
]

{ #category : #tests }
MPMazeAsStringTest >> testTopBoundaryOn [

	| expected actual |
	expected := subjectClass cellCorner , (subjectClass horizontalCellBoundary repeat: grid4x4 totalColumns) , Character cr asString.
	
	instance topBoundaryOn: asciiDisplayStream length: grid4x4 totalColumns.
	
	actual := asciiDisplayStream contents.

	self assert: actual equals: expected  
]
