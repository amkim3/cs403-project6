Shape subclass: Torus [
        | smallRadius bigRadius |

        Torus class >> new: torusName smallRadius: torusSmall bigRadius: torusBig [
                <category: 'instance creation'>
                | r |
                r := super new.
                r init: torusName smallRadius: torusSmall bigRadius: torusBig.
                ^r
        ]

        init: torusName smallRadius: torusSmall bigRadius: torusBig[
                <category: 'initalization'>
                super init: torusName.
                smallRadius := torusSmall.
		bigRadius := torusBig
        ]

        Torus >> getArea [
                | area |
                area := 2.00 * Float pi * bigRadius * 2 * Float pi * smallRadius.
                ^ area
       ]

        Torus >> getVolume [
                | volume |
                volume := Float pi * smallRadius squared * 2 * Float pi * bigRadius.
                ^volume
        
	]

	Torus >> getInfo [
		| ss info |
                ss := WriteStream on: (String new: 100).
                ss nextPutAll: 'Torus: ', self getName, ', Small Radius=', smallRadius fixDec, ', Big Radius=', bigRadius fixDec.
                ss nl.
                ss tab.
                ss nextPutAll: ' Surface Area: ', self getArea fixDec, ', Volume: ', self getVolume fixDec.
                info := ss contents.
                ^ info
	]

	Torus >> test: cond [
		| type op value shape size subs i floatVal|
		size := cond size.
		shape := 'torus'.
		cond do: [:condition |
        		subs := condition substrings.
			type := subs at: 1.
			op := subs at: 2. 
			value := subs at: 3.
			(type = 'type') ifTrue: [
				(op = '==') ifTrue: [value = 'torus' ifFalse: [ ^ false]].
				(op = '!=') ifTrue: [value = 'torus' ifTrue: [ ^ false]]. 
				(op = '>=')
				ifTrue: [shape < value ifTrue: [^ false].].
                                (op = '<=')
                                ifTrue: [shape > value ifTrue: [^ false].].
                                (op = '>')
                                ifTrue: [shape <= value ifTrue: [^false].].
                                (op = '<')
                                ifTrue: [shape >= value ifTrue: [^false]]
			].
			(type = 'area') ifTrue: [
				|diff area|
				area := (self getArea) asNumber.
				floatVal := value asNumber.
				diff := (area - floatVal).
				(op = '==') ifTrue: [area = floatVal ifFalse: [ ^ false].].
                                (op = '!=') ifTrue: [area = floatVal ifTrue: [ ^ false].].
                                (op = '>=') ifTrue: [diff < 0 ifTrue: [^ false].].
                                (op = '<=') ifTrue: [diff > 0 ifTrue: [^ false].].
                                (op = '>') ifTrue: [diff <= 0 ifTrue: [^false].].
                                (op = '<') ifTrue: [diff >= 0 ifTrue: [^false]]
			].
			(type = 'volume') ifTrue: [
                                |diff vol |
                                vol := (self getVolume) asNumber.
                                floatVal := value asNumber.
                                diff := (vol - floatVal).
                                (op = '==') ifTrue: [vol = floatVal ifFalse: [ ^ false].].
                                (op = '!=') ifTrue: [vol = floatVal ifTrue: [ ^ false].].
                                (op = '>=') ifTrue: [diff < 0 ifTrue: [^ false].].
                                (op = '<=') ifTrue: [diff > 0 ifTrue: [^ false].].
                                (op = '>') ifTrue: [diff <= 0 ifTrue: [^false].].
                                (op = '<') ifTrue: [diff >= 0 ifTrue: [^false]]
                        ].
	      	].
		^true
        ]
]
