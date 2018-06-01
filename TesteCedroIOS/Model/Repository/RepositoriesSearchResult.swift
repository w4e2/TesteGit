//
//  RepositoriesSearchResult.swift
//
//  Created by pc on 31/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RepositoriesSearchResult: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let incompleteResults = "incomplete_results"
    static let totalCount = "total_count"
    static let items = "items"
  }

  // MARK: Properties
  public var incompleteResults: Bool? = false
  public var totalCount: Int?
  public var items: [Items]?
    public var page: Int = 1

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }
    func merge(result: RepositoriesSearchResult) {
        self.items?.append(contentsOf: result.items!)
        self.incompleteResults = result.incompleteResults
        self.totalCount = result.totalCount
        self.page = self.page + 1
    }
  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    incompleteResults = json[SerializationKeys.incompleteResults].boolValue
    totalCount = json[SerializationKeys.totalCount].int
    if let items = json[SerializationKeys.items].array { self.items = items.map { Items(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.incompleteResults] = incompleteResults
    if let value = totalCount { dictionary[SerializationKeys.totalCount] = value }
    if let value = items { dictionary[SerializationKeys.items] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.incompleteResults = aDecoder.decodeBool(forKey: SerializationKeys.incompleteResults)
    self.totalCount = aDecoder.decodeObject(forKey: SerializationKeys.totalCount) as? Int
    self.items = aDecoder.decodeObject(forKey: SerializationKeys.items) as? [Items]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(incompleteResults, forKey: SerializationKeys.incompleteResults)
    aCoder.encode(totalCount, forKey: SerializationKeys.totalCount)
    aCoder.encode(items, forKey: SerializationKeys.items)
  }

}
