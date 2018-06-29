//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

	var items: Results<Item>?
	let realm = try! Realm()
	
	var selectedCategory : Category?{
		didSet{
			loadItems()
		}
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
	
		if let item = items?[indexPath.row]{
			cell.textLabel?.text = item.title
			cell.accessoryType = item.done ? .checkmark : .none
		} else{
			cell.textLabel?.text = "No Items Added"
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items?.count ?? 1
	}
	
	//MARK: - Tableview Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

		if let item = items?[indexPath.row]{
			do{
				try realm.write {
					realm.delete(item)
					//item.done = !item.done
				}
			}catch{
				print("Error when toggling tick, \(error)")
			}
		}
		
		//tableView.deselectRow(at: indexPath, animated: true)
		tableView.reloadData()
	}
	
	//MARK: - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
	
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			if textField.text?.count != 0 {

				if let currentCotegory = self.selectedCategory {
					do{
						try self.realm.write {
							let newItem = Item()
							newItem.title = textField.text!;
							newItem.dateCreated = Date()
							currentCotegory.items.append(newItem)
						}
					} catch{
						print("Error saving items, \(error)")
					}

				}
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
	
	//MARK: - Model Manuplation Methods
	
	func loadItems(){
		items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

		tableView.reloadData()
	}
}

//MARK: - Search Bar Methods


extension TodoListViewController: UISearchBarDelegate{

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
		tableView.reloadData()
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0{
			loadItems()

			DispatchQueue.main.async {
				searchBar.resignFirstResponder() //dismisses keyboard
			}
		}
	}
}

