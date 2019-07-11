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
	grid4x4 := MPBitfieldGrid of: 4 by: 4.
	
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
'
]

{ #category : #tests }
MPMazeAsStringTest >> testBuild [

	| actual stringBuilder |	
	stringBuilder := MPMazeAsString newFrom: grid4x4.
	stringBuilder build.
	actual := stringBuilder contents.

	self assert: actual equals: expected
]
