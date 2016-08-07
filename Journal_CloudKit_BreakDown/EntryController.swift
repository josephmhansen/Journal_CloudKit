//
//  EntryController.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class EntryController {
    
    private let entriesKey = "entries"
    
    static let sharedController = EntryController()
    
    var entries: [Entry]
    
    init() {
        
        self.entries = []
    }
    
    func addEntry(entry: Entry) {
        
        entries.append(entry)
    }
    
    func removeEntry(entry: Entry) {
        
        if let entryIndex = entries.indexOf(entry) {
            entries.removeAtIndex(entryIndex)
        }
    }
}