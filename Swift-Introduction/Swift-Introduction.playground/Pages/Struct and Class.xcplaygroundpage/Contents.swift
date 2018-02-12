/*:
 
 # Struct and Class
 
 */

/*:
 
 ## Struct
 
 ### Point example
 
 */
struct Point {
    let x: Double
    let y: Double
    
    static let origin = Point(x: 0, y: 0)
    
    func distance(to another: Point) -> Double {
        let deltaX = self.x - another.x
        let deltaY = self.y - another.y
        return (deltaX*deltaX + deltaY*deltaY).squareRoot()
    }
    
    var distanceToOrigin: Double {
        return self.distance(to: Point.origin)
    }
}
let point1 = Point(x: 3, y: 4)
let point2 = Point(x: 15, y: 9)
let origin = Point.origin
point1.distanceToOrigin
point1.distance(to: point2)

/*:
 
 ### Bank Account example
 
 */
struct BankAccount {
    var deposit: Int {
        willSet {
            print(">>> Deposit value will change from \(self.deposit) to \(newValue).")
        }
        didSet {
            print(">>> Deposit value did change from \(oldValue) to \(self.deposit).")
        }
    }
}
var account = BankAccount(deposit: 1000)
account.deposit += 10

/*:
 
 ### Rectangle example
 
 */

struct Rect {
    struct Point { var x, y: Double }
    struct Size {
        var width, height: Double
        mutating func scale(by times: Double) {
            self.width *= times
            self.height *= times
        }
    }
    
    var origin: Point, size: Size
    var center: Point {
        get {
            return Point(x: self.origin.x + self.size.width/2,
                         y: self.origin.y + self.size.height/2)
        }
        set(newCenter) {
            self.origin.x = newCenter.x - self.size.width/2
            self.origin.y = newCenter.y - self.size.height/2
        }
    }
    
    mutating func move(toX x: Double, y: Double) {
        self.origin.x = x
        self.origin.y = y
    }
    mutating func scaleSize(by times: Double) {
        self.size.scale(by: times)
    }
}
var rect = Rect(origin: Rect.Point(x: 5, y: 5), size: Rect.Size(width: 20, height: 40))
rect.origin
rect.center
rect.center = Rect.Point(x: 40, y: 40)
rect.origin

/*:
 
 ### Book example
 
 */

import Foundation

struct Book {
    var title: String
    let author: String
    var price = 10.0
    let publishDate = Date()
    
    init(title: String, author: String, price: Double) {
        self.title = title
        self.author = author
        self.price = price
    }
    
    init(title: String, author: String) {
        self.init(title: title, author: author, price: 10.0)
    }
}
let book1 = Book(title: "Harry Potter 1", author: "J.K. Rowling")
let book2 = Book(title: "Harry Potter 2", author: "J.K. Rowling")
book1.publishDate == book2.publishDate

/*:
 
 ### Fraction example
 
 */
struct Fraction {
    var numerator: Int
    var denominator: Int
    
    init?(numerator: Int, denominator: Int) {
        guard denominator != 0 else {
            return nil
        }
        self.numerator = numerator
        self.denominator = denominator
    }
    
    init(_ integer: Int) {
        self.init(numerator: integer, denominator: 1)!
    }
}

let half = Fraction(numerator: 1, denominator: 2)
let nilFraction = Fraction(numerator: 2, denominator: 0)

/*:
 
 ### Audio channel example
 
 */
struct AudioChannel {
    static let thresholdLevel = 10  // Use as constants
    static var maxLevelOfAllChannels = 0  // Use as shared variables
    var currentLevel: Int = 0 {
        didSet {
            if (self.currentLevel > AudioChannel.thresholdLevel) {
                self.currentLevel = AudioChannel.thresholdLevel
            }
            if (self.currentLevel > AudioChannel.maxLevelOfAllChannels) {
                AudioChannel.maxLevelOfAllChannels = self.currentLevel
            }
        }
    }
}

//: --------------------------------------------------------------------------------------------------------------------

/*:
 
 ## Class
 
 ### Animal example
 
 */
