import Foundation

public protocol UserDefaultsGatewayType {
    func setObject<ObjectType: Encodable>(_ object: ObjectType, forKey key: String) throws
    func object<ObjectType: Decodable>(forKey key: String) throws -> ObjectType?
    func removeObject(forKey key: String)
}

public final class UserDefaultsGateway {

    // MARK: - Private properties

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let defaults = UserDefaults.standard

    // MARK: - Init

    public init() {}
}

extension UserDefaultsGateway: UserDefaultsGatewayType {

    public func setObject<ObjectType: Encodable>(_ object: ObjectType, forKey key: String) throws {
        if object is String || object is Float || object is Bool || object is Double || object is Int {
            defaults.set(object, forKey: key)
        } else {
            let data = try encoder.encode(object)
            defaults.set(data, forKey: key)
        }
    }

    public func object<ObjectType: Decodable>(forKey key: String) throws -> ObjectType? {
        if
            ObjectType.self == String.self
                || ObjectType.self == Float.self
                || ObjectType.self == Bool.self
                || ObjectType.self == Double.self
                || ObjectType.self == Int.self
        {
            return defaults.object(forKey: key) as? ObjectType
        } else if let data = defaults.data(forKey: key) {
            return try decoder.decode(ObjectType.self, from: data)
        }

        return nil
    }

    public func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
