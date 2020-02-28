//
//  FeedViewController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

final class FeedViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        showPostAlertView()
    }
    
    private let tableRefreshControl = UIRefreshControl()
    private lazy var postAlertView = PostAlertView()
    
    private let dataProvider = FeedDataProvider()
    private var fetchedObjects = [FeedItemModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setValues()
        fetchData(state: .loadMore)
    }
    
    func setupUI() {
        tableRefreshControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        table.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    func setValues() {
        dataProvider.delegate = self
        fetchedObjects = dataProvider.feedItems
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        fetchData(state: .refresh)
    }
    
    private func fetchData(state: FetchState) {
        dataProvider.fetchItems(state: state)
    }
    
}


// MARK: - Table view data source

extension FeedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        let object = fetchedObjects[indexPath.item]
        cell.dateLabel.text = object.date
        cell.postTextLabel.text = object.text
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == fetchedObjects.count - 2 {
            fetchData(state: .loadMore)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StringSize.getHeight(from: fetchedObjects[indexPath.item])
    }
    
}

extension FeedViewController: DataProviderProtocol {
    
    func didFailWithError(error: String) {
        let errorAlert = ErrorAlertController(withTitle: "Warning", message: error, actionTitle: "OK")
        present(errorAlert, animated: true, completion: { [weak self] in
            guard let self = self else { return }
            if self.tableRefreshControl.isRefreshing {
                self.tableRefreshControl.endRefreshing()
                if !self.fetchedObjects.isEmpty {
                    let topIndex = IndexPath(row: 0, section: 0)
                    self.table.scrollToRow(at: topIndex, at: .top, animated: true)
                }
            }
        })
    }
    
    func didFetchData(updated: Bool, fetchSource: FetchSource) {
        
        if fetchSource == .network, tableRefreshControl.isRefreshing {
            tableRefreshControl.endRefreshing()
        }
        
        if updated {
            self.fetchedObjects = self.dataProvider.feedItems
            self.table.reloadData()
        }
    }
    
}

extension FeedViewController: PostAlertDelegate {
    
    func postButtonTapped(message: String) {
        dataProvider.post(message: message) { [weak self] (error) in
            guard let self = self else { return }
            if error == nil, self.postAlertView.isDescendant(of: self.view) {
                self.postAlertView.removeFromSuperview()
            } else {
                self.didFailWithError(error: error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    func showPostAlertView() {
        if !postAlertView.isDescendant(of: view) {
            postAlertView = PostAlertView()
            postAlertView.delegate = self
            view.addSubview(postAlertView)
            postAlertView.translatesAutoresizingMaskIntoConstraints = false
            postAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            postAlertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.bounds.height / 10)).isActive = true
            postAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
            view.trailingAnchor.constraint(equalTo: postAlertView.trailingAnchor, constant: 24).isActive = true
            postAlertView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3.5).isActive = true
        }
    }
    
}
