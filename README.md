# swift-rfc-6454

Use this package when you need to read the Origin request header or compare a request's origin with its host. Start from `RFC_6454.Origin(serialized:)` for the header's text, and name the header with `RFC_9110.Field.Name.origin`.

## Laws

- A serialized origin is an RFC 3986 scheme, `://` and an authority with no user information, and nothing more: no path, query or fragment. Anything else, including the opaque `null`, reads as no origin.
- The scheme and host are RFC 3986's, compared without case, so `HTTP://Example.COM` and `http://example.com` are one origin.
- `isSame(authority:)` compares the origin's authority with a request's Host, port included.
- `RFC_9110.Field.Name.origin` is the field name RFC 6454 registers, spelled `Origin`.
