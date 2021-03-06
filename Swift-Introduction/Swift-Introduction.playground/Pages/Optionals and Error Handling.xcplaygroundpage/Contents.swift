/*:
 
 # Optionals
 
 You use **optionals** in situations where a value may be _absent_.
 
 An optional represents two possibilities:
 - Either there is a value, and you can unwrap the optional to access that value
 - or there isn’t a value at all
 
 We put _a question mark_ (`?`) after the type to indicate that this variable has
 an optional value.
 
 */
/*:
 
 Take following lines as example, converting strings into numbers may fail when
 the string is not composed by digits.
 
 */
let possibleNumber1 = "123"
let convertedNumber1 = Int(possibleNumber1)
let possibleNumber2 = "ABC1"
let convertedNumber2 = Int(possibleNumber2)
//: > Use `option+click` to see the type of `convertedNumber2`.

/*:
 
 ## `nil`
 
 We use `nil` to denote that the value is absent.
 
 */
var concreteNumber: Int = 42
var optionalNumber: Int? = 42
optionalNumber = nil

func divide(_ dividend: Int, by divisor: Int) -> (quotient: Int, remainder: Int)? {
    // We cannot perform division when the `divisor` is '0',
    // So we have to check whether divisor is not zero, and returns `nil` when it's zero
    // The result is absent because we cannot perform task with given arguments.
    guard divisor != 0 else { return nil }
    return (dividend/divisor, dividend%divisor)
}

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Unwrapping optional values
 
 We have to unwrap the value from optionals before using it.
 
 ### Forced unwrapping
 
 Use `if` statement to check whether it's `nil` or not, and then put a
 _exclamation mark_ (`!`) after optionals to force unwrapping it.
 
 We called this way, using the `!` mark, as "forced unwrapping".
 
 */
func convertToNumber(from input: String, default defaultValue: Int = 0) -> Int {
    let convertedOptionalNumber = Int(input)
    if convertedOptionalNumber != nil {
        // Use the `!` mark to force unwrapping an optional to get its value
        // It's like telling Swift: I have checked this value, open the box of optional for me
        return convertedOptionalNumber!
    } else {
        return defaultValue
    }
}
convertToNumber(from: "1")
convertToNumber(from: "A")
convertToNumber(from: "A", default: -1)

/*:
 
 ### Optional binding
 
 You use optional binding to find out whether an optional contains a value,
 and if so, to make that value available as a temporary constant or variable.
 
 Optional binding can be used with `if`, `guard`, and `while` statements to
 check for a value inside an optional, and to extract that value into a constant
 or variable, as part of a single action.
 
 */

func parseInt(_ string: String) -> (isInteger: Bool, value: Int) {
    if let actualNumber = Int(string) {
        return (true, actualNumber)
    } else {
        return (false, 0)
    }
}
parseInt("12")
parseInt("XD")

/*:
 
 The `optional binding` could be chained together, like:
 
 */

func stringPower(base: String, exponent exp: String) -> String? {
    guard let baseNumber = Int(base), let expNumber = Int(exp) else {
        return nil
    }
    var result = 1
    for _ in 0..<expNumber {
        result *= baseNumber
    }
    return String(result)
}
stringPower(base: "2", exponent: "5")
stringPower(base: "2", exponent: "B")

/*:
 
 ### Optional Chaining
 
To safely access the properties and methods of a wrapped instance, use the postfix optional chaining operator (postfix ?). The following example uses optional chaining to access the hasSuffix(_:) method on a String? instance.
 
*/

let imagePaths = ["star": "/glyphs/star.png",
                  "portrait": "/images/content/portrait.jpg",
                  "spacer": "/images/shared/spacer.gif"]

let isPNG = imagePaths["star"]?.hasSuffix(".png")
let isJPG = imagePaths["starwar"]?.hasSuffix(".jpg")
//: > Try to "option+click" on `isJPG` to see their types.

/*:
 
 ### Nil-Coalescing Operator
 
 The _nil-coalescing operator_ (`a ?? b`) unwraps an optional a if it contains a value,
 or returns a default value b if a is nil.
 
 The expression `a` is always of an optional type. The expression `b` must match the type
 that is stored inside `a`.
 
 */
let someString1 = "XD"
let someString2 = "42"
let whateverNumber1 = Int(someString1) ?? -1
let whateverNumber2 = Int(someString1) ?? 0
let whateverNumber3 = Int(someString2) ?? -1
//: > Try to "option+click" on `whateverNumber1` and `whateverNumber2` to see their types.

