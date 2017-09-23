//
//  BaseModel.swift
//
//  Created by prafull kumar on 23/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let modelIdentifier = "modelIdentifier"
    static let series = "series"
    static let name = "name"
    static let fuelType = "fuelType"
    static let licensePlate = "licensePlate"
    static let transmission = "transmission"
    static let color = "color"
    static let latitude = "latitude"
    static let id = "id"
    static let fuelLevel = "fuelLevel"
    static let innerCleanliness = "innerCleanliness"
    static let make = "make"
    static let longitude = "longitude"
    static let carImageUrl = "carImageUrl"
    static let group = "group"
    static let modelName = "modelName"
  }

  // MARK: Properties
  public var modelIdentifier: String?
  public var series: String?
  public var name: String?
  public var fuelType: String?
  public var licensePlate: String?
  public var transmission: String?
  public var color: String?
  public var latitude: Float?
  public var id: String?
  public var fuelLevel: Float?
  public var innerCleanliness: String?
  public var make: String?
  public var longitude: Float?
  public var carImageUrl: String?
  public var group: String?
  public var modelName: String?

  // new url logic
  public var imageUrlNew : String? {
    get {
        if (modelIdentifier == nil) || (color == nil) {
            return nil
        }
        return "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(self.modelIdentifier!)/\(self.color!)/2x/car.png"
    }
  }
    
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
    modelIdentifier = json[SerializationKeys.modelIdentifier].string
    series = json[SerializationKeys.series].string
    name = json[SerializationKeys.name].string
    fuelType = json[SerializationKeys.fuelType].string
    licensePlate = json[SerializationKeys.licensePlate].string
    transmission = json[SerializationKeys.transmission].string
    color = json[SerializationKeys.color].string
    latitude = json[SerializationKeys.latitude].float
    id = json[SerializationKeys.id].string
    fuelLevel = json[SerializationKeys.fuelLevel].float
    innerCleanliness = json[SerializationKeys.innerCleanliness].string
    make = json[SerializationKeys.make].string
    longitude = json[SerializationKeys.longitude].float
    carImageUrl = json[SerializationKeys.carImageUrl].string
    group = json[SerializationKeys.group].string
    modelName = json[SerializationKeys.modelName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = modelIdentifier { dictionary[SerializationKeys.modelIdentifier] = value }
    if let value = series { dictionary[SerializationKeys.series] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = fuelType { dictionary[SerializationKeys.fuelType] = value }
    if let value = licensePlate { dictionary[SerializationKeys.licensePlate] = value }
    if let value = transmission { dictionary[SerializationKeys.transmission] = value }
    if let value = color { dictionary[SerializationKeys.color] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = fuelLevel { dictionary[SerializationKeys.fuelLevel] = value }
    if let value = innerCleanliness { dictionary[SerializationKeys.innerCleanliness] = value }
    if let value = make { dictionary[SerializationKeys.make] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = carImageUrl { dictionary[SerializationKeys.carImageUrl] = value }
    if let value = group { dictionary[SerializationKeys.group] = value }
    if let value = modelName { dictionary[SerializationKeys.modelName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.modelIdentifier = aDecoder.decodeObject(forKey: SerializationKeys.modelIdentifier) as? String
    self.series = aDecoder.decodeObject(forKey: SerializationKeys.series) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.fuelType = aDecoder.decodeObject(forKey: SerializationKeys.fuelType) as? String
    self.licensePlate = aDecoder.decodeObject(forKey: SerializationKeys.licensePlate) as? String
    self.transmission = aDecoder.decodeObject(forKey: SerializationKeys.transmission) as? String
    self.color = aDecoder.decodeObject(forKey: SerializationKeys.color) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.fuelLevel = aDecoder.decodeObject(forKey: SerializationKeys.fuelLevel) as? Float
    self.innerCleanliness = aDecoder.decodeObject(forKey: SerializationKeys.innerCleanliness) as? String
    self.make = aDecoder.decodeObject(forKey: SerializationKeys.make) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
    self.carImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.carImageUrl) as? String
    self.group = aDecoder.decodeObject(forKey: SerializationKeys.group) as? String
    self.modelName = aDecoder.decodeObject(forKey: SerializationKeys.modelName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(modelIdentifier, forKey: SerializationKeys.modelIdentifier)
    aCoder.encode(series, forKey: SerializationKeys.series)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(fuelType, forKey: SerializationKeys.fuelType)
    aCoder.encode(licensePlate, forKey: SerializationKeys.licensePlate)
    aCoder.encode(transmission, forKey: SerializationKeys.transmission)
    aCoder.encode(color, forKey: SerializationKeys.color)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(fuelLevel, forKey: SerializationKeys.fuelLevel)
    aCoder.encode(innerCleanliness, forKey: SerializationKeys.innerCleanliness)
    aCoder.encode(make, forKey: SerializationKeys.make)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(carImageUrl, forKey: SerializationKeys.carImageUrl)
    aCoder.encode(group, forKey: SerializationKeys.group)
    aCoder.encode(modelName, forKey: SerializationKeys.modelName)
  }

}
