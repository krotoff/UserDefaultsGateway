import XCTest
@testable import UserDefaultsGateway

final class UserDefaultsGatewayTests: XCTestCase {

    var gateway: UserDefaultsGatewayType!

    override func setUp() {
        gateway = UserDefaultsGateway()
    }

    // MARK: - Set

    func test_ifSetString_thenThereIsTheSameValue() {
        setAndCheck("Test_string")
    }

    func test_ifSetFloat_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setAndCheck(Float.random(in: -1000...1000))
        }
    }

    func test_ifSetBool_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setAndCheck(Bool.random())
        }
    }

    func test_ifSetDouble_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setAndCheck(Double.random(in: -1000...1000))
        }
    }

    func test_ifSetInt_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setAndCheck(Int.random(in: -1000...1000))
        }
    }

    func test_ifSetCustomObject_thenThereIsTheSameValue() {
        struct Object: Codable, Equatable {
            let int: Int
            let string: String
            let float: Float
        }

        for _ in 0..<10 {
            setAndCheck(Object(
                int: Int.random(in: -1000...1000),
                string: "Test_string",
                float: Float.random(in: -1000...1000)
            ))
        }
    }

    // MARK: - Set and Remove

    func test_ifSetStringAndRemove_thenThereIsNothing() {
        setRemoveAndCheck("Test_string")
    }

    func test_ifSetFloatAndRemove_thenThereIsNothing() {
        for _ in 0..<10 {
            setRemoveAndCheck(Float.random(in: -1000...1000))
        }
    }

    func test_ifSetBoolAndRemove_thenThereIsNothing() {
        for _ in 0..<10 {
            setAndCheck(Bool.random())
        }
    }

    func test_ifSetDoubleAndRemove_thenThereIsNothing() {
        for _ in 0..<10 {
            setRemoveAndCheck(Double.random(in: -1000...1000))
        }
    }

    func test_ifSetIntAndRemove_thenThereIsNothing() {
        for _ in 0..<10 {
            setRemoveAndCheck(Int.random(in: -1000...1000))
        }
    }

    func test_ifSetCustomObjectAndRemove_thenThereIsTheSameValue() {
        struct Object: Codable, Equatable {
            let int: Int
            let string: String
            let float: Float
        }

        for _ in 0..<10 {
            setRemoveAndCheck(Object(
                int: Int.random(in: -1000...1000),
                string: "Test_string",
                float: Float.random(in: -1000...1000)
            ))
        }
    }

    // MARK: - Empty value

    func test_ifNoSet_thenThereIsNoString() {
        checkNoObject(String.self)
    }

    func test_ifNoSet_thenThereIsNoFloat() {
        checkNoObject(Float.self)
    }

    func test_ifNoSet_thenThereIsNoBool() {
        checkNoObject(Bool.self)
    }

    func test_ifNoSet_thenThereIsNoDouble() {
        checkNoObject(Double.self)
    }

    func test_ifNoSet_thenThereIsNoInt() {
        checkNoObject(Int.self)
    }

    func test_ifNoSet_thenThereIsNoCustomObject() {
        struct Object: Codable, Equatable {
            let int: Int
            let string: String
            let float: Float
        }

        checkNoObject(Object.self)
    }

    // MARK: - Private methods

    private func setAndCheck<ObjectType: Codable & Equatable>(_ value: ObjectType) {
        let key = "some.test.key"

        do {
            try gateway.setObject(value, forKey: key)

            let result: ObjectType? = try gateway.object(forKey: key)

            XCTAssertEqual(value, result)
        } catch {
            XCTFail("Test failed with caught error \(error)")
        }
    }

    private func checkNoObject<ObjectType: Codable & Equatable>(_ type: ObjectType.Type) {
        let key = "some.test.key"

        do {
            let result: ObjectType? = try gateway.object(forKey: key)

            XCTAssertEqual(nil, result)
        } catch {
            XCTFail("Test failed with caught error \(error)")
        }
    }

    private func setRemoveAndCheck<ObjectType: Codable & Equatable>(_ value: ObjectType) {
        let key = "some.test.key"

        do {
            try gateway.setObject(value, forKey: key)
            gateway.removeObject(forKey: key)
            let result: ObjectType? = try gateway.object(forKey: key)

            XCTAssertEqual(nil, result)
        } catch {
            XCTFail("Test failed with caught error \(error)")
        }
    }
}
