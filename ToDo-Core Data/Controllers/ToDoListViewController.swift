//
//  ViewController.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = Array<Item>();
    
    var selectedCategory: Category? {
        didSet {
            loadItems();
        }
    };
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    override func viewDidLoad() {
        super.viewDidLoad();
        loadItems();
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        cell.textLabel?.text = itemArray[indexPath.row].title;
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let newVal = !itemArray[indexPath.row].done;
        itemArray[indexPath.row].setValue(newVal, forKey: "done");
//        context.delete(itemArray[indexPath.row]);
//        itemArray.remove(at: indexPath.row);

        saveItems();
    };
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField();
        
        let alert = UIAlertController(title: "ADD IT", message: "This is what we should add", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens on click of button
            let newItem = Item(context: self.context);
            newItem.title = textField.text!;
            newItem.pCat = self.selectedCategory;
            self.itemArray.append(newItem);
            self.saveItems()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item";
            textField = alertTextField;
        }
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
    func saveItems() {
        do {
            try context.save();
        } catch {
            print("Having a bad day! \(error)");
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), searchPredicate: NSPredicate? = nil) {
        
        let predicate = NSPredicate(format: "pCat.name MATCHES %@", selectedCategory!.name!);
        
        if let trueSearch = searchPredicate {
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicate, trueSearch] );
            request.predicate = compoundPredicate;
        } else {
            request.predicate = predicate
        }
        
        do {
            itemArray = try context.fetch(request).filter({ val in
                val.title != "";
            });
        } catch {
            print("ERR: \(error)");
        }
    }
}

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest();

        let predicate = NSPredicate(format: "title CONTAINS[c] %@", searchBar.text!);
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)];
        
        loadItems(with: request, searchPredicate: predicate);
 
        tableView.reloadData();
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let request: NSFetchRequest<Item> = Item.fetchRequest();
        
        let predicate = NSPredicate(format: "title CONTAINS[c] %@", searchBar.text!);
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)];

        if (searchBar.text! != "") {
            loadItems(with: request, searchPredicate: predicate);
        } else {
            loadItems();
        
            DispatchQueue.main.async {
                searchBar.resignFirstResponder();
            }
        }
        
        tableView.reloadData();
    }
}
