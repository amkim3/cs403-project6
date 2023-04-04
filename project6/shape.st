Object subclass: Shape [
        | name |

        Shape class >> new: shapeName [
                <category: 'instance creation'>
                | r |
                r := super new.
                r init: shapeName.
                ^r
        ]

        init: shapeName [
                <category: 'initialization'>
                name := shapeName
        ]

        "getter"
        Shape >> getName [
                ^name
        ]

        "setter"
        Shape >> setName: shapeName [
                name := shapeName
        ]

        "get area"
        Shape >> getArea [
                self subclassResponsibility
        ]

        "get volume"
        Shape >> getVolume [
                self subclassResponsibility
        ]

        "test cond"
        Shape >> test: cond [
                self subclassResponsibility
        ]

        "get info"
        Shape >> getInfo [
                self subclassResponsibility
        ]
             
].
	Float extend [
                roundTo: numDec [
                        | scale newNum|
                        scale := (10 raisedTo: numDec).
			newNum := (((self asFloat) * scale) rounded / scale) asFloat.
			^newNum
		]
        ]

	Float extend [
		fixDec [
			| s newNum|
			newNum := (self asFloat) roundTo: 2.
			(newNum = (newNum asInteger)) ifTrue: [
				| s |
				s := (newNum asInteger) asString, '.00'.
				^ s
			] ifFalse: [
				(newNum = (newNum roundTo:1)) ifTrue: [
					| s|
					s := newNum asString, '0'.
					^s
				] ifFalse: [
					^(newNum asString)
				]
			]
		]
	]
	Integer extend [
		fixDec [
			| newNum |
			newNum := (self asFloat) roundTo: 2.
                        (newNum = (newNum asInteger)) ifTrue: [
                                | s |
                                s := (newNum asInteger) asString, '.00'.
                                ^ s
                        ] ifFalse: [
                                (newNum = (newNum roundTo:1)) ifTrue: [
                                        | s|
                                        s := newNum asString, '0'.
                                        ^s
                                ] ifFalse: [
                                        ^(newNum asString)
                                ]
                        ]
		]
	]
        

