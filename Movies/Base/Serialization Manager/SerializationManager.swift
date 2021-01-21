//
//  SerializationManager.swift
//  Movies
//
//  Created by Mateo Doslic on 19/01/2021.
//

import Foundation
class SerializationManager {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
  static func parseData<T: Codable>(jsonData: Data, toType: T.Type) -> T?{
        let object: T?
        do {
            object = try jsonDecoder.decode(T.self, from: jsonData)
            
        } catch let error {
            debugPrint("Error while parsing data from server. Received dataClassType: \(T.self). More info: \(error)")
            object = nil
        }
        return object
    }
}
