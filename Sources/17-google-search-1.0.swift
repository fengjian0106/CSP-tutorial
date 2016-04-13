//
//  16-google-search-1.0.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func google(query: String) -> Array<GoogleSearchResult> {
    var results = Array<GoogleSearchResult>()
    
    results.append(web(query))
    results.append(image(query))
    results.append(video(query))
    
    return results
}

public func run17() {
    var result: Array<GoogleSearchResult>?
    
    time("google search v1.0, use time: ") { () -> () in
        result = google("CSP")
    }
    
    result?.log()
}