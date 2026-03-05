import Foundation

// MARK: - API Parameter

public struct APIParameter: Identifiable, Codable, Sendable {
    public let id: UUID
    public let name: String
    public let location: String      // query, path, header
    public let required: Bool
    public let schemaType: String
    public let description: String
    public let example: String?
    public let minimum: Int?
    public let maximum: Int?

    public init(
        id: UUID = UUID(),
        name: String,
        location: String,
        required: Bool,
        schemaType: String,
        description: String,
        example: String? = nil,
        minimum: Int? = nil,
        maximum: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.required = required
        self.schemaType = schemaType
        self.description = description
        self.example = example
        self.minimum = minimum
        self.maximum = maximum
    }

    enum CodingKeys: String, CodingKey {
        case name, location, required, schemaType, description, example, minimum, maximum
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.location = try container.decode(String.self, forKey: .location)
        self.required = try container.decode(Bool.self, forKey: .required)
        self.schemaType = try container.decode(String.self, forKey: .schemaType)
        self.description = try container.decode(String.self, forKey: .description)
        self.example = try container.decodeIfPresent(String.self, forKey: .example)
        self.minimum = try container.decodeIfPresent(Int.self, forKey: .minimum)
        self.maximum = try container.decodeIfPresent(Int.self, forKey: .maximum)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(required, forKey: .required)
        try container.encode(schemaType, forKey: .schemaType)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(example, forKey: .example)
        try container.encodeIfPresent(minimum, forKey: .minimum)
        try container.encodeIfPresent(maximum, forKey: .maximum)
    }
}

// MARK: - API Response

public struct APIResponse: Identifiable, Codable, Sendable {
    public let id: UUID
    public let statusCode: String
    public let description: String
    public let contentType: String?

    public init(
        id: UUID = UUID(),
        statusCode: String,
        description: String,
        contentType: String? = nil
    ) {
        self.id = id
        self.statusCode = statusCode
        self.description = description
        self.contentType = contentType
    }

    enum CodingKeys: String, CodingKey {
        case statusCode, description, contentType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.statusCode = try container.decode(String.self, forKey: .statusCode)
        self.description = try container.decode(String.self, forKey: .description)
        self.contentType = try container.decodeIfPresent(String.self, forKey: .contentType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(statusCode, forKey: .statusCode)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(contentType, forKey: .contentType)
    }
}

// MARK: - Requirement

public struct Requirement: Identifiable, Codable, Sendable {
    public let id: UUID
    public let reqId: String
    public let reqType: RequirementType
    public let useCase: String
    public let description: String
    public let acceptanceCriteria: String

    public init(
        id: UUID = UUID(),
        reqId: String,
        reqType: RequirementType,
        useCase: String,
        description: String,
        acceptanceCriteria: String
    ) {
        self.id = id
        self.reqId = reqId
        self.reqType = reqType
        self.useCase = useCase
        self.description = description
        self.acceptanceCriteria = acceptanceCriteria
    }

    enum CodingKeys: String, CodingKey {
        case reqId, reqType, useCase, description, acceptanceCriteria
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.reqId = try container.decode(String.self, forKey: .reqId)
        self.reqType = try container.decode(RequirementType.self, forKey: .reqType)
        self.useCase = try container.decode(String.self, forKey: .useCase)
        self.description = try container.decode(String.self, forKey: .description)
        self.acceptanceCriteria = try container.decode(String.self, forKey: .acceptanceCriteria)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reqId, forKey: .reqId)
        try container.encode(reqType, forKey: .reqType)
        try container.encode(useCase, forKey: .useCase)
        try container.encode(description, forKey: .description)
        try container.encode(acceptanceCriteria, forKey: .acceptanceCriteria)
    }
}

public enum RequirementType: String, Codable, Sendable {
    case functional = "FR"
    case nonFunctional = "NFR"
}

// MARK: - Endpoint

public struct Endpoint: Identifiable, Codable, Sendable {
    public let id: UUID
    public let path: String
    public let method: String
    public let summary: String
    public let description: String
    public let parameters: [APIParameter]
    public let responses: [APIResponse]
    public let requirements: [Requirement]
    public let securitySchemes: [String]

    public init(
        id: UUID = UUID(),
        path: String,
        method: String,
        summary: String,
        description: String,
        parameters: [APIParameter],
        responses: [APIResponse],
        requirements: [Requirement],
        securitySchemes: [String]
    ) {
        self.id = id
        self.path = path
        self.method = method
        self.summary = summary
        self.description = description
        self.parameters = parameters
        self.responses = responses
        self.requirements = requirements
        self.securitySchemes = securitySchemes
    }

    enum CodingKeys: String, CodingKey {
        case path, method, summary, description, parameters, responses, requirements, securitySchemes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.path = try container.decode(String.self, forKey: .path)
        self.method = try container.decode(String.self, forKey: .method)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.description = try container.decode(String.self, forKey: .description)
        self.parameters = try container.decode([APIParameter].self, forKey: .parameters)
        self.responses = try container.decode([APIResponse].self, forKey: .responses)
        self.requirements = try container.decode([Requirement].self, forKey: .requirements)
        self.securitySchemes = try container.decode([String].self, forKey: .securitySchemes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(method, forKey: .method)
        try container.encode(summary, forKey: .summary)
        try container.encode(description, forKey: .description)
        try container.encode(parameters, forKey: .parameters)
        try container.encode(responses, forKey: .responses)
        try container.encode(requirements, forKey: .requirements)
        try container.encode(securitySchemes, forKey: .securitySchemes)
    }
}

// MARK: - API Info

public struct APIInfo: Codable, Sendable {
    public var title: String
    public var version: String
    public var description: String
    public var securitySchemes: [String: SecurityScheme]

    public init(title: String = "API", version: String = "1.0", description: String = "", securitySchemes: [String: SecurityScheme] = [:]) {
        self.title = title
        self.version = version
        self.description = description
        self.securitySchemes = securitySchemes
    }
}

public struct SecurityScheme: Codable, Sendable {
    public let type: String
    public let scheme: String
    public let description: String

    public init(type: String, scheme: String, description: String) {
        self.type = type
        self.scheme = scheme
        self.description = description
    }
}

// MARK: - Parsed Specification

public struct ParsedSpec: Sendable {
    public let apiInfo: APIInfo
    public let endpoints: [Endpoint]
    public let requirements: [Requirement]

    public init(apiInfo: APIInfo, endpoints: [Endpoint], requirements: [Requirement]) {
        self.apiInfo = apiInfo
        self.endpoints = endpoints
        self.requirements = requirements
    }
}
