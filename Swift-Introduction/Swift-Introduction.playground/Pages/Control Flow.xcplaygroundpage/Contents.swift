/*:
 
 # Control Flow
 
 Control flow statements are used to change the execution order of lines of code.
 
 Swift provides a variety of control flow statements. These include `while` loops to perform a task multiple times;
 `if`, `guard`, and `switch` statements to execute different branches of code based on certain conditions;
 and statements such as `break` and `continue` to transfer the flow of execution to another point in your code.
 
 Swift also provides a `for-in` loop that makes it easy to iterate over arrays,
 dictionaries, ranges, strings, and other sequences.
 
 */

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Loops
 
 A **loop** is a sequence of statements which is specified once but which may be
 carried out several times.
 
 ### `for-in`
 
 You use the for-in loop to iterate over a sequence, such as ranges of numbers,
 items in an array, or characters in a string.
 
 */
for index in 0..<5 {
    index
}

func sum(_ x: Int) -> Int {
    var result = 0
    for item in 0...x {
        result += item
    }
    return result
}
sum(6)

//: > In Swift, you use underscore (`_`) for values which would not be used.

for character in "Hello World!" {
    print(character)
}

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### While loops
 
 A while loop performs a set of statements until a condition becomes false.
 These kinds of loops are best used when the number of iterations is not known
 before the first iteration begins.
 
 Swift provides two kinds of while loops:
 - `while` evaluates its condition at the start of each pass through the loop.
 - `repeat-while` evaluates its condition at the end of each pass through the loop.
 
 */
func heat(to targetTemperature: Int) {
    var currentTemperature = 0
    while currentTemperature < targetTemperature {
        print("Keep heating to \(targetTemperature) ... It's \(currentTemperature) now.")
        currentTemperature += 10
    }
    print("Done heating, the temperature is now \(currentTemperature).")
}
print("------ Heat ------")
heat(to: 50)
heat(to: -10)
print("====== Heat ======\n\n")

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Control Transfer Statements
 
 Control transfer statements change the order in which your code is executed,
 by transferring control from one piece of code to another.
 
 Swift has five control transfer statements:
 - `continue`
 - `break`
 - `fallthrough`
 - `return`
 - `throw`
 
 In this Playground page, we would talk about `continue` and `break`.
 _(You know the `return` statement via function implementation, and the `fallthrough` and `throw` would be
 mentioned in further chapters.)_
 
 */
/*:
 
 ### `continue`
 (Self-Reading)
 The `continue` statement tells a loop to stop what it is doing and start again at the beginning
 of the next iteration through the loop. It says “I am done with the current loop iteration”
 without leaving the loop altogether.
 
 */
func sumOfEvenNumbers(to upperBound: Int) -> Int {
    var result = 0
    for number in 0...upperBound {
        guard number % 2 == 0 else {
            continue
        }
        result += number
    }
    return result
}
sumOfEvenNumbers(to: 10)

/*:
 
 ### `break`
 
 The `break` statement ends execution of an entire control flow statement immediately.
 The `break` statement can be used inside a switch statement or loop statement when you want to
 terminate the execution of the switch or loop statement earlier than would otherwise be the case.
 
 */
func isPrime(_ number: Int) -> Bool {
    guard number >= 2 else {
        print("Error: The definition of primes is available only when the number is greater than 1.")
        return true
    }
    let squareRootBound = Double(number).squareRoot().rounded()
    for divisor in 2..<number {
        guard divisor <= Int(squareRootBound) else {
            break
        }
        print("Test whether \(number) is a prime or not with \(divisor) as divisor.")
        if number % divisor == 0 {
            return false
        }
    }
    return true
}
print("------ Prime ------")
isPrime(5)
isPrime(13)
isPrime(221)
print("====== Prime ======\n\n")

//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced Topics
//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Labeled Statements
 
 In Swift, you can nest loops and conditional statements inside other loops and conditional statements
 to create complex control flow structures.
 
 However, loops and conditional statements can both use the break statement to end their execution prematurely.
 Therefore, it is sometimes useful to be explicit about which loop or conditional statement
 you want a break statement to terminate. Similarly, if you have multiple nested loops,
 it can be useful to be explicit about which loop the continue statement should affect.
 
 */

typealias Grid = [[Int]]
typealias Position = (x: Int, y: Int)

