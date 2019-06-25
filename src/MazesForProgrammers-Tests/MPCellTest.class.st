"
# MPCellTest

I am the TestCase for `MPCell`.

## Instance Variables

A variety of `MPCell` instances are provided for testing.
"
Class {
	#name : #MPCellTest,
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
MPCellTest >> setUp [
	super setUp.
	firstCell := MPCell new.
	secondCell := MPCell new.
	northCell := MPCell new.
	eastCell := MPCell new.
	
	cellWithNeighbours := MPCell new
		north: northCell;
		east: eastCell;
		yourself
]

{ #category : #tests }
MPCellTest >> testLink [
	| actual |	
	actual := firstCell link: secondCell.
	
	self assert: (firstCell links includes: secondCell) equals: true.
	self assert: (secondCell links includes: firstCell) equals: true.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
MPCellTest >> testLinkBidirectional [
	| actual |
	actual := firstCell link: secondCell bidirectional: false.
	
	self assert: (firstCell links includes: secondCell) equals: true.
	self assert: (secondCell links includes: firstCell) equals: false.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
MPCellTest >> testLinked [
	| linkedActual unlinkedActual |
	firstCell link: secondCell.
	
	linkedActual := firstCell linked: secondCell.
	
	firstCell unlink: secondCell.
	
	unlinkedActual := firstCell linked: secondCell.
	
	self assert: linkedActual equals: true.
	self assert: unlinkedActual equals: false
]

{ #category : #tests }
MPCellTest >> testNeighbours [
	| actual expected |
	expected := { northCell. eastCell. }.
	actual := cellWithNeighbours neighbours.
	
	self assertCollection: actual hasSameElements: expected 
	
]

{ #category : #tests }
MPCellTest >> testUnlink [
	| actual |
	firstCell link: secondCell.
	actual := firstCell unlink: secondCell.
	
	self assert: (firstCell links includes: secondCell) equals: false.
	self assert: (secondCell links includes: firstCell) equals: false.
	self assert: actual equals: firstCell 
]

{ #category : #tests }
MPCellTest >> testUnlinkBidirectional [
	| actual |
	firstCell link: secondCell.
	actual := firstCell unlink: secondCell bidirectional: false.
	
	self assert: (firstCell links includes: secondCell) equals: false.
	self assert: (secondCell links includes: firstCell) equals: true.
	self assert: actual equals: firstCell 
]
