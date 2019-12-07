//
//  URL+AddQueries.swift
//  
//
//  Created by Isaac Ballas on 2019-12-03.
//

import Foundation
// This extension is used to add queries dynamically to a URL. Great for future projects.
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
        resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
{ URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

// HOW TO USE:
// Create the URL
let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
let query: [String:String] = [
    "api_key": "DEMO_KEY",
    "date": "2011-07-13"
]
let url = baseURL.withQueries(query)!
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data, let string = String(bytes: data, encoding: .utf8) {
        print(string)
    }
    PlaygroundPage.current.finishExecution()
}
task.resume()


