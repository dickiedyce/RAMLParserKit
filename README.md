# RAMLParserKit

A Swift package that parses RAML 1.0 and OpenAPI specifications into structured data. Extracted from [RAMLtoISA](https://github.com/dickiedyce/RAMLtoISA).

## Features

- Parses RAML 1.0 specifications
- Parses OpenAPI (Swagger) specifications
- Resolves `!include` directives (RAML files, YAML, JSON, plain text)
- Extracts endpoints, parameters, responses, and security schemes
- Extracts functional and non-functional requirements from description tables
- Pure Swift -- no AppKit/UIKit dependencies

## Requirements

- macOS 13.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dickiedyce/RAMLParserKit", from: "1.0.0"),
]
```

Then add `"RAMLParserKit"` as a dependency of your target:

```swift
.target(
    name: "YourTarget",
    dependencies: ["RAMLParserKit"]
),
```

## Usage

```swift
import RAMLParserKit

let parser = RAMLParser(fileURL: ramlFileURL)
let spec = try parser.parse()

// Access parsed data
print(spec.apiInfo.title)       // API title
print(spec.apiInfo.version)     // API version
print(spec.endpoints.count)     // Number of endpoints

for endpoint in spec.endpoints {
    print("\(endpoint.method) \(endpoint.path)")
    print("  Parameters: \(endpoint.parameters.count)")
    print("  Responses:  \(endpoint.responses.count)")
}
```

### Using with a Document-based macOS app

```swift
import SwiftUI
import UniformTypeIdentifiers
import RAMLParserKit

struct RAMLDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.yaml]

    let spec: ParsedSpec

    init(configuration: ReadConfiguration) throws {
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(configuration.file.filename ?? "spec.raml")
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        try data.write(to: tempURL)
        defer { try? FileManager.default.removeItem(at: tempURL) }

        let parser = RAMLParser(fileURL: tempURL)
        self.spec = try parser.parse()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.featureUnsupported)
    }
}
```

## Data Model

| Type             | Description                                                         |
| ---------------- | ------------------------------------------------------------------- |
| `ParsedSpec`     | Top-level result containing API info, endpoints, and requirements   |
| `APIInfo`        | API title, version, description, and security schemes               |
| `Endpoint`       | HTTP method, path, summary, parameters, responses, and requirements |
| `APIParameter`   | Query/path/header parameter with type, description, and constraints |
| `APIResponse`    | Status code, description, and content type                          |
| `Requirement`    | Functional or non-functional requirement with acceptance criteria   |
| `SecurityScheme` | Auth type, scheme, and description                                  |

## Dependencies

- [Yams](https://github.com/jpsim/Yams) -- YAML parsing

## License

MIT. See [LICENSE](LICENSE).
