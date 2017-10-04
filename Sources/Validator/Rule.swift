//
//  Rule.swift
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


public struct Rule {

    /// Designated to validate e-mails.
    struct Email: Validation {

        func validate(_ string: String) throws {
            /// RFC 2822 Validation
            let expression = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
            + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
            + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
            + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
            + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
            + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
            + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

            let predicate = NSPredicate(format:"SELF MATCHES[c] %@", expression)

            if !predicate.evaluate(with: string) {
                let message = NSLocalizedString("InvalidEmail_WithFormat", comment: "The e-mail entered doesn't have a valid format.")
                let formatedMessage = String.localizedStringWithFormat(message, string)
                let error = ValidationError.singleValidation(localizedDescription: formatedMessage)
                throw error
            }
        }
    }

    /// Designated to validates if the strings starts with te specified prefix.
    struct Starts: Validation {
        private let prefix: String

        init(with prefix: String) {
            self.prefix = prefix
        }

        func validate(_ string: String) throws {
            if !string.hasPrefix(prefix) {
                let message = NSLocalizedString("MustStartWith_WithFormat", comment: "The text entered must start with the prefix.")
                let formatedMessage = String.localizedStringWithFormat(message, string)
                let error = ValidationError.singleValidation(localizedDescription: formatedMessage)
                throw error
            }
        }
    }

    /// Validates if the string is not empty.
    struct NotEmpty: Validation {

        func validate(_ string: String) throws {
            if string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                let message = NSLocalizedString("MustNotBeEmpty_WithFormat", comment: "The text must not be empty.")
                let formatedMessage = String.localizedStringWithFormat(message, string)
                let error = ValidationError.singleValidation(localizedDescription: formatedMessage)
                throw error
            }
        }
    }

}
