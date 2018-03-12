/*:
 
 # Book Store

 This is a simple playground which is a shopping cart of an online book store.
 
 The shopping cart shows authors and books the user wants to buy.
 It shows the total price in the title bar.
 
 For example, I want to buy following books. Each book is represented by
 a dictionary with 3 keys: `author`, `title`, and `price`.
 
 > You have to open the **Timeline view** if you cannot see the shopping cart.
 
 */
import Foundation

// Throw errors if invalid URL and bookData
func getBookData(urlText: String) throws -> [[String: String]]{
    guard let url = URL.init(string: urlText) else { return [] }
    let data = try Data.init(contentsOf: url)
    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
    guard let bookData: [[String : String]] = jsonData as? [[String : String]] else { return [] }
    return bookData
}

do {
    
    let books: [[String: String]] = try getBookData(urlText: "http://bit.do/eaaqu")
    
    /*:
     
     And, let's show the book store shopping cart:
     
     */

    let bookStore = BookStore.from(books)
    bookStore.showInPlayground()
}
// Do error handling for invalid URL and bookData

//: ---
//: [Next ->](@next)
