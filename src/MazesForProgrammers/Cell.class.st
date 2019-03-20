"
# Cell

I am an individual cell of a grid. A grid will be composed of many instances of me.

## Colaborators

I am used by instances of Grid to contain many instances of me.

## Usage

I have a class side method for easy creation of instances i.e. `Cell class>>#row:column:`

```
Cell row: 4 column: 4
```

### Links

The **links** protocol provides methods for linking and unlinking Cells. `link:` and `unlink:`
by default bidirectionally link Cells. `link:bidirectional:` and `unlink:bidirectional:` allow
explicit setting of bidirectional links. A testing method `linked:` will return if a Cell 
instance is linked to another.

```
aCell unlink: anotherCell.

aCell link: anotherCell bidirectional: false. 

aCell linked: anotherCell
```

## Instance Variables

- row, column: These are my position in a containing grid. They are read only.
- north, south, east, west: My neighbouring cells in a grid.
- links: A Dictionary which keeps track of which neighbouring cells are linked (joined by a passage). Only used internally.

## ToDo

Consider initializing Cell with a Point instance for row and column coordinates.

## Reference

Mazes for Programmers, Jamis Buck, page 65.
"
Class {
	#name : #Cell,
	#superclass : #Object,
	#instVars : [
		'row',
		'column',
		'north',
		'south',
		'east',
		'west',
		'links'
	],
	#category : #MazesForProgrammers
}

{ #category : #'instance creation' }
Cell class >> row: row column: column [
	^ self new row: row column: column
]

{ #category : #accessing }
Cell >> column [
	^ column
]

{ #category : #accessing }
Cell >> east [
	^ east
]

{ #category : #accessing }
Cell >> east: aCell [
	east := aCell
]

{ #category : #initialization }
Cell >> initialize [
	links := Dictionary new
]

{ #category : #links }
Cell >> link: aCell [
	^ self link: aCell bidirectional: true
	
]

{ #category : #links }
Cell >> link: aCell bidirectional: aBoolean [
	links at: aCell put: true.
	aBoolean ifTrue: [ aCell link: self bidirectional: false ].
	^ self
]

{ #category : #testing }
Cell >> linked: aCell [
	^ self links includes: aCell
]

{ #category : #accessing }
Cell >> links [
	^ links keys
]

{ #category : #accessing }
Cell >> neighbours [
	^ { north. south. east. west. } reject: [ :cell | cell isNil ] 
]

{ #category : #accessing }
Cell >> north [
	^ north
]

{ #category : #accessing }
Cell >> north: aCell [
	north := aCell
]

{ #category : #accessing }
Cell >> row [
	^ row
]

{ #category : #positioning }
Cell >> row: rowPosition column: columnPosition [ 
	"TODO: consider using a point"
	row := rowPosition.
	column := columnPosition 
]

{ #category : #accessing }
Cell >> south [
	^ south
]

{ #category : #accessing }
Cell >> south: aCell [
	south := aCell
]

{ #category : #links }
Cell >> unlink: aCell [
	self unlink: aCell bidirectional: true
]

{ #category : #links }
Cell >> unlink: aCell bidirectional: aBoolean [
	links removeKey: aCell.
	aBoolean ifTrue: [ aCell unlink: self bidirectional: false ].
	^ self
]

{ #category : #accessing }
Cell >> west [
	^ west
]

{ #category : #accessing }
Cell >> west: aCell [
	west := aCell
]
