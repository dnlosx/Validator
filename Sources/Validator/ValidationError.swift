//
//  ValidationError.swift
//  Qik
//
//  Created by Daniel on 9/27/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Foundation


class ValidationError: LocalizedError {

    var localizedDescription: String

    init(localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }


}
