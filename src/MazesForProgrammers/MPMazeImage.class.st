"
# MPMazeImage

I create image files of mazes.

## Description

I create pixel based image files using a raster algorithm. The files will be
named `maze.png` and will be in the same directory as the IDE image is being 
run from. New images will overwrite an older image.

To see the directory path where the image file will be run this code:
```
Smalltalk imageDirectory.
```

### Drawing Implementation

From the start the northern and western maze boundaries are drawn leaving the
east and south boundaries to be drawn with each cell.

Individual cells are drawn on the form using a raster algorithm for each cell
along the x and then y axies. Each pixel of the cell is also drawn using a 
raster along the x and then the y axies. When a cell is being drawn a 
starting reference position is set and used as the zero point of that cell 
i.e. the cellZero instance variable. 

## Colaborators

I make use of the Grid and Cell classes to generate maze images based off of the 
cell links in a grid. A Form is used to write the pixels of the image and then
used as data for a PNGReadWriter to produce the image.

## Usage

I have a class side method `for:` which can be used for a one time creation of
an image from a Grid instance.

```
MPMazeImage for: aGrid
```

## Instance Variables

- form: Image data is written to the form and then used to create the image file.
- grid: A Grid instance representing the maze to be written.
- writePointer: A Point instance representing a position on the form. Any writing operations use this position.
- cellZero: A Point instance uses as a reference for drawing the pixels of a cell.
- xExtent: An integer representing the maximum x coordinate on the form.

## Constants

- CellBodySize: An integer. The cell body is its white space center. This number is the amount of pixels this white space is for both the x and y axies.

## Reference

Mazes for Programmers, Jamis Buck.
"
Class {
	#name : #MPMazeImage,
	#superclass : #Object,
	#instVars : [
		'form',
		'grid',
		'writePointer',
		'cellZero',
		'xExtent'
	],
	#classVars : [
		'CellBodySize'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
MPMazeImage class >> cellBodySize [

	^ CellBodySize 
]

