//
//  Message.swift
//  Expresso
//
//  Created by Viraj Shah on 10/23/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit
import Firebase

class Message : NSObject{
    var fromId: String?
    var toId: String?
    var timestamp: NSNumber?
    var text: String?
    
    func chatPartnerId() -> String? {
        return fromId == FIRAuth.auth()?.currentUser?.uid ? toId : fromId
    }
    
}
