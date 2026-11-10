import RFC_3986
import RFC_6454
import RFC_9110
import Testing

@Suite
struct `Origin Tests` {
    @Test
    func `a serialized origin reads its scheme and authority, scheme and host in lower case`() throws {
        let origin = try #require(RFC_6454.Origin(serialized: "HTTP://Example.COM:8080"))
        #expect(origin.scheme.value == "http")
        #expect(origin.isSame(authority: try RFC_3986.URI.Authority("example.com:8080")))
        #expect(!origin.isSame(authority: try RFC_3986.URI.Authority("example.com")))
    }

    @Test(arguments: ["null", "rule.law", "https://rule.law/path", "https://", "https://rule.law:99999", "://rule.law", "https://user@rule.law"])
    func `text that serializes no origin is refused`(text: String) {
        #expect(RFC_6454.Origin(serialized: text) == nil)
    }

    @Test
    func `the Origin field name is spelled as registered`() {
        #expect(RFC_9110.Field.Name.origin.rawValue == "Origin")
    }
}
