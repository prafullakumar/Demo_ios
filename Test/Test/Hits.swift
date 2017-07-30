//
//  Hits.swift
//
//  Created by prafulla on 30/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Hits: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let points = "points"
    static let parentId = "parent_id"
    static let highlightResult = "_highlightResult"
    static let tags = "_tags"
    static let objectID = "objectID"
    static let numComments = "num_comments"
    static let author = "author"
    static let createdAtI = "created_at_i"
    static let createdAt = "created_at"
    static let title = "title"
    static let url = "url"
    static let storyText = "story_text"
  }

  // MARK: Properties
  public var points: Int?
  public var parentId: Int?
  public var highlightResult: HighlightResult?
  public var tags: [String]?
  public var objectID: String?
  public var numComments: Int?
  public var author: String?
  public var createdAtI: Int?
  public var createdAt: String?
  public var title: String?
  public var url: String?
  public var storyText: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    points = json[SerializationKeys.points].int
    parentId = json[SerializationKeys.parentId].int
    highlightResult = HighlightResult(json: json[SerializationKeys.highlightResult])
    if let items = json[SerializationKeys.tags].array { tags = items.map { $0.stringValue } }
    objectID = json[SerializationKeys.objectID].string
    numComments = json[SerializationKeys.numComments].int
    author = json[SerializationKeys.author].string
    createdAtI = json[SerializationKeys.createdAtI].int
    createdAt = json[SerializationKeys.createdAt].string
    title = json[SerializationKeys.title].string
    url = json[SerializationKeys.url].string
    storyText = json[SerializationKeys.storyText].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = points { dictionary[SerializationKeys.points] = value }
    if let value = parentId { dictionary[SerializationKeys.parentId] = value }
    if let value = highlightResult { dictionary[SerializationKeys.highlightResult] = value.dictionaryRepresentation() }
    if let value = tags { dictionary[SerializationKeys.tags] = value }
    if let value = objectID { dictionary[SerializationKeys.objectID] = value }
    if let value = numComments { dictionary[SerializationKeys.numComments] = value }
    if let value = author { dictionary[SerializationKeys.author] = value }
    if let value = createdAtI { dictionary[SerializationKeys.createdAtI] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = storyText { dictionary[SerializationKeys.storyText] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.points = aDecoder.decodeObject(forKey: SerializationKeys.points) as? Int
    self.parentId = aDecoder.decodeObject(forKey: SerializationKeys.parentId) as? Int
    self.highlightResult = aDecoder.decodeObject(forKey: SerializationKeys.highlightResult) as? HighlightResult
    self.tags = aDecoder.decodeObject(forKey: SerializationKeys.tags) as? [String]
    self.objectID = aDecoder.decodeObject(forKey: SerializationKeys.objectID) as? String
    self.numComments = aDecoder.decodeObject(forKey: SerializationKeys.numComments) as? Int
    self.author = aDecoder.decodeObject(forKey: SerializationKeys.author) as? String
    self.createdAtI = aDecoder.decodeObject(forKey: SerializationKeys.createdAtI) as? Int
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.storyText = aDecoder.decodeObject(forKey: SerializationKeys.storyText) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(points, forKey: SerializationKeys.points)
    aCoder.encode(parentId, forKey: SerializationKeys.parentId)
    aCoder.encode(highlightResult, forKey: SerializationKeys.highlightResult)
    aCoder.encode(tags, forKey: SerializationKeys.tags)
    aCoder.encode(objectID, forKey: SerializationKeys.objectID)
    aCoder.encode(numComments, forKey: SerializationKeys.numComments)
    aCoder.encode(author, forKey: SerializationKeys.author)
    aCoder.encode(createdAtI, forKey: SerializationKeys.createdAtI)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(storyText, forKey: SerializationKeys.storyText)
  }

}
