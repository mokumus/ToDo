//
//  Item.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 19.06.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import Foundation
import RealmSwift


//Inherit realm object
class Item : Object {
	@objc dynamic var title : String = ""
	@objc dynamic var done : Bool = false
	
	//From Category to Items (as in items.swift)
	let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
