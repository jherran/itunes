//
//  DetailViewController.swift
//  itunes
//
//  Created by Jose A. Herran on 11/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var artist: ListArtist?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configView() {
        title = artist?.artistName
        let cell = UINib(nibName: "RecordDetailTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: RecordDetailTableViewCell.cellIdentifier())
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordDetailTableViewCell.cellIdentifier(), for: indexPath) as! RecordDetailTableViewCell
        cell.configureCell(record: (artist?.discography![indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (artist?.discography!.count)!
    }
    
}

