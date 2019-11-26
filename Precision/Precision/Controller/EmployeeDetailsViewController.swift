//
//  EmployeeDetailsViewController.swift
//  Precision
//
//  Created by Radu Mitrea on 25/11/2019.
//  Copyright © 2019 Radu Mitrea. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {

    var descriptionNameArray = ["First Name","Last Name"]
    var actualNames = String()
    var employeeArray = [String]()
    var employeeLastNameArray = [String]()
    
    var completeName = String()
    var nameArray = ["",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(title: "Employees", style: .plain, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.leftBarButtonItem = backButton
        nameArray = actualNames.components(separatedBy: " ")

    }

    var detailItem: String? {
        didSet {
            // Update the view.
        }
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        
        if employeeArray.last == nil {
            employeeArray.append(nameArray[0])
        }
        if employeeLastNameArray.last == nil {
            employeeLastNameArray.append(nameArray[1])
        }
        
        guard let firstName = employeeArray.last else { return }
        guard let lastName = employeeLastNameArray.last else { return }
        
        self.completeName = "\(firstName) \(lastName)"
        self.performSegue(withIdentifier: "unwindToEmployees", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToEmployees" {
            if let nextViewController = segue.destination as? MasterViewController {
                
                    nextViewController.completeName = [completeName]
            }
        }
    }

}
extension EmployeeDetailsViewController: UITableViewDelegate, UITableViewDataSource  {
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptionNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! EmployeeTableViewCell
        
        let names = descriptionNameArray[indexPath.row]
        if nameArray.count != 2 {
            nameArray.append("")
        } else {
            let nameslast = nameArray[indexPath.row]
            cell.nameTextField.text = nameslast
        }
        cell.nameDescriptionLabel.text = names

        cell.nameTextField.tag = indexPath.row
        cell.nameTextField.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}

extension EmployeeDetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let kActualText = (textField.text ?? "") + string
        switch textField.tag
        {
        case 0:
            employeeArray.append(kActualText)
        case 1:
            employeeLastNameArray.append(kActualText)
        default:
            print("It is nothing");
        }
        
        return true;
    }
    
}

