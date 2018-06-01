//
//  User.swift
//
//  Created by pc on 31/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class User: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let login = "login"
    static let avatarUrl = "avatar_url"
  }

  // MARK: Properties
  public var login: String?
  public var avatarUrl: String?

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
    login = json[SerializationKeys.login].string
    avatarUrl = json[SerializationKeys.avatarUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = login { dictionary[SerializationKeys.login] = value }
    if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.login = aDecoder.decodeObject(forKey: SerializationKeys.login) as? String
    self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(login, forKey: SerializationKeys.login)
    aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
  }

}
