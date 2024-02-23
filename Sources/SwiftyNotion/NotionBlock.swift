//
//  NotionBlock.swift
//  
//
//  Created by James Saeed on 2021-06-30.
//

import Foundation

public struct NotionBlock: NotionObject {
    public let id: String
    public let createdTime: String
    public let lastEditedTime: String
    
    public let type: BlockType
    
    public let paragraph: BlockParagraph?
    public let heading1: BlockHeading1?
    public let heading2: BlockHeading2?
    public let heading3: BlockHeading3?
    public let bulletedListItem: BlockBulletedListItem?
    public let numberedListItem: BlockNumberedListItem?
    public let toDo: BlockToDo?
    public let toggle: BlockToggle?
    public let childPage: BlockPage?
    public let code: NotionCode?
    public let hasChildren: Bool
}

public enum BlockType: String, Decodable {
    case paragraph, toggle, unsupported, code, image, bookmark, quote, table, divider, column, file
    
    case heading1 = "heading_1"
    case heading2 = "heading_2"
    case heading3 = "heading_3"
    case bulletedListItem = "bulleted_list_item"
    case numberedListItem = "numbered_list_item"
    case toDo = "to_do"
    case childPage = "child_page"
    case childDatabase = "child_database"
    case tableRow = "table_row"
    case columnList = "column_list"
}

public struct BlockParagraph: Decodable {
    public let text: [NotionRichText]
    public let children: [NotionBlock]?
}

public struct BlockHeading1: Decodable {
    public let text: [NotionRichText]
}

public struct BlockHeading2: Decodable {
    public let text: [NotionRichText]
}

public struct BlockHeading3: Decodable {
    public let text: [NotionRichText]
}

public struct BlockBulletedListItem: Decodable {
    public let text: [NotionRichText]
    public let children: [NotionBlock]?
}

public struct BlockNumberedListItem: Decodable {
    public let text: [NotionRichText]
    public let children: [NotionBlock]?
}

public struct BlockToDo: Decodable {
    public let text: [NotionRichText]
    public let children: [NotionBlock]?
    public let checked: Bool?
}

public struct BlockToggle: Decodable {
    public let text: [NotionRichText]
    public let children: [NotionBlock]?
}

public struct BlockPage: Decodable {
    public let title: String
}
