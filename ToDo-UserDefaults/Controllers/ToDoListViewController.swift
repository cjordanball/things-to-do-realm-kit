//
//  ViewController.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Balance Checkbook", "Pay Bills", "File Taxes"];

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        cell.textLabel?.text = itemArray[indexPath.row];
        return cell;
    }
}

