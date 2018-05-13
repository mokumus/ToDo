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
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

	override func viewDidLoad() {
		super.viewDidLoad()
		loadItems()
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
		saveItems()
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
				self.saveItems()
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
	
	//MARK -Model Manuplation Methods
	func saveItems(){
		let encoder = PropertyListEncoder()
		
		do{
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath! )
		}catch{
			print("Error encoding item array, \(error)")
		}
	}
	
	func loadItems(){
		if let data = try? Data(contentsOf: dataFilePath!){
			let decoder = PropertyListDecoder()
			do{
				itemArray = try decoder.decode([Item].self, from: data)
			}catch{
				print("Error loading data, \(error)")
			}
		}
	}
}

