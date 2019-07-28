"
# MPDistanceGrid

I am a grid that can display the distances of each of my cells from a 'root' cell.
I override `#contentsOf:` to display the distance of each cell.

## Colaborators

I work with `MPDistances` to allow me to display the distance of each cell.

## Todo

I think any implementation of `MPGrid` should be able to display its distance if
it wants too. This shouldn't be limited to specific subclasses. Maybe make the
displaying of distances the responsibility of a decorator.
"
Class {
	#name : #MPDistanceGrid,
	#superclass : #MP2dArrayGrid,
	#instVars : [
		'distances'
	],
	#category : #MazesForProgrammers
}

{ #category : #displaying }
MPDistanceGrid >> contentsOf: aCell [

	^ self distances 
		ifNotNil: [ 
			(distances at: aCell) asString.
			 ] 
		ifNil: [ 
			super.
			 ]
]

{ #category : #accessing }
MPDistanceGrid >> distances [

	^ distances 
		ifNotNil: [ 
			distances.
		 ]
		ifNil: [ | start |
			start := (self atCoordinates: 0@0).
			distances := start distances.
			distances.
			 ]
]
