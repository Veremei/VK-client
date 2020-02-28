//
//  FeedModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/13/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation

// MARK: - Feed
struct FeedModel: Codable {
    let response: FeedResponse?
}

// MARK: - Response
struct FeedResponse: Codable {
    let count: Int?
    let items: [FeedItem]?
}

// MARK: - Item
struct FeedItem: Codable {
    let date: Int?
    let text: String?
    let copyHistory: [CopyHistory]?
    let attachments: [ItemAttachment]?

    enum CodingKeys: String, CodingKey {
        case date
        case text
        case copyHistory = "copy_history"
        case attachments
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let photo: AttachmentPhoto?
}

// MARK: - AttachmentPhoto
struct AttachmentPhoto: Codable {
    let text: String?
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let text: String?
}
