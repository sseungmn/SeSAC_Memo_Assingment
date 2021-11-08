//
//  MemoTableViewCell.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    static let identifier = "MemoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak var writeDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // asslignment
        stackView.spacing = 10
        writeDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // attribute
        self.backgroundColor = .clear
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        writeDateLabel.font = .systemFont(ofSize: 13)
        writeDateLabel.textColor = .gray
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
