//
//  FacadeAPI.swift
//  Movies
//
//  Created by Mateo Doslic on 19/01/2021.
//

import Foundation
import CoreData
import UIKit

class FacadeAPI {
  
  private var errorAlert: AlertController
  private var urlSession: RequestService
  private var coreDataManager: CoreDataManager
  
  static let shared = FacadeAPI()
  
  private init() {
    errorAlert = AlertController()
    urlSession = RequestService()
    coreDataManager = CoreDataManager()
  }
  
  // MARK: - RequestService
  func fetchEntityType<T: Codable>(_ type: T.Type, from endpoint: Endpoint, completion: @escaping (DataWrapper<T>)->()) {
    urlSession.sendRequestOfType(.get, endpoint: endpoint) { (wrappedData) in
      var completionValue = DataWrapper<T>(data: nil, error: nil)
      if let data = wrappedData.data, let object = SerializationManager.parseData(jsonData: data, toType: T.self) {
        completionValue.data = object
      } else {
        let error = wrappedData.error ?? "Something went wrong."
        completionValue.error = error
        print(error)
      }
      DispatchQueue.main.async {
        completion(completionValue)
      }
    }
  }
  
  func fetchImage(_ endpoint: Endpoint, completion: @escaping(DataWrapper<UIImage>)->()) {
    var completionValue = DataWrapper<UIImage>(data: nil, error: nil)
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Could not get AppDelegate instance!")
    }
    guard let urlString = endpoint.getUrl()?.absoluteString else {
      completionValue.error = "Failed to get Image"
      completion(completionValue)
      return
    }
    if let imageData = appDelegate.ImageCache[urlString] {
      completionValue.data = UIImage(data: imageData)
      completion(completionValue)
    } else {
      urlSession.sendRequestOfType(.get, endpoint: endpoint) { (wrappedData) in
        completionValue.error = wrappedData.error
        if let data = wrappedData.data {
          DispatchQueue.main.async {
            appDelegate.ImageCache[urlString] = data
            let image = UIImage(data: data)
            completionValue.data = image
            completion(completionValue)
          }
        }
      }
    }
  }
  // MARK: - AlertController
  
  func showAlertView(from view: UIViewController, with title: String, and message: String) {
    errorAlert.alert(viewToPresent: view, title: title, message: message)
  }
  
  // MARK: - CoreDataManager
  
  func getObjectEntityOfType<T: NSManagedObject>(_ type: T.Type, with ids: [Int]? = nil) -> [T]? {
    return coreDataManager.getObjectEntityOfType(type, with: ids)
  }
  
  func castToPersistable(_ source: NetworkMovie) -> Movie {
    return coreDataManager.castToPersistable(source)
  }
  
  func castToPersistable(_ source: NetworkGenre) -> Genre {
    return coreDataManager.castToPersistable(source)
  }
  
  func populateGenreToPersistentStore() {
    coreDataManager.populateGenreToPersistentStore()
  }
  
  func removeEntityOfType<T: NSManagedObject>(_ type: T.Type, with id: Int) {
    coreDataManager.removeEntityOfType(type, with: id)
  }
  
  func persistEntity(_ movie: NetworkMovie) {
    coreDataManager.persistEntity(movie)
  }
  
}



