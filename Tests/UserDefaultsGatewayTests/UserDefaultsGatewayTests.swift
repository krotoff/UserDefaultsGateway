import XCTest
@testable import UserDefaultsGateway

final class UserDefaultsGatewayTests: XCTestCase {

    var gateway: UserDefaultsGatewayType!

    override func setUp() {
        gateway = UserDefaultsGateway()
    }

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

    func test_ifSetStringAndRemove_thenThereIsTheSameValue() {
        setRemoveAndCheck("Test_string")
    }

    func test_ifSetFloatAndRemove_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setRemoveAndCheck(Float.random(in: -1000...1000))
        }
    }

    func test_ifSetBoolAndRemove_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setAndCheck(Bool.random())
        }
    }

    func test_ifSetDoubleAndRemove_thenThereIsTheSameValue() {
        for _ in 0..<10 {
            setRemoveAndCheck(Double.random(in: -1000...1000))
        }
    }

    func test_ifSetIntAndRemove_thenThereIsTheSameValue() {
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
