//
//  CategoryViewController.swift
//  ToDo-Realm
//
//  Created by C. Jordan Ball III on 8/12/21.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm();
    
    var categories: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad();
    
        loadCategories();
    }

    //Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath);
        
        cell.textLabel?.text = categories?[indexPath.row].name.capitalized ?? "No Categories Added";
        return cell;
    }
    
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField();
        
        let alert = UIAlertController(title: "Add Category", message: "Add a category in which to place items", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            
            let newCategory = Category();
            newCategory.name = textField.text!;
            
            self.save(category: newCategory);

        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create a new category";
            textField = alertTextField;
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil);
        
    }
    
    
    //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController;

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row];
            destinationVC.title = categories?[indexPath.row].name.uppercased() ?? "";
        } else {
            print("Invalid row");
        }
    }
    
    //Mark: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category);
            };
        } catch {
            print("Having a bad day \(error)");
        }
        tableView.reloadData();
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self);
        
        tableView.reloadData();
    }
}
