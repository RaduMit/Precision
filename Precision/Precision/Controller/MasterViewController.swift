//
//  MasterViewController.swift
//  Precision
//
//  Created by Radu Mitrea on 25/11/2019.
//  Copyright © 2019 Radu Mitrea. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: EmployeeDetailsViewController? = nil
    var objects = [Any]()
    var completeName = [String]()
    var isCanceled = Bool()
    var selectedIndexPath: IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? EmployeeDetailsViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        guard let collapsedView = self.splitViewController else { return }
        self.clearsSelectionOnViewWillAppear = collapsedView.isCollapsed

        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "newEmployee", sender: self)
    }
    
    @IBAction func unwindToMaster(segue:UIStoryboardSegue) {
        if isCanceled == false {
            objects.insert(completeName[0], at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToEmployees(segue:UIStoryboardSegue) {
        guard let selectedIndex = selectedIndexPath?.row else { return }

        objects[selectedIndex] = completeName[0]
        tableView.reloadData()

        
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! String
                let controller = (segue.destination as! UINavigationController).topViewController as! EmployeeDetailsViewController
                controller.detailItem = object
                guard let selectedIndex = selectedIndexPath?.row else { return }
                controller.actualNames = (objects[selectedIndex] as? String)!
                controller.navigationItem.leftItemsSupplementBackButton = false
            }
        }
        
        if segue.identifier == "newEmployee" {

        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "showDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

