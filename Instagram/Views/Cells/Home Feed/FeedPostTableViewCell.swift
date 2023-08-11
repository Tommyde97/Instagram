//
//  FeedPostTableViewCell.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/10/23.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell {

    static let identifier  = "FeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //Configure the cell
    }
}
