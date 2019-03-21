"
# GridTest

I am the TestCase for Grid.
"
Class {
	#name : #GridTest,
	#superclass : #TestCase,
	#category : #'MazesForProgrammers-Tests'
}

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
GridTest >> testOfBy [
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
