//: [Previous](@previous)

/*:
 
 # Closures
 
 Closures are self-contained blocks of functionality that can be passed around
 and used in your code.
 
 Functions are actually special cases of closures. Closures take one of three forms:
 
 - Global functions are closures that **have a name** and do not capture any values.
 - Nested functions are closures that _have a name_ and can **capture values**
 from their enclosing function.
 - Closure expressions are **unnamed closures** written in a lightweight syntax
 that can capture values from their surrounding context.
 
 */

func reduce(numbers: [Int], reducer: (Int, Int) -> Int) -> Int? {
    guard !numbers.isEmpty else {
        return nil
    }
    // This array is not empty, so it’s okay to use `!` to get the first element as result.
    var result = numbers.first!
    // Then, enumerate the rest part of this array
    for number in numbers[1..<numbers.count] {
        result = reducer(result, number)
    }
    return result
}

reduce(numbers: [1, 2, 3, 4], reducer: { (a: Int, b: Int) -> Int in
    return (a + b) * 2
})

/*:
 
 Closure expression syntax has the following general form:
 
 ```
 { (<parameter1>: <Type1>, <parameter2>: <Type2>, ...) -> <ReturnType> in
 <closure body>
 }
 
 ```
 
 And it can be simplified as following syntaxes:
 
 */
// The full form
reduce(numbers: [1, 2, 3, 4], reducer: { (a: Int, b: Int) -> Int in
    return a + b
})
// Inferring Type From Context
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in
    return a + b
})
// Shorth and Argument Names
reduce(numbers: [1, 2, 3, 4], reducer: {
    return $0 + $1
})
// Implicit Returns from Single-Expression Closures
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in
    a + b
})
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in a + b })
reduce(numbers: [1, 2, 3, 4], reducer: {
    $0 + $1
})
reduce(numbers: [1, 2, 3, 4], reducer: { $0 + $1 })

/*:
 
 ## Trailing Closures
 
 If you need to pass a closure expression to a function as the function's final argument and
 the closure expression is long, it can be useful to write it as a trailing closure instead.
 
 A trailing closure is written after the function call's parentheses, even though it is still
 an argument to the function. When you use the trailing closure syntax, you don’t write
 the argument label for the closure as part of the function call.
 
 */
reduce(numbers: [1, 2, 3, 4]) { (a: Int, b: Int) -> Int in
    return a + b
}
// Or even ...
reduce(numbers: [1, 2, 3, 4]) { a, b in return a + b }
reduce(numbers: [1, 2, 3, 4]) { return $0 + $1 }
reduce(numbers: [1, 2, 3, 4]) { $0 + $1 }

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Capturing Values
 
 A closure can capture constants and variables from the surrounding context
 in which it is defined. The closure can then refer to and modify the values
 of those constants and variables from within its body,
 even if the original scope that defined the constants and variables no longer exists.
 
 */
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0

    return { () -> Int in
        runningTotal += amount
        return runningTotal
    }
}
let oneStepIncrementer = makeIncrementer(forIncrement: 1)
let tenStepsIncrementer = makeIncrementer(forIncrement: 10)

oneStepIncrementer()
oneStepIncrementer()
oneStepIncrementer()
tenStepsIncrementer()
oneStepIncrementer()
tenStepsIncrementer()
/*:
 
 We can find that there are different `runningTotal` vairables **captured** by the two incremeneter.
 So their value are separated and won't affect each other.
 
 And also, although the scope of `runnintTotal` is end, but it still avaialbe
 inside the incremeneter closure. _(Because it has been captured by closures.)_
 
 */

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Escaping
 
 A closure is said to **escape** a function when:
 - the closure is passed as an argument to the function,
 - but is called after the function returns.
 
 When you declare a function that takes a closure as one of its parameters,
 you can write @escaping before the parameter’s type to indicate
 that the closure is allowed to escape.
 
 */

struct IntegerGenerator {
    var start: Int
    var end: Int
    private var current: Int
    private var transformers = [(Int) -> Int]()
    
    init(start: Int, end: Int) {
        self.start = start
        self.end = end
        self.current = self.start
    }
    
    mutating func next() -> Int? {
        guard self.current <= self.end else { return nil }
        defer { self.current += 1 }
        
        var value = self.current
        for transformer in self.transformers {
            value = transformer(value)
        }
        return value
    }
    
    // The `body` closure is used immediately and only in this function,
    // so we don't have to add `escaping`.
    mutating func forEach(_ body: (Int) -> Void) {
        while let next = self.next() {
            body(next)
        }
    }
    
    // The `transformer` closure is saved for later using,
    // so we say it escaped from the `add(transformer:)` function.
    mutating func add(transformer: @escaping (Int) -> Int) {
        self.transformers.append(transformer)
    }
}

var generator = IntegerGenerator(start: 1, end: 5)

generator.add(transformer: { $0 * $0 })  // square
generator.add(transformer: -)  // negaive
generator.forEach { (value) in
    print(value)
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
