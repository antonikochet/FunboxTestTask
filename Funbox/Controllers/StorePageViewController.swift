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
            storeFrontVC.activity?.startAnimating()
            storeFrontVC.activity?.isHidden = false
            self?.deviceProvider.buy(localDevice) { device in
                guard device != nil else { return }
                DispatchQueue.main.async {
                    storeFrontVC.activity?.stopAnimating()
                    storeFrontVC.activity?.isHidden = true
                    storeFrontVC.device = device
                }
            }
            
            self?.buyLastDevice(localDevice, currectVC: storeFrontVC)
        }
        return storeFrontVC
    }
    
    private func buyLastDevice(_ device: Device, currectVC: StoreFrontContentViewController) {
        guard device.count <= 1 else { return }
        let index = currectVC.pageNumber
        
        let nextPageDevice = index == deviceProvider.count - 1 ? index - 1 : index + 1
        if let nextVC = showViewController(at: nextPageDevice) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                if let firstVC = self.viewControllers?.first,
                    firstVC == currectVC {
                    print("currectVC:", currectVC, "firstVC:", firstVC)
                    self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
                }
            }
        }
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
