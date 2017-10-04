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
    public func validate(_ rule: Validation) throws {
        try rule.validate(self)
    }

    /// Validates if the string meets all the rules.
    ///
    /// - parameter rules: The rules to verify.
    /// - throws: A validation error if any validation fails.
    public func validate(_ rules: [Validation]) throws {
        var messages = [String]()

        for rule in rules {

            do {
                try rule.validate(self)
            } catch ValidationError.singleValidation(localizedDescription: let message) {
                messages.append(message)
            }

        }

        if messages.count > 0 {
            throw  ValidationError.multiValidation(localizedDescriptions: messages)
        }

    }

    /// Checks if the rule is valid.
    ///
    /// - returns: True if the validations success.
    public func isValid(_ rule: Validation) -> Bool {
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
    public func isValid(_  rules: [Validation]) -> Bool {
        do {
            try validate(rules)
            return true
        } catch {
            return false
        }
    }

}
