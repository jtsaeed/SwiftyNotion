//
//  NotionRichText.swift
//  
//
//  Created by James Saeed on 2021-06-30.
//

import Foundation
// import UIKit

// TODO: Support all rich text types

public struct NotionRichText: Decodable {
    public let type: RichTextType
    public let annotations: RichTextAnnotations
    public let plainText: String
    public let href: String?
}

public enum RichTextType: String, Decodable {
    case text, mention, equation
}

public struct RichTextAnnotations: Decodable {
    public let bold: Bool
    public let italic: Bool
    public let strikethrough: Bool
    public let underline: Bool
    public let code: Bool
    
    // TODO: Make this an enum
    public let color: String
}

enum RichTextColor: String, Decodable {
    case gray
}
