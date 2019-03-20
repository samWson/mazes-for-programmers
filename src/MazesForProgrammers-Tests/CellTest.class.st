"
# CellTest

I am the TestCase for Cell.

## Instance Variables

A variety of Cell instances are provided for testing.
"
Class {
	#name : #CellTest,
	#superclass : #TestCase,
	#instVars : [
		'firstCell',
		'secondCell',
		'northCell',
		'eastCell',
		'cellWithNeighbours'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
CellTest >> setUp [
	super setUp.
	firstCell := Cell new.
	secondCell := Cell new.
	northCell := Cell new.
	eastCell := Cell new.
	
	cellWithNeighbours := Cell new
		north: northCell;
		east: eastCell;
		yourself
]

{ #category : #tests }
CellTest >> testLink [
	| actual |	
	actual := firstCell link: secondCell.
	
	self assert: (firstCell links includes: secondCell) equals: true.
	self assert: (secondCell links includes: firstCell) equals: true.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
CellTest >> testLinkBidirectional [
	| actual |
	actual := firstCell link: secondCell bidirectional: false.
	
	self assert: (firstCell links includes: secondCell) equals: true.
	self assert: (secondCell links includes: firstCell) equals: false.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
CellTest >> testLinked [
	| linkedActual unlinkedActual |
	firstCell link: secondCell.
	
	linkedActual := firstCell linked: secondCell.
	
	firstCell unlink: secondCell.
	
	unlinkedActual := firstCell linked: secondCell.
	
	self assert: linkedActual equals: true.
	self assert: unlinkedActual equals: false
]

{ #category : #tests }
CellTest >> testNeighbours [
	| actual expected |
	expected := { northCell. eastCell. }.
	actual := cellWithNeighbours neighbours.
	
	self assertCollection: actual hasSameElements: expected 
	
]

{ #category : #tests }
CellTest >> testUnlink [
	| actual |
	firstCell link: secondCell.
	actual := firstCell unlink: secondCell.
	
	self assert: (firstCell links includes: secondCell) equals: false.
	self assert: (secondCell links includes: firstCell) equals: false.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
CellTest >> testUnlinkBidirectional [
	| actual |
	firstCell link: secondCell.
	actual := firstCell unlink: secondCell bidirectional: false.
	
	self assert: (firstCell links includes: secondCell) equals: false.
	self assert: (secondCell links includes: firstCell) equals: true.
	self assert: actual equals: firstCell 
]
