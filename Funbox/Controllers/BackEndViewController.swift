//
//  BackEndTableViewController.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import UIKit

class BackEndViewController: UITableViewController {

    private var deviceProvider: BackEndProviderProtocol
    
    init(provider: BackEndProviderProtocol) {
        deviceProvider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DeviceCell.self, forCellReuseIdentifier: DeviceCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        setupNavBar()
    }

    func updateContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    private func setupNavBar() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewDevice))
        button.tintColor = .black
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func addNewDevice() {
        let detailVC = DetailViewController()
        detailVC.delegateAdd = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - TableView Data source
extension BackEndViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceProvider.countTable
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier, for: indexPath) as? DeviceCell {
            if let device = deviceProvider.getDevice(by: indexPath.row) {
                cell.configure(name: device.name, count: device.count)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deviceProvider.deleteDevice(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

//MARK: - TableView Delegate
extension BackEndViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = deviceProvider.getDevice(by: indexPath.row)
        let editDeviceVC = DetailViewController()
        editDeviceVC.currectDevice = device
        editDeviceVC.delegateEdit = self
        navigationController?.pushViewController(editDeviceVC, animated: true)
    }
}

extension BackEndViewController: AddDeviceDelegate {
    func addDevice(_ device: Device) {
        deviceProvider.addDevice(device)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BackEndViewController: EditDeviceDelegate {
    func editDevice(_ device: Device) {
        if let indexRow = tableView.indexPathForSelectedRow {
            deviceProvider.editingDevice(device, index: indexRow.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
