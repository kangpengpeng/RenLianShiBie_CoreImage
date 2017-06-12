//
//  ViewController.swift
//  人脸识别
//
//  Created by 康鹏鹏 on 2017/6/8.
//  Copyright © 2017年 dhcc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var faceImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        imgView.contentMode = .scaleAspectFit
        self.detectFace(withImage: imgView.image!)
        
        
    }
    
    

    func detectFace(withImage image: UIImage) {
        // 将图像转为CIImage，使用Core Image需要使用CIImage
        guard let personCIImg = CIImage(image: image) else {
            return
        }
        // 设置识别精度
        let opts: [String: Any] = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        // 初始化识别器
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: opts)
        
        let result: [CIFaceFeature] = (detector?.features(in: personCIImg, options: opts) as? [CIFaceFeature])!
        
        let CIImgSize = personCIImg.extent.size
        print("CIImgSize -----> %d", CIImgSize)
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -CIImgSize.height)
        
        if result.count > 0 {
            for face in result {
                
                // Apply the transform to convert the coordinates
                var faceViewBounds = face.bounds.applying(transform)
                
                // Calculate the actual position and size of the rectangle in the image view
                let viewSize = imgView.bounds.size
                let scale = min(viewSize.width / CIImgSize.width,
                                viewSize.height / CIImgSize.height)
                let offsetX = (viewSize.width - CIImgSize.width * scale) / 2
                let offsetY = (viewSize.height - CIImgSize.height * scale) / 2
                
                faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
                print("faceViewBounds前 -----> %d", faceViewBounds)

                faceViewBounds.origin.x += offsetX
                faceViewBounds.origin.y += offsetY
                
                let faceBox = UIView(frame: faceViewBounds)
                
                print("viewSize -----> %d", viewSize)
                
                print("image.size -----> %@", imgView.image?.size)

                print("scale -----> %d", scale)

                print("faceViewBounds后 -----> %d", faceViewBounds)

                // 画一个红框画出面部位置
                faceBox.layer.borderWidth = 3
                faceBox.layer.borderColor = UIColor.red.cgColor
                faceBox.backgroundColor = UIColor.clear
                // 添加红框到图片上
                imgView.addSubview(faceBox)
                
                let clipFrame = CGRect(x: 0, y: 0, width: 500, height: 500)

//                let imgScale = UIScreen.main.scale
//                let clipFrame = CGRect(x: faceViewBounds.origin.x*imgScale, y: faceViewBounds.origin.y*imgScale, width: faceViewBounds.size.width*imgScale, height: faceViewBounds.size.height*imgScale)

//                self.faceImgView.image = self.imgView.image?.getSubImage(clipFrame)
                
//                let clipFrame = CGRect(x: faceViewBounds.origin.x/0.3125, y: (faceViewBounds.origin.y-50)/0.3125, width: faceViewBounds.size.width/0.3125, height: faceViewBounds.size.height/0.3125)

                
                self.faceImgView.image = self.cutImage(withImage: imgView.image!, rect: clipFrame)

                if face.rightEyeClosed {
                    print("右眼闭着")
                }
                if face.leftEyeClosed {
                    print("左眼闭着")
                }
                if face.hasSmile {
                    print("在笑")
                }
                

                
                
                

            }
        }
    }
    
    /// 裁剪图片
    func cutImage(withImage image: UIImage, rect: CGRect) -> UIImage {
        
        let cgImage: CGImage = image.cgImage!

        let imagePart: CGImage = cgImage.cropping(to: rect)!

        let newImg = UIImage.init(cgImage: imagePart)
        
        return newImg

    }
    
    
    
    // 坐标转换前
    func detectFace0(withImage image: UIImage) {
        // 将图像转为CIImage，使用Core Image需要使用CIImage
        guard let personCIImg = CIImage(image: image) else {
            return
        }
        // 设置识别精度
        let opts: [String: Any] = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        // 初始化识别器
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: opts)
        
        let result: [CIFaceFeature] = (detector?.features(in: personCIImg, options: opts) as? [CIFaceFeature])!
        
        if result.count > 0 {
            for face in result {
                let faceBox = UIView(frame: face.bounds)
                
                // 画一个红框画出面部位置
                faceBox.layer.borderWidth = 3
                faceBox.layer.borderColor = UIColor.red.cgColor
                faceBox.backgroundColor = UIColor.clear
                // 添加红框到图片上
                imgView.addSubview(faceBox)
                print("面部坐标------> %d ", faceBox.frame)
                
            }
        }
    }
    
    
    



}

