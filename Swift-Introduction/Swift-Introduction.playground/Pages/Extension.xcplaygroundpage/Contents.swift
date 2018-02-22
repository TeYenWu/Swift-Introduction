/*:
 
 # Extensions
 
 Extensions add new functionality to an existing `class`, `struct`, and `enum`.
 It can also extend types for which you do not have access to the original source code.
 
 Extensions in Swift can:
 
 - Add computed instance properties and computed type properties
 - Define instance methods and type methods
 - Provide new initializers
 - Define subscripts
 - Define and use new nested types
 - Make an existing type conform to a protocol
 
 */

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Extend types
 
 */
extension Array {
    var middle: Element? {
        guard !self.isEmpty else {
            return nil
        }
        return self[self.count/2]
    }
}

[0, 1, 2].middle
[1, 2, 3, 4].middle


//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:

