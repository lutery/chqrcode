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
}
