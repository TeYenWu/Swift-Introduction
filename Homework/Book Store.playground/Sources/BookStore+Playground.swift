import PlaygroundSupport
import UIKit


extension BookStore {

    public func showInPlayground() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 420, height: 640))
        
        window.rootViewController = self.createRootViewController()
        window.makeKeyAndVisible()
        window.setNeedsDisplay()
        PlaygroundPage.current.needsIndefiniteExecution = true
        PlaygroundPage.current.liveView = window
    }

    func createRootViewController() -> UIViewController {
        let bookListViewController = BookListViewController(style: .plain)
        bookListViewController.authors = self.authors
        bookListViewController.books = self.books
        bookListViewController.totalPrice = self.totalBookPrice
        return UINavigationController(rootViewController: bookListViewController)
    }

}
