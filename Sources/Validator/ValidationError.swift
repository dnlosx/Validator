//
//  ValidationError.swift
//  Qik
//
//  Created by Daniel on 9/27/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Foundation


/// Designated to describe an validation error.
public enum ValidationError: LocalizedError {

    case singleValidation(localizedDescription: String)
    case multiValidation(localizedDescriptions: [String])


    var localizedDescription: String  {
        switch self {
        case .singleValidation(localizedDescription: let description):
            return description
        case .multiValidation(localizedDescriptions: let descriptions):
            return descriptions.joined(separator: "\n")
        }
    }

}
