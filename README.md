# Copyable

Easily copy models with some properties changed.
It works with `struct`, `class` and objective C classes. (see tests for more examples)

- Example for mutable models:
```swift
struct Person: Copyable {
	var name: String
	var age: Int
}

let person = Person(name: "Daniel", age: 99)

let personWithName = person.copyWith(\.name, "Pepe")
let personWithAge = person.copyWith(\.age, 88)
let personWithNameAge = person.copyWith(
	(\.name, "John"),
	(\.age, 93)
)
```

- Example for immutable models:
```swift
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

let person = ImmutablePerson(name: "Daniel", age: 99, petName: "pet-1")

let personWithName = person.copyWith(name: .value("Pepe"))

let personWithAge = person.copyWith(age: .value(88))

let personWithPet1 = person.copyWith(petName: .value("John"))
let personWithPet2 = person.copyWith(petName: .nil) // or: nil, or: .value(nil)
```
