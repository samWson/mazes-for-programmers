# Mazes for Programmers

Generate Mazes with Programming.

## Description

A Smalltalk implementation of the execises in the Mazes for Programmers book.

## Loading Packages

The project packages can be loaded using Metacello. The following snippet will load all the packages from the `master` branch. Evaluate it in a Playground:

```smalltalk
Metacello new
  repository: 'github://samWson/MazesForProgrammers/src';
  baseline: 'MazesForProgrammers';
  load
```

The packages needed to generate mazes only can be loaded using the `Mazes` group. This will exclude test packages.

```smalltalk
Metacello new
  repository: 'github://samWson/MazesForProgrammers/src';
  baseline: 'MazesForProgrammers';
  load: 'Mazes'
```

## Reference

Mazes for Programmers by Jamis Buck at [The Pragmatic Bookshelf](https://pragprog.com/book/jbmaze/mazes-for-programmers).

## Licence

This repository is open source software under the MIT licence. As it was made during our work hack days the copyrights belong to [Flux Federation Ltd](https://fluxfederation.com/).