/*:
 
 ### Optional Pattern
 
 An optional pattern matches values wrapped in a some(Wrapped) case of an Optional<Wrapped> enumeration. Optional patterns consist of an identifier pattern followed immediately by a question mark and appear in the same places as enumeration case patterns.
 
 The optional pattern provides a convenient way to iterate over an array of optional values in a for-in statement, executing the body of the loop only for non-nil elements.
 */

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
// Match only non-nil values.
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5

/*:
 
 # Error Handling
 
 Error handling is the process of responding to and **recovering** from error conditions
 in your program. Swift provides first-class support for throwing, catching, propagating,
 and manipulating recoverable errors at runtime.
 
 Some operations aren’t guaranteed to always complete execution or produce a useful output.
 Optionals are used to represent the absence of a value, but when an operation fails,
 it’s often useful to understand what caused the failure, so that your code can respond accordingly.
 
 */
/*:
 
 ## Error Types
 
 In Swift, errors are represented by values of types that conform to the Error protocol.
 This empty protocol indicates that a type can be used for error handling.
 
 */
enum ArithmeticError: Error {
    case divideByZero
    case rootsOfNegativeNumbers
}

/*:
 
 ## Throw Errors
 
 You use a `throw` statement to throw an error.
 
 To indicate that a function can throw an error, you write the `throws` keyword in the
 function's declaration after its parameters. A function marked with throws is called
 **a throwing function**. If the function specifies a return type, you write the `throws`
 keyword before the return arrow (`->`).
 
 A throwing function propagates errors that are thrown inside of it to the scope from
 which it’s called. Only throwing functions can propagate errors. Any errors thrown
 inside a _nonthrowing function_ must be handled inside the function.
 
 */
func cannotThrowErrors() -> String? {
    return nil
}

func canThrowErrors() throws -> String? {
    return nil
}

func divide(_ dividend: Int, divisor: Int) throws -> (Int, Int) {
    guard divisor != 0 else {
        throw ArithmeticError.divideByZero
    }
    return (dividend/divisor, dividend%divisor)
}

/*:
 
 ## Handle Errors
 
 There are four ways to handle errors in Swift:
 
 - Propagate the error from a function to the code that calls that function
 - Handle the error using a `do-catch` statement
 - Handle the error as an _optional value_ with `try?`.
 - Assert that the error will not occur with `try!`.
 
 The last 2 are useful when you don't care about the error reason or when you
 just want the result.
 
 */

// Propagate
func mod(_ a: Int, _ b: Int) throws -> Int {
    let (_, remainder) = try divide(a, divisor: b)
    return remainder
}

// Handle by `do-catch`
do {
    try divide(22, divisor: 0)
} catch ArithmeticError.divideByZero {
    "Cannot divide 22 by 0."
} catch {
    "Unknown Error."
}

// Handle by `try?`
let divideResult1 = try? divide(55, divisor: 7)
if divideResult1 != nil {
    let (quotient1, remainder1) = divideResult1!
    quotient1
    remainder1
} else {
    "No Result"
}

let divideResult2 = try? divide(49, divisor: 0)
if divideResult2 != nil {
    let (quotient2, remainder2) = divideResult2!
    quotient2
    remainder2
} else {
    "No Result"
}

// Handle by `try!`
let (quotient3, remainder3) = try! divide(22, divisor: 7)
quotient3
remainder3
//let (quotient4, remainder4) = try! divide(22, divisor: 0)
// Uncomment the above line to see what Xcode yields.

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## (Self-Reading)Optionals vs Throwing Errors
 
 In performance, optionals are faster than throwing errors. Also the Swift prefers optionals over
 throwing errors, like when handling abset keys of a dictionary.
 
 But throwing errors are useful when the function may generate multiple kinds of errors, and even
 including the bad value or the way to recover from the error. _(See the above example: vending function)_
 Optionals doesn't show the reason why the function fails.
 
 For simple functions which would fail by only one reason, use optionals; for others, you may use
 throwing errors, like the vending function.
 
 */
func divide1(_ dividend: Int, divisor: Int) throws -> (Int, Int) {
    guard divisor != 0 else {
        throw ArithmeticError.divideByZero
    }
    return (dividend/divisor, dividend%divisor)
}

func divide2(_ dividend: Int, divisor: Int) -> (Int, Int)? {  // preferred way
    guard divisor != 0 else {
        return nil
    }
    return (dividend/divisor, dividend%divisor)
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:


