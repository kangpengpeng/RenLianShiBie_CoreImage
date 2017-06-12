//
//  CameraViewController.swift
//  人脸识别
//
//  Created by 康鹏鹏 on 2017/6/8.
//  Copyright © 2017年 dhcc. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // 按钮响应事件
    @IBAction func btnAction(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        // 自定义拍照界面设置为false
        imagePicker.showsCameraControls = false
        
        let customCameraView = UIView()
        customCameraView.frame = CGRect(x: 50, y: 100, width: 150, height: 150)
        customCameraView.center = self.view.center
        customCameraView.frame.size = CGSize(width: 150, height: 150)
        customCameraView.layer.borderColor = UIColor.gray.cgColor
        customCameraView.layer.borderWidth = 2
        customCameraView.layer.cornerRadius = 75
        customCameraView.clipsToBounds = true
        customCameraView.backgroundColor = UIColor.white
        
        
        // 将自定义的相机界面赋值给cameraOverlayView属性即可显示自定义界面
//        imagePicker.cameraOverlayView = customCameraView
        imagePicker.cameraOverlayView?.center = self.view.center
        imagePicker.cameraOverlayView?.frame.size = CGSize(width: 150, height: 150)
        imagePicker.cameraOverlayView?.layer.borderWidth = 2
        imagePicker.cameraOverlayView?.layer.cornerRadius = 75
        imagePicker.cameraOverlayView?.layer.borderColor = UIColor.gray.cgColor
        imagePicker.cameraOverlayView?.clipsToBounds = true
        
        imagePicker.cameraOverlayView = customCameraView
        
        self.present(imagePicker, animated: true, completion: nil)

        
//        self.overlayView.frame = self.imagePikerViewController.cameraOverlayView.frame;
//        self.overlayView.backgroundColor = [UIColor clearColor];
//        self.imagePikerViewController.cameraOverlayView = self.overlayView;
//        self.overlayView = nil;
//        [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
        
        

    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 取出照片
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.contentMode = .scaleAspectFit
            imgView.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}
