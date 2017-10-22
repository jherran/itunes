//
//  ListTableViewCell.swift
//  itunes
//
//  Created by Jose A. Herran on 11/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistGenre: UILabel!
    @IBOutlet weak var discographyTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var presenter: ListPresenter?
    var artist: ListArtist?
    
    class func cellIdentifier() -> String {
        return "ListTableViewCellIdentifier"
    }
    
    // MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // settings view
        configureTableView()
    }
    
    func configureCell(artist: ListArtist) {
        self.artist = artist
        artistName.text = artist.artistName
        artistGenre.text = artist.primaryGenreName != nil ? artist.primaryGenreName : "---"
        calculateRowHeight()
        discographyTableView.reloadData()
    }
    
    func configureTableView() {
        let cell = UINib(nibName: "RecordTableViewCell", bundle: nil)
        discographyTableView.register(cell, forCellReuseIdentifier: RecordTableViewCell.cellIdentifier())
    }
    
    func calculateRowHeight() {
        if let count = artist?.discography?.count {
            switch count {
            case 0:
                tableViewHeight.constant = 0
            case 1:
                tableViewHeight.constant = 60
            case 2:
                tableViewHeight.constant = 90
            default:
                tableViewHeight.constant = 120
            }
        } else {
            tableViewHeight.constant = 0
        }
    }
}

extension ListTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.cellIdentifier(), for: indexPath) as! RecordTableViewCell
        cell.configureCell(record: indexPath.row == 2 ? "Mas..." : (artist?.discography?[indexPath.row].collectionName)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let discography = artist?.discography {
            return (discography.count > 2) ? 3 : discography.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let discography = artist?.discography {
            return (discography.count > 0) ? "Discografía" : nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

extension ListTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToDetailWith(artist: artist!)
    }
}
