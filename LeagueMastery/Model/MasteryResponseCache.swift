//
//  MasteryResponseCache.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 21/01/2026.
//
import Foundation


final class MasteryCacheEntryObject {
    let entry: MasteryCacheEntry
    init(entry: MasteryCacheEntry) { self.entry = entry }
}

enum MasteryCacheEntry {
    case inProgress(Task<[MasteryResponse], Error>)
    case ready([MasteryResponse])
}

extension NSCache where KeyType == NSString, ObjectType == MasteryCacheEntryObject {
    subscript(_ puuid: String) -> MasteryCacheEntry? {
        get {
            let key = puuid as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = puuid as NSString
            if let entry = newValue {
                let value = MasteryCacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
