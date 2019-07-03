"
# MPMazeAsStringTest

I am the test case for `MPMazeAsString`.

## Instance Variables

- grid4x4: an `MPGrid` instance which is used as data to generate the maze string from.
- expected: a `String` representing the expected maze. 
"
Class {
	#name : #MPMazeAsStringTest,
	#superclass : #TestCase,
	#instVars : [
		'grid4x4',
		'expected'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
MPMazeAsStringTest >> setUp [

	| centerLink |
	super setUp.
	grid4x4 := MP2dArrayGrid of: 4 by: 4.
	
	centerLink := 1@1.
	
	grid4x4 
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
]

{ #category : #tests }
MPMazeAsStringTest >> testBuild [

	| actual stringBuilder |	
	stringBuilder := MPMazeAsString newFrom: grid4x4.
	stringBuilder build.
	actual := stringBuilder contents.

	self assert: actual equals: expected
]
