//
//  StemWordsTableViewCell.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import UIKit

class StemWordsHistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var stemWordLabel: UILabel!
    @IBOutlet weak var occurranceLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public API
    func configure(with presentable: StemWordPresentable) {
        stemWordLabel.text = presentable.stemWord
        stemWordLabel.textColor = window?.tintColor
        
        occurranceLabel.text = String(presentable.occurrance)
    }


}
