
/*:
 # Functions
 Functions are self-contained chunks of code that perform a specific task.
 You give a function a name that identifies what it does, and this name is used to “call”
 the function to perform its task when needed.
 Functions might have input parameters (arguments) and might have a returned result as output.
 Every function in Swift has a type, consisting of the function’s parameter types and
 return type.
 */
//: --------------------------------------------------------------------------------------------------------------------
/*:
 ## Parameters
 Functions are not required to define input parameters. Here’s a function with no input
 parameters, which always returns the same String message whenever it is called.
 In this case, this function's name is `sayHello()`
 */
func sayHello() -> String {
    return "Hello"
}
sayHello()

/*:
 Functions can have multiple input parameters, which are written within
 the function’s parentheses, separated by commas.
 In this case, this function's name is `multiply(x:y:)`
 */

func add(x: Int, y: Int) -> Int {
    return x + y
}
let addedResult = add(x: 1, y: 2)

func multiply(x: Int, y: Int) -> Int {
    return x * y
}
multiply(x: 6, y: 7)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 ## Return value
 Functions are not required to define a return type.
 */
func doNothing() {
}

/*:
 For functions which return a value, we use arrow (`->`) to indicate the type of return value,
 and use `return` keyword to specify the value as output.
 Functions would stop execution after a `return` statement is executed.
 */
func subtract(x: Int, y: Int) -> Int {
    return x - y
}
let answer = subtract(x: 50, y: 8)

/*:
 Functions could return multiple values as results via tuples
 */
func divide(x: Int, y: Int) -> (quotient: Int, remainder: Int) {
    let quotient = x / y
    let remainders = x % y
    return (quotient, remainders)
}

let divideResult1 = divide(x: 22, y: 7)
divideResult1.quotient
divideResult1.remainder
let (divideQuotient1, divideRemainders1) = divide(x: 50, y: 6)
divideQuotient1
divideRemainders1

//: --------------------------------------------------------------------------------------------------------------------
/*:
 ## Argument Labels and Parameter Names
 Each function parameter has both an argument label and a parameter name.
 The argument label is used when calling the function; each argument is written in
 the function call with its argument label before it. The parameter name is used in the
 implementation of the function.
 By default, parameters use their parameter name as their argument label.
 */
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
greet(person: "Peter", from: "Tokyo")

/*:
 In above function, we say:
 1. This function is named: `greet(person:from:)`
 2. It takes two parameters, both are strings, and returns a String value.
 3. The **parameter name** of the first parameter is `person` and its argument label
 is also `person`.
 4. The **parameter name** of the first parameter is `hometown` and its argument label
 is `from`.
 The parameter name is used when writing the implementation of the function.
 And the argument label is used when calling the function.
 By using argument labels makes the statement of calling a function fit to English grammar,
 and using parameter names provides clear syntax when implementing functions.
 */

func bad_move1(from: String, to: String) -> String {
    return "Moving from \(from) to \(to)."
}
bad_move1(from: "Tokyo", to: "Osaka")

func bad_move2(origin: String, destination: String) -> String {
    return "Moving from \(origin) to \(destination)."
}
bad_move2(origin: "Tokyo", destination: "Osaka")


func move(from origin: String, to destination: String) -> String {
    return "Moving from \(origin) to \(destination)."
}
move(from: "Tokyo", to: "Osaka")

/*:
 ### Omit argument labels
 Sometimes the argument label would make the sentence redundant, we can use `_` to omit it.
 In following case, the function name is `divide(_:by:)`
 
 > In Swift, `_` is used to omit values.
 */
func divide(_ x: Int, by y: Int) -> (Int, Int) {
    return (x/y, x%y)
}
divide(25, by: 4)

//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced topics
//: --------------------------------------------------------------------------------------------------------------------
/*:
 ## Default value of parameters
 You can define a default value for any parameter in a function by assigning
 a value to the parameter after that parameter’s type. If a default value is defined,
 you can omit that parameter when calling the function.
 */
func greet(to person: String, with message: String = "Hello") -> String {
    return "\(message) \(person)!"
}
greet(to: "Peter")
greet(to: "Emma", with: "Hi")

//: --------------------------------------------------------------------------------------------------------------------
/*:
 ## Scope of variables
 In Swift, variables and costants have scope to live, usually the code block defined by
 the curly brackets (`{}`).
 A variable/constant can be accessed only in the same scope or the children scopes. It
 cannot be accessed in outer scope. Also, the value its stored would be freed or destroyed
 after leaving the scope.
 Parameters of a function are live in the scope of the function.
 */
let meltingPointInFahrenheit = 32.0
func convertToCelsius(from fahrenheit: Double) -> Double {
    let factor = 100.0 / 180.0
    return (fahrenheit - meltingPointInFahrenheit) * factor
}
convertToCelsius(from: 68)
//fahrenheit  // Use of unresolved identifier 'fahrenheit'
//factor  //  Use of unresolved identifier 'factor'

//: --------------------------------------------------------------------------------------------------------------------
/*:
 ### Variadic Parameters
 
 A variadic parameter accepts zero or more values of a specified type.
 You use a variadic parameter to specify that the parameter can be passed a
 varying number of input values when the function is called.
 
 Write variadic parameters by inserting three period characters (`...`) after the parameter’s type name.
 */

func average(_ numbers: Double...) -> Double {
    // `numbers` here is an array of Double.
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
average(1, 2, 3, 4, 5)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### In-Out Parameters
 
 Function parameters are constants by default. Trying to change the value of
 a function parameter from within the body of that function results in a compile-time error.
 This means that you can’t change the value of a parameter by mistake.
 If you want a function to modify a parameter’s value,
 and you want those changes to persist after the function call has ended,
 define that parameter as an in-out parameter instead.
 */

func swapTwoNumbers(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var firstInt = 42
var secondInt = 2000
swapTwoNumbers(&firstInt, &secondInt)
firstInt
secondInt

// Q:> Try to uncomment following function to see the error message from Xcode
//func broken_swap(_ a: Int, _ b: Int) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
// A:>

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### Overloading
 
 Function overloading is the ability to create multiple functions of the same name with different implementations.
 Calls to an overloaded function will run a specific implementation of that function appropriate to
 the context of the call, allowing one function call to perform different tasks depending on context.
 */
func swapTwoNumbers(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var firstDouble = 42.0
var secondDouble = 24.0
swapTwoNumbers(&firstDouble, &secondDouble)



//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Function Types
 
 Every function has a specific function type, made up of the parameter types and the return type of the function.
 
 */

/*:
 
 'add' and 'multiply' functions take two `Int` values, and return an `Int` value. So the type of these functions is
 `(Int, Int) -> Int`.
 
 This can be read as:
 “A function type that has two parameters, both of type Int, and that returns a value of type Int.”
 
 */
var someArithmeticFunction: (Int, Int) -> Int = add
someArithmeticFunction(1, 2)

someArithmeticFunction = multiply
someArithmeticFunction(1, 2)

/*:
 
 ### Use function as arguments
 
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
reduce(numbers: [1, 2, 3, 4], reducer: add(x:y:))
reduce(numbers: [1, 2, 3, 4], reducer: multiply(x:y:))
reduce(numbers: [2, 3, 4, 5], reducer: +)
//: > Yes, operatos are functions in Swift.

/*:
 
 ### Nested Functions
 
 All of the functions you have encountered so far in this chapter have been examples of global functions, which are defined at a global scope. You can also define functions inside the bodies of other functions, known as nested functions.
 
 Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
 
 You can rewrite the chooseStepFunction(backward:) example above to use and return nested functions:
 */
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")


//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
//: [Next](@next)
