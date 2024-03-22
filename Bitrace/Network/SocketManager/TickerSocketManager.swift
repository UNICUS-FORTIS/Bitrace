//
//  TickerSocketManager.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation
import Combine


final class TickerSocketManager: NSObject {
    
    static let shared = TickerSocketManager()
    private override init() { super.init() }
    
    var webSocket: URLSessionWebSocketTask?
    var timer: Timer?
    var isOpen = false
    
    var jsonBuilder: SocketJsonBuilder?
    var dataObject = PassthroughSubject<TickerSocketResponse, Never>()
}

extension TickerSocketManager: SocketManagerProtocol {
    
    func send() {
        guard let json = jsonBuilder?.build(ticket: "test example",
                                            type: "ticker",
                                            level: nil) else { return }
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
                        
                        if let decodedData = try? JSONDecoder().decode(TickerSocketResponse.self, from: data) {
                            self?.dataObject.send(decodedData)
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

extension TickerSocketManager: URLSessionWebSocketDelegate {
    
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
