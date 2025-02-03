import UIKit

extension UIImageView {
    func loadImageFromServer(urlString: String) async throws {
        guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            throw URLError(.badURL)
        }
        
        // Fetch data from the URL
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Validate the response and data
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Create an image from the data
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image from data"])
        }

        // Update the UIImageView's image on the main thread
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
