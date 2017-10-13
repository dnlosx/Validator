//
//  Rule+URL.swift
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


extension Rule {
    
    /// Describes the URL protocol
    enum Scheme {
        
        /// Designed to validate http and https URLs.
        case web(onlySSL: Bool)

        /// Validates URLs that starts with 'ftp:'
        case ftp
        
        /// Validates URLs that starts with 'mailto:'
        case mailto
        
        /// Validates URLs that starts with the specified scheme.
        /// For example if 'scheme' is data, then will validates the URLs that starts with 'data:'.
        /// Only supports alphanumeric schemes.
        ///
        /// - parameter scheme: Choose any URL protocol that you want.
        case custom(scheme: String)
        
        
        fileprivate var expression: String {
            switch self {
            case .web(onlySSL: let onlySSL):
                if onlySSL {
                    return "(https)"
                } else {
                    return "(http)(s)?"
                }
            case .ftp:
                return "(ftp)"
            case .mailto:
                return "(mailto)"
            case .custom(scheme: let scheme):
                return "\(scheme)"
                
            }
        }


    }

    struct URL: Validation {
        
        let scheme: Scheme
        
        /// Designated initializer method
        ///
        /// - parameter scheme: Defines the kind of URL protocol to validate, for example: use '.ftp' to validate 'ftp:'.
        init(scheme: Scheme) {
            self.scheme = scheme
        }
    
        // MARK: - Sugar instances

        /// An Rule.URL instance that validate 'http:' and 'https:' URLs.
        static var web = URL(scheme: .web(onlySSL: false))
        
        /// An Rule.URL instance that only validates 'https:' URLs.
        static var webSSL = URL(scheme: .web(onlySSL: true))
        
        /// An Rule.URL instance that validate 'ftp:' URLs.
        static var ftp = URL(scheme: .ftp)
        
        /// An Rule.URL instance that validate 'mailto:' URLs.
        static var mailto = URL(scheme: .mailto)
        
        // MARK: - Validation

        func validate(_ string: String) throws {
            let expression = "\(scheme.expression)(\\:\\/\\/)?([^\\ ]*)$"
            
            let predicate = NSPredicate(format:"SELF MATCHES[c] %@", expression)
            
            if !predicate.evaluate(with: string) {
                let message = NSLocalizedString("InvalidURL_WithFormat", comment: "The URL entered doesn't have a valid format.")
                let formatedMessage = String.localizedStringWithFormat(message, string)
                let error = ValidationError.singleValidation(localizedDescription: formatedMessage)
                throw error
            }
        }
        

    }


}
