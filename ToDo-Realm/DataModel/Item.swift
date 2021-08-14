//
//  Item.swift
//  ToDo-Realm
//
//  Created by C. Jordan Ball III on 8/14/21.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = "";
    @objc dynamic var done: Bool = false;
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items");
}