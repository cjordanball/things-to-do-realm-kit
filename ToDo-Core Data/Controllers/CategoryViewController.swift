//
//  CategoryViewController.swift
//  ToDo-Core Data
//
//  Created by C. Jordan Ball III on 8/12/21.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = Array<Category>();
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

    override func viewDidLoad() {
        super.viewDidLoad();
        loadCategories();
    }

    //Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath);
        cell.textLabel?.text = categoryArray[indexPath.row].name;
        return cell;
    }
    
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("pressed");
        var textField = UITextField();
        
        let alert = UIAlertController(title: "Add Category", message: "Add a category in which to place items", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let newCategory = Category(context: self.context);
            newCategory.name = textField.text!;
            self.categoryArray.append(newCategory);
            self.saveCategories();
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
            print(categoryArray[indexPath.row].name!);
            destinationVC.selectedCategory = categoryArray[indexPath.row];
            destinationVC.title = categoryArray[indexPath.row].name!.uppercased();
        } else {
            print("Invalid row");
        }
    }
    
    //Mark: - Data Manipulation Methods
    
    func saveCategories() {
        do {
            try context.save();
        } catch {
            print("Having a bad day \(error)");
        }
        self.tableView.reloadData();
    }
    
    func loadCategories(_ request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request).filter({ val in
                val.name != "";
            })
        } catch {
            print("ERR: \(error)");
        }
    }
}
