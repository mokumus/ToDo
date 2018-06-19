//
//  Category.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 19.06.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
	@objc var name : String = ""
	let items = List<Item>()
	
	
}
