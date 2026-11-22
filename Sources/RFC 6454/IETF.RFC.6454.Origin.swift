public import RFC_3986

extension IETF.RFC.`6454` {

    public struct Origin: Sendable, Hashable {

        public let scheme: IETF.RFC.`3986`.URI.Scheme

        public let authority: IETF.RFC.`3986`.URI.Authority

        public init?(scheme: IETF.RFC.`3986`.URI.Scheme, authority: IETF.RFC.`3986`.URI.Authority) {
            guard authority.userinfo == nil else { return nil }
            self.scheme = scheme
            self.authority = authority
        }
    }
}

extension IETF.RFC.`6454`.Origin {

    public init?(serialized text: some StringProtocol) {
        guard let mark = text.firstRange(of: "://") else { return nil }
        let rest = text[mark.upperBound...]
        guard !rest.isEmpty, !rest.contains("/"), !rest.contains("?"), !rest.contains("#") else { return nil }
        do throws(IETF.RFC.`3986`.URI.Scheme.Error) {
            let scheme = try IETF.RFC.`3986`.URI.Scheme(text[..<mark.lowerBound])
            do throws(IETF.RFC.`3986`.URI.Authority.Error) {
                self.init(scheme: scheme, authority: try IETF.RFC.`3986`.URI.Authority(rest))
            } catch {
                return nil
            }
        } catch {
            return nil
        }
    }

    public func isSame(authority other: IETF.RFC.`3986`.URI.Authority) -> Bool {
        authority == other
    }
}
