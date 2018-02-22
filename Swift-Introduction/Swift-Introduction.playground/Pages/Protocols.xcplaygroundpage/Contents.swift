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


//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:

