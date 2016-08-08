//
//  Entry+CloudKit.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import CloudKit

extension Entry {
    
    static var recordType: String { return "Entry" }
    static var entryTitleKey: String { return "EntryText" }
    static var entryBodyKey: String { return "EntryBody" }
    
    init?(cloudKitRecord: CKRecord) {
        guard let title = cloudKitRecord[Entry.entryTitleKey] as? String,
            body = cloudKitRecord[Entry.entryBodyKey] as? String
            where cloudKitRecord.recordType == Entry.recordType else { return nil }
        
        self.init(title: title, body: body)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Entry.recordType)
        record[Entry.entryTitleKey] = title
        record[Entry.entryBodyKey] = body
        
        return record
    }
}