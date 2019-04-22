"
# MPMazeImageTest

I am the test case for MPMazeImage

## TODO

Testing that the streaming - helpers work is harder than expected. ZnBufferedWriteStream does
not have an accessor for the stream contents.
"
Class {
	#name : #MPMazeImageTest,
	#superclass : #TestCase,
	#category : #'MazesForProgrammers-Tests'
}

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
