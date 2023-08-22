//
//  FeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/10/23.
//

import UIKit

class FeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier  = "FeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
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
