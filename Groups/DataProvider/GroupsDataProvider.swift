//
//  GroupsManager.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

//protocol


final class GroupsDataProvider {
    

    private let realmManager = DBService.shared
    private var offlineDataFetched = false
    private var isInitialFetch = true
    private var isFetchInProgress = false
    private var count = 0
    private var maxGroupCount = 20 // max amount of user's groups --- vk api response
    
    weak var delegate : DataProviderProtocol?
    
    var groupsItems = [GroupItemModel]()
    
    func fetchItems(state: FetchState) {
        
        fetchOfflineData { [weak self] in
            guard let self = self, !self.isFetchInProgress else {
                return
            }
            print(self.groupsItems)
            self.fetchNetworkData(state: state)
        }
    }
    
    
    private func fetchNetworkData(state: FetchState) {
        
        
        if count >= maxGroupCount {
            delegate?.didFetchData(updated: false, fetchSource: .network)
            return
        }
        
        isFetchInProgress = true
        
        var count = groupsItems.count
        var offset = 0
        
        if state == .loadMore {
            count = 20
            offset = groupsItems.count
        }
        
        
        APIClient.shared.request(to: GroupsRoute.getRoute(count: count, offset: offset)) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isFetchInProgress = false
            
            if error != nil {
                self.delegate?.didFailWithError(error: error?.localizedDescription ?? "")
                return
            }
            
            
            if let groups = result  {
                
                self.maxGroupCount = groups?.response?.count ?? 0
                
                switch state {
                case .refresh:
                    self.groupsItems = groups?.response?.items ?? []
                    
                case .loadMore:
                    if self.isInitialFetch {
                        self.isInitialFetch = false
                        self.groupsItems = groups?.response?.items ?? []
                        
                    } else {
                        self.groupsItems.append(contentsOf: groups?.response?.items ?? [])
                    }
                }
                
                self.realmManager.updateData(group: self.groupsItems)
                self.delegate?.didFetchData(updated: true, fetchSource: .network)
                
            } else {
                self.delegate?.didFetchData(updated: false, fetchSource: .network)
            }
            
        }
        
    }
    
    
    private func fetchOfflineData(completion: @escaping () -> ()) {
        if !offlineDataFetched {
            realmManager.getGroupsFromDB(completion: { [weak self] (items) in
                guard let self = self else { return }
                self.groupsItems = items
                self.offlineDataFetched = true
                self.delegate?.didFetchData(updated: true, fetchSource: .offline)
                completion()
            })
            
        } else {
            completion()
        }
    }
}
