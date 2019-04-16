"
# MPMazeImage

I create image files of mazes.
## Description

I create pixel based image files using a raster algorithm. The files will be
named `maze.pgm` and will be in the same directory as the IDE is being run from.
New images will overwrite an older image.

## Colaborators

I make use of the Grid and Cell classes to generate maze images based off of the 
cell links in a grid.

## Usage

I have a class side method `for:` which can be used for a one time creation of
an image from a Grid instance.

```
MPMazeImage for: aGrid
```

## Reference

Mazes for Programmers, Jamis Buck.
"
Class {
	#name : #MPMazeImage,
	#superclass : #Object,
	#classVars : [
		'CellCorner',
		'HorizontalCellBoundary'
	],
	#category : #MazesForProgrammers
}

{ #category : #constants }
MPMazeImage class >> cellCorner [
	"A single black pixel."
	
	^ CellCorner
]

{ #category : #'instance creation api' }
MPMazeImage class >> for: aGrid [
	"Create an image of a maze based off of aGrid."

	"Algorithm:
	Create file headers as text.
	Switch to binary writing mode.
	write top boundary
	write each row
		write top half of cell i.e. vertical boundaries and cell body
		write bottom half of cell i.e. horizontal boundaries"

	| header fileStream |
	header := String
		streamContents: [ :stream | 
			stream
				<< 'P5';
				cr;
				<< '4 4';
				cr;
				<< '255';
				cr ].
	fileStream := ZnBufferedWriteStream
		on: 'maze.pgm' asFileReference binaryWriteStream.
	fileStream nextPutAll: header.
	self topBoundaryOn: fileStream length: aGrid totalColumns.
	
	aGrid eachRow
		do: [ :row | self put: fileStream on: row ]. 
		
	fileStream flush	"Ensure this happens."
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
	HorizontalCellBoundary := #(0 0 0 0) "Three black pixels and one corner pixel"
]

{ #category : #'streaming - helpers' }
MPMazeImage class >> put: aRow on: aZnBufferedWriteStream [
	"Draw the top half of the row"
	"Draw the bottom half of the row"
	"place both rows on the write stream"
	self notYetImplemented
]

{ #category : #'streaming - helpers' }
MPMazeImage class >> topBoundaryOn: aZnBufferedWriteStream length: anInteger [ 

	aZnBufferedWriteStream nextPutAll: self cellCorner.
	anInteger timesRepeat: [ aZnBufferedWriteStream nextPutAll: self horizontalCellBoundary ]
]
