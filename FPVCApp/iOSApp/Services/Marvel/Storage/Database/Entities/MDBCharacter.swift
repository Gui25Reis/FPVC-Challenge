//
//  MDBCharacter+CoreDataClass.swift
//  KingsStorage
//
//  Created by Gui Reis on 08/09/24.
//
//

import CoreData
import KingsFoundation


@objc(MDBCharacter)
public class MDBCharacter: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MDBCharacter> {
        return NSFetchRequest<MDBCharacter>(entityName: "MDBCharacter")
    }
    
    @nonobjc public class func fetchRequest(forId id: String) -> NSFetchRequest<MDBCharacter> {
        let request = fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "dataId == %@", id)
        return request
    }

    @NSManaged public var dataId: String
    @NSManaged public var name: String
    @NSManaged public var infos: String
    @NSManaged public var image: String
    @NSManaged public var modified: String
    @NSManaged public var dateFavorited: String
    @NSManaged public var comics: String
    @NSManaged public var series: String
    @NSManaged public var stories: String
    @NSManaged public var events: String
    
    
    func populate(with data: MarvelCharacterData) {
        dataId = data.id.toString
        name = data.name
        infos = data.infos.data
        image = data.image.imageName
        modified = data.modified.defaultValue
        dateFavorited = data.favoritedDate
        comics = data.comics.data
        series = data.series.data
        stories = data.stories.data
        events = data.events.data
    }
}
