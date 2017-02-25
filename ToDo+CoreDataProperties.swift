//
//  ToDo+CoreDataProperties.swift
//  projectKazu
//
//  Created by Apple on 2017/02/17.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo");
    }

    @NSManaged public var complete: Bool
    @NSManaged public var delete: Bool
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var inputDate: NSDate?
    @NSManaged public var myContents: String?
    @NSManaged public var myTitle: String?
    @NSManaged public var reChallenge: Bool
    @NSManaged public var score: Int16

}
