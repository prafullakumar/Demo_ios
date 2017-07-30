//
//  BaseModel.swift
//
//  Created by prafulla on 30/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let hitsPerPage = "hitsPerPage"
    static let nbHits = "nbHits"
    static let hits = "hits"
    static let page = "page"
    static let params = "params"
    static let processingTimeMS = "processingTimeMS"
    static let query = "query"
    static let exhaustiveNbHits = "exhaustiveNbHits"
    static let nbPages = "nbPages"
  }

  // MARK: Properties
  public var hitsPerPage: Int?
  public var nbHits: Int?
  public var hits: [Hits]?
  public var page: Int?
  public var params: String?
  public var processingTimeMS: Int?
  public var query: String?
  public var exhaustiveNbHits: Bool? = false
  public var nbPages: Int?

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
    hitsPerPage = json[SerializationKeys.hitsPerPage].int
    nbHits = json[SerializationKeys.nbHits].int
    if let items = json[SerializationKeys.hits].array { hits = items.map { Hits(json: $0) } }
    page = json[SerializationKeys.page].int
    params = json[SerializationKeys.params].string
    processingTimeMS = json[SerializationKeys.processingTimeMS].int
    query = json[SerializationKeys.query].string
    exhaustiveNbHits = json[SerializationKeys.exhaustiveNbHits].boolValue
    nbPages = json[SerializationKeys.nbPages].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = hitsPerPage { dictionary[SerializationKeys.hitsPerPage] = value }
    if let value = nbHits { dictionary[SerializationKeys.nbHits] = value }
    if let value = hits { dictionary[SerializationKeys.hits] = value.map { $0.dictionaryRepresentation() } }
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = params { dictionary[SerializationKeys.params] = value }
    if let value = processingTimeMS { dictionary[SerializationKeys.processingTimeMS] = value }
    if let value = query { dictionary[SerializationKeys.query] = value }
    dictionary[SerializationKeys.exhaustiveNbHits] = exhaustiveNbHits
    if let value = nbPages { dictionary[SerializationKeys.nbPages] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.hitsPerPage = aDecoder.decodeObject(forKey: SerializationKeys.hitsPerPage) as? Int
    self.nbHits = aDecoder.decodeObject(forKey: SerializationKeys.nbHits) as? Int
    self.hits = aDecoder.decodeObject(forKey: SerializationKeys.hits) as? [Hits]
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? Int
    self.params = aDecoder.decodeObject(forKey: SerializationKeys.params) as? String
    self.processingTimeMS = aDecoder.decodeObject(forKey: SerializationKeys.processingTimeMS) as? Int
    self.query = aDecoder.decodeObject(forKey: SerializationKeys.query) as? String
    self.exhaustiveNbHits = aDecoder.decodeBool(forKey: SerializationKeys.exhaustiveNbHits)
    self.nbPages = aDecoder.decodeObject(forKey: SerializationKeys.nbPages) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(hitsPerPage, forKey: SerializationKeys.hitsPerPage)
    aCoder.encode(nbHits, forKey: SerializationKeys.nbHits)
    aCoder.encode(hits, forKey: SerializationKeys.hits)
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(params, forKey: SerializationKeys.params)
    aCoder.encode(processingTimeMS, forKey: SerializationKeys.processingTimeMS)
    aCoder.encode(query, forKey: SerializationKeys.query)
    aCoder.encode(exhaustiveNbHits, forKey: SerializationKeys.exhaustiveNbHits)
    aCoder.encode(nbPages, forKey: SerializationKeys.nbPages)
  }

}
