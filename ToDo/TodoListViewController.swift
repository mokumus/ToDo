//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()

		
		if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
			itemArray = items
		}
		
	}

	//MARK - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	//MARK - Tableview Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		//print(itemArray[indexPath.row])
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		toggleCheckMark(cell: tableView.cellForRow(at: indexPath)!)
		

	}
	
	func toggleCheckMark(cell: UITableViewCell){
		if cell.accessoryType == .checkmark{
			cell.accessoryType = .none
		}
		else{
			cell.accessoryType = .checkmark
		}
	}
	
	//MARK - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
	
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			// What will happen when addItem is clicked on UIAlert
			if textField.text?.count != 0 {
				self.itemArray.append(textField.text!)
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

