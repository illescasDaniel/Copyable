public enum CopyValue<T> {
	case `default`
	case value(T)
}

public extension CopyValue {
	func valueOrDefault(_ defaultValue: T) -> T {
		switch self {
		case .default:
			return defaultValue
		case .value(let value):
			return value
		}
	}
}
public extension CopyValue where T: Copyable {
	func valueOrDefault(_ defaultValue: T) -> T {
		switch self {
		case .default:
			return defaultValue.copy()
		case .value(let value):
			return value.copy()
		}
	}
}

public extension CopyValue {
	init(_ value: T) {
		self = .value(value)
	}
}

extension CopyValue: Swift.ExpressibleByNilLiteral where T: Swift.ExpressibleByNilLiteral {
	
	public static var `nil`: Self {
		Self.init(nilLiteral: ())
	}
	
	public init(nilLiteral: ()) {
		self = .value(nil)
	}
}
