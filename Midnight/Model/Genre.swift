//
//  Genre.swift
//  Midnight
//
//  Created by Victor Mendes on 07/11/22.
//

import Foundation

struct Genres: Codable {
    var genres: [Genre] = []
}

final class Genre: NSObject, NSCoding, Codable {
    var id: Int
    var name: String
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
    }
    
    init?(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: PropertyKey.id)
        
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            fatalError("Unable to decode name.")
            return nil
        }
        self.init(id: id, name: name)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: PropertyKey.id)
        coder.encode(name, forKey: PropertyKey.name)
    }
}