class Animal {
    var name: String?
    func makeNoise() {}
    init(name: String) { self.name = name }
}
class Cat: Animal {
    override func makeNoise() { print("meow~") }
}
class Dog: Animal {
    override func makeNoise() { print("wof!") }
}
let kitty = Cat(name: "Kitty")
let puppy = Dog(name: "Puppy")

print("\n\n---")
kitty.makeNoise()  // meow~
kitty.name  // Kitty
puppy.makeNoise()  // wof!


/*:
 
 ### Student example
 
 */
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
class Student: Person {
    var school: String
    var department: String?
    init(name: String, school: String, department: String?) {
        self.school = school
        self.department = department
        super.init(name: name)
    }
    convenience init(name: String, school: String) {
        self.init(name: name, school: school, department: nil)
    }
}

/*:
 
 ### Reference example
 
 */
let person1 = Person(name: "Peter")
let person2 = person1
let person3 = Person(name: "Peter")
person1 == person2
person1 == person3
person1 === person2  // Check identity: Memory block
person1 === person3  // Check identity: Memory block
person1.name = "Annie"
person2.name  // Also changed, because `person1` and `person2` are the same memory block.
person3.name  // Still "Peter".

var fraction1 = Fraction(numerator: 1, denominator: 2)!
var fraction2 = fraction1
fraction1.denominator = 3
fraction2.denominator  // Still 2, because Fraction is a struct, value type.

//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced Example
//: --------------------------------------------------------------------------------------------------------------------

class LinkedListNode<Element> {
    // LinkedList should be reference based ... use `class`
    // And in Swift, we ususally use `Element` as name for generic type of content
    
    // Optional is actually made by enum, `cmd+click` on `.none` to see it
    var nextNode: LinkedListNode? = .none
    var content: Element
    
    init(content: Element) {
        self.content = content
    }
    
    var isLastNode: Bool {
        return self.nextNode == nil
    }
    
    var lastNode: LinkedListNode {
        var lastNode = self
        while !lastNode.isLastNode {
            lastNode = lastNode.nextNode!
        }
        return lastNode
    }
    
    func toArray() -> [Element] {
        var result = [Element]()
        var node: LinkedListNode<Element>? = self
        repeat {
            result.append(node!.content)
            node = node!.nextNode
        } while node != nil
        return result
    }
    
    // Override operators
    static func +=(left: inout LinkedListNode, right: LinkedListNode) {
        left.lastNode.nextNode = right
    }
    
    // `subscript` is the method of `[]` operator
    subscript(steps: Int) -> LinkedListNode? {
        guard steps >= 0 else {
            print("Steps should equals to or be greater than 0")
            return nil
        }
        var resultNode: LinkedListNode? = self
        for _ in 0..<steps {
            resultNode = resultNode?.nextNode
        }
        return resultNode
    }
    
    subscript(indexes: Int...) -> [Element?] {
        var result = [Element?]()
        for index in indexes {
            result.append(self[index]?.content)
        }
        return result
    }
    
    // A static func is usually used as factory.
    static func createLinkedList(items: Element...) -> LinkedListNode<Element>? {
        guard !items.isEmpty else { return nil }
        
        let resultNode = LinkedListNode(content: items.first!)
        var lastNode = resultNode
        for item in items[1..<items.count] {
            lastNode.nextNode = LinkedListNode(content: item)
            lastNode = lastNode.nextNode!  // Step forward
        }
        return resultNode
    }
}

var linkedList1 = LinkedListNode.createLinkedList(items: 1, 2, 3, 4)!
linkedList1[0]?.content
linkedList1[1]?.content
linkedList1[2]?.content
linkedList1[3]?.content
linkedList1[4]?.content

linkedList1[0]!.isLastNode
linkedList1.lastNode.isLastNode
linkedList1.lastNode.content

linkedList1[0, 1, 5]

linkedList1.toArray()

let linkedList2 = LinkedListNode.createLinkedList(items: 5, 6, 7)!
linkedList1 += linkedList2
linkedList1.toArray()

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:

