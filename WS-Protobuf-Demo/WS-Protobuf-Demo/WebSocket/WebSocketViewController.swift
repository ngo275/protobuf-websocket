//
//  WebSocketViewController.swift
//  WS-Protobuf-Demo
//
//  Created by ShuichiNagao on 2019/05/23.
//  Copyright © 2019 Shuichi Nagao. All rights reserved.
//

import UIKit
import Starscream

class WebSocketViewController: UIViewController {

    let socket = WebSocket(url: URL(string: "ws://localhost:8080/")!, protocols: ["echo-protocol"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        socket.delegate = self
        socket.connect()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension WebSocketViewController: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("connected!!")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print(error)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print(data)
    }
}
