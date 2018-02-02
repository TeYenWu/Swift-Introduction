/*:
 
 # Collections
 
 Swift provides three primary collection types, known as arrays, sets, and dictionaries,
 for storing collections of values.
 
 - Arrays are **ordered** collections of values.
 - Sets are **unordered** collections of **unique values**.
 - Dictionaries are **unordered** collections of **key-value associations**.
 
 Arrays, sets, and dictionaries in Swift are always clear about
 the types of values and keys that they can store.
 
 This means that you cannot insert a value of the wrong type into a collection
 by mistake. It also means you can be confident about the type of values you
 will retrieve from a collection.
 
 If you create an array, a set, or a dictionary, and assign it to a variable,
 the collection that is created will be mutable. You can change the collection
 by adding, removing, or changing items in the collection.
 
 If you assign an array, a set, or a dictionary to a constant,
 that collection is immutable, and its size and contents cannot be changed.
 
 */
/*:
 
 ## Arrays
 
 An array stores values of _the same type_ in **an ordered list**.
 The same value can appear in an array multiple times at different positions.
 
 ### Array creation
 
 Arrays could be created by using Array's initializers or with the array literals.
 
 An array literal is written as a list of values, separated by commas,
 surrounded by a pair of square brackets.
 
 */
let names = ["Peter", "Annie", "Matt", "Spencer", "Alvin"]
let zeros = Array(repeating: 0, count: 10)
var emptyStringArray = [String]()
var emptyDoubleArray = Array<Double>()

/*:
 
 ### Array Type
 
 The type of a Swift array is written in full as `Array<Element>`,
 where `Element` is the type of values the array is allowed to store.
 
 You can also write the type of an array in shorthand form as `[Element]`.
 The shorthand form is preferred and is used throughout this guide
 when referring to the type of an array.
 
 ### Array and Operators
 
 - Arrays could be joined by `+` operator.
 - We use bracket operator (`[]`) to access the content of an array
 by a given index or a range.
 
 */
var japaneseFoods = ["寿司", "カツ丼", "うどん"]
let taiwaneseFoods = ["大腸麵線", "蚵仔煎", "珍珠奶茶", "小籠湯包"]
let asianFoods = japaneseFoods + taiwaneseFoods
let noodles = asianFoods[2..<4]

/*:
 
 ### Properties and Methods of Arrays
 
 */
asianFoods.isEmpty
japaneseFoods.count
let sushi = japaneseFoods.first
let doubleOptionalValue = emptyDoubleArray.last
// Use "option+click" to see the type of above two constants.

japaneseFoods.append("牛丼")
japaneseFoods.insert("Rib eye steak", at: 2)
// taiwaneseFoods.append("魯肉飯") // Cannot use mutating member on immutable value: 'taiwaneseFoods' is a 'let' constant


let indexOf肉骨茶 = japaneseFoods.index(of: "肉骨茶")
let indexOfRibEyeSteak = japaneseFoods.index(of: "Rib eye steak")!
// Use "option+click" to see the type of above two constants.
let indexOfPhở = japaneseFoods.index(of: "Phở")! //

japaneseFoods.remove(at: indexOfRibEyeSteak)
japaneseFoods
if let indexOfBurrito = japaneseFoods.index(of: "Burrito") {
    japaneseFoods.remove(at: indexOfBurrito)
}
//japaneseFoods.remove(at: indexOf肉骨茶)  // Value of optional type 'Array.Index?' (aka 'Optional<Int>') not unwrapped;

/*:
 
 ### Array and Control flows
 
 The `for-in` loop is great to enumerate elements in an array
 
 */
for japaneseFood in japaneseFoods {
    "\(japaneseFood) is a delicious."
}

// `enumerated` method would return an `interator` with pairs (tuples) of index and value.
for (index, taiwaneseFood) in taiwaneseFoods.enumerated() {
    "The food at \(index) is \(taiwaneseFood)."
}

/*:
 
 (Self-Reading) In Swift, we have a convention that functions and methods which alter the data structure itself (in place)
 would be named in plain form, like `sort` and `filter`. And since these methods alters the object itself,
 it's only available to mutable instances (variables).
 
 For method named with past tense, like `sorted` and `filtered`, they return a copy of the original one
 
 */

let unorderedNumbers = [4, 1, 5, -10, 12, 6, 3, 7, 2]
let sortedNumbers = unorderedNumbers.sorted()
unorderedNumbers


var unorderedNumbers2 = [1, 2, -1, 4, 3, 5]
unorderedNumbers2.sort()
unorderedNumbers2

/*:
 
 ## Array is a generic type
 
 (Self-Reading) The `Array` type could hold another type as its `Element` type. This concept
 is called **Generic**. We say that Array is a generic collection type. The syntax
 of denoting a generic type is by angle brackets (`<>`).
 
 Types in properties and methods of a generic type may be changed.
 
 */
let emptyDoubleOptional = emptyDoubleArray.first
let emptyStringOptional = emptyStringArray.first
// Use "option+click" to see the type of above two constants.

emptyDoubleArray.append(42.0)
emptyStringArray.append("String")

