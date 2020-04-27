//
//  File.swift
//  
//
//  Created by Daniel Illescas Romero on 27/04/2020.
//

#if canImport(ObjectiveC)
import class Foundation.NSObject
#endif

public protocol Copyable {
	
	func copyWith<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self
	
	func copyWith<T1,T2>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2)
	) -> Self
	
	func copyWith<T1,T2,T3>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2),
		_ keyValue3: (WritableKeyPath<Self, T3>, T3)
	) -> Self
	
	func copyWith<T1,T2,T3,T4>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2),
		_ keyValue3: (WritableKeyPath<Self, T3>, T3),
		_ keyValue4: (WritableKeyPath<Self, T4>, T4)
	) -> Self
	
	func copy() -> Self
}
public extension Copyable {
	
	func copy() -> Self { self }
	
	func copyWith<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
		var copy = self.copy()
		copy[keyPath: keyPath] = value
		return copy
	}
	
	func copyWith<T1,T2>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2)
	) -> Self {
		var copy = self.copy()
		copy[keyPath: keyValue1.0] = keyValue1.1
		copy[keyPath: keyValue2.0] = keyValue2.1
		return copy
	}
	
	func copyWith<T1,T2,T3>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2),
		_ keyValue3: (WritableKeyPath<Self, T3>, T3)
	) -> Self {
		var copy = self.copy()
		copy[keyPath: keyValue1.0] = keyValue1.1
		copy[keyPath: keyValue2.0] = keyValue2.1
		copy[keyPath: keyValue3.0] = keyValue3.1
		return copy
	}
	
	func copyWith<T1,T2,T3,T4>(
		_ keyValue1: (WritableKeyPath<Self, T1>, T1),
		_ keyValue2: (WritableKeyPath<Self, T2>, T2),
		_ keyValue3: (WritableKeyPath<Self, T3>, T3),
		_ keyValue4: (WritableKeyPath<Self, T4>, T4)
	) -> Self {
		var copy = self.copy()
		copy[keyPath: keyValue1.0] = keyValue1.1
		copy[keyPath: keyValue2.0] = keyValue2.1
		copy[keyPath: keyValue3.0] = keyValue3.1
		copy[keyPath: keyValue4.0] = keyValue4.1
		return copy
	}
}

#if canImport(ObjectiveC)
public extension Copyable where Self: NSObject {
	func copy() -> Self {
		self.copy() as! Self
	}
}
#endif
