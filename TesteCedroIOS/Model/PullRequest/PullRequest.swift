//
//  PullRequest.swift
//
//  Created by pc on 31/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PullRequest: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let user = "user"
    static let title = "title"
    static let htmlUrl = "html_url"
    static let createdAt = "created_at"
  }

  // MARK: Properties
  public var user: User?
  public var title: String?
  public var htmlUrl: String?
  public var createdAt: String?

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
    user = User(json: json[SerializationKeys.user])
    title = json[SerializationKeys.title].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    createdAt = json[SerializationKeys.createdAt].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
  }

}
