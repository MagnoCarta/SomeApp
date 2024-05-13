//
//  NetworkManagerProtocol.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<Response: Codable, Request: Codable>(
        method: HTTPMethod,
        using path: String,
        data: Request?,
        completion: @escaping (Result<Response, NetworkServiceError>) -> Void
    )
    
    func responselessRequest<Request: Codable>(
        method: HTTPMethod,
        using path: String,
        data: Request?,
        completion: @escaping (Result<Bool, NetworkServiceError>) -> Void
    )

}
