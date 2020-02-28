//
//  GroupsDBManager.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/19/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit
import RealmSwift

class DBService {
    
    private var database: Realm
    static let shared = DBService()
    
    private init() {
        database = try! Realm()
    }
    
    func getGroupsFromDB(completion: @escaping ([GroupItemModel]) -> ()) {
        
        let results = database.objects(RealmGroupItemModel.self)
        var groupItems = [GroupItemModel]()
        
        results.toArray().forEach { (group) in
            let groupItem = GroupItemModel(name: group.name, photo: group.photo)
            print(groupItem)

            groupItems.append(groupItem)
        }
        
        completion(groupItems)
    }
    
    func getPostsFromDB(completion: @escaping ([FeedItemModel]) -> ()){
        
        let results: Results<RealmFeedItemModel> = database.objects(RealmFeedItemModel.self)
        var feedItems = [FeedItemModel]()
        
        results.toArray().forEach { (post) in
            let feedItem = FeedItemModel(date: post.date, text: post.text)
            feedItems.append(feedItem)
        }
        
        completion(feedItems)
    }
    
    
    func removeAll()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func updateData(group objects: [GroupItemModel]) {
        let realmObjects = database.objects(RealmGroupItemModel.self)
        print(realmObjects)
        try! database.write {
            database.delete(realmObjects)
            
            objects.forEach { (item) in
                let realmObject = RealmGroupItemModel()
                realmObject.name = item.name
                realmObject.photo = item.photo
                database.add(realmObject)
            }
        }
    }
    
    func updateData(feed objects: [FeedItemModel]) {
        let realmObjects = database.objects(RealmFeedItemModel.self)

        try! database.write {
            database.delete(realmObjects)

            objects.forEach { (item) in
                let realmObject = RealmFeedItemModel()
                realmObject.date = item.date
                realmObject.text = item.text
                database.add(realmObject)
            }
        }
    }
    
}
