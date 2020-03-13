//
//  String+Validator.swift
//
//  Copyright 2017 Fco Daniel B.R.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
//  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
