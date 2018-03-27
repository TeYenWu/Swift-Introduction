//: [Previous](@previous)

/*:
 
 # Generics
 
 Generic code enables you to write flexible, reusable functions and types
 that can work with any type, subject to requirements that you define.
 You can write code that avoids duplication and expresses its intent
 in a clear, abstracted manner.
 
 Generics are one of the most powerful features of Swift,
 and much of the Swift standard library is built with generic code.
 
 */

func mySwap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var firstPeople = "Peter"
var secondPeople = "Rebecca"
mySwap(&firstPeople, &secondPeople) // Uncomment this line to check the functionality
firstPeople
secondPeople

var firstPrice = 1950
var secondPrice = 2450
mySwap(&firstPrice, &secondPrice) // Uncomment this line to check the functionality
firstPrice
secondPrice


/*:
 
 We can also limit generic types. It means not all types can be substituted.
 The type passed into the functions or types must reach some requirements.
 
 For example, we can implement a `max` function to find the max value in a sequence.
 In the implementation, we would compare values,
 
 */

func myMax<Value: Comparable>(_ rest: Value...) -> Value {
    var result = rest[0]
    for value in rest {
        if value > result { result = value }
    }
    return result
}

myMax(1, -1, 2, 3, 5, 10, -4)

extension Array where Element: Comparable {
    var maximum: Element? {
        guard !self.isEmpty else { return nil }
        var result = self.first!
        for value in self[1..<self.count] {
            if value > result { result = value }
        }
        return result
    }
}

let numbers = [1, 5, -10, 7, 42]
numbers.maximum!
let booleans = [true, false]
//booleans.maximum  // Uncomment to see what error message Xcode yields.

func find<T: Equatable, U: Sequence>(_ target: T, in values: U) -> Bool
where U.Iterator.Element == T{
        for value in values {
            if target == value { return true }
        }
        return false
}

find(3, in: [2, 3, 5, 7, 11, 13, 17, 19])
find(9, in: [2, 3, 5, 7, 11, 13, 17, 19])
//find("A", in: [2, 3, 5, 7, 11, 13, 17, 19])  // Uncomment to see what error message Xcode yields.

//: ---
/*:
 
 ## LinkedList
 
 */

class LinkedListNode<Element>: ExpressibleByArrayLiteral {
    var nextNode: LinkedListNode<Element>? = nil
    var content: Element?
    
    init(content: Element?) {
        self.content = content
    }
    
    required init(arrayLiteral elements: Element...) {
        self.content = elements.first
        var node = self
        for element in elements[1..<elements.count] {
            node.nextNode = LinkedListNode(content: element)
            node = node.nextNode!
        }
    }
}

// Make the `LinkedListNode` conforms to `Sequence` protocol to provide features like
// `for ... in`, `map`, `enumerated`, and etc.
extension LinkedListNode: Sequence {
    func makeIterator() -> AnyIterator<Element> {
        var node: LinkedListNode<Element>? = self
        return AnyIterator {
            if let currentNode = node {
                let content = currentNode.content
                node = currentNode.nextNode
                return content
            } else {
                return nil
            }
        }
    }
}

// Add `==` operator for the `LinkedListNode` only when its `Element` is equatable.
extension LinkedListNode where Element: Equatable {
    static func ==(left: LinkedListNode, right: LinkedListNode) -> Bool {
        // Check the content of both nodes
        guard left.content == right.content else { return false }
        // Check nextNode of both nodes
        switch (left.nextNode, right.nextNode) {
        case (.none, .none):  // `Optional` is actuall an `enum`.
            return true
        case (.some(let leftNextNode), .some(let rightNextNode)):
            return leftNextNode == rightNextNode
        default:
            return false
        }
    }
}

let uppercaseLetterList: LinkedListNode<String> = ["A", "B", "C", "D"]
Array(uppercaseLetterList)
for (index, content) in uppercaseLetterList.enumerated() {
    print("Item \(index) is '\(content)'.")
}
let lowercaseLetterArray = uppercaseLetterList.map { $0.lowercased() }

print(lowercaseLetterArray)

let anotherUppercaseLetterList: LinkedListNode<String> = ["A", "B", "C", "D"]
uppercaseLetterList == anotherUppercaseLetterList
uppercaseLetterList == uppercaseLetterList

/*:
 
 Using generics with protocols is a little tricky.
 
 */

protocol Generator {
    associatedtype Element  // The generic type in protocol
    
    mutating func next() -> Element?
    
    mutating func forEach(_ body: (Element) -> Void)
    func map<Mapped>(_ transform: @escaping (Element) -> Mapped) -> MappedGenerator<Self, Mapped>
    mutating func reduce<Reduced>(initial: Reduced, _ reducer: (Reduced, Element) -> Reduced) -> Reduced
    func filter(_ shouldInclude: @escaping (Element) -> Bool) -> FilteredGenerator<Self>
    func enumerated() -> EnumeratedGenerator<Self>
    
