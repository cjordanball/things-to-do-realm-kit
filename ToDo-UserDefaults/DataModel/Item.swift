//
//  Item.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/6/21.
//

import Foundation

struct Item: Codable {
    var title: String;
    var done: Bool = false;
}
