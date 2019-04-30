"
# MPMazeImageTest

I am the test case for MPMazeImage

"
Class {
	#name : #MPMazeImageTest,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'extent'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
MPMazeImageTest >> setUp [

	| grid |
	super setUp.
	grid := Grid of: 2 by: 2.
	extent := MPMazeImage extentFrom: grid totalRows by: grid totalColumns.
	instance := MPMazeImage new.
	instance
		grid: grid;
		form: (Form extent: extent).
]

{ #category : #tests }
MPMazeImageTest >> testAdvanceCellZero [
	
	| expected actual |
	expected := (instance cellZero x + 4) @ (instance cellZero y).
	instance advanceCellZero.
	actual := instance cellZero.
	self assert: actual equals: expected 

]

{ #category : #tests }
MPMazeImageTest >> testAdvanceCellZeroPastXExtent [
	
	| expected actual |
	expected := (instance cellZero x) @ (instance cellZero y + 4).
	2 timesRepeat: [ instance advanceCellZero. ].
	actual := instance cellZero.
	self assert: actual equals: expected 

]

{ #category : #tests }
MPMazeImageTest >> testAdvancePointer [

	| expected actual |
	expected := (instance position x + 1) @ (instance position y).
	instance advancePointer.
	actual := instance position.
	self assert: actual equals: expected
	
]

{ #category : #tests }
MPMazeImageTest >> testAdvancePointerPastXExtent [

	| expected actual xExtent |
	xExtent := extent x - 1.
	expected := 0 @ (instance position y + 1).
	xExtent + 1 timesRepeat: [ instance advancePointer ].
	actual := instance position.
	self assert: actual equals: expected
]

{ #category : #tests }
MPMazeImageTest >> testAtXExtentFalse [

	self assert: instance atXExtent equals: false
		
	
]

{ #category : #tests }
MPMazeImageTest >> testAtXExtentTrue [

	| xExtent |
	xExtent := extent x - 1.
	xExtent timesRepeat: [ instance advancePointer ].
	self assert: instance atXExtent equals: true
		
	
]

{ #category : #tests }
MPMazeImageTest >> testExtentFromBy [
	
	| totalRows totalColumns expected actual |
	totalRows := 4.
	totalColumns := 4.
	expected := 17@17.
	
	actual := MPMazeImage extentFrom: totalRows by: totalColumns.
	
	self assert: actual equals: expected
]

{ #category : #tests }
MPMazeImageTest >> testTotalBoundaries [
	
	| totalColumns expected actual |
	totalColumns := 4.
	expected := totalColumns + 1.
	
	actual := MPMazeImage totalBoundaries: totalColumns.
	
	self assert: actual equals: expected
]