{ #category : #'image writing - helpers' }
MPMazeImage class >> extentFrom: totalRows by: totalColumns [ 
	"Answer a point of the extent of pixels calculated from the rows and columns.
	totalPixels = totalRowsOrColumns * cellBodyLength + boundaryAmount"
	
	| x y |
	x := totalColumns * self cellBodySize + (self totalBoundaries: totalColumns).
	y := totalRows * self cellBodySize + (self totalBoundaries: totalRows).
	^ x@y
]

{ #category : #'public api' }
MPMazeImage class >> for: aGrid [
	"Create an image of a maze based off of aGrid."

	| instance |
	instance := self newInstanceFor: aGrid.
	instance writeNorthBoundary.
	instance writeWesternBoundary.
	instance writeCells.
	PNGReadWriter putForm: instance form onFileNamed: 'maze.png'
]

{ #category : #'class initialization' }
MPMazeImage class >> initialize [ 

	CellBodySize := 3. "3 pixels wide or high."
]

{ #category : #'instance creation' }
MPMazeImage class >> newInstanceFor: aGrid [

	| extent |
	extent := self extentFrom: aGrid totalRows by: aGrid totalColumns.
	^ self new 
		grid: aGrid;
		form: (Form extent: extent)

]

{ #category : #'image writing - helpers' }
MPMazeImage class >> totalBoundaries: anInteger [
	"Answer the total boundaries in a maze for a given amount of columns or rows."
	
	^ anInteger + 1
]

{ #category : #positioning }
MPMazeImage >> advanceCellZero [
	"Advance to the zero by zero starting point of the next cell. If the x coordinate exceeds the bounds of the Form then return to x = 1 and advance one position along the y axis."
	
	| pixelSize positionOffset nextPosition |
	pixelSize := 1.
	positionOffset := self cellBodySize + pixelSize.
	nextPosition := cellZero x + positionOffset.
	cellZero := (nextPosition >= xExtent)
		ifTrue:  [ 1 @ (cellZero y + positionOffset) ]
		ifFalse: [ nextPosition @ (cellZero y) ]
]

{ #category : #positioning }
MPMazeImage >> advancePointer [
	"Move the pointer increasing the x coordinate by 1. If the highest x coordinate is reached move the pointer to x = 0 and increase the y coordinate by 1."

	writePointer := self atXExtent 
		ifTrue: [ 0 @ (writePointer y + 1) ] 
		ifFalse: [ (writePointer x + 1) @ (writePointer y) ]

]

{ #category : #positioning }
MPMazeImage >> advancePointerToNextCellRow [
	
	writePointer := (cellZero x) @ (writePointer y + 1)
]

{ #category : #testing }
MPMazeImage >> atXExtent [
	"Answer whether the writePointer is at or beyond the extent of x coordinates."

	^ (writePointer x >= xExtent)
	
]

{ #category : #constants }
MPMazeImage >> cellBodySize [
	
	^ self class cellBodySize
]

{ #category : #accessing }
MPMazeImage >> cellZero [

	^ cellZero
]

{ #category : #accessing }
MPMazeImage >> form [
	
	^ form
]

{ #category : #accessing }
MPMazeImage >> form: aForm [

	form := aForm.
	xExtent := aForm extent x
]

{ #category : #accessing }
MPMazeImage >> grid: aGrid [

	grid := aGrid
]

{ #category : #initialization }
MPMazeImage >> initialize [

	writePointer := 0@0.
	cellZero := 1@1
]

{ #category : #accessing }
MPMazeImage >> position [
	
	^ writePointer
]

{ #category : #'form-actions' }
MPMazeImage >> writeCell: aCell [
	"Write the pixels of a cell using a raster algorithm."

	writePointer := cellZero copy.
	self cellBodySize timesRepeat: [ 
		self writeCellRow: aCell.
		self advancePointerToNextCellRow. 
		].
	self writeCellSouthBoundary: aCell.
	self advanceCellZero
]

{ #category : #'form-actions' }
MPMazeImage >> writeCellRow: aCell [
	"A cell row is the whitespace of the center of the cell and a part of the cels eastern boundary."

	self cellBodySize timesRepeat: [ self advancePointer ].

	aCell
		ifNil: [ self writePixel ]
		ifNotNil: [ 
			(grid class linkedEast: aCell)
				ifFalse: [ self writePixel ] 
				]
]

{ #category : #'form-actions' }
MPMazeImage >> writeCellSouthBoundary: aCell [
	"A boundary is made of white pixels if the cell is linked to its southern neighbour and black pixels if is not."

	writePointer := (cellZero x) @ (cellZero y + self cellBodySize).
	
	aCell
		ifNil: [ 
			self cellBodySize + 1 timesRepeat: [ 
				self writePixel. 
				self advancePointer. 
				] 
			] 
		ifNotNil: [ 
			(grid class linkedSouth: aCell)
				ifTrue: [ 
					self cellBodySize timesRepeat: [ 
						self advancePointer.
						 ].
					 ] 
				ifFalse: [
					self cellBodySize timesRepeat: [ 
						self writePixel.
						self advancePointer.
						 ].
					 ].
				].

			self writePixel
]

{ #category : #'form-actions' }
MPMazeImage >> writeCells [

		grid eachRow do: [ :row |
			row do: [ :cell |
				self writeCell: cell.
				 ].
		 ]
]

{ #category : #'form-actions' }
MPMazeImage >> writeNorthBoundary [

	| zeroIndexedExtent |
	zeroIndexedExtent := xExtent - 1.
	0 to: zeroIndexedExtent do: [ :coordinate | form colorAt: coordinate@0 put: Color black. ]
]

{ #category : #'form-actions' }
MPMazeImage >> writePixel [

	^ form colorAt: writePointer put: Color black
]

{ #category : #'form-actions' }
MPMazeImage >> writeWesternBoundary [

	| yExtent |
	yExtent := form extent y - 1.
	0 to: yExtent do: [ :coordinate | form colorAt: 0@coordinate put: Color black. ]
]
