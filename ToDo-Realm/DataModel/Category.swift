//
//  Category.swift
//  ToDo-Realm
//
//  Created by C. Jordan Ball III on 8/14/21.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = "";
    
    let items = List<Item>();
}
