//
//  Entry.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class Entry: Equatable {
    
    private let timestampKey = "timestamp"
    private let titleKey = "title"
    private let textKey = "text"
    
    var timestamp: NSDate
    var title: String
    var text: String
    
    init(timestamp: NSDate = NSDate(), title: String, text: String) {
        
        self.timestamp = timestamp
        self.title = title
        self.text = text
    }
}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}