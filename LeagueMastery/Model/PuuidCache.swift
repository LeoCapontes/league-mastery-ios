//
//  PUUIDCache.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 27/01/2026.
//

import Foundation

final class PuuidCacheEntryObject {
    let entry: PuuidCacheEntry
    init(entry: PuuidCacheEntry) { self.entry = entry }
}

enum PuuidCacheEntry {
    case inProgress(Task<PuuidResponse, Error>)
    case ready(PuuidResponse)
}

struct NameTagServerCombination {
    var name: String
    var tagline: String
    var server: String
    
    var description: String {
        "\(name)\(tagline)\(server)"
    }
    
    init(_ name: String, _ tag: String, _ server: String) {
        self.name = name
        self.tagline = tag
        self.server = server
    }
}

extension NSCache where KeyType == NSString, ObjectType == PuuidCacheEntryObject {
    subscript(_ nameTagServer: NameTagServerCombination) -> PuuidCacheEntry? {
        get {
            let key = nameTagServer.description as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = nameTagServer.description as NSString
            if let entry = newValue {
                let value = PuuidCacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
