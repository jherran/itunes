//
//  RecordDetailTableViewCell.swift
//  itunes
//
//  Created by Jose A. Herran on 22/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import UIKit


class RecordDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recordImage: UIImageView!
    @IBOutlet weak var recordName: UILabel!
    @IBOutlet weak var recordDate: UILabel!
    
    class func cellIdentifier() -> String {
        return "RecordDetailTableViewCellIdentifier"
    }
    
    // MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // settings view
    }
    
    func configureCell(record: ListRecord) {
        recordImage.imageFrom(stringURL: record.artworkUrl60!)
        recordName.text = record.collectionName
        recordDate.text = record.releaseDate
    }
}
