//
//  ListViewController.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var presenter: ListPresenter?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        title = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String
        let cell = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: ListTableViewCell.cellIdentifier())
        tableView.estimatedRowHeight = 74.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension ListViewController: ListPresenterOutput {
    func listRetrieved() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func listError(error: String?) {
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        self.loadingIndicator.stopAnimating()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier(), for: indexPath) as! ListTableViewCell
        cell.presenter = presenter
        cell.configureCell(artist: (presenter?.listArray[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.listArray.count)!
    }
        
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            loadingIndicator.startAnimating()
            presenter?.getListWith(term: term)
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.listArray = []
        tableView.reloadData()
    }
}
