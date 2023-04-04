
"Read in file and check if valid. Quit if no file was given"
| fName shape args f r name shapes line eachLine type tokens|
args := Smalltalk arguments
(1 > args size) ifTrue: [
	'Usage: shape.st sphere.st cylinder.st torus.st box.st -f main.st shape_file' displayNl.
        ObjectMemory quit.
].
fName := args at: 1.
f := FileStream open: fName mode: FileStream read ifFail: [
	('Unable to open ', fName displayString, ' for reading') displayNl.
        ObjectMemory quit.
].
shapes := OrderedCollection new.
[f atEnd] whileFalse: [
	| l w h |
	line := f nextLine.
	tokens := line substrings.
	type := tokens at: 2.
	(type asString = 'sphere') ifTrue: [
        	eachLine := line substrings.
        	name := eachLine at: 1.
        	r := (eachLine at: 3) asNumber.
        	shape := Sphere new: name radius: r.
        	shapes add: shape.	
	].
	(type asString = 'box') ifTrue: [
		eachLine := line substrings.
                name := eachLine at: 1.
                l := (eachLine at: 3) asNumber.
                w := (eachLine at: 4) asNumber.
		h := (eachLine at: 5) asNumber.
                shape := Box new: name length: l width: w height: h.
                shapes add: shape.
	].
	(type asString = 'cylinder') ifTrue: [
                eachLine := line substrings.
                name := eachLine at: 1.
                r := (eachLine at: 3) asNumber.
                h := (eachLine at: 4) asNumber.
                shape := Cylinder new: name radius: r height: h.
                shapes add: shape.
	].
	(type asString = 'torus') ifTrue: [
		| small big |
                eachLine := line substrings.
                name := eachLine at: 1.
                small := (eachLine at: 3) asNumber.
                big := (eachLine at: 4) asNumber.
                shape := Torus new: name smallRadius: small bigRadius: big.
                shapes add: shape.
        ]	
].

