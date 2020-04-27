import XCTest
@testable import Copyable

struct ImmutablePerson {
	
	let name: String
	let age: Int
	let petName: String?
	
	func copyWith(
		name: CopyValue<String> = .default,
		age: CopyValue<Int> = .default,
		petName: CopyValue<String?> = .default
	) -> Self {
		Self(
			name: name.valueOrDefault(self.name),
			age: age.valueOrDefault(self.age),
			petName: petName.valueOrDefault(self.petName)
		)
	}
}

struct Person: Copyable {
	var name: String
	var age: Int
}

#if canImport(ObjectiveC)
@objcMembers
final class PersonClass: NSObject, Copyable {
	
	var name: String
	var age: Int
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
	
	override func copy() -> Any {
		return PersonClass(name: self.name, age: self.age)
	}
}
#endif

final class PersonClass2: Copyable {
	
	var name: String
	var age: Int
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
	
	func copy() -> Self {
		return Self(name: self.name, age: self.age)
	}
}

final class CopyableTests: XCTestCase {
    
	func testValueOrDefault() {
		let test: CopyValue<String> = .init("lol") // or: .value("lol")
		let test2: CopyValue<String?> = .init("lol") // or: .value("lol")
		let test3: CopyValue<String?> = .nil // or: .init(nil), or: .value(nil)
		
		XCTAssertEqual(test.valueOrDefault("default-1"), "lol")
		XCTAssertEqual(test2.valueOrDefault("default-2"), "lol")
		XCTAssertEqual(test3.valueOrDefault("default-3"), nil)
		XCTAssertEqual(test3.valueOrDefault(nil), nil)
    }
	
	func testImmutable() {
		let person = ImmutablePerson(name: "Daniel", age: 99, petName: "pet-1")
		
		let personWithName = person.copyWith(name: .value("Pepe"))
		XCTAssertEqual(personWithName.name, "Pepe")
		
		let personWithAge = person.copyWith(age: .value(88))
		XCTAssertEqual(personWithAge.age, 88)
		
		let personWithPet1 = person.copyWith(petName: .value("John"))
		XCTAssertEqual(personWithPet1.petName, "John")
		
		let personWithPet2 = person.copyWith(petName: .value(nil))
		XCTAssertEqual(personWithPet2.petName, person.copyWith(petName: .nil).petName)
		XCTAssertEqual(personWithPet2.petName, person.copyWith(petName: nil).petName)
		XCTAssertNotEqual(personWithPet2.petName, "John")
	}
	
	func testMutable() {
		let person = Person(name: "Daniel", age: 99)
		
		let personWithName = person.copyWith(\.name, "Pepe")
		XCTAssertEqual(personWithName.name, "Pepe")
		
		let personWithAge = person.copyWith(\.age, 88)
		XCTAssertEqual(personWithAge.age, 88)
		
		let personWithNameAge = person.copyWith(
			(\.name, "John"),
			(\.age, 93)
		)
		XCTAssertEqual(personWithNameAge.name, "John")
		XCTAssertEqual(personWithNameAge.age, 93)
	}
	
	#if canImport(ObjectiveC)
	func testNSObjectClass() {
		let person = PersonClass(name: "Daniel", age: 99)
		
		let personWithName = person.copyWith(\.name, "Pepe")
		XCTAssertEqual(personWithName.name, "Pepe")
		XCTAssertEqual(person.name, "Daniel")
		
		let personWithAge = person.copyWith(\.age, 88)
		XCTAssertEqual(personWithAge.age, 88)
		XCTAssertEqual(person.age, 99)
		
		let personWithNameAge = person.copyWith(
			(\.name, "John"),
			(\.age, 93)
		)
		XCTAssertEqual(personWithNameAge.name, "John")
		XCTAssertEqual(personWithNameAge.age, 93)
		XCTAssertEqual(person.name, "Daniel")
		XCTAssertEqual(person.age, 99)
	}
	#else
	func testNSObjectClass() {}
	#endif
	
	func testClass() {
		let person = PersonClass2(name: "Daniel", age: 99)
		
		let personWithName = person.copyWith(\.name, "Pepe")
		XCTAssertEqual(personWithName.name, "Pepe")
		XCTAssertEqual(person.name, "Daniel")
		
		let personWithAge = person.copyWith(\.age, 88)
		XCTAssertEqual(personWithAge.age, 88)
		XCTAssertEqual(person.age, 99)
		
		let personWithNameAge = person.copyWith(
			(\.name, "John"),
			(\.age, 93)
		)
		XCTAssertEqual(personWithNameAge.name, "John")
		XCTAssertEqual(personWithNameAge.age, 93)
		XCTAssertEqual(person.name, "Daniel")
		XCTAssertEqual(person.age, 99)
	}

    static var allTests = [
        ("testValueOrDefault", testValueOrDefault),
		("testImmutable", testImmutable),
		("testMutable", testMutable),
		("testNSObjectClass", testNSObjectClass),
		("testClass", testClass)
    ]
}
