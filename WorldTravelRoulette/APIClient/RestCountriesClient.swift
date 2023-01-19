//
//  RestCountriesClient.swift
//  WorldTravelRoulette
//
//  Created by mikaurakawa on 2023/01/20.
//

import Foundation

// HTTPクライアント
class RestCountriesClient {
    // URLSessionのインスタンスは使い回すので、ストアドプロパティとして保持する
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()

    func send<Request: RestCountriesRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, RestCountriesClientError>) -> Void
    ) {
        let urlReqeust = request.buildURLRequest()
        let task = session.dataTask(with: urlReqeust) { data, response, error in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch let error as RestCountriesAPIError {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
            default:
                fatalError("invalid responnse combination \(data), \(response), \(error)")
            }
        }

        task.resume()
    }
}
