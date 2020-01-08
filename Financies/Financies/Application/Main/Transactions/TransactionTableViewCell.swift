//
//  TransactionTableViewCell.swift
//  Financies
//
//  Created by Juan on 1/8/20.
//  Copyright © 2020 Juan. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionDescriptionLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    
    var viewModel: TransactionViewModel! {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpView() {
        transactionNameLabel.text = viewModel.name
        transactionDateLabel.text = viewModel.date
        transactionTimeLabel.text = viewModel.time
        transactionValueLabel.text = viewModel.value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
