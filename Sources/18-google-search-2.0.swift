//
//  18-google-search-2.0.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

private func google(query: String) -> Array<GoogleSearchResult> {
    let channel = Channel<GoogleSearchResult>()
    
    co(channel.send(web(query)))
    co(channel.send(image(query)))
    co(channel.send(video(query)))
    
    var results = Array<GoogleSearchResult>()
    for _ in 0..<3 {
        results.append(channel.receive()!)
    }
    return results
}

public func run18() {
    var result: Array<GoogleSearchResult>?
    
    time("google search v2.0, use time: ") { () -> () in
        result = google("CSP")
    }
    
    result?.log()
}