    mutating func contains(_ target: Element, where predicate: (Element, Element) -> Bool) -> Bool
    mutating func maximum(by isLarger: (Element, Element) -> Bool) -> Element?
}


// Default implementations
extension Generator {
    mutating func forEach(_ body: (Element) -> Void) {
        while let next = self.next() {
            body(next)
        }
    }
    
    func map<T>(_ transform: @escaping (Element) -> T) -> MappedGenerator<Self, T> {
        return MappedGenerator(base: self, transformer: transform)
    }
    
    mutating func reduce<T>(initial: T, _ reducer: (T, Element) -> T) -> T {
        var result = initial
        self.forEach { (item) in
            result = reducer(result, item)
        }
        return result
    }
    
    func filter(_ shouldInclude: @escaping (Element) -> Bool) -> FilteredGenerator<Self> {
        return FilteredGenerator(base: self, shouldInclude: shouldInclude)
    }
    
    func enumerated() -> EnumeratedGenerator<Self> {
        return EnumeratedGenerator(base: self)
    }
    
    mutating func contains(_ target: Element, where predicate: (Element, Element) -> Bool) -> Bool {
        while let next = self.next() {
            if predicate(target, next) {
                return true
            }
        }
        return false
    }
    
    mutating func maximum(by isLarger: (Element, Element) -> Bool) -> Element? {
        var result: Element? = nil
        while let next = self.next() {
            if result == nil || isLarger(next, result!) {
                result = next
            }
        }
        return result
    }
}


struct MappedGenerator<Base: Generator, Element>: Generator {
    var base: Base
    let transformer: (Base.Element) -> Element
    
    mutating func next() -> Element? {
        guard let next = self.base.next() else { return nil }
        return self.transformer(next)
    }
}

struct FilteredGenerator<Base: Generator>: Generator {
    var base: Base
    let shouldInclude: (Base.Element) -> Bool
    
    mutating func next() -> Base.Element? {
        while let next = self.base.next() {
            if self.shouldInclude(next) { return next }
        }
        return nil
    }
}

struct EnumeratedGenerator<Base: Generator>: Generator {
    var base: Base
    var currentIndex: Int = 0
    
    init(base: Base) {
        self.base = base
    }
    
    mutating func next() -> (Int, Base.Element)? {
        guard let next = self.base.next() else { return nil }
        defer { currentIndex += 1 }
        return (currentIndex, next)
    }
}

// Extra capabilities
extension Generator where Element: Equatable {
    mutating func contains(_ target: Element) -> Bool {
        return self.contains(target, where: ==)
    }
}
extension Generator where Element: Comparable {
    mutating func maximum() -> Element? {
        return self.maximum(by: >)
    }
}

// Type conversions
extension Array {
    init<T: Generator>(_ Generator: T) where T.Element == Element {
        var copiedGenerator = Generator
        var result = [Element]()
        while let next = copiedGenerator.next() {
            result.append(next)
        }
        self = result
    }
}


// Concrete Types - Number Generator
struct NumberGenerator: Generator {
    let startStep: Int
    let targetStep: Int
    var currentStep: Int
    
    init(steps: Int, from startStep: Int = 0) {
        self.startStep = startStep
        self.targetStep = startStep + steps
        self.currentStep = startStep
    }
    
    // Protocol-Generic conformation by implement `Element` related method
    mutating func next() -> Int? {
        guard self.currentStep <= self.targetStep else { return nil }
        defer { self.currentStep += 1 }
        return self.currentStep
    }
    
    // You can still provide your own implementation.
    // for better performance one. From O(n) -> O(1)
    func contains(_ target: Int) -> Bool {
        return self.startStep <= target && target <= self.targetStep
    }
}

struct LetterGenerator: Generator {
    var currentLetterIndex: Int = 0
    
    mutating func next() -> Character? {
        guard self.currentLetterIndex < 26 else { return nil }
        defer { self.currentLetterIndex += 1 }
        return Character(UnicodeScalar(self.currentLetterIndex + 65)!)
    }
}

Array(NumberGenerator(steps: 5))

var fiveToTen = NumberGenerator(steps: 10, from: 5)
fiveToTen.contains(2)

var evenGenerator = NumberGenerator(steps: 20).filter { $0 % 2 == 0}
evenGenerator.forEach { (number) in
    print("\(number) is an even number.")
}

print("\n----\n")

var letterGenerator = LetterGenerator()
var lowercaseLetterGenerator = letterGenerator.map { String($0).lowercased().characters.first! }.enumerated()
lowercaseLetterGenerator.forEach { (index, letter) in
    print("The letter at index \(index) is \(letter).")
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:


//: [Next](@next)
