/*:
 
 # Protocols
 
 A protocol defines a blueprint of methods, properties, and other requirements
 that suit a particular task or piece of functionality.
 
 */

/*:
 
 ## Movable example
 
 */
import Foundation

struct Point { let x: Double, y: Double }

protocol Movable {
    func move(from origin: Point, to destination: Point) -> String
}

class Dog: Movable {
    func move(from origin: Point, to destination: Point) -> String {
        return "A dog walk from \(origin) to \(destination)."
    }
}

class Person {
    var name: String
    var position: Point = Point(x:0, y:0)
    
    init(name: String)
    {
        self.name = name
    }
}

protocol PeopleRidable {
    var passengers: [Person] { get set }
}

class Vehicle: PeopleRidable, Movable {
    var passengers: [Person] = []
    
    func carry(passengers: Person...){
        self.passengers.append(contentsOf: passengers)
    }
    
    func move(from origin: Point, to destination: Point) -> String {
        for passenger in passengers{
            passenger.position = destination
        }
        return "A vehicle move from \(origin) to \(destination)."
    }
}

class Bus: Vehicle {
    override func move(from origin: Point, to destination: Point) -> String {
        super.move(from: origin, to: destination)
        return "A bus drive from \(origin) to \(destination)."
    }
}
class Plane: Vehicle {
    override func move(from origin: Point, to destination: Point) -> String {
        super.move(from: origin, to: destination)
        return "A plane fly from \(origin) to \(destination)."
    }
}


let bus = Bus()
let mike = Person(name: "Mike")
let cindy = Person(name: "Cindy")

bus.carry(passengers: mike, cindy)
bus.move(from: Point(x: 0, y:0), to: Point(x: 10, y:10))

print("Mike's position is at (\(mike.position.x), \(mike.position.y))")

class MovementController {
    var movables: [Movable] = []
    func update() {
        for movable in self.movables {
            let originalPoint = Point(x: 0, y: 0)
            let destinationPoint = Point(x: drand48() * 100, y: drand48() * 100)
            print(movable.move(from: originalPoint, to: destinationPoint))
        }
    }
}

let movmentController = MovementController()
movmentController.movables = [Bus(), Plane(), Dog()]
movmentController.update()


extension Movable {  // Provide default implementation
    func move(from origin: Point, to destination: Point) -> String {
        return "Move from \(origin) to \(destination)."
    }
}

struct MovableItem: Movable {
}

let item = MovableItem()
item.move(from: Point(x: 0, y:0), to: Point(x: 10, y:10))

// bus == Bus()
// Try to uncomment the above line to see what Xcode yield

// Implment Equatable Protocol
extension Vehicle: Equatable{
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        if(type(of: lhs) == type(of: rhs)){
            return lhs.passengers.count == rhs.passengers.count
        }
        
        return false
    }
}

bus == Bus()


/*:
 
 Swift uses built-in `protocol` and `struct` to implement basic featuers
 
 ## Fraction
 
 */

struct Fraction {
    var numerator: Int
    var denominator: Int
    
    init?(numerator: Int, denominator: Int) {
        guard denominator != 0 else { return nil }
        self.numerator = numerator
        self.denominator = denominator
    }
}

extension Fraction {
    static func gcd(_ a: Int, _ b: Int) -> Int {
        let maxNumber = max(a, b)
        let minNumber = min(a, b)
        
        if minNumber == 0 { return maxNumber }
        else { return Fraction.gcd(minNumber, maxNumber % minNumber) }
    }
    
    mutating func reduce() {
        let gcd = Fraction.gcd(self.numerator, self.denominator)
        self.numerator /= gcd
        self.denominator /= gcd
    }
    
    func reduced() -> Fraction {
        let gcd = Fraction.gcd(self.numerator, self.denominator)
        return Fraction(numerator: self.numerator/gcd, denominator: self.denominator/gcd)!
    }
    
    func expanded(by value: Int) -> Fraction {
        return Fraction(numerator: self.numerator*value, denominator: self.denominator*value)!
    }
    
    var doubleValue: Double {
        return Double(self.numerator) / Double(self.denominator)
    }
}

extension Fraction: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(numerator: value, denominator: 1)!
    }
}

extension Fraction: CustomStringConvertible {
    var description: String {
        return "\(self.numerator)/\(self.denominator)"
    }
}

extension Fraction: Equatable {
    static func ==(left: Fraction, right: Fraction) -> Bool {
        let reduecdLeft = left.reduced()
        let reducedRight = right.reduced()
        return (reduecdLeft.numerator == reducedRight.numerator &&
            reduecdLeft.denominator == reducedRight.denominator)
    }
    // You can even implement `>`, `<=`, and `>=` for better performance.
    // (By default, the `>`  would be implemented as `!(==) && !(<)`
}

protocol Arithmetic {
    static func +(left: Self, right: Self) -> Self
    static func -(left: Self, right: Self) -> Self
    static func *(left: Self, right: Self) -> Self
    static func *=(left: inout Self, right: Self)
    static func /(left: Self, right: Self) -> Self
}

extension Fraction: Arithmetic{
    static func +(left: Fraction, right: Fraction) -> Fraction {
        let expandedLeft = left.expanded(by: right.denominator)
        let expandedRight = right.expanded(by: left.denominator)
        let resultNumerator = expandedLeft.numerator + expandedRight.numerator
        let resultDenominator = expandedLeft.denominator
        return Fraction(numerator: resultNumerator, denominator: resultDenominator)!
    }
    
    static func -(left: Fraction, right: Fraction) -> Fraction {
        let expandedLeft = left.expanded(by: right.denominator)
        let expandedRight = right.expanded(by: left.denominator)
        let resultNumerator = expandedLeft.numerator - expandedRight.numerator
        let resultDenominator = expandedLeft.denominator
        return Fraction(numerator: resultNumerator, denominator: resultDenominator)!
    }
    
    static func *(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator: left.numerator*right.numerator,
                        denominator: left.denominator*right.denominator)!
    }
    
    static func *=(left: inout Fraction, right: Fraction) {
        left.numerator *= right.numerator
        left.denominator *= right.denominator
    }
    
    static func /(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator: left.numerator*right.denominator,
                        denominator: left.denominator*right.numerator)!
    }
}

let half = Fraction(numerator: 1, denominator: 2)!
let one: Fraction = 1
let oneThird = Fraction(numerator: 4, denominator: 24)!

String(describing: oneThird)
String(describing: oneThird.reduced())

oneThird == half

let oneFouth = Fraction(numerator: 1, denominator: 2)! * Fraction(numerator: 1, denominator: 2)!

var fraction1 = Fraction(numerator: 2, denominator: 5)!
fraction1 *= Fraction(numerator: 1, denominator: 3)!
String(describing: fraction1)

var fraction2 = Fraction(numerator: 1, denominator: 2)! + Fraction(numerator: 1, denominator: 2)!
fraction2.doubleValue

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:

