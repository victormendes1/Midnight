//
//  ServiceError.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

enum ServiceError: Error {
    case serverError
    case invalidRequest
    case invalidURL
    case invalidResponseCode(Int)
    case decodingError(String)
    case authorizationError
    case unknownError(description: String)
    
    var message: ErrorRepresentation {
        switch self {
        case .serverError:
            return ErrorRepresentation(title: "Erro no servidor", message: "Ops! Não foi possível processar a sua solicitação.")
            
        case .invalidRequest:
            return ErrorRepresentation(title: "Solicitação invalida", message: "Ops! Não foi possível processar a sua solicitação, tente mais tarde.")
            
        case .invalidURL:
            return ErrorRepresentation(title: "URL Inválido", message: "Não é possível realizar sua solicitação.")
            
        case .invalidResponseCode(let code):
            return ErrorRepresentation(title: "Código HTTP desconhecido", message: "Novo erro precisa ser tratado, codigo - \(code.description).")
            
        case .decodingError(let message):
            debugPrint("Problema com a decodificação do objeto. -- \(message)")
            return ErrorRepresentation(title: "Tente novamente mais tarde", message: "Estamos com problemas para mostrar o conteudo")
            
        case .authorizationError:
            return ErrorRepresentation(title: "Sem autorização", message: "Ops! Parece que você não possui autorizção")
            
        case .unknownError(let description):
            return ErrorRepresentation(title: "Erro desconhecido", message: "Não foi possível processar a sua solicitação - \(description)")
        }
    }
}
