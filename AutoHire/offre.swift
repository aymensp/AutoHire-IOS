//
//  offre.swift
//  AutoHire
//
//  Created by Admin on 12/2/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//




struct User: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    let username: String
    let name: String

    var description: String {
        return "User: { username: \(username), name: \(name) }"
    }

    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let username = response.url?.lastPathComponent,
            let representation = representation as? [String: Any],
            let name = representation["name"] as? String
        else { return nil }

        self.username = username
        self.name = name
    }
}
