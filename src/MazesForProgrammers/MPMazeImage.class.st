"
# MPMazeImage

I create image files of mazes.

## Description

I create pixel based image files using a raster algorithm. The files will be
named `maze.png` and will be in the same directory as the IDE image is being 
run from. New images will overwrite an older image.

## Colaborators

I make use of the Grid and Cell classes to generate maze images based off of the 
cell links in a grid.

## Usage

I have a class side method `for:` which can be used for a one time creation of
an image from a Grid instance.

```
MPMazeImage for: aGrid
```

## TODO

Class should be refactored to used an instance of the class and have the Grid and Form as instance variables.

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
		'CellBodySize',
		'CellCorner',
		'HorizontalCellBoundary'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
MPMazeImage class >> cellBodySize [

	^ CellBodySize 
]

{ #category : #constants }
MPMazeImage class >> cellCorner [
	"A single black pixel."
	
	^ CellCorner
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

{ #category : #'instance creation api' }
MPMazeImage class >> for: aGrid [
	"Create an image of a maze based off of aGrid."

	"Algorithm:
	Initialize an instance. /
		Assign it a Form. /
			Form must be the right number of pixels for the Grid size. /
			Form must be grayscale with `0` being white and `1` being black. /
			This means the `depth` will be 1 bit i.e. supports 2 colors. /
		Assign it a Grid. /
	
	Write top boundary to Form. /
	Write each row to Form. /
		Write top half of cell i.e. vertical boundaries and cell body /
		Write bottom half of cell i.e. horizontal boundaries /
		
	Use PNGReadWriter to write an image file called 'maze.png' /
"

	| extent instance |
	extent := self extentFrom: aGrid totalRows by: aGrid totalColumns.
	instance := self new.
	instance
		grid: aGrid;
		form: (Form extent: extent).  
 
	instance writeTopBoundary.
	instance writeWesternBoundary.
	instance writeCells.

	aGrid eachRow do: [ :row |
		instance writeRowBody: row.
		 ].
	self flag: #fixme. "Almost there but not quite. If all the cells are unlinked then this should be a perfect grid. Set a break point and step through each writing of a cell. In the inspector the form can be written as a PNG to see the output as it is built."
	PNGReadWriter putForm: instance form onFileNamed: 'maze.png'
]

{ #category : #constants }
MPMazeImage class >> horizontalCellBoundary [ 
	"From left to right: three black pixels and one corner pixel"

	^ HorizontalCellBoundary 
]

{ #category : #'class initialization' }
MPMazeImage class >> initialize [ 

	self flag: #todo. "Document the implementation of constants in class comment."
	CellCorner := #(0). "A single black pixel"
	HorizontalCellBoundary := #(0 0 0 0). "Three black pixels and one corner pixel"
	CellBodySize := 3. "3 pixels wide or high."
]

{ #category : #'image writing - helpers' }
MPMazeImage class >> rowBodyOn: aForm grid: aGrid [
	"Write the body of a row, from left to right using a raster algorithm."
	
	
]

{ #category : #'image writing - helpers' }
MPMazeImage class >> rowBodyOn: aForm grid: aGrid yCoordinate: anInteger [
	"Write the body of a row at y coordinate on aForm, from left to right using a raster algorithm."
	
	
]

{ #category : #'image writing - helpers' }
MPMazeImage class >> totalBoundaries: anInteger [
	"Answer the total boundaries in a maze for a given amount of columns or rows."
	
	^ anInteger + 1
]

{ #category : #positioning }
MPMazeImage >> advanceCellZero [
	"Advance to the zero by zero starting point of the next cell. If the x coordinate exceeds the bounds of the Form then return to x = 1 and advance one position along the y axis."
	
	| cellBodySize pixelSize positionOffset nextPosition |
	cellBodySize := 3.
	pixelSize := 1.
	positionOffset := cellBodySize + pixelSize.
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
	"Answer weather the writePointer is at or beyond the extent of x coordinates."
	
	| xExtent |
	xExtent := form extent x - 1.
	^ (writePointer x >= xExtent)
	
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
	self flag: #fixme. "Possible bug. The below expression needs to be run for the number equivalent to the cell body size."
	self class cellBodySize timesRepeat: [ self writeCellBody: aCell. ].
	self writeCellSouthBoundary: aCell.
	self advanceCellZero 
	
	"
	def setPointerToCellZero
		pointer = cellZero
	
	def writeCellBody
		cellBodySize timesRepeat:
			advancePointer
			
		if cellIsLinked
			advancePointerToNextRow
		else
			writePixel
			advancePointerToNextRow
	
	def writeCellBoundary
		if cellIsLinked
			cellBodySize timesRepeat:
				advancePointer
		else
			cellBodySize timesRepeat:
				writePixel
				advancePointer
				
		writePixel
		advancePointer
	
	def advanceCellZero
		"
]

{ #category : #'form-actions' }
MPMazeImage >> writeCellBody: aCell [
	"The body of a cell is its center whitespace and eastern boundary."

	self class cellBodySize timesRepeat: [ self advancePointer ].
	
	aCell
		ifNil: [ self writePixel ]
		ifNotNil: [ (aCell linked: aCell east)
				ifFalse: [ self writePixel ] ].
	
	self flag: #fixme. "Leave advancing the pointer to be sent outside this method i.e. in a block during the same iteration."
	self advancePointerToNextCellRow

	"
	def writeCellBody
		cellBodySize timesRepeat:
			advancePointer
			
		if cellIsLinked
			advancePointerToNextRow
		else
			writePixel
			advancePointerToNextRow
"
]

{ #category : #'form-actions' }
MPMazeImage >> writeCellSouthBoundary: aCell [
	"A boundary is made of white pixels if the cell is linked to its southern neighbour and black pixels if is not."
	self flag: #fixme. "Possible bug. It is leaving white pixels for an unlinked cell boundary i.e. it should be black."
	writePointer := (cellZero x) @ (cellZero y + self class cellBodySize).
	
	aCell
		ifNil: [ 
			self class cellBodySize + 1 timesRepeat: [ 
				self writePixel. 
				self advancePointer. 
				] 
			] 
		ifNotNil: [ 
			(aCell linked: aCell south) 
				ifTrue: [ 
					self class cellBodySize timesRepeat: [ 
						self advancePointer.
						 ].
					 ] 
				ifFalse: [
					self class cellBodySize timesRepeat: [ 
						self writePixel.
						self advancePointer.
						 ].
					 ].
				].			
			self writePixel.  
	"
	setPointerToSouthernBoundaryOffset
	
	if cellLinked
		advance 3 points
		write 1 pixel
	else
		write 4 pixels
	" 
]

{ #category : #'form-actions' }
MPMazeImage >> writeCells [
	"Write each cell in turn using a raster algorithm."

		grid eachRow do: [ :row |
			row do: [ :cell |
				self writeCell: cell.
				 ].
		 ]
]

{ #category : #'form-actions' }
MPMazeImage >> writePixel [
	"Set the pixel color to black."

	^ form pixelValueAt: writePointer put: 1
]

{ #category : #'form-actions' }
MPMazeImage >> writeRowBody: aCollection [
	"Write the body of a row at y coordinate on form, from left to right using a raster algorithm."
	self flag: #fixme. "method name is incorrect. The entire row is written in the folowing methods not just the body."
	
	aCollection do: [ :cell | self writeCell: cell ]
	
	
]

{ #category : #'form-actions' }
MPMazeImage >> writeTopBoundary [
	"Draw a boundary of black pixels on aForm."
	
	| xExtent |
	xExtent := form extent x - 1.
	0 to: xExtent do: [ :coordinate | form pixelValueAt: coordinate@0 put: 1 ]
]

{ #category : #'form-actions' }
MPMazeImage >> writeWesternBoundary [
	"Write a line of black pixels for the full extent of the western boundary."

	| yExtent |
	yExtent := form extent y - 1.
	0 to: yExtent do: [ :coordinate | form pixelValueAt: 0@coordinate put: 1 ]
]
