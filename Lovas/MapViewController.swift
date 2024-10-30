//
//  MapViewController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 01/07/2024.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore

class MapViewController: UIViewController 
{

// MARK: VIEW DID LOAD ------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Feliratkozás értesítésekre
        NotificationCenter.default.addObserver(self, selector: #selector(locationsDownloaded), name: .locationsDownloaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lovardaSelected), name: .lovardaSelected, object: nil)
        
        mapView?.delegate = self
        setMap()
        createAnnotations()
        
        // --- user lokációjának kérése --- //
        guard let locationManager = locationManager else { return }
        requestLocationAuthorazition()
        locationManager.startUpdatingLocation()
        mapView?.showsUserLocation = true
        // -------------------------------- //
        
        // gomb létrehozása, és elhelyezése
        searchButton = createButton()
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        print("⚠️ - SEARCH VIEW: VIEW DID LOAD lefutott")
    }
// MARK: VIEW WILL APPEAR ------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        print("⚠️ - MAP VIEW: VIEW WILL APPEAR lefutott")
    }
    
// MARK: NOTIFICATION CENTERTŐL ÉRKEZŐ ÉRTESÍTÉS KEZELÉSE
    @objc func locationsDownloaded()
    {
        createAnnotations()
    }
    
    @objc func lovardaSelected()
    {
        let lovardaID = DataStorage.shared.getLovarda()?.id
        guard let lovardaID = lovardaID else { return }
        
        let annotation = annotationSearch(lovardaID: lovardaID)
        guard let annotation = annotation else { return }
        
        mapView?.selectAnnotation(annotation, animated: true)
    }
    

// MARK: TÉRKÉP LÉTREHOZÁSA ÉS BEÁLLÍTÁSA ------------------------------------------------------------------
    public var mapView: MKMapView? =
    {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()
    
    func setMap()
    {
        // Térkép felhelyezése a nézetre
        if let mapView = mapView
        {
            self.view.addSubview(mapView)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
                mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ])
        }
    }
    
    
    // Éppen nem látható annotációk törlése
    /*
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    {
        let visibleMapRect = mapView.visibleMapRect
        let allAnnotations = mapView.annotations
            
        let annotationsToRemove = allAnnotations.filter { !visibleMapRect.contains(MKMapPoint($0.coordinate)) }
        let annotationsToAdd = allAnnotations.filter { visibleMapRect.contains(MKMapPoint($0.coordinate)) }
            
        mapView.removeAnnotations(annotationsToRemove)
        mapView.addAnnotations(annotationsToAdd)
    }
     */
    
    func createAnnotations()
    {
        var annotation: CustomAnnotation!
        // Annotációk létrehozása és felhelyezése a térképre Locationökből
        for location in DataStorage.shared.getLocationStorage()
        {
            annotation = CustomAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                title: location.name, lovardaID: location.lovardaID)
            mapView?.addAnnotation(annotation)
        }
        if (DataStorage.shared.getLocationStorage().count != 0)
        {
            print("⚠️ - Felhelyezés sikeres")
        }
    }
    
// MARK: SEARCH BUTTON ------------------------------------------------------------------
    var searchButton = UIButton()
    func createButton() -> UIButton
    {
        // Kinézet
        let customButton = UIButton(type: .system)
        customButton.backgroundColor = Colors.lightBlue09.color
        let searchImage = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
        customButton.tintColor = Colors.paleBlue.color
        customButton.setImage(searchImage, for: .normal)

        customButton.layer.cornerRadius = 35
        customButton.layer.masksToBounds = true
        
        // Elhelyezés

        
        customButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return customButton
    }
    
    // Metódus a keresőgomb megnyomására
    @objc func searchButtonTapped()
    {
        let vc = UINavigationController(rootViewController: SearchTableViewController())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }

//MARK: DEINIT
    deinit {
        print("⚠️ - MAP VIEW: DEINIT lefutott")
    }
    
// MARK: FELHASZNÁLÓ LOKÁCIÓJÁNAK LEKÉRÉSE 1 ------------------------------------------------------------------
    var locationManager: CLLocationManager? = CLLocationManager()
}

// MARK: FELHASZNÁLÓ LOKÁCIÓJÁNAK LEKÉRÉSE 2 ------------------------------------------------------------------
extension MapViewController: CLLocationManagerDelegate
{
    func requestLocationAuthorazition()
    {
        guard let locationManager = locationManager else { return }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        let status = locationManager.authorizationStatus
        
        // Helylekérés státuszának ellenőrzése
        switch status
        {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            print("-- helymeghatározás kérve --")
        case .authorizedWhenInUse, .authorizedAlways:
            print("-- helymeghatározás engedélyezve --")
        case .denied, .restricted:
            print("-- helymeghatározás elutasítva --")
        @unknown default:
            print("-- helymeghatározási státusz ismeretlen --")
        }
    }
    
