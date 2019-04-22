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
	#classVars : [
		'CellBodyLength',
		'CellCorner',
		'HorizontalCellBoundary'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
MPMazeImage class >> cellBodyLength [

	^ CellBodyLength 
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
	x := totalColumns * self cellBodyLength + (self totalBoundaries: totalColumns).
	y := totalRows * self cellBodyLength + (self totalBoundaries: totalRows).
	^ x@y
]

{ #category : #'instance creation api' }
MPMazeImage class >> for: aGrid [
	"Create an image of a maze based off of aGrid."

	"Algorithm:
	Initialize a Form for the image. /
		Form must be the right number of pixels for the Grid size. /
		Form must be grayscale with `0` being white and `1` being black. /
			This means the `depth` will be 1 bit i.e. supports 2 colors. /
	
	Write top boundary to Form. /
	Write each row to Form.
		Write top half of cell i.e. vertical boundaries and cell body
		Write bottom half of cell i.e. horizontal boundaries
		
	Use PNGReadWriter to write an image file called 'maze.png'"

	| imageForm extent |
	extent := self extentFrom: aGrid totalRows by: aGrid totalColumns. 
	imageForm := Form extent: extent.
	self topBoundaryOn: imageForm.
	aGrid eachRow do: [ :row |
		self rowBodyOn: imageForm grid: aGrid
		 ].
	self flag: #todo. "Rewrite according to algorithm above."

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
	CellBodyLength := 3. "3 pixels wide or high."
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
MPMazeImage class >> topBoundaryOn: aForm [
	"Draw a boundary of black pixels on aForm."
	
	| xExtent |
	xExtent := aForm extent x - 1.
	0 to: xExtent do: [ :coordinate | aForm pixelValueAt: coordinate@0 put: 1 ]
]

{ #category : #'image writing - helpers' }
MPMazeImage class >> totalBoundaries: anInteger [
	"Answer the total boundaries in a maze for a given amount of columns or rows."
	
	^ anInteger + 1
]