func find(_ target: Int, in binaryGrid: Grid, onlyFirst: Bool = false) -> [Position] {
    var result = [Position]()
    
    rowLoop: for (rowIdx, row) in binaryGrid.enumerated() {
        columnLoop: for (colIdx, value) in row.enumerated() {
            // Not target
            if value != target {
                continue columnLoop
            }
            // Found target
            result.append((colIdx, rowIdx))
            if onlyFirst {
                break rowLoop
                // of course, instead of braking loops,
                // you can use `return result` here to stop this function too.
            }
        }
    }
    return result
}

let grid = [
    [0, 1, 0, 1],
    [0, 0, 2, 1],
    [0, 0, 1, 0],
    [0, 2, 0, 0],
]
for position in find(2, in: grid) {
    "Found '2' in (\(position.x), \(position.y))"
}

for position in find(2, in: grid, onlyFirst: true) {
    "Found '2' in (\(position.x), \(position.y))"
}


//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Conditional Statements
 
 It is often useful to execute different pieces of code based on certain conditions.
 You might want to run an extra piece of code when an error occurs,
 or to display a message when a value becomes too high or too low.
 To do this, you make parts of your code conditional.
 
 
 ### `if`

   (Self-Reading) In its simplest form, the if statement has a single `if` condition. It executes a set of statements
 only if that condition is true.
 
 */
print("------ If statement ------")
if 5 > 2 {
    print("5 is bigger than 2.")
}
/*:
  (Self-Reading) The if statement can provide an alternative set of statements, known as an _else clause_,
 for situations when the `if` condition is false. These statements are indicated by the `else` keyword.
 
 */
print("------ Temperature ------")
let currentTemperature = 24.0
if currentTemperature > 32 {
    print("It's quite hot today.")
} else {
    print("It's not so hot today.")
}
print("====== Temperature ======\n\n")

/*:
 
 You can chain _multiple_ `if` _statements_ together to consider additional clauses.
 
 */
func feeling(ofTemperature degree: Double) -> String {
    let message: String
    if currentTemperature > 32 {
        message = "It's quite hot today."
    } else if currentTemperature > 25 {
        message = "It's a little hot today."
    } else if currentTemperature > 20 {
        message = "It's great today."
    } else if currentTemperature > 15 {
        message = "It's cool today."
    } else {
        message = "It's cold today."
    }
    return message
}
feeling(ofTemperature: currentTemperature)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### `guard`
 
 A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression.
 
 You use a `guard` statement to require that a condition must be true
 **in order for the code after the guard statement to be executed**.
 
 Unlike an `if` statement, a guard statement _always_ has an else clause,
 the code inside the else clause is executed if the condition is not true.
 
 */
