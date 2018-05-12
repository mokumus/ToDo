//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	var itemArray = [Item]()
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let newItem = Item(title: "Find Mike")
		itemArray.append(newItem)
		
		let newItem2 = Item(title: "Buy Eggs")
		itemArray.append(newItem2)
		
		let newItem3 = Item(title: "Destroy Demogorgon")
		itemArray.append(newItem3)
		
		if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
			itemArray = items
			print("Array retrieved!")
		}
		
	}

	//MARK - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
	
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	//MARK - Tableview Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		//print(itemArray[indexPath.row])
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		tableView.reloadData()
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
	
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			// What will happen when addItem is clicked on UIAlert
			if textField.text?.count != 0 {
				let newItem = Item(title: textField.text!)
				self.itemArray.append(newItem)
				self.defaults.set(self.itemArray, forKey: "ToDoListArray")
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}

