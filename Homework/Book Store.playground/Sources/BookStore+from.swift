
public extension BookStore {

    public static func from(_ books: [[String: String]]) -> BookStore {
        let bookStore = BookStore()

        func getBook(bookIndex: Int) -> Book?{
            // Implement 'getBook' method 
            return nil
        }
        
        // Get books to buy
        bookStore.setDataSource(bookGetter: getBook)

        return bookStore
    }
}