| match prefix i cons count con copy|
[
| str input index num| 
input := stdin nextLine.
index := input findFirst: [:char | char isDigit].
(index = 0) ifTrue: [
	str := input.
	num := 0.
] ifFalse: [
	str := input copyFrom: 1 to: index - 1.
	num := (input copyFrom: index to: input size) asNumber.
].
str = 'quit' ifTrue: [
	ObjectMemory quit.
].
str = 'help' ifTrue: [
	'	count
        *** print the number of all shapes
        countN
        *** print the number of all shapes that satisfy all N conditions specified below
        *** for example: count3
        print
        *** print all shapes
        printN
        *** print all shapes that satisfy all N conditions specified below
        *** for example: print4
        min
        *** find the minimum surface area and volume of all shapes
        minN
        *** find the minimum surface area and volume of all shapes that satisfy all N conditions specified below
        *** for example: min2
        max
        *** find the maximum surface area and volume of all shapes
        maxN
        *** find the maximum surface area and volume of all shapes that satisfy all N conditions specified below
        *** for example: max3
        total
        *** find the tatal surface area and volume of all shapes
        totalN
        *** find the total surface area and volume of all shapes that satisfy all N conditions specified below
        *** for example: total4
        avg
        *** find the average surface area and volume of all shapes
        avgN
        *** find the average surface area and volume of all shapes that satisfy all N conditions specified below
        *** for example: avg2
        quit
        *** quit this program
        help
        *** print this list

Each condition shall be entered in one line and of the following format:
                volume

        The valid operators:
                ==
                !=
                >=
                <=
                >
                <' displayNl.
].
str = 'count' ifTrue: [
	| inputSize |
	inputSize := input size.
	cons := OrderedCollection new.
	(num = 0) ifTrue: [
		count := shapes size. 
		('There are ', count displayString, ' shapes.') displayNl.
	] ifFalse: [
               	cons := OrderedCollection new.
               	i := 1.
               	[i <= num]  whileTrue: [
			con := stdin nextLine.
                        cons add: con.
                        i := i + 1.
                ].
                count := 0.
                shapes do: [:element |
                       	(element test: cons) ifTrue: [
                               	count := count + 1.
                       	]
                ].
               	('There are ', count displayString, ' shapes.') displayNl.
        ].
] ifFalse: [
	str = 'print' ifTrue: [
	cons := OrderedCollection new.
	(num = 0) ifTrue: [
        	shapes do: [:element |
                	(element getInfo) displayNl.
        	].
	] ifFalse: [
		cons := OrderedCollection new.
                num := input copyFrom: 6.
                i := 1.
                [i <= num asNumber]  whileTrue: [
                       	con := stdin nextLine.
                       	cons add: con.
                       	i := i + 1.
                ].
                shapes do: [:element |
                       	(element test: cons) ifTrue: [
                               	(element getInfo) displayNl.
                       	]
                ]
        ].
	] ifFalse: [
		str = 'min' ifTrue: [
			| minVol minArea |
			(num = 0) ifTrue: [
				minVol := ((shapes at: 1) getVolume) asNumber.
				minArea := ((shapes at: 1) getArea) asNumber. 
				shapes do: [:element |
					(((element getVolume) asNumber) < minVol) ifTrue: [
						minVol := ((element getVolume) asNumber).
					].
					(((element getArea) asNumber) < minArea) ifTrue: [
						minArea := ((element getArea) asNumber). 	
					]
				].
				('min(surface area)=', minArea displayString) displayNl.
				('min(volume)=', minVol displayString) displayNl.
			] ifFalse: [
				| newShapes |
				cons := OrderedCollection new.
				newShapes := OrderedCollection new.
                		i := 1.
                		[i <= num]  whileTrue: [
                        		con := stdin nextLine.
                        		cons add: con.
                        		i := i + 1.
                		].
				shapes do: [:element |
                        		(element test: cons) ifTrue: [
                                		newShapes add: element.		
                        		]
                		].
				minVol := ((newShapes at: 1) getVolume) asNumber.
                        	minArea := ((newShapes at: 1) getArea) asNumber.
                        	newShapes do: [:element |
                                	(((element getVolume) asNumber) < minVol) ifTrue: [
                                        	minVol := ((element getVolume) asNumber).
                                	].
                                	(((element getArea) asNumber) < minArea) ifTrue: [
                                        	minArea := ((element getArea) asNumber).
                                	]
                        	].
				('min(surface area)=', minArea displayString) displayNl.
                       		('min(volume)=', minVol displayString) displayNl.
			]
		] ifFalse: [
        		str = 'max' ifTrue: [
                		| maxVol maxArea |
                		newShapes := OrderedCollection new.
                		cons := OrderedCollection new.
                		(num = 0) ifTrue: [
                        		maxVol := ((shapes at: 1) getVolume) asNumber.
                        		maxArea := ((shapes at: 1) getArea) asNumber.
                			shapes do: [:element |
                        			(((element getVolume) asNumber) > maxVol) ifTrue: [
                                			maxVol := ((element getVolume) asNumber).
                        			].
                        			(((element getArea) asNumber) > maxArea) ifTrue: [
                                			maxArea := ((element getArea) asNumber).
                        			]
                			].
        			] ifFalse: [
                			| newShapes |
                			cons := OrderedCollection new.
                			newShapes := OrderedCollection new.
                			i := 1.
                			[i <= num]  whileTrue: [
                        			con := stdin nextLine.
                        			cons add: con.
                        			i := i + 1.
                			].
                			shapes do: [:element |
                        			(element test: cons) ifTrue: [
                                			newShapes add: element.
                        			]
                			].
                			maxVol := ((newShapes at: 1) getVolume) asNumber.
                			maxArea := ((newShapes at: 1) getArea) asNumber.
                			newShapes do: [:element |
                        			(((element getVolume) asNumber) > minVol) ifTrue: [
                                			maxVol := ((element getVolume) asNumber).
                        			].
                        			(((element getArea) asNumber) < maxArea) ifTrue: [
                                			maxArea := ((element getArea) asNumber).
                        			]
                			].
        			].
        		('max(surface area)=', maxArea displayString) displayNl.
       			('max(volume)=', maxVol displayString) displayNl.
		] ifFalse: [
		        | totalVol totalArea |
        		str = 'total' ifTrue: [
				totalVol := 0.
                        	totalArea := 0.
				(num ~= 0 ) ifTrue: [
					i := 1.
					[i <= num]  whileTrue: [
                                                con := stdin nextLine.
                                                cons add: con.
                                                i := i + 1.
                                        ].
					shapes do: [:element |
                                                (element test: cons) ifTrue: [
                                                        newShapes add: element.
                                                ]
                                        ].
					shapes := newShapes	
				].
                        	shapes do: [:element |
                                	totalVol := (totalVol + ((element getVolume) asNumber)).
                                	totalArea := (totalArea + ((element getArea) asNumber)).
                        	].
                        	('total(surface area)=', totalArea displayString) displayNl.
                        	('total(volume)=', totalVol displayString) displayNl.
			] ifFalse: [
				str = 'avg' ifTrue: [
					| totalArea totalVol size avgArea avgVol |
					avgVol := 0.
        				avgArea := 0.
        				totalArea := 0.
        				totalVol := 0.
					size := (shapes size) asNumber.
					(num ~= 0) ifTrue: [
						i := 1.
                                        	[i <= num]  whileTrue: [
                                                	con := stdin nextLine.
                                                	cons add: con.
                                                	i := i + 1.
                                        	].
                                        	shapes do: [:element |
                                                	(element test: cons) ifTrue: [
                                                        	newShapes add: element.
                                                	]
                                        	].
                                        	shapes := newShapes
					].
					shapes do: [:element |
                				totalVol := (totalVol + ((element getVolume) asNumber)).
                				totalArea := (totalArea + ((element getArea) asNumber)).
        				].
        				avgVol := (totalVol / size).
        				avgArea := (totalArea / size).
        				('avg(surface area)=', avgArea displayString) displayNl.
        				('avg(volume)=', avgVol displayString) displayNl.
			]
		]
	].
	].
	].
	].
] repeat.


