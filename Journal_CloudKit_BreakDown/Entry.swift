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
    
    init?(dictionary: [String: AnyObject]) {
        guard let timestamp = dictionary[timestampKey] as? NSDate,
            let title = dictionary[titleKey] as? String,
            let text = dictionary[textKey] as? String else { return nil }
        
        self.timestamp = timestamp
        self.title = title
        self.text = text
        
    }
    
    func dictionaryCopy() -> [String: AnyObject] {
        
        let dictionary = [
            timestampKey : self.timestamp,
            titleKey : self.title,
            textKey : self.text
        ]
        
        return dictionary
    }
    
}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}