//
//  EntryController.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

public let EntriesControllerDidRefreshNotification = "MessagesControllerDidRefreshNotification"

class EntryController {
    
    private let entriesKey = "entries"
    
    static let sharedController = EntryController()
    private let cloudKitManager = CloudKitManager()
    
    init() {
        refresh()
    }
    
    private(set) var entries: [Entry] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(EntriesControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func postNewEntry(entry: Entry, completion: (NSError?) -> Void) {
        
        let record = entry.cloudKitRecord
        
        cloudKitManager.saveRecord(record) { error in
            defer { completion(error) }
            
            if let error = error {
                print("Error saving \(entry) to CloudKit \(error.localizedDescription)")
                return
            }
            self.entries.insert(entry, atIndex: 0)
            print("Entry successfully appended to array0")
        }
    }
    
    func refresh(completion: ((NSError?) -> Void)? = nil) {
        let sortDescriptors = [NSSortDescriptor(key: Entry.entryTitleKey, ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Entry.recordType, sortDescriptors: sortDescriptors) { (records, error) in
            defer {
                completion?(error)
            }
            
            if let error = error {
                print("Error fetching messages: \(error)")
                return
            }
            
            guard let records = records else { return }
            
            self.entries = records.flatMap { Entry(cloudKitRecord: $0) }
            print("Successfully  created Entry CKRecord")
        }
    }
}