//
//  RecordTableViewCell.swift
//  itunes
//
//  Created by Jose A. Herran on 21/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import UIKit


class RecordTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recordName: UILabel!
    
    class func cellIdentifier() -> String {
        return "RecordTableViewCellIdentifier"
    }
    
    // MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // settings view
    }
    
    func configureCell(record: String) {
        recordName.text = record
    }
}
