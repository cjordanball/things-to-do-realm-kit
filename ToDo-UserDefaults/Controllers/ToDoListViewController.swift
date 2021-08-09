//
//  ViewController.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = Array<Item>();
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist");

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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done;
        saveItems();
    };
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "ADD IT", message: "This is what we should add", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens on clicke of button
            if let myVar = alert.textFields![0].text {
                if myVar != "" {
                    self.itemArray.append(Item(title: myVar));
                }
            }
            self.saveItems()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item";
        }
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder();
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Having a bad day!");
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder();
            do {
                itemArray = try decoder.decode([Item].self, from: data);
            } catch {
                print("ERR: \(error)");
            }
        }
    }
    
}
