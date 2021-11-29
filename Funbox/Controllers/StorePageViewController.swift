//
//  StorePageViewController.swift
//  Funbox
//
//  Created by Антон Кочетков on 25.11.2021.
//

import UIKit

class StorePageViewController: UIPageViewController {

    private var deviceProvider: StoreFrontProviderProtocol
    
    init(provider: StoreFrontProviderProtocol) {
        deviceProvider = provider
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contentVC = showViewController(at: 0) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }

    func updateContent() {
        guard let currectVC = viewControllers?.first as? StoreFrontContentViewController else { return }
        guard let device = deviceProvider.view(with: currectVC.pageNumber) else { return }

        if device != currectVC.device {
            currectVC.device = device
        }
    }
    
    private func showViewController(at index: Int) -> StoreFrontContentViewController? {
        guard index >= 0 && index <= deviceProvider.count else { return nil }
        guard let device = deviceProvider.view(with: index) else { return nil }
        guard device.count > 0 else { return nil }
        
        let storeFrontVC = StoreFrontContentViewController()
        storeFrontVC.device = device
        storeFrontVC.pageNumber = index
        storeFrontVC.buy = { [weak self] localDevice in
            let newDevice = self?.deviceProvider.buy(localDevice)
            storeFrontVC.device = newDevice != nil ? newDevice : device
        }
        return storeFrontVC
    }
}

extension StorePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! StoreFrontContentViewController).pageNumber
        pageNumber -= 1
        
        return showViewController(at: pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! StoreFrontContentViewController).pageNumber
        pageNumber += 1
        
        return showViewController(at: pageNumber)
    }
}

extension StorePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let storeFront = pendingViewControllers.first as? StoreFrontContentViewController else { return }
        guard let device = deviceProvider.view(with: storeFront.pageNumber) else { return }
        
        if device != storeFront.device {
            storeFront.device = device
        }
    }
}
