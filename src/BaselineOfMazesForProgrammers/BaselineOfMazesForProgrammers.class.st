Class {
	#name : #BaselineOfMazesForProgrammers,
	#superclass : #BaselineOf,
	#category : #BaselineOfMazesForProgrammers
}

{ #category : #baselines }
BaselineOfMazesForProgrammers >> baseline: spec [

	<baseline>
	spec
		for: #common 
		do: [ 
			spec
				package: 'MazesForProgrammers';
				package: 'MazesForProgrammers-Tests' with: [ spec requires: #('MazesForProgrammers') ]
			 ].
			spec 
				group: 'Mazes' with: #('MazesForProgrammers')
]

{ #category : #accessing }
BaselineOfMazesForProgrammers >> projectClass [
	^ MetacelloCypressBaselineProject
]
