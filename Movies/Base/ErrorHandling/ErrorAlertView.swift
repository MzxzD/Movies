//
//  ErrorAlertView.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class AlertController {
  func alert(viewToPresent: UIViewController, title: String, message: String) {
    let action = UIAlertAction(title: "OK", style: .default)
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.view.tintColor = .black
    alert.addAction(action)
    viewToPresent.present(alert, animated: true, completion: nil)
  }
  
}
