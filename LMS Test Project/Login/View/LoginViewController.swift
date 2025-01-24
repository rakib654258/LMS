//
//  LoginViewController.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 20/1/25.
//

import UIKit

enum SegmentType: String {
    case face = "Face"
    case fingerprint = "Fingerprint"
}

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var authTypeContainerView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var segmentBGView: UIView!
    @IBOutlet weak var segmentSelectedView: UIView!
    @IBOutlet weak var unselectedSegmentButton: UIButton!
    @IBOutlet weak var selectedSegmentButton: UIButton!
    @IBOutlet weak var biomatricImage: UIImageView!
    @IBOutlet weak var selectedSegmentTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedSegmentLeadingConstraint: NSLayoutConstraint!
    
    private let viewModel = LoginViewModel()
    
    private var selectedSegmentType: SegmentType = SegmentType.fingerprint
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        loginButton.layer.cornerRadius = 8
        authTypeContainerView.layer.cornerRadius = 5
        
        let cornerRadious = segmentBGView.frame.height / 2
        segmentBGView.layer.cornerRadius = cornerRadious
        segmentSelectedView.layer.cornerRadius = cornerRadious
        authTypeContainerView.isHidden = true
        
        subTitleLabel.text = "Scan your Finger"
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        loginButton.isHidden = true
        authTypeContainerView.isHidden = false
    }
    
    @IBAction func segmentButtonAction(_ sender: UIButton) {
        
        if selectedSegmentType == .fingerprint {
            selectedSegmentType = .face
            selectedSegmentLeadingConstraint.constant = 36
            selectedSegmentTraillingConstraint.constant = 36
            subTitleLabel.text = "Use Face Recognition"
            unselectedSegmentButton.setTitle("Fingerprint", for: .normal)
            selectedSegmentButton.setTitle("Face", for: .normal)
            biomatricImage.image = UIImage(named: "face-scanner")
            
        } else {
            selectedSegmentType = .fingerprint
            selectedSegmentLeadingConstraint.constant = 24
            selectedSegmentTraillingConstraint.constant = 24
            subTitleLabel.text = "Scan your Finger"
            unselectedSegmentButton.setTitle("Face", for: .normal)
            selectedSegmentButton.setTitle("Fingerprint", for: .normal)
            biomatricImage.image = UIImage(named: "fingerprint")
        }
    }
    
    // Helper to show alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func biomatricAuthAction(_ sender: UIButton) {
        // Check and display the biometric type
        let biometricType = viewModel.getBiometricType()
        switch biometricType {
        case .faceID:
            print("Face ID is available.")
            if selectedSegmentType == .face {
                authenticateUser()
            } else {
                showAlert(title: "Error", message: "Fingerprint not available.")
            }
        case .touchID:
            print("Touch ID is available.")
            if selectedSegmentType == .fingerprint {
                authenticateUser()
            } else {
                showAlert(title: "Error", message: "Face ID not available.")
            }
        default:
            print("Biometrics are not available.")
            showAlert(title: "Error", message: "Biometrics are not available.")
        }
    }
    private func authenticateUser() {
        viewModel.authenticateUser { [weak self] result in
            switch result {
            case .success:
                
                UserDefaults.standard.setValue(true, forKey: "isLogedIn")
                (UIApplication.shared.delegate as? AppDelegate)?.loadHomeScene()
                
            case .failure(let error):
                self?.showAlert(title: "Error", message: error)
            case .unavailable(let message):
                self?.showAlert(title: "Unavailable", message: message)
            }
        }
    }
}

