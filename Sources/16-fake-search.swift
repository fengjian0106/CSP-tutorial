//
//  16-fake-search.swift
//  CSP-tutorial
//
//  Created by fengjian on 16/3/9.
//  Copyright © 2016年 fengjian. All rights reserved.
//

import Foundation
import Venice

public typealias GoogleSearchResult = String

internal func fakeSearch(kind: String) -> (String) -> GoogleSearchResult {
    func search(query: String) -> GoogleSearchResult {
        let sleepTime = Int(arc4random_uniform(1000) + 1).milliseconds
        //print("-->\(kind) search use time: \(Int(sleepTime * 1000)) ms")
        nap(for: sleepTime)
        
        return GoogleSearchResult("\(kind) result for \(query), use time: \(Int(sleepTime * 1000)) ms")
    }
    
    return search
}

let web = fakeSearch("web")
let image = fakeSearch("image")
let video = fakeSearch("video")



//some util
internal func time(desc: String, function: ()->()) {
    let start : UInt64 = mach_absolute_time()
    function()
    let duration : UInt64 = mach_absolute_time() - start
    
    var info : mach_timebase_info = mach_timebase_info(numer: 0, denom: 0)
    mach_timebase_info(&info)
    
    let total = (duration * UInt64(info.numer) / UInt64(info.denom)) / NSEC_PER_MSEC
    print("\(desc)\(total) ms.")
}


protocol GoogleSearchResultDebugAble {
    func log()
}

extension GoogleSearchResult: GoogleSearchResultDebugAble {
    func log() {
        print("  \(self)")
    }
}

internal extension Array where Element: GoogleSearchResultDebugAble {
    internal func log() {
        print("google search result is:")
        for searchResult in self {
            searchResult.log()
        }
    }
}
