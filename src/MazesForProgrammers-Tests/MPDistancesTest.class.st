"
# MPDistancesTest

I am the test case for `MPDistances`.

## Instance Variables

- instance: the instance of `MPDistances`
- rootCell: the starting `MPCell`
- nextCell: an `MPCell`
"
Class {
	#name : #MPDistancesTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCell',
		'nextCell',
		'instance'
	],
	#category : #'MazesForProgrammers-Tests'
}

{ #category : #running }
MPDistancesTest >> setUp [
	
	super setUp.
	rootCell := MPCell new.
	nextCell := MPCell new.
	instance := MPDistances newFrom: rootCell.
	instance at: nextCell put: 1
]

{ #category : #tests }
MPDistancesTest >> testAccess [

	self assert: (instance at: nextCell) equals: 1 
]

{ #category : #tests }
MPDistancesTest >> testCells [

	self assertCollection: instance cells hasSameElements: { rootCell. nextCell }
]
