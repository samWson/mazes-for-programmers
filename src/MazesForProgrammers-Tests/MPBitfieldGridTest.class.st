"
# MPBitfieldGridTest

I am the test case for `MPBitfield`.
"
Class {
	#name : #MPBitfieldGridTest,
	#superclass : #TestCase,
	#instVars : [
		'instance'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
MPBitfieldGridTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	instance := MPBitfieldGrid of: 4 by: 4 
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkTo [

	| firstCoordinate secondCoordinate |
	firstCoordinate := 2@2.
	secondCoordinate := 3@2.
	
	instance link: firstCoordinate to: secondCoordinate.
	
	self assert: (instance linked: firstCoordinate to: secondCoordinate).
	self assert: (instance linked: secondCoordinate to: firstCoordinate)
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkToSignalsNotANeighbor [
	
	| action point nonNeighborPoint |
	point := 1@1.
	nonNeighborPoint := 1@3.
	
	action := [ instance link: point to: nonNeighborPoint ].
	
	self should: action raise: MPNotANeighbor
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkToSignalsOutOfBounds [
	
	| action point outOfBoundsPoint |
	point := 3@3.
	outOfBoundsPoint := 3@4.
	
	action := [ instance link: point to: outOfBoundsPoint ].
	
	self should: action raise: MPOutOfGridBounds  
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedEastFalse [

	| southLinkedCell |
	southLinkedCell := 2r0100.
	self assert: (instance class linkedEast: southLinkedCell) equals: false
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedEastTrue [ 

	| eastLinkedCell |
	eastLinkedCell := 2r0010.
	self assert: (instance class linkedEast: eastLinkedCell) equals: true
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedSouthFalse [

	| eastLinkedCell |
	eastLinkedCell := 2r0010.
	self assert: (instance class linkedSouth: eastLinkedCell) equals: false
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedSouthTrue [

	| southLinkedCell |
	southLinkedCell := 2r0100.
	self assert: (instance class linkedSouth: southLinkedCell) equals: true
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedToEastWest [

	| firstCoordinate secondCoordinate cellLinkedEast cellLinkedWest |
	firstCoordinate := 0@0.
	secondCoordinate := 1@0.
	
	cellLinkedEast := instance class east.
	cellLinkedWest := instance class west.
	
	instance grid at: 1 put: cellLinkedEast.
	instance grid at: 2 put: cellLinkedWest.
	
	self assert: (instance linked: firstCoordinate to: secondCoordinate)
	
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedToNorthSouth [

	| firstCoordinate secondCoordinate cellLinkedNorth cellLinkedSouth |
	firstCoordinate := 3@3.
	secondCoordinate := 3@2.
	
	cellLinkedSouth := instance class south.
	cellLinkedNorth := instance class north.

	instance grid at: 12 put: cellLinkedSouth.
	instance grid at: 16 put: cellLinkedNorth.

	self assert: (instance linked: firstCoordinate to: secondCoordinate)
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedToSignalsNotANeighbor [
	
	| action point nonNeighborPoint |
	point := 1@1.
	nonNeighborPoint := 1@3.
	
	action := [ instance linked: point to: nonNeighborPoint ].
	
	self should: action raise: MPNotANeighbor
]

{ #category : #tests }
MPBitfieldGridTest >> testLinkedToSignalsOutOfBounds [
	
	| action point outOfBoundsPoint |
	point := 3@3.
	outOfBoundsPoint := 3@4.
	
	action := [ instance linked: point to: outOfBoundsPoint ].
	
	self should: action raise: MPOutOfGridBounds  
]

{ #category : #'tests - dependencies' }
MPBitfieldGridTest >> testPointFourNeighbors [
	"Bitfield depends on the ordering of the collection returned by Point>>#fourNeighbors. This test is intended to detect breaking changes that are depended on by BitfieldGrid. A failing test here means that the ordering has changed."
	
	| expectedNorth expectedSouth expectedWest neighbors expectedEast |
	expectedSouth := 2@3.
	expectedEast := 3@2.
	expectedNorth := 2@1.
	expectedWest := 1@2.
	
	neighbors := (2@2) fourNeighbors.
	
	self assert: (neighbors at: 1) equals: expectedEast.
	self assert: (neighbors at: 2) equals: expectedSouth.
	self assert: (neighbors at: 3) equals: expectedWest.
	self assert: (neighbors at: 4) equals: expectedNorth
]
