public import RFC_3986

extension RFC_6454 {

    public struct Origin: Sendable, Hashable {

        public let scheme: RFC_3986.URI.Scheme

        public let authority: RFC_3986.URI.Authority

        public init?(scheme: RFC_3986.URI.Scheme, authority: RFC_3986.URI.Authority) {
            guard authority.userinfo == nil else { return nil }
            self.scheme = scheme
            self.authority = authority
        }
    }
}

extension RFC_6454.Origin {

    public init?(serialized text: some StringProtocol) {
        guard let mark = text.firstRange(of: "://") else { return nil }
        let rest = text[mark.upperBound...]
        guard !rest.isEmpty, !rest.contains("/"), !rest.contains("?"), !rest.contains("#") else { return nil }
        do throws(RFC_3986.URI.Scheme.Error) {
            let scheme = try RFC_3986.URI.Scheme(text[..<mark.lowerBound])
            do throws(RFC_3986.URI.Authority.Error) {
                self.init(scheme: scheme, authority: try RFC_3986.URI.Authority(rest))
            } catch {
                return nil
            }
        } catch {
            return nil
        }
    }

    public func isSame(authority other: RFC_3986.URI.Authority) -> Bool {
        authority == other
    }
}
