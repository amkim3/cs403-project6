Shape subclass: Box [
        | length width height |

        Box class >> new: boxName length: boxLength width: boxWidth height: boxHeight [
                <category: 'instance creation'>
                | r |
                r := super new.
                r init: boxName length: boxLength width: boxWidth height: boxHeight.
                ^r
        ]

        init: boxName length: boxLength width: boxWidth height: boxHeight[
                <category: 'initalization'>
                super init: boxName.
                length:= boxLength.
		width:= boxWidth.
		height:= boxHeight.
        ]

        Box >> getArea [
                | area |
                area := 2.00 * length * width + (2 * length * height) + (2 * height * width).
                ^ area
       ]

        Box >> getVolume [
                ^ length * width * height.
        ]

	Box >> getInfo [
		| ss info |
		ss := WriteStream on: (String new: 100).
   		ss nextPutAll: 'Box: ', self getName, ', Length=', length fixDec, ', Width=', width fixDec, ', Height=', height fixDec.
		ss nl.
		ss tab.
		ss nextPutAll: ' Surface Area: ', (self getArea) fixDec, ', Volume: ', (self getVolume) fixDec.
    		info := ss contents.
		^ info	
	]
 	Box >> test: cond [
		| type op value shape size subs i floatVal|
		size := cond size.
		shape := 'box'.
		cond do: [:condition |
        		subs := condition substrings.
			type := subs at: 1.
			op := subs at: 2. 
			value := subs at: 3.
			(type = 'type') ifTrue: [
				(op = '==') ifTrue: [value = 'box' ifFalse: [ ^ false]].
				(op = '!=') ifTrue: [value = 'box' ifTrue: [ ^ false]]. 
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
