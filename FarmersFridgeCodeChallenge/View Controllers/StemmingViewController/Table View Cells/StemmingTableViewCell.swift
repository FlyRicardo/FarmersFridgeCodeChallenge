//
//  StemmingTableViewCell.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import UIKit

class StemmingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var stemWordLabel: UILabel!
    @IBOutlet weak var ocurranceLabel: UILabel!
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: StemWord) {
        stemWordLabel.text = model.stemWord
        stemWordLabel.textColor = window?.tintColor
        
        ocurranceLabel.text = String(model.occurrance)
    }

}
