//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//


enum MarvelCharactersParameters: MarvelParameters {
    case name(_ data: String)
    case nameStartsWith(_ data: String)
    case modifiedSince(_ data: String)
    case comics(_ data: String)
    case series(_ data: String)
    case events(_ data: String)
    case stories(_ data: String)
    case orderBy(_ data: String)
    case limit(_ data: String)
    case offset(_ data: String)
    
    
    var parameter: String {
        return switch self {
        case .name(_): "name"
        case .nameStartsWith(_): "nameStartsWith"
        case .modifiedSince(_): "modifiedSince"
        case .comics(_): "comics"
        case .series(_): "series"
        case .events(_): "events"
        case .stories(_): "stories"
        case .orderBy(_): "orderBy"
        case .limit(_): "limit"
        case .offset(_): "offset"
        }
    }
    
    var value: String {
        return switch self {
        case .name(let data): data
        case .nameStartsWith(let data): data
        case .modifiedSince(let data): data
        case .comics(let data): data
        case .series(let data): data
        case .events(let data): data
        case .stories(let data): data
        case .orderBy(let data): data
        case .limit(let data): data
        case .offset(let data): data
        }
    }
}