let removedDouble = emptyDoubleArray.removeLast()
let removedString = emptyStringArray.removeFirst()
// Use "option+click" to see the type of above two constants.

/*:
 
 ## Sets
 
 A set stores distinct values of the same type in a collection with no defined ordering.
 You can use a set instead of an array when the order of items is not important,
 or when you need to ensure that an item only appears once.
 
 ### Set creation
 
 Sets could be created by using Set initializers or with _the array literals_.
 
 */
let fibNumbers: Set<Int> = [1, 1, 2, 3, 5, 8, 13]

/*:
 
 ### Set Type
 
 The type of a Swift set is written in full as `Set<Element>`,
 where `Element` is the type of values the array is allowed to store.
 
 */
let members: Set<String> = ["Peter", "Marry", "Tom"]

/*:
 
 ### Set operations
 
 You can efficiently perform fundamental set operations,
 such as combining two sets together, determining which values two sets
 have in common, or determining whether two sets contain
 all, some, or none of the same values.
 
 */
var primes: Set<Int> = [2, 2, 3, 5, 7, 11, 13, 17, 19, 6+5]
let oddNumbers = Set<Int>([1, 3, 5, 7, 9, 11, 13, 15, 17, 19])
let evenNumbers: Set<Int> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
let smallEvenNumbers: Set<Int> = [2, 4, 6, 8]

primes.insert(21)
primes.remove(21)

let emptyIntSet = oddNumbers.intersection(evenNumbers)
let allNumbers = evenNumbers.union(oddNumbers)
let evenPrimes = primes.intersection(evenNumbers)
let nonPrimeOddNumbers = oddNumbers.subtracting(primes)
smallEvenNumbers.isSubset(of: evenNumbers)
evenNumbers.isSuperset(of: evenPrimes)
evenNumbers.isDisjoint(with: oddNumbers)
primes.contains(12)

/*:
 
 ### Set and Control flows
 
 (Self-Reading) The `for-in` loop is great to enumerate elements in a set
 
 */
for prime in primes {
    "\(prime) is a prime."
}

for evenNumber in evenNumbers.sorted() {
    "\(evenNumber) is an even number."
}

/*:
 
 ## Dictionaries
 
 A dictionary stores associations between **keys** of the same type and
 **values** of the same type in a collection with no defined ordering.
 Each value is associated with a unique key, which acts as an identifier for
 that value within the dictionary.
 
 Unlike items in an array, items in a dictionary do not have a specified order.
 You use a dictionary when you need to look up values based on their identifier,
 in much the same way that a real-world dictionary is used to look up the
 definition for a particular word.
 
 ### Dictionary Creation
 
 Dictionary could be created by using Dictionary's initializers or with the
 dictionary literals.
 
 A _key-value pair_ is a combination of a key and a value. In a dictionary literal,
 the key and value in each key-value pair are separated by **a colon** (`:`).
 The key-value pairs are written as _a list_, separated by commas (`,`),
 surrounded by a pair of square brackets.
 
 */
var airports = [
    "TPE": "Taipei Taoyuan",
    "HND": "Tokyo Haneda",
    "NRT": "Tokyo Narita"
]
let emptyStringIntPairDictionary = Dictionary<String, Int>()
let emptyStringFloatPairDictionary = [String: Float]()
let emptyStringBoolPairDictionary: [String: Bool] = [:]

/*:
 
 ### Dictionary Type
 
 The type of a Swift dictionary is written in full as `Dictionary<Key, Value>`,
 where `Key` is the type of value that can be used as a dictionary key,
 and `Value` is the type of value that the dictionary stores for those keys.
 
 You can also write the type of a dictionary in shorthand form as `[Key: Value]`.
 Although the two forms are functionally identical, the shorthand form is preferred
 and is used throughout this guide when referring to the type of a dictionary.
 
 */
var fruitsColors: Dictionary<String, String> = [
    "apple": "red",
    "banana": "yellow",
    "orange": "orange",
]
let numberNames: [Int: [String]] = [
    1: ["One", "ichi", "いち"],
    2: ["Two", "ni", "に"],
    4: ["Four", "yon", "よん"],
    7: ["Seven", "nana", "なな"],
    8: ["Eight", "hachi", "はち"],
]

/*:
 
 ### Dictionary and Operators
 
 - We use bracket operator (`[]`) to access the content of a dictionary
 by a given key.
 
 */
let colorOfApple = fruitsColors["apple"]!
let colorOfWatermelon = fruitsColors["watermelon"]
// Use "option+click" to see the type of above two constants.

fruitsColors["grape"] = "purple"
fruitsColors
fruitsColors["grape"] = nil
fruitsColors["watermelon"] = nil
fruitsColors

/*:
 
 ### Properties and Methods of Dictionaries
 
 */
numberNames.count
let numbers = Array(numberNames.keys)
let colors = Set(fruitsColors.values)

/*:
 
 ### Dictionaries and Control flows
 
 (Self-Reading) The `for-in` loop is great to enumerate key-value pairs in a dictionary.
 
 */
for (fruit, color) in fruitsColors {
    "\(fruit) is \(color)."
}

for fruit in fruitsColors.keys {
    fruit
}

for color in fruitsColors.values {
    color
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:

