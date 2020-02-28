//
//  FeedManager.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

//protocol delegate


final class FeedDataProvider {
    
    private let realmManager = DBService.shared
    private var offlineDataFetched = false
    private var isInitialFetch = true
    private var isFetchInProgress = false
    private var count = 0
    private var maxPostsCount = 20 // max amount of user's groups --- vk api response
    
    weak var delegate : DataProviderProtocol?
    
    var feedItems = [FeedItemModel]()
    
    func fetchItems(state: FetchState) {
        
        fetchOfflineData { [weak self] in
            guard let self = self else { return }
            self.fetchNetworkData(state: state)
        }
    }
    
    func post(message: String, completion: @escaping (Error?) -> ()) {
        APIClient.shared.request(to: WallPostRoute.getRoute(message: message)) { (result, error) in
            completion(error)
        }
    }
    
    private func fetchNetworkData(state: FetchState) {
        
        if count >= maxPostsCount {
            delegate?.didFetchData(updated: false, fetchSource: .network)
            return
        }
        
        isFetchInProgress = true
        
        var count = feedItems.count
        var offset = 0
        
        if state == .loadMore {
            count = 20
            offset = feedItems.count
        }
        
        APIClient.shared.request(to: FeedRoute.getRoute(count: count, offset: offset)) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isFetchInProgress = false
            
            if error != nil {
                self.delegate?.didFailWithError(error: error?.localizedDescription ?? "")
                return
            }
            
            
            if let feed = result  {
                
                self.maxPostsCount = feed?.response?.count ?? 0
                let mappedFeedItems : [FeedItemModel]? = (feed?.response?.items?.compactMap({ FeedItemModel(element: $0) }))?.filter({ !($0.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! })
                
                switch state {
                case .refresh:
                    self.feedItems = mappedFeedItems ?? []
                    
                case .loadMore:
                    if self.isInitialFetch {
                        self.isInitialFetch = false
                        self.feedItems = mappedFeedItems ?? []
                        
                    } else {
                        self.feedItems.append(contentsOf: mappedFeedItems ?? [])
                    }
                }
                self.realmManager.updateData(feed: self.feedItems)
                self.delegate?.didFetchData(updated: true, fetchSource: .network)
                
            } else {
                self.delegate?.didFetchData(updated: false, fetchSource: .network)
            }
            
        }
    }
    
    private func fetchOfflineData(completion: @escaping () -> ()) {
        if !offlineDataFetched {
            realmManager.getPostsFromDB(completion: { [weak self] (items) in
                guard let self = self else { return }
                self.feedItems = items
                self.offlineDataFetched = true
                self.delegate?.didFetchData(updated: true, fetchSource: .offline)
                completion()
            })
            
        } else {
            completion()
        }
    }
    
}
