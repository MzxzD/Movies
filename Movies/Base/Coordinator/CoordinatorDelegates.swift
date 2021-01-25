//
//  Coordinator+Extensions.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    func viewControllerHasFinished()
}

protocol ParentCoordinatorDelegate: AnyObject {
    func childHasFinished(coordinator: Coordinator)
}
