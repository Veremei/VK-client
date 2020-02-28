//
//  CommunitiesViewController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/11/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit
import Kingfisher

final class GroupsViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    private let tableRefreshControl = UIRefreshControl()
    
    private let dataProvider = GroupsDataProvider()
    private var fetchedObjects = [GroupItemModel]()
    
    
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
        table.allowsSelection = false
    }
    
    func setValues() {
        dataProvider.delegate = self
        fetchedObjects = dataProvider.groupsItems
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData(state: .refresh)
    }
    
    func fetchData(state: FetchState) {
        dataProvider.fetchItems(state: state)
    }
    
}


// MARK: - Table view data source

extension GroupsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsCell
        
        let item = fetchedObjects[indexPath.row]
        cell.groupNameLabel.text = item.name
        
        if let imageUrl = item.photo, let url = URL(string: imageUrl) {
            cell.groupImageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { result in
                switch result {
                case .success(_):
                    cell.setNeedsLayout()
                case .failure(_):
                    return
                }
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == fetchedObjects.count - 1 {
            fetchData(state: .loadMore)
        }
    }
    
}


// MARK: - DataProviderProtocol

extension GroupsViewController: DataProviderProtocol {
    
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
            fetchedObjects = dataProvider.groupsItems
            table.reloadData()
        }
    }
    
}
