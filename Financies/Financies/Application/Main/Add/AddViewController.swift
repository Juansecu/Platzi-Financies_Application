//
//  AddTableViewController.swift
//  PlatziFinanzas
//
//  Created by Andres Silva on 12/5/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var transactionNameLabel: UITextField!
    @IBOutlet weak var transactionDescriptionLabel: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    private var viewModel = AddTransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        valueTextField.becomeFirstResponder()
    }

    @IBAction func addTransaction(_ sender: UIButton) {
        viewModel.add(
            name: transactionNameLabel.text ?? "new add",
            description: transactionDescriptionLabel.text ?? "",
            value: valueTextField.text ?? "0"
        )
        
        valueTextField.resignFirstResponder()
        tabBarController?.selectedIndex = 0
    }
}
