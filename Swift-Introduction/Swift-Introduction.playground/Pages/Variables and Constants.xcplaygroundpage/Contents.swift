/*:
 
 # Variables
 
 - Variable names in Swift follows the **camelCase** rule.
 + The first letter of the name is lowercase.
 + The second or further words in the name are connected by a _uppercase_ letter.
 + Like `bookTitle`, `authorName`, and `nameOfAccountOwner`
 - Don’t use meaningless name for variables, you (or your partner) could not understand
 the usage of this variable. _Like x, i, a, tmp, foo, bar, blah ..._
 - Follow English grammar when possible. It helps people who read your code.
 - In Swift, it’s okay to use _non-ASCII_ characters as variable name.
 
 */

/*:

## Declaration

- We use `let` to declare a **constant**, (_immutable value_).
- _For mutable values_, we use `var` to declare a **variable**, storage which allows
to change its value later.
- A variable/constant is said **initialized** after assigning first value to it.

*/

// A constant named "answer", and the value `42.0` is assgined when declaring it.
let answer = 42.0
//answer = 44  // Cannot assign to value: 'answer' is a 'let' constant.
// A variable called "year", and is initialized with the value `2016`.
var year = 2016
// A constant called "name" is declared with an initial value `"Peter"`.
let name = "Peter"
// A variable called "thisYear", and is assigned with the value of the "year" variable.
var thisYear = year
// The "year" is a variable, and could be re-assigned with a new value, `2017`.
year = 2017

/*:
 
## Int, Float, and Double
 - no operator(--) in Swift4
 - no automatic typecast among Int, Float and Double
 - Float only support 6 decimal digits
 
*/
var a = 1.11111111

// no operator(--) in Swift4
a -= 1
print(a+=0)
print(type(of:a+=0))

// no automatic typecast among Int, Float and Double
let b: Float = Float(a)
let c: Int = Int(a)
print(a + Double(b))
print(a * Double(c))

// Float only support 6 decimal digits
print(a == Double(b))
print(Double(b) == 0.111111)
print("b value: \(Double(b))")

/*:
## Tuples
Tuples group multiple values into a single compound value.
- Use round brackets `()` to group values into a tuple.
- Also use round brackets to unwrap values in a tuple
- Use `.` to access values in a tuple
*/

let salaryTuple = ("Peter", 600000)
let (staffName, salary) = salaryTuple  // Unpack salaryTuple into `staffName` and `salary`
staffName
salary
var monday = (1, "Monday", "星期一", "月曜日")
let mondayJapanese = monday.3

/*:
 Elements in tuples could come with labels, like:
 */
let contact = (name: "Te-Yen", mail: "teyanwu@gmail.com")
let contactName = contact.name
let contactName2 = contact.0
let contactMail = contact.mail

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
//: [Next](@next)
