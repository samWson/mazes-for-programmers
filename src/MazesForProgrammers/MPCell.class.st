"
# MPCell

I am an individual cell of a grid. A grid will be composed of many instances of me.

## Colaborators

I am used by some subclases of MPGrid to contain many instances of me.

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

Mazes for Programmers, Jamis Buck, page 50.
"
Class {
	#name : #MPCell,
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
MPCell class >> row: row column: column [
	^ self new row: row column: column
]

{ #category : #accessing }
MPCell >> column [
	^ column
]

{ #category : #distances }
MPCell >> distances [

	| distances frontier |
	distances := MPDistances newFrom: self.
	frontier := { self. }.
	
	[ frontier isNotEmpty ] whileTrue: [ | newFrontier |
		newFrontier := LinkedList new.
		
		frontier do: [ :cell | 
			cell links do: [ :linked |
				distances at: linked ifAbsentPut: [ 
					newFrontier add: linked.
					(distances at: cell) + 1.
					].
				 ].
			 ].
		
		frontier := newFrontier.
	 ].

	^ distances 	
]

{ #category : #accessing }
MPCell >> east [
	^ east
]

{ #category : #accessing }
MPCell >> east: aCell [
	east := aCell
]

{ #category : #initialization }
MPCell >> initialize [
	links := Dictionary new
]

{ #category : #links }
MPCell >> link: aCell [
	^ self link: aCell bidirectional: true
	
]

{ #category : #links }
MPCell >> link: aCell bidirectional: aBoolean [

	links at: aCell put: true.
	aBoolean ifTrue: [ aCell link: self bidirectional: false ].
	^ self
]

{ #category : #testing }
MPCell >> linked: aCell [
	^ self links includes: aCell
]

{ #category : #accessing }
MPCell >> links [
	^ links keys
]

{ #category : #accessing }
MPCell >> neighbours [
	^ { north. south. east. west. } reject: [ :cell | cell isNil ] 
]

{ #category : #accessing }
MPCell >> north [
	^ north
]

{ #category : #accessing }
MPCell >> north: aCell [
	north := aCell
]

{ #category : #accessing }
MPCell >> row [
	^ row
]

{ #category : #positioning }
MPCell >> row: rowPosition column: columnPosition [ 
	"TODO: consider using a point"
	row := rowPosition.
	column := columnPosition 
]

{ #category : #accessing }
MPCell >> south [
	^ south
]

{ #category : #accessing }
MPCell >> south: aCell [
	south := aCell
]

{ #category : #links }
MPCell >> unlink: aCell [
	self unlink: aCell bidirectional: true
]

{ #category : #links }
MPCell >> unlink: aCell bidirectional: aBoolean [
	links removeKey: aCell.
	aBoolean ifTrue: [ aCell unlink: self bidirectional: false ].
	^ self
]

{ #category : #accessing }
MPCell >> west [
	^ west
]

{ #category : #accessing }
MPCell >> west: aCell [
	west := aCell
]
