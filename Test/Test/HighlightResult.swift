//
//  HighlightResult.swift
//
//  Created by prafulla on 30/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class HighlightResult: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let author = "author"
    static let url = "url"
    static let storyText = "story_text"
  }

  // MARK: Properties
  public var title: Title?
  public var author: Author?
  public var url: Url?
  public var storyText: StoryText?

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
    title = Title(json: json[SerializationKeys.title])
    author = Author(json: json[SerializationKeys.author])
    url = Url(json: json[SerializationKeys.url])
    storyText = StoryText(json: json[SerializationKeys.storyText])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value.dictionaryRepresentation() }
    if let value = author { dictionary[SerializationKeys.author] = value.dictionaryRepresentation() }
    if let value = url { dictionary[SerializationKeys.url] = value.dictionaryRepresentation() }
    if let value = storyText { dictionary[SerializationKeys.storyText] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? Title
    self.author = aDecoder.decodeObject(forKey: SerializationKeys.author) as? Author
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? Url
    self.storyText = aDecoder.decodeObject(forKey: SerializationKeys.storyText) as? StoryText
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(author, forKey: SerializationKeys.author)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(storyText, forKey: SerializationKeys.storyText)
  }

}
