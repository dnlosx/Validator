//
//  Rule+URL.swift
//  ValidatorPackageDescription
//
//  Created by Daniel BR on 29/09/17.
//

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
        
        /// Validate URLs that starts with the specified scheme.
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
                let error = ValidationError(localizedDescription: formatedMessage)
                throw error
            }
        }
        

    }
    
}