func divide(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    guard y != 0 else {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    guard x > 0 && y > 0 else {
        print("Error: Only accept positive integers.")
        return (0, 0)
    }
    return (x/y, x%y)
}
print("------ Divide ------")
divide(12, by: 5)
divide(12, by: 0)
print("====== Divide ======\n\n")

/*:
 
   (Self-Reading)Without using the `guard` statement, the function implementation would be like:
 
 */
func badDivide1(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    if y == 0 {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    return (x/y, x%y)
}

func badDivide2(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    if y != 0 {
    } else {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    return (x/y, x%y)
}

/*:
 
 In the first example, `badDivide1(_:by:)`, the requirement condition is reversed.
 The condition we want to ensure is `y != 0`, but the code we write is `y == 0`.
 
 In the second example, `badDivide2(_:by:)`, the requirement condition is the same
 as the one we want to ensure. But it has an empty and redundant code block.
 
 Using a `guard` statement for requirements improves the readability of your code,
 compared to doing the same check with an `if` statement. It lets you write the code
 that’s typically executed without wrapping it in an `else` block, and it lets you
 keep the code that handles a violated requirement next to the requirement.
 
 */


//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced Topics
//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### `defer`
 
 You use a `defer` statement to execute a set of statements just
 before code execution leaves the current block of code.
 
 This statement lets you do any necessary cleanup that should be performed
 regardless of how execution leaves the current block of code—whether
 it leaves because an error was thrown or because of a statement such as return or break.
 
 For example, you can use a defer statement to ensure that file descriptors are closed
 and manually allocated memory is freed.
 
 */

// Import C library from OS (for `fopen` and `fgets`)
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

func readString(from filename: String) -> String? {
    guard let file = fopen(filename, "r") else { return nil }
    defer {
        fclose(file)
    }
    
    let buffer = [CChar](repeating: 0, count: 1024)
    var result = String()
    while fgets(UnsafeMutablePointer(mutating: buffer), Int32(buffer.count), file) != nil {
        guard let read = String(validatingUTF8: buffer) else { return nil }
        result += read
    }
    
    return result
}

readString(from: "/etc/hosts")

// Better file reading in swift
import Foundation  // Like STL in C++

try? String(contentsOfFile: "/etc/hosts")


//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Switch
 
 A switch statement considers a value and compares it against several possible matching patterns.
 It then executes an appropriate block of code, based on the first pattern that matches successfully.
 A switch statement provides an alternative to the if statement for responding to multiple potential states.
 
 In its simplest form, a switch statement compares a value against one or more values of the same type.
 
 */
func description(of character: Character) -> String {
    var description: String
    switch character {
    case "a", "A":
        description = "The first letter of the alphabet"
    case "z", "Z":
        description = "The last letter of the alphabet"
    case "m":
        description = "This is a lowercase 'm'."
    case "M":
        description = "This is an 'M'."
    default:
        description = "Some other character"
    }
    return description
}
description(of: "z")
description(of: "h")
description(of: "A")
description(of: "m")

/*:
 
 ### Fallthrough
 
(Self-Reading)In contrast with switch statements in C and Objective-C,
 switch statements in Swift do not fall through the bottom of each case and into the next one by default.
 
 Instead, the entire switch statement finishes its execution
 as soon as the first matching switch case is completed, without requiring an explicit break statement.
 This makes the switch statement safer and easier to use than the one in C and
 avoids executing more than one switch case by mistake.
 
 By contrast, C requires you to insert an explicit `break` statement at the end of every switch `case`
 to prevent fallthrough. Avoiding default fallthrough means that Swift switch statements are
 much more concise and predictable than their counterparts in C,
 and thus they avoid executing multiple switch cases by mistake.
 
 If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case
 basis with the `fallthrough` keyword. The example below uses `fallthrough` to create
 a textual description of a number.
 
 */
func describe(_ integerToDescribe: Int) -> String {
    var description = "The number \(integerToDescribe) is"
    
    switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
    }
    return description
}

describe(12)
describe(13)

/*:
 
(Self-Reading)Swift's switch-case also supports **Interval Matching**.
 
 */
func feeling(of temperature: Int) -> String {
    switch temperature {
    case 36...50:
        return "Super hot"
    case 30..<36:
        return "Quite hot"
    case 26..<30:
        return "Hot"
    case 18..<26:
        return "Great"
    case 14..<18:
        return "Cool"
    case 0..<14:
        return "Cold"
    default:
        return "Unknown"
    }
}
feeling(of: 32)
feeling(of: 24)
feeling(of: 17)

/*:
 
 Even **tuple matching**, like
 
 */
typealias Point = (x: Double, y: Double)
func position(of point: Point) -> String {
    switch point {
    case (0, 0):
        return "(0, 0) is at the origin"
    case (_, 0):
        return "(\(point.x), 0) is on the x-axis"
    case (0, _):
        return "(0, \(point.y)) is on the y-axis"
    case (-2...2, -2...2):
        return "(\(point.x), \(point.y)) is inside the box"
    default:
        return "(\(point.x), \(point.y)) is outside of the box"
    }
}
position(of: (0, 5))
position(of: (1, 5))
position(of: (-1.5, 2))
position(of: (2, 0))
position(of: (0, 0))

/*:
 
 ### Value Bindings
 
 A switch case can bind the value or values it matches to temporary
 constants or variables, for use in the body of the case. This behavior
 is known as value binding, because the values are bound to temporary
 constants or variables within the case’s body.
 
 */

func axis(of point: Point) -> String {
    switch point {
    case (0, 0):
        return "at the origin."
    case (let x, 0):
        return "on the x-axis with an x value of \(x)."
    case (0, let y):
        return "on the y-axis with a y value of \(y)."
    case let (x, y) where x == y:
        return "on the axis where x == y, the value is \(x)."
    case let (x, y):
        return "somewhere else at (\(x), \(y))."
    }
}
axis(of: (2, 0))
axis(of: (0, 4.2))
axis(of: (10, 5))
axis(of: (10, 10))
axis(of: (0, 0))

/*:
 
 (Self-Reading) This above `switch` statement **does not** have a default case.
 
 The final case, `case let (x, y)`, declares a tuple of two placeholder
 constants that can match any value. Because `point` is always
 a tuple of two values, this case matches all possible remaining
 values, and a default case is not needed to make the switch statement exhaustive.
 
 Q:> Try to move the `case (0, 0)` to after `case let (x, y)` to see what happens.
 A:>
 
 >
 */


//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:


