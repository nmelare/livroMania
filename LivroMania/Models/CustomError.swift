enum CustomError: Error {
    case errorToGetBooks
    case errorToFindContext
    case errorToDelete
    case errorToSaveBook
    case errorToUpdateStatus
    case errorToLoadImage
    case errorLoadingCell
    case errorToGetEspecificFlowBooks(flow: String)
    case errorToUpdateValue
}
