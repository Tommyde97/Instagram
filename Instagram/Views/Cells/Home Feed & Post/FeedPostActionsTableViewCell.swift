//
//  FeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/10/23.
//

import UIKit

class FeedPostActionsTableViewCell: UITableViewCell {

    static let identifier  = "FeedPostActionsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //Configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
