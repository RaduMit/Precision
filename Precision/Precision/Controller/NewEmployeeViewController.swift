//
//  NewEmployeeViewController.swift
//  Precision
//
//  Created by Radu Mitrea on 25/11/2019.
//  Copyright © 2019 Radu Mitrea. All rights reserved.
//

import UIKit

class NewEmployeeViewController: UIViewController {

    var nameArray = ["First Name","Last Name"]
    var employeeArray = [String]()
    var employeeLastNameArray = [String]()

    var completeName = String()
    var isCanceled = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeNavBar()
    }
    
    func customizeNavBar() {
//                navigationController?.navigationBar.topItem?.hidesBackButton = true
//                navigationItem.setHidesBackButton(true, animated: false)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onBack(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = saveButton
    }

    
    @objc
    func insertNewObject(_ sender: Any) {
        isCanceled = false
        guard let firstName = employeeArray.last else {
            showAlert(withTitle: "Error", withMessage: "Please fill in the text field with your First Name")
            return
        }
        guard let lastName = employeeLastNameArray.last else {
            showAlert(withTitle: "Error", withMessage: "Please fill in the text field with your Last Name")
            return
        }

        self.completeName = "\(firstName) \(lastName)"
        self.performSegue(withIdentifier: "unwindNewEmployee", sender: self)
    }
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindNewEmployee" {
            if let nextViewController = segue.destination as? MasterViewController {
                nextViewController.isCanceled = isCanceled

                if !isCanceled {
                    nextViewController.isCanceled = isCanceled
                    nextViewController.completeName = [completeName]
                }
            }
        }
    }
    
    @objc
    func onBack(_ sender: AnyObject) {
        isCanceled = true
        self.performSegue(withIdentifier: "unwindNewEmployee", sender: self)
        
    }
}



extension NewEmployeeViewController: UITableViewDelegate, UITableViewDataSource  {
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! EmployeeTableViewCell
        
        let names = nameArray[indexPath.row]
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

extension NewEmployeeViewController: UITextFieldDelegate {
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
