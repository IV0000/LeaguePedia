//
//  CacheImplementation.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 16/08/22.
//

import Foundation

class InMemoryCache<V> {
    fileprivate let cache: NSCache<NSString, CacheEntry<V>> = .init()
    let expirationInterval: TimeInterval

    init(expirationInterval: TimeInterval) {
        self.expirationInterval = expirationInterval
    }

    func removeValue(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    func removeAllValues() {
        cache.removeAllObjects()
    }

    func setValue(_ value: V?, forKey key: String) {
        if let value = value {
            let expiredTimestamp = Date().addingTimeInterval(expirationInterval)
            let cacheEntry = CacheEntry(key: key, value: value, expiredTimestamp: expiredTimestamp)
            cache.setObject(cacheEntry, forKey: key as NSString)
        } else {
            removeValue(forKey: key)
        }
    }

    func value(forKey key: String) -> V? {
        guard let entry = cache.object(forKey: key as NSString) else {
            return nil
        }

        // Invalidates the cache if expired
        guard !entry.isCacheExpired(after: Date()) else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }
}
