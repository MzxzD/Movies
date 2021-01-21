//
//  RequestService.swift
//  Movies
//
//  Created by Mateo Doslic on 18/01/2021.
//

import Foundation

enum RequestType: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
  case put = "PUT"
}

class RequestService {
  func sendRequestOfType(_ requestType: RequestType, endpoint: Endpoint, completion: @escaping(DataWrapper<Data>)->()) {
    var completionValue = DataWrapper<Data>(data: nil, error: nil)
    var components = URLComponents(url: endpoint.getUrl()!, resolvingAgainstBaseURL: false)!
    components.queryItems = []
    for (key, value) in endpoint.queryItems() {
      components.queryItems?.append(URLQueryItem(name: key, value: value))
    }
    if let url = components.url {
      let urlSessionConfig = URLSessionConfiguration.default
      urlSessionConfig.timeoutIntervalForRequest = 60
      let urlSession = URLSession(configuration: urlSessionConfig)
      urlSession.dataTask(with: url) { (data, response, error) in
        completionValue.data = data
        completionValue.error = error?.localizedDescription
        completion(completionValue)
      }.resume()
    } else {
      completionValue.error = "Failed to cast URL from string"
      completion(completionValue)
    }
  }
  
}
