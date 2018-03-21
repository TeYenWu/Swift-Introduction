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
        var totalBookPrice = 0.0
        var authors: [String] = []
        
        // Get book from bookGetter
        
        // Sort books
        
        // Retrieive authors and prices
    
        //assign value to property
        self.books = books
        self.totalBookPrice = totalBookPrice
        self.authors = authors
        
    }

}


