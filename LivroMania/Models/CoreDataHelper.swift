import Foundation
import UIKit
import CoreData

final class CoreDataHelper {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var models = [BooksSave]()
    
    private func getAllItens() {
        do {
            guard let context = context else {return }
            models = try context.fetch(BooksSave.fetchRequest())
        }
        catch {
            print(CustomError.errorToGetBooks)
        }
    }
    
    func saveBook(title: String,
                  image: String?,
                  subtitle: String,
                  author: String,
                  publishedDate: String,
                  bookDescription: String,
                  id: String,
                  pageCount: String,
                  publisher: String,
                  mainCategory: String,
                  value: String) {
        guard let context = context else {return }

        let newItem = BooksSave(context: context)
        newItem.title = title
        newItem.subtitle = subtitle
        newItem.author = author
        newItem.publishedDate = publishedDate
        newItem.bookDescription = bookDescription
        newItem.id = id
        newItem.pageCount = pageCount
        newItem.publisher = publisher
        newItem.mainCategory = mainCategory
        newItem.value = value
        newItem.image = image
        
        do {
            try context.save()
            getAllItens()
        }
        catch {
            print(CustomError.errorToSaveBook)
        }
    }
    
    func cancelItem(item: BooksSave) {
        context?.delete(item)
        
        do {
            try context?.save()
            getAllItens()
        }
        catch {
            print(CustomError.errorToDelete)
        }
    }
    
    func updateStatus(book: BooksSave, id: String) {
        book.id = id
        
        do {
            try context?.save()
            getAllItens()
        }
        catch {
            print(CustomError.errorToUpdateStatus)
        }
    }
    
    func updateValue(book: BooksSave, value: String) {
        book.value = value
        
        do {
            try context?.save()
            getAllItens()
        }
        catch {
            print(CustomError.errorToUpdateValue)
        }
    }

    func getAllBooks(for flow: String) {
        guard let context = context else {return }

        let fetchRequest: NSFetchRequest<BooksSave>
        fetchRequest = BooksSave.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "id = %@", flow
        )

        do {
            models = try context.fetch(fetchRequest)
        }
        catch {
            print(CustomError.errorToGetEspecificFlowBooks(flow: flow))
        }
    }
}