    // Helyzet lekérése után lefutó metódus -- amennyiben sikeres --
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let locationManager = locationManager,
              let location = locations.last else { return }
                
                // Térkép beállítása az aktuális helyszínre
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                mapView?.setRegion(region, animated: true)
                
                // Helyszolgáltatások leállítása
                locationManager.stopUpdatingLocation()
        
        print("✅ - Get user's location")
    }
    
    // Helyzet lekérése után lefutó metódus -- amennyiben sikertelen --
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
            print("❌ - Get user's location: \(error.localizedDescription)")
    }

// MARK: LOVARDA ÉS ANNOTÁCIÓ KERESÉS ID ALAPJÁN
    func lovardaSearch(lovardaID: String) -> Lovarda?
    {
        for lovarda in DataStorage.shared.getLovardaStorage()
        {
            if lovardaID == lovarda.id { return lovarda }
        }
        return nil
    }
    
    func annotationSearch(lovardaID: String) -> CustomAnnotation?
    {
        if let mapView = mapView
        {
            for annotation in mapView.annotations
            {
                if let annotation = annotation as? CustomAnnotation
                {
                    if lovardaID == annotation.lovardaID
                    {
                        return annotation
                    }
                }
            }
        }
        return nil
    }
}

// MARK: PIN MEGNYITÁSÁNAK ÉS PIN KINÉZETÉNEK BEÁLLÍTÁSA ÉS MAP TOVÁBBI BEÁLLÍTÁSAI -------------------------------------------------------------
extension MapViewController: MKMapViewDelegate
{
    // Annotációra kiválasztása
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotation = view.annotation as? CustomAnnotation
        {
            Task
            {
                setRegionForMap(mapView, didSelect: view)
                DataStorage.shared.setLovarda(lovarda: lovardaSearch(lovardaID: annotation.lovardaID)!)
                let images = await Lovarda.DownloadImages()
                DataStorage.shared.setLovardaKepek(images: images)
                presentLovardaInfo()
            }
        } else { mapView.deselectAnnotation(view.annotation, animated: false) }

    }
    
    // Annotáció kiválasztása esetén térkép helyzetének beállítása
    func setRegionForMap(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotation = view.annotation as? CustomAnnotation
        {
            // Térkép nézetének megfelelő helyre való igazítása
            let region = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude - 0.005, longitude: annotation.coordinate.longitude)
            let newRegion = MKCoordinateRegion(center: region, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(newRegion, animated: true)
            
            // Animáció annotáció kiválasztásakor
            UIView.animate(withDuration: 0.3) {
                let scaleTranform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                view.transform = scaleTranform
            }
        }
    }
    
    // lovarda info megjelenítése
    func presentLovardaInfo()
    {
        // LovardaInfoViewController() megjelenítésének beállítása
        let vc = LovardaInfoViewController()
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController
        {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            
        }
        present(vc, animated: true, completion: nil)
    }
    
    // Annotáció kinézetének beállítása
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation { return nil }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "lovardaPin")
        annotationView.image = UIImage(named: "pin")
        let transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        annotationView.transform = transform
        return annotationView
    }
//MARK: PIN KIVÁLASZTÁSÁNAK MEGSZÜNTETÉSE
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
    {
        if view.annotation is CustomAnnotation
        {
            UIView.animate(withDuration: 0.15)
            {
                let scaleTranform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                view.transform = scaleTranform
            }
        }
        DataStorage.shared.setLovarda(lovarda: nil)
        DataStorage.shared.setLovardaKepek(images: [])
    }
}

extension MapViewController
{
    func cleanUpMapView()
    {
        // Memória felsazbadítása oldalváltáskor
        if let mapView = mapView
        {
            mapView.delegate = nil
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeFromSuperview()
        }
        mapView = nil
        searchButton.removeFromSuperview()
        locationManager = nil
        NotificationCenter.default.removeObserver(self)
    }
// MARK: VIEW DID DISAPPEAR
    override func viewDidDisappear(_ animated: Bool)
    {
        //cleanUpMapView()
        print("⚠️ - MAP VIEW: VIEW DID DISAPPEAR lefutott")
    }
}
