//
//  KeyService.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import Foundation

public class KeysService {
    public enum Keys: String {
        case terms
    }
    
    public static func get(_ key: KeysService.Keys) -> Any? {
        UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    public static func set(_ value: Any?, for key: KeysService.Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func has(key: KeysService.Keys) -> Bool {
        UserDefaults.standard.value(forKey: key.rawValue) != nil
    }
}


import Foundation

open class TermManager {
    
    public init() {}
  
    @discardableResult
    func addNewTerms(terms: [String : Int]) -> Bool {
        if var actualTerms = KeysService.get(.terms) as? [String : Int] {
            for (name,theme) in terms { actualTerms[name] = theme }
            KeysService.set(actualTerms, for: .terms)
            NotificationCenter.default.post(name: NSNotification.Name(NotificationCenter.Names.updateTerms), object: nil)
            return true
        }
        KeysService.set(terms, for: .terms)
        NotificationCenter.default.post(name: NSNotification.Name(NotificationCenter.Names.updateTerms), object: nil)
        return true
    }
    
    func getTerms() -> [Everything.Request : NATheme] {
        let results = KeysService.get(.terms) as? [String : Int]
        var terms: [Everything.Request : NATheme] = [:]
        results?.forEach {
            terms[Everything.Request(searchIn:$0.key,pageSize: "10")] = NATheme(rawValue: $0.value)
        }
        return terms
    }
    
}


extension NotificationCenter {
    
    struct Names {
        static var updateTerms = "update.terms"
    }
    
}
