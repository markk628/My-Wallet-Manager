//
//  SnapShotExtensions.swift
//  Budget
//
//  Created by Mark Kim on 3/18/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        
        var documentJson = data()
        
        if includingId {
            documentJson?["id"] = documentID
        }
        let documentData = try JSONSerialization.data(withJSONObject: documentJson as Any, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}
