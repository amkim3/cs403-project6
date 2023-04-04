Shape subclass: Cylinder [
        | radius height |

        Cylinder class >> new: cylName radius: cylRadius height: cylHeight [
                <category: 'instance creation'>
                | r |
                r := super new.
                r init: cylName radius: cylRadius height: cylHeight.
                ^r
        ]

        init: cylName radius: cylRadius height: cylHeight [
                <category: 'initalization'>
                super init: cylName.
                radius := cylRadius.
		height := cylHeight
        ]

        Cylinder >> getArea [
                | area |
                area := 2.00 * Float pi * radius * height + (2.00 * Float pi * radius squared).
                ^ area
       ]

        Cylinder >> getVolume [
                | volume |
                volume := Float pi * radius squared * height.
                ^volume
        ]

	Cylinder >> getInfo [
		| ss info |
                ss := WriteStream on: (String new: 100).
                ss nextPutAll: 'Cylinder: ', self getName, ', Radius=', radius fixDec, ', Height=', height fixDec.
                ss nl.
                ss tab.
                ss nextPutAll: ' Surface Area: ', self getArea fixDec, ', Volume: ', self getVolume fixDec.
                info := ss contents.
                ^ info
	]
	
	Cylinder >> test: cond [
		| type op value shape size subs i floatVal|
		size := cond size.
		shape := 'cylinder'.
		cond do: [:condition |
        		subs := condition substrings.
			type := subs at: 1.
			op := subs at: 2. 
			value := subs at: 3.
			(type = 'type') ifTrue: [
				(op = '==') ifTrue: [value = 'cylinder' ifFalse: [ ^ false]].
				(op = '!=') ifTrue: [value = 'cylinder' ifTrue: [ ^ false]]. 
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
