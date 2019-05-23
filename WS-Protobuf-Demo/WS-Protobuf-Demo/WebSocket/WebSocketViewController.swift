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

    @IBOutlet weak var tableView: UITableView!
    
    let socket = WebSocket(url: URL(string: "ws://localhost:8080/")!, protocols: ["echo-protocol"])
    var dataList: [BookInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        if let error = error {
            print(error)
            return
        }
        print("disconnected..")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        guard let book = try? BookInfo(serializedData: data) else {
            print("failed")
            return
        }
        print(book)
        dataList.append(book)
    }
}

extension WebSocketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let book = dataList[indexPath.row]
        cell.textLabel?.text = "\(book.id): \(book.title) by \(book.author)"
        return cell
    }
}

extension WebSocketViewController: UITableViewDelegate {
    
}
