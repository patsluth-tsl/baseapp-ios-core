//
//  URLComponents+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public extension URLComponents {
    var queryItemsByName: [String: URLQueryItem]? {
        return queryItems?.reduce(into: [String: URLQueryItem]()) {
            $0[$1.name] = $1
        }
    }
    
    init?(url: URL?, resolvingAgainstBaseURL: Bool = true) {
        guard let url = url else { return nil }
        self.init(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
    }
}
