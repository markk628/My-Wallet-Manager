//
//  EncodableExtension.swift
//  Budget
//
//  Created by Mark Kim on 3/18/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

enum MyError: Error {
    case encodingError
}

extension Encodable {
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        
        let objectData = try JSONEncoder().encode(self)
        let JsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        
        guard var json = JsonObject as? [String: Any] else { throw MyError.encodingError }
        
        for key in keys {
            json[key] = nil
        }
        return json
    }
}
