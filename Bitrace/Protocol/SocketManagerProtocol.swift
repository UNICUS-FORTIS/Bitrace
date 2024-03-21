//
//  SocketManagerProtocol.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation

protocol SocketManagerProtocol: AnyObject {
    
    var webSocket: URLSessionWebSocketTask? { get set }
    var timer: Timer? { get set }
    var isOpen: Bool { get set }

    func openWebSocket()
    func closeWebSocket()
    func send()
    func receive()
    func ping()
    
}

extension SocketManagerProtocol where Self: URLSessionWebSocketDelegate {
    
    func openWebSocket() {
        
        closeWebSocket()
        
        guard let url = URL(string: EndPoints.socketURL) else { return }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        ping()
    }
    
    func closeWebSocket() {
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        timer?.invalidate()
        timer = nil
        
        isOpen = false
    }
    
    func ping() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error in
                if let error {
                    print("핑퐁 에러 ", error)
                } else {
                    print("핑")
                }
            })
        })
    }
}
