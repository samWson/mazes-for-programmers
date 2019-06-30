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
MPMazeAsStringTest >> testBuild [

	| actual centerLink expected maze stringBuilder |
	self flag: #fixme. "Once MPMazeAsString is cleaned up a bit look at deleting the streaming helper methods and moving all the setup of this method into #setUp"
	maze := MP2dArrayGrid of: 4 by: 4.
	centerLink := 1@1.
	maze 
		link: 1@0 to: centerLink;
		link: 0@1 to: centerLink;
		link: 2@1 to: centerLink;
		link: 1@2 to: centerLink.
	expected := 
'+---+---+---+---+
|   |   |   |   |
+---+   +---+---+
|           |   |
+---+   +---+---+
|   |   |   |   |
+---+---+---+---+
|   |   |   |   |
+---+---+---+---+
'.

	self flag: #fixme. "This is printed upsidedown. 0,0 starts at the top left. x axis goes from top to bottom, y axis goes from left to right. This is really confusing and needs to be fixed."
	
	stringBuilder := subjectClass newFrom: maze.
	stringBuilder build.
	actual := stringBuilder contents.
	
	self assert: actual equals: expected
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
