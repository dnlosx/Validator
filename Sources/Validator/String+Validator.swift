//
//  String+Validator.swift
//  ValidatorPackageDescription
//
//  Created by Daniel on 9/29/17.
//

import Foundation


extension String {

    /// Validates if the string meets the rule.
    ///
    /// - parameter rule: The rule to verify.
    /// - throws: A validation error if the validation fails.
    func validate(_ rule: Validation) throws {
        try rule.validate(self)
    }

    /// Validates if the string meets all the rules.
    ///
    /// - parameter rules: The rules to verify.
    /// - throws: A validation error if any validation fails.
    func validate(_ rules: [Validation]) throws {
        // TODO: Tests all rules and join all erors in a single one...
    }

    /// Checks if the rule is valid.
    ///
    /// - returns: True if the validations success.
    func isValid(_ rule: Validation) -> Bool {
        do {
            try validate(rule)
            return true
        } catch {
            return false
        }
    }

    /// Checks if the rules are valid.
    ///
    /// - returns: True if the all validations success.
    func isValid(_  rules: [Validation]) -> Bool {
        do {
            try validate(rules)
            return true
        } catch {
            return false
        }
    }

}
