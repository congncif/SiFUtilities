//
//  Endpoint.swift
//  SiFUtilities
//
//  Created by FOLY on 3/26/18.
//

import Foundation

open class EndpointBase {
    open static var path: String = ""
}

public protocol EndpointProtocol: CustomStringConvertible {
    static var root: String { get }
    func path(base: String, _ arguments: CVarArg...) -> String
}

func PathHelper(format: String) -> (_ params: CVaListPointer) -> String {
    return { (params: CVaListPointer) in
        NSString(format: format, arguments: params) as String
    }
}

extension EndpointProtocol {
    public static var root: String {
        return ""
    }
    
    public func path(base: String = EndpointBase.path, _ arguments: CVarArg...) -> String {
        let purePath = base +/ (Self.root.isEmpty ? description : Self.root +/ description)
        if arguments.count > 0 {
            let helper = PathHelper(format: purePath)
            return withVaList(arguments) { helper($0) }
        } else {
            return purePath
        }
    }
}

infix operator +/: AdditionPrecedence
public func +/(lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}

extension RawRepresentable where Self.RawValue == String {
    public var description: String {
        return rawValue
    }
}
