"
# MPSidewinder

I am a maze implemented with a sidewinder algorithm.

## Usage

My public API is documented in my superclass MPMazeAlgorithm in the **Usage** section.

```
MPMazeAlgorithm comment.
```

## Reference

Mazes for Programmers, Jamis Buck, page 86.
"
Class {
	#name : #MPSidewinder,
	#superclass : #MPMazeAlgorithm,
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
MPSidewinder class >> on: aGrid [
	
	aGrid eachRow do: [ :row | | run |
		run := LinkedList new.
		row do: [ :cell | | atEasternBoundary atNorthernBoundary shouldCloseOut member |
			run add: cell.
			atEasternBoundary := cell east isNil.
			atNorthernBoundary := cell north isNil.
			shouldCloseOut := (atEasternBoundary or: (atNorthernBoundary not and: (2 atRandom = 1))).
			shouldCloseOut 
				ifTrue: [ 
					member := run atRandom.
					member north ifNotNil: [ member link: member north ].
					run removeAll.
					 ] 
				ifFalse: [ 
					cell link: cell east 
					].
			]. 		
		 ].
	^ aGrid
]
