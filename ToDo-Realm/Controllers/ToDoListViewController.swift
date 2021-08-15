//
//  ViewController.swift
//  ToDo-Realm
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?
    let realm = try! Realm();
    
    var selectedCategory: Category? {
        didSet {
            loadItems();
        }
    };

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    override func viewDidLoad() {
        super.viewDidLoad();
//        loadItems();
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);

        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title;
            cell.accessoryType = item.done ? .checkmark : .none;
        } else {
            cell.textLabel?.text = "No Items Added";
        }
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done;
                }
            } catch {
                print("ERR: Can't update!");
            }
        }
        tableView.deselectRow(at: indexPath, animated: true);
        tableView.reloadData();
    };
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField();
        
        let alert = UIAlertController(title: "ADD IT", message: "This is what we should add", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens on click of button
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item();
                        newItem.title = textField.text!;
                        currentCategory.items.append(newItem);
                    }
                } catch {
                    print("ERR: \(error)");
                }
            }
            self.tableView.reloadData();
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item";
            textField = alertTextField;
        }
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true);

        tableView.reloadData();
    }
}

//extension ToDoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request: NSFetchRequest<Item> = Item.fetchRequest();
//
//        let predicate = NSPredicate(format: "title CONTAINS[c] %@", searchBar.text!);
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)];
//
//        loadItems(with: request, searchPredicate: predicate);
//
//        tableView.reloadData();
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let request: NSFetchRequest<Item> = Item.fetchRequest();
//
//        let predicate = NSPredicate(format: "title CONTAINS[c] %@", searchBar.text!);
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)];
//
//        if (searchBar.text! != "") {
//            loadItems(with: request, searchPredicate: predicate);
//        } else {
//            loadItems();
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder();
//            }
//        }
//
//        tableView.reloadData();
//    }
//}
