## **Journal with CloudKit**

**Part 1**
-	Fork the repository and create a branch off of **Stretch Starting Point V2**

-	Your goal is to implement CloudKit into Journal and be able to save your entries to the cloud and fetch them automatically on the EntryListTableViewController

-	Use the following code as your starting point for your CloudKitManager:
	
    import UIKit
    import CloudKit
    
    class CloudKitManager {
        
        let database = CKContainer.defaultContainer().publicCloudDatabase
        
        func fetchRecordsWithType(type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: ([CKRecord]?, NSError?) -> Void) {
            
            let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
            query.sortDescriptors = sortDescriptors
            
            database.performQuery(query, inZoneWithID: nil, completionHandler: completion)
        }
        
        func saveRecord(record: CKRecord, completion: ((NSError?) -> Void) = {_ in }) {
    
            database.saveRecord(record) { (_, error) in
                completion(error)
            }
        }
    }
