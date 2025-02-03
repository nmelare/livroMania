import Foundation

struct BookViewModel {
    var volumeInfo: MyGoogleBooks.VolumeInfo
    var value: String?
    var id: BookCategorySaving?
}

enum BookCategorySaving: String {
    case want = "want"
    case have = "have"
}
