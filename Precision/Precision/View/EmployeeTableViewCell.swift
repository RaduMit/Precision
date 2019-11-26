//
//  EmployeeTableViewCell.swift
//  Precision
//
//  Created by Radu Mitrea on 25/11/2019.
//  Copyright © 2019 Radu Mitrea. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameDescriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextField.autocorrectionType = .no
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

