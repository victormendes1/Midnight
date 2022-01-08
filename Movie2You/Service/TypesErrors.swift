//
//  TypesErrors.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

public struct RequestError: Decodable, Error {
    let status: String
    let message: String
    
    static func unknownError() -> RequestError {
        return RequestError(status: "Erro desconhecido", message: "Ops! Não foi possível processar a sua solicitação")
    }
    
    static func authorizationError() -> RequestError {
        return RequestError(status: "Sem autorização", message: "Ops! Parece que você não possui autorizção")
    }
    
    static func invalidRequest() -> RequestError {
        return RequestError(status: "Solicitação invalida", message: "Ops! Não foi possível processar a sua solicitação, tente mais tarde.")
    }
    
    static func serverError() -> RequestError {
        return RequestError(status: "Erro no servidor", message: "Ops! Não foi possível processar a sua solicitação.")
    }
}
