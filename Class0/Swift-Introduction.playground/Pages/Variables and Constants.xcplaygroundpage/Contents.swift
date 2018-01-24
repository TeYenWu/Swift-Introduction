//: [Previous](@previous)

import Foundation

var a = 1.11111111

/*
 ## Int, Float, and Double
 - no operator(--) in Swift4
 - no automatic typecast among Int, Float and Double
 - Float only support 6 decimal digits
*/

// no operator(--) in Swift4
// ex: a -- (error)
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

/*
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
let contact = (name: "Peter", mail: "sodas@icloud.com")
let contactName = contact.name
let contactName2 = contact.0
let contactMail = contact.mail

//: [Next](@next)

