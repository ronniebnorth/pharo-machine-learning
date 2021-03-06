creation
createFrom: helper features: features output: output ridge: rCoef stepSize: stepSize maxIter: maxIters
	"comment stating purpose of message"

	| matrix result tempCoefs dataset prediction errors size derivative |
	dataset := helper dataset.
	size := features size + 1.
	tempCoefs := DhbVector new: size withAll: 0.0.
	iters := 0.
	result := DhbVector newFrom: (dataset collect: [ :each | each at: (helper indexOfName: output) ]).
	matrix := self matrixFrom: helper features: features.
	[ iters < maxIters] whileTrue:  [ 
		prediction := matrix * tempCoefs.
		errors := prediction - result.
		derivative := 2*errors * matrix.
		1 to: size do: [ :n |
			
		n = 1 ifFalse: [ 
			derivative at: n put: ((derivative at:n) + (2.0 * rCoef * (tempCoefs at: n) asFloat))
			]  
		].
		tempCoefs := tempCoefs - (stepSize  * derivative).
		iters := iters + 1.
	 ].
    intercept := tempCoefs at: 1.
    2 to: size do: [ :n |
		coefs at: (features at: n - 1) put: (tempCoefs at: n). 
	  ].
	 rsse := errors norm.
	 rss := errors * errors.
	^self.