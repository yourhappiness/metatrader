//
//  TinkoffService.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 25.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    public typealias JSONCompletion = (Result<[String : Any]>) -> Void
    
    public func jsonRequest(_ request: WebRequest, then completion: JSONCompletion?) {
      Alamofire.request(request.url, method: request.method, parameters: request.parameters, headers: request.headers).responseJSON { [weak self] response in
            response.result
                .withValue { json in
                  completion?(.success(json as! [String : Any]))
                }
                .withError {
                    self?.logError($0, request: request)
                    completion?(.failure($0))
            }
        }
    }
    
    private func logError(_ error: Error, request: WebRequest) {
        print("Error while executing request \(request.url), error: \(error.localizedDescription)")
    }
}
