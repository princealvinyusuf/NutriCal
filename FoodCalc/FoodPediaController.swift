//
//  ViewController.swift
//  FoodPedia
//
//  Created by Prince Alvin Yusuf on 23/05/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class FoodPediaController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // IBA
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var imageIllustration: UIImageView!
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        actionSheet()
    }
    
    
    // Variable
    let imagePicker = UIImagePickerController()
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imageIllustration.isAccessibilityElement = true
        imageIllustration.accessibilityTraits = .image
        imageIllustration.accessibilityLabel = "scanning your food with the camera"
    }
    
    func actionSheet() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in self.openCamera()}))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {_ in self.openGallery()}))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "Your Camera is Broken", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion:  nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access gallery", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                fatalError("Cannot convert to CIImage")
            }
            
            detect(image: convertedCIImage)
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: NutriCal01().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) {(request, error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image.")
            }
            
            self.navigationItem.title = classification.identifier.capitalized
            self.requestInfo(foodName: classification.identifier)
            self.imageView.isAccessibilityElement = true
            self.imageView.accessibilityTraits = .image
            self.imageView.accessibilityLabel = "Picture of \(classification.identifier)"
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
            
        catch {
            print(error)
        }
    }
    
    func requestInfo(foodName: String) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : foodName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
        ]
        
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got the wikipedia info.")
                print(response)
                
                let foodJSON: JSON = JSON(response.result.value!)
                
                let pageid = foodJSON["query"]["pageids"][0].stringValue
                let foodDescription = foodJSON["query"]["pages"][pageid]["extract"].stringValue
                
                let foodImageURL = foodJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                self.imageView.sd_setImage(with: URL(string: foodImageURL))
                self.imageView.contentMode = .scaleAspectFill
                self.imageIllustration.isHidden = true
                self.txtView.text = foodDescription
            }
        }
    }
    
    
}


