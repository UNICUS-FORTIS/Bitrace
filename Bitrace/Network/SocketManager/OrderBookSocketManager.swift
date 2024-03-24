//
//  OrderBookSocketManager.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation
import Combine


final class OrderBookSocketManager: NSObject {
    
    static let shared = OrderBookSocketManager()
    private override init() { super.init() }
    
    var webSocket: URLSessionWebSocketTask?
    var timer: Timer?
    var isOpen = false
    
    var jsonBuilder: SocketJsonBuilder?
    var orderBookObject = PassthroughSubject<OrderBookSocketResponse,Never>()
}

extension OrderBookSocketManager: SocketManagerProtocol {
    
    func send() {
        guard let json = jsonBuilder?.build(ticket: "test",
                                            type: "orderbook",
                                            level: 0) else { return }
        
        webSocket?.send(.string(json), completionHandler: { error in
            if let error {
                print("send error, \(error)")
            }
        })
    }
    
    func receive() {
        if isOpen {
            webSocket?.receive(completionHandler: { [weak self] result in
                switch result {
                case .success(let success):
                    
                    switch success {
                    case .data(let data):
                        
                        if let decodedData = try? JSONDecoder().decode(OrderBookSocketResponse.self, from: data) {
                            self?.orderBookObject.send(decodedData)
                        }
                        
                    case .string(_): break
                        
                    @unknown default: print("unknown error")
                    }
                    
                case .failure(let failure):
                    print("failure, \(failure)")
                    self?.closeWebSocket()
                }
                self?.receive()
            })
        }
    }
}

extension OrderBookSocketManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Connected - 연결됨")
        isOpen = true
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        isOpen = false
        print("Disconnected - 해제됨")
    }
    
}
