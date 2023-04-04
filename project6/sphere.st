Shape subclass: Sphere [
        | radius |

        Sphere class >> new: sphereName radius: sphereRadius [
                <category: 'instance creation'>
                | r |
                r := super new.
                r init: sphereName radius: sphereRadius.
                ^r
        ]

        init: sphereName radius: sphereRadius [
                <category: 'initalization'>
                super init: sphereName.
                radius := sphereRadius.
        ]

        Sphere >> getArea [
                | area |
                area := 4.00 * Float pi * (radius asNumber squared).
		^ area
      	]

        Sphere >> getVolume [
                | volume |
		volume := (4.00 / 3.00 * Float pi * (radius asNumber squared) * radius).
		^ (volume)
	]
	
	Sphere >> getInfo [
		| ss info |
                ss := WriteStream on: (String new: 100).
                ss nextPutAll: 'Sphere: ', self getName, ', Radius=', (radius asFloat) fixDec.
		ss nl.
                ss tab.
                ss nextPutAll: ' Surface Area: ', (self getArea) fixDec, ', Volume: ', (self getVolume) fixDec.
                info := ss contents.
                ^ info
	]

	Sphere >> test: cond [
		| type op value shape size subs i floatVal|
		size := cond size.
		shape := 'sphere'.
		cond do: [:condition |
        		subs := condition substrings.
			type := subs at: 1.
			op := subs at: 2. 
			value := subs at: 3.
			(type = 'type') ifTrue: [
				(op = '==') ifTrue: [value = 'sphere' ifFalse: [ ^ false]].
				(op = '!=') ifTrue: [value = 'sphere' ifTrue: [ ^ false]]. 
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
