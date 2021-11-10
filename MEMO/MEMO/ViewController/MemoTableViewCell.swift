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
//        stackView.distribution = .fill
//        writeDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
//        contentLabel.setcontent
        
        // attribute
        titleLabel.font = .cellTitle
        
        writeDateLabel.font = .cellContent
        contentLabel.font = .cellContent
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
