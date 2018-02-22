import PlaygroundSupport

// MARK: - Book
public struct Book{
    var title: String
    var author: String
    var price: Double
}

// MARK: - Book Store (Model and Main class)

public class BookStore {

    public init() {}
    
    // MARK: Properties

    var books: [Book] = []
    
    var totalBookPrice: Double = 0
    
    var authors: [String] = []
    
    // MARK: Function interfacesc

    public func setDataSource(bookGetter: ((Int) -> Book?)) {
        var books = [Book]()
        
        // Get book from bookGetter
        
        // Sort books
    
        //assign value to property
        self.books = books
    }

}


