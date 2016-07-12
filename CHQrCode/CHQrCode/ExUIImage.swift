//
//  ExUIImage.swift
//  CHQrCode
//
//  Created by 杨辉 on 16/7/10.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

enum CenterImgType {
    case Square, Circle, CornorRadious;
}

extension UIImage{
    
    /**
     *  异步生成原始的二维码（中间不带图片）
     *
     *  @param string 数据
     *  @param size 二维码的大小
     *  @param completion 二维码制作成功回调block
     */
    func qrImage(WithString string:NSString, Size size:CGFloat, Completion completion:(UIImage) -> Void){
        self.qrImage(WithString: string, Size: size, IconImage: nil, Scale: 0, Completion: completion);
    }
    
    ///  异步生成二维码图像(默认方形，默认比例)
    ///
    /// @param string     二维码图像的字符串
    /// @param size       二维码的大小
    /// @param iconIamge  头像图像，默认比例 0.2
    /// @param completion 完成回调
    func qrImage(WithString string:NSString, Size size:CGFloat, IconImage iconImage:UIImage?, Completion completion: (UIImage) -> Void){
        self.qrImage(WithString: string, Size: size, IconImage: iconImage, Scale: 0.20, Completion: completion);
    }
    
    /// 异步生成二维码图像(默认方形，指定比例)
    ///
    /// @param string     二维码图像的字符串
    /// @param size       二维码的大小
    /// @param iconImage  头像图像
    /// @param scale      头像占二维码图像的比例
    /// @param completion 完成回调
    func qrImage(WithString string:NSString, Size size:CGFloat, IconImage iconImage:UIImage?, Scale scale:CGFloat, Completion completion: (UIImage) -> Void){
        self.qrImage(WithString: string, Size: size, ImageType: CenterImgType.Square, IconImage: iconImage, Scale: scale, Completion: completion);
    }
    
    /**
     *  异步生成带图片的二维码 (指定形状，指定比例)
     *
     *  @param string    数据
     *  @param size      二维码的大小
     *  @param type      自定义二维码图片的种类（中间图片为方形，中间图片为圆形）
     *  @param image     中间图片
     *  @param imageSize 中间图片的大小
     *  @param completion 二维码制作成功回调block
     */
    func qrImage(WithString string:NSString, Size size:CGFloat, ImageType type:CenterImgType, IconImage iconImage:UIImage?, Scale scale:CGFloat, Completion completion: (UIImage) -> Void){
        //ToDo 寻找增加断言的方法
//        assert(completion == nil, "必须传入完成回调");
        
        DispatchQueue.global().async(execute: {
//            let ciImage = UIImage(contentsOfFile: string);
//            let qrImage =
            var ciImage = UIImage.qrImage(WithString: string);
            var qrImage = UIImage.qrImage(CodeImage: ciImage, Size: size);
//            qrImage = self.qrImage
        })
    }
    
    /**
     *  为二维码添加自定义背景，二维码形状为方形
     *
     *  @param qrImage     二维码图片
     *  @param bgImage     背景图片
     *  @param bgImageSize 背景图片大小
     *  @param completion  成功回调block
     */
    func qrImage(_ qrImage:UIImage, AddBgImage bgImage:UIImage, Size size:CGFloat, Completion completion: (UIImage) -> Void){
        
    }
    
    /**
     *  为二维码添加自定义背景,设置二维码显示形状
     *
     *  @param qrImage     二维码
     *  @param type        形状
     *  @param bgImage     背景图片
     *  @param bgImageSize 背景图片大小
     *  @param completion  成功回调
     */
    func qrImage(_ qrImage:UIImage, ImageType type:CenterImgType, AddBgImage bgImage:UIImage, Size size:CGFloat, Completion completion: (UIImage) -> Void){
        
    }
    
    private class func qrImage(WithString string:NSString) -> CIImage?{
        let qrFilter = CIFilter(name: "CIQRCodeGenerator");
        qrFilter?.setDefaults();
        qrFilter?.setValue(string.data(using: String.Encoding.utf8.rawValue), forKey: "inputMessage");
        let ciImage = qrFilter?.outputImage;
        
        return ciImage;
    }
    
    private class func qrImage(CodeImage ciImage:CIImage?, Size size:(CGFloat)) -> UIImage?{
        let extent = ciImage?.extent.integral;
        let scale = min(size / (extent?.width)!, size / (extent?.height)!);
        
        let  width = (extent?.width)! * scale;
        let height = (extent?.height)! * scale;
        let cs = CGColorSpaceCreateDeviceGray();
        //下面这个对象相当于android中的Canvas，mfc中的DC
        var bitmapRef = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue);
        let context = CIContext.init(options: nil);
        var bitmapImage = context.createCGImage(ciImage!, from: extent!);
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none;
        bitmapRef?.scale(x: scale, y: scale);
        bitmapRef?.draw(in: extent!, image: bitmapImage!);
        
        let scaledImage = bitmapRef?.makeImage();
        bitmapRef = nil;
        bitmapImage = nil;
        
        return UIImage(cgImage: scaledImage!, scale: UIScreen.main().scale, orientation: .up);
    }
    
    private class func qrImage(CodeImage qrImage:UIImage?, Add iconImage:UIImage?, ImageType type:CenterImgType, Scale scale:(CGFloat)) -> UIImage?{
        let screenScale = UIScreen.main().scale;
        let rect = CGRect(x:0, y:0, width:(qrImage?.size.width)! * screenScale, height:(qrImage?.size.height)! * screenScale);
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, screenScale);
        qrImage?.draw(in: rect);
        
        var tempIconImage:UIImage? = nil;
        
        if iconImage != nil{
            let avatarSize = CGSize(width: rect.size.width * scale, height: rect.size.height * scale);
            let x = (rect.size.width - avatarSize.width) * 0.5;
            let y = (rect.size.height - avatarSize.height) * 0.5;
            
            if type == CenterImgType.Circle {
                tempIconImage = UIImage.createCircularImage(IconImage: iconImage);
            }
            else if type == CenterImgType.CornorRadious {
                tempIconImage = UIImage.image(WithRoundedCorners: iconImage, Size: avatarSize, CornerRadius: 5.0);
            }
            
            iconImage?.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height));
        }
        
        var result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return UIImage(cgImage: result!.cgImage!, scale: screenScale, orientation: UIImageOrientation.up);
    }
    
    private class func createCircularImage(IconImage iconImage:UIImage?) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions((iconImage?.size)!, false, 0);
        
        let ctx = UIGraphicsGetCurrentContext();
        
        ctx?.addEllipse(inRect: CGRect(x: 0, y: 0, width: (iconImage?.size.width)!, height: (iconImage?.size.height)!));
        
        ctx?.clip();
        
        iconImage?.draw(in: CGRect(x: 0, y: 0, width: (iconImage?.size.width)!, height: (iconImage?.size.height)!));
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    private class func image(WithRoundedCorners image:UIImage?, Size sizeToFit:CGSize, CornerRadius radius:CGFloat) -> UIImage?{
        let rect = CGRect(x: 0.0, y: 0.0, width: sizeToFit.width, height: sizeToFit.height);
        
        UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.main().scale);
        
        let context = UIGraphicsGetCurrentContext();
    
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath);
        
        context?.clip();
        
        image?.draw(in: rect);
        
        let output = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return output;
    }
    
//    private class func qrImage(
}
