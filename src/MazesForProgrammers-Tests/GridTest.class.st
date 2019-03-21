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
GridTest >> testInitializeGrid [
	"This appears correct but is still a failing test."
	| grid row expected actual |
	grid := Grid new totalRows: 3 totalColumns: 3.		
	row := grid fillColumn.
	expected := { row copy. row copy. row copy. }.

	grid initializeGrid.
	
	actual := grid grid.
	
	self assert: actual equals: expected
]
