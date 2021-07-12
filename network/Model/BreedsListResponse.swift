//
//  BreedsListResponse.swift
//  network
//
//  Created by m.bui on 7/12/21.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
