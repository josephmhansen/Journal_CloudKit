//
//  Entry+Cloudkit.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Joseph Hansen on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

import CloudKit

extension Entry {
    static var recordType: String { return "Entry" }
    static var entryTitleKey: String { return "EntryText" }
    static var entryBodyKey: String { return "Body" }
    static var dateKey: String { return "Date" }
    
    init?(cloudKitRecord: CKRecord) {
        guard let entryText = cloudKitRecord[Entry.entryBodyKey] as? String,
        entryTitle = cloudKitRecord[Entry.entryTitleKey] as? String,
        date = cloudKitRecord[Entry.dateKey] as? NSDate
            where cloudKitRecord.recordType == Entry.recordType else {
                return nil
        }
        
        self.init(date: date, title: entryText, body: entryTitle)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Entry.recordType)
        record[Entry.entryTitleKey] = title
        record[Entry.entryBodyKey] = body
        record[Entry.dateKey] = date
        return record
    }
}
