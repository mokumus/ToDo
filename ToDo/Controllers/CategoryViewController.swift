//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 13.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categoryArray = [Category]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    override func viewDidLoad() {
        super.viewDidLoad()

		loadCategories()
    }
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as UITableViewCell
		let category = categoryArray[indexPath.row]
		
		cell.textLabel?.text = category.name
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryArray.count
	}
	
	//MARK: - TableView Delegete Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categoryArray[indexPath.row]

		}
	}
	
	//MARK: - Model Manuplation Methods
	
	func saveCategories(){
		do{
			try context.save()
		}catch{
			print("Error saving context \(error)")
		}
	}
	
	func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
		do{
			categoryArray = try context.fetch(request)
		} catch{
			print("Error fetching data from context \(error)")
		}
		tableView.reloadData()
	}
	
	//MARK: - Add New Categories

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			// What will happen when addCategory is clicked on UIAlert
			if textField.text?.count != 0 {
				let newCategory = Category(context: self.context)
				newCategory.name = textField.text!
				
				self.categoryArray.append(newCategory)
				self.saveCategories()
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new category"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}

	
	
}
