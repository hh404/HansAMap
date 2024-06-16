//
//  ViewController.swift
//  HansAMap
//
//  Created by hanshuang on 2024/6/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = LocationPickerViewController()
        present(vc, animated: true)
    }

}

//import UIKit
//import AMapSearchKit
//import AMapFoundationKit
//import MAMapKit
//
//class LocationPickerViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate {
//
//    var mapView: MAMapView!
//    var search: AMapSearchAPI!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 设置高德地图服务的 API Key
//        AMapServices.shared().apiKey = "9b7a1fba3f976b92cf9072bc4147a627"
//        // 设置隐私政策显示和同意状态
//        // 设置隐私政策显示和同意状态
//        MAMapView.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
//        MAMapView.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
//
//        // 初始化地图视图
//        mapView = MAMapView(frame: self.view.bounds)
//        mapView.delegate = self
//        self.view.addSubview(mapView)
//
//        // 初始化搜索 API
//        search = AMapSearchAPI()
//        search.delegate = self
//
//        // 设置地图中心点
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074), animated: true)
//
//        // 添加大头针
//        let annotation = MAPointAnnotation()
//        annotation.coordinate = mapView.centerCoordinate
//        mapView.addAnnotation(annotation)
//        
//        // 搜索附近的POI
//        searchNearbyPOI()
//    }
//
//    func searchNearbyPOI() {
//        let request = AMapPOIAroundSearchRequest()
//        request.location = AMapGeoPoint.location(withLatitude: CGFloat(mapView.centerCoordinate.latitude), longitude: CGFloat(mapView.centerCoordinate.longitude))
//        request.keywords = "景点"
//        request.radius = 1000
//        search.aMapPOIAroundSearch(request)
//    }
//
//    // MARK: - AMapSearchDelegate
//
//    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
//        if response.count == 0 {
//            return
//        }
//
//        // 展示搜索结果
//        for poi in response.pois {
//            print("POI: \(poi.name), 地址: \(poi.address)")
//        }
//    }
//
//    // MARK: - MAMapViewDelegate
//
//    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
//        let reuseIdentifier = "annotationReuseIdentifier"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MAPinAnnotationView
//
//        if annotationView == nil {
//            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            annotationView?.canShowCallout = true
//        }
//
//        annotationView?.annotation = annotation
//        return annotationView
//    }
//}

import UIKit
import AMapSearchKit
import AMapFoundationKit
import MAMapKit
import AMapLocationKit

//import UIKit
//import MAMapKit
//import AMapSearchKit

/*class LocationPickerViewController: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var mapView: MAMapView!
    var locationManager: AMapLocationManager!
    var search: AMapSearchAPI!
    var tableView: UITableView!
    var poiArray: [AMapPOI] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化地图视图
        // 设置高德地图服务的 API Key
        AMapServices.shared().apiKey = "026ccdebc467187b9357bd2e72a0e217"
        AMapServices.shared().enableHTTPS = true
        // 设置隐私政策显示和同意状态
        MAMapView.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
        MAMapView.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
        mapView = MAMapView(frame: self.view.bounds)
        mapView.zoomLevel = 15
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        // 初始化位置管理器
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        // 初始化搜索API
        search = AMapSearchAPI()
        search.delegate = self
        
        // 初始化TableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        // 注册 cell class
              tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
              
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8), // 保留8像素空隙
            tableView.heightAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    // MARK: - AMapLocationManagerDelegate
    func amapLocationManager(_ manager: AMapLocationManager, didUpdate location: CLLocation?) {
        guard let location = location else { return }
        let coordinate = location.coordinate
        
        // 在地图上标记当前位置
        let annotation = MAPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "当前位置"
        mapView.addAnnotation(annotation)
        mapView.setCenter(coordinate, animated: true)
        
        // 搜索当前位置的POI
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        request.radius = 1000
//        request.types = "餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅"
                search.aMapPOIAroundSearch(request)
        
        // 创建并配置请求
//        let request = AMapPOIKeywordsSearchRequest()
//        request.keywords = "天津大学"
//        request.city = "天津"
//        request.types = "高等院校"
////        request.requireExtension = true
//        request.cityLimit = true
////        request.requireSubPOIs = true
//        
//        // 发起搜索
//        search.aMapPOIKeywordsSearch(request)

    }
    
    // MARK: - AMapSearchDelegate
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count > 0 {
            poiArray = response.pois
            tableView.reloadData()
        }
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print("🧚‍♀️🧚‍♀️🧚‍♀️Error: \(error.localizedDescription)")
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let poi = poiArray[indexPath.row]
        cell.textLabel?.text = poi.name
        cell.detailTextLabel?.text = poi.address
        return cell
    }
}*/

class LocationPickerViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var mapView: MAMapView!
    var search: AMapSearchAPI!
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var pois: [AMapPOI] = []
    var filteredPOIs: [AMapPOI] = []
    var searchBarTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置高德地图服务的 API Key
        AMapServices.shared().apiKey = "026ccdebc467187b9357bd2e72a0e217"
        AMapServices.shared().enableHTTPS = true
        // 设置隐私政策显示和同意状态
        MAMapView.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
        MAMapView.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
        
        // 初始化地图视图
        mapView = MAMapView(frame: .zero)
        mapView.delegate = self
        mapView.zoomLevel = 15 // 设置缩放级别
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4) // 地图高度占屏幕高度的40%
        ])
        
        // 初始化搜索栏
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "搜索地点"
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBarTopConstraint = searchBar.topAnchor.constraint(equalTo: mapView.bottomAnchor)
        NSLayoutConstraint.activate([
            searchBarTopConstraint,
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        // 初始化 TableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 初始化搜索API
        search = AMapSearchAPI()
        search.delegate = self
        
        // 获取当前定位
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // 请求周边POI
        requestPOI()
        
        // 监听键盘事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.contentInset.bottom = keyboardFrame.height
            self.searchBarTopConstraint.constant = -self.mapView.frame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.contentInset.bottom = 0
            self.searchBarTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func requestPOI() {
        guard let location = mapView.userLocation.location else {
            print("User location is not available")
            return
        }
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
        request.keywords = ""
        request.radius = 1000
//        request.requireExtension = true
        
        search.aMapPOIAroundSearch(request)
    }
    
    // MARK: - MAMapViewDelegate
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            print("latitude:\(userLocation.coordinate.latitude), longitude:\(userLocation.coordinate.longitude)")
            requestPOI() // 位置更新后重新发起请求
        }
    }
    
    // MARK: - AMapSearchDelegate
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count > 0 {
            pois = response.pois
            filteredPOIs = pois
            tableView.reloadData()
        } else {
            print("No POI found")
        }
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print("Error: \(error.localizedDescription)")
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPOIs = pois
        } else {
            filteredPOIs = pois.filter { poi in
                return poi.name.contains(searchText) || poi.address.contains(searchText)
            }
        }
        tableView.reloadData()
        updateSearchBarPosition()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPOIs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let poi = filteredPOIs[indexPath.row]
        cell.textLabel?.text = poi.name
        cell.detailTextLabel?.text = poi.address
        return cell
    }
    
    // 更新searchBar位置
    func updateSearchBarPosition() {
        let tableHeight = tableView.contentSize.height
        let maxSearchBarTop = view.safeAreaLayoutGuide.topAnchor
        let newSearchBarTop = min(mapView.frame.height + searchBar.frame.height, tableHeight)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(searchBar.constraints)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: maxSearchBarTop, constant: newSearchBarTop)
        ])
    }
}
