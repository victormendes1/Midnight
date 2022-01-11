//
//  TypesErrors.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

public struct ResultError: Decodable, Error {
    let title: String
    let message: String
    
    static func unknownError() -> ResultError {
        return ResultError(title: "Erro desconhecido", message: "Ops! Não foi possível processar a sua solicitação")
    }
    
    static func authorizationError() -> ResultError {
        return ResultError(title: "Sem autorização", message: "Ops! Parece que você não possui autorizção")
    }
    
    static func invalidRequest() -> ResultError {
        return ResultError(title: "Solicitação invalida", message: "Ops! Não foi possível processar a sua solicitação, tente mais tarde.")
    }
    
    static func serverError() -> ResultError {
        return ResultError(title: "Erro no servidor", message: "Ops! Não foi possível processar a sua solicitação.")
    }
}
