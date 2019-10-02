"
# MPCoordinates

I am a pair of column and row coordinates. I am specifically used for
acessing the positions on a maze grid. I wrap a `Point` instance and
ensure the correct mapping of column and row coordinates to the
points X and Y coordinates.

Columns map to X and rows map to Y. Both values are subtracted by 1
to turn them into zero based indexes.

## Rationale

When acessing `MPGrid` implementations a `Point` instance is used. 
`Point` instances would be freqently made using the literal syntax 
i.e. `3@2`. Errors could be easily introduced however if the row
or column values were accidentily reversed.

Another issue is that by convention points are frequently used on
the assumption that the starting value is `0@0`, meaning they are
effectively zero indexed. From a human point of view it is more
intuitive that a grids smallest row and column values start at 1.

This class overcomes these problems by ensuring correct mapping of
column and row values to X and Y coordinates, and offsetting the
values to account for zero based indexing. Keeping these 
transformations in one class limits the number of places errors
can occur.

With these featres the user of a `MPGrid` instance should only
have to think in terms of which column and row they want to access.
"
Class {
	#name : #MPCoordinates,
	#superclass : #Object,
	#instVars : [
		'point'
	],
	#category : #MazesForProgrammers
}
