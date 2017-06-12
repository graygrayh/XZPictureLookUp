//
//  XZPictureLookUpVc.swift
//  PeopleLight
//
//  Created by xzh.pc on 2017/6/8.
//  Copyright © 2017年 XZH. All rights reserved.
//

import UIKit

class XZPictureLookUpView: UIView , UIScrollViewDelegate {
    
    /// 记录原始位置信息
    private var originFrame : CGRect!
    /// 缩放大小，暂时未用到
    private var scale : CGFloat!
    /// 图片
    var image : UIImage!
    /// 图片imageview
    private var xzImageView : UIImageView!
    /// 背景视图
    private var xzBackgroundView : UIView!
    /// 图片查看scrollview
    private var xzScrollView : UIScrollView!
    
    /// 展示回调事件
    var sureAction:(parament:AnyObject,image:UIImage)->() = ({_ in
        
    })
    /// 关闭回调事件
    var cancelAction:(parament:AnyObject,image:UIImage)->() = ({_ in
        
    })
    
    static func creat() -> XZPictureLookUpView
    {
        let view = XZPictureLookUpView()
        view.frame = UIScreen.mainScreen().bounds
        return view
    }
    
    //MARK: - 背景点击事件
    func backgroundTap(sender:AnyObject) {
        
        close {
            self.cancelAction(parament: "",image: UIImage())
        }
    }
    
    //MARK: - 关闭查看器
    func close(complete:()->()) {
        
        colseAnimation {
            print(self.cancelAction)
            self.removeFromSuperview()
            complete()
        }
    }
    
    //MARK: - 显示查看器
    func showWithImage(image:UIImage,frame:CGRect,fromView:UIView)  {
        
        /**
         配置imageview
         
         - parameter frame: xzImageView
         */
        xzImageView = UIImageView.init(frame: self.bounds)
        xzImageView.contentMode = UIViewContentMode.ScaleAspectFit
        xzImageView.image = image
        xzImageView.frame = self.convertRect(frame, fromView: fromView)
        originFrame = self.convertRect(frame, fromView: fromView)
        /**
         配置backgroudview
         
         - parameter frame: xzBackgroundView
         */
        xzBackgroundView = UIView.init(frame: self.bounds)
        xzBackgroundView.backgroundColor = colorFromHex("000000")
        self.insertSubview(xzBackgroundView, atIndex: 0)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.backgroundTap(_:)))
        self.addGestureRecognizer(tap)
        
        /**
         配置scrollview
         
         - parameter frame: xzScrollView
         */
        xzScrollView = UIScrollView.init(frame: self.bounds)
        xzScrollView.contentSize = self.bounds.size
        xzScrollView.zoomScale = 1
        xzScrollView.maximumZoomScale = 2
        xzScrollView.minimumZoomScale = 0.5
        xzScrollView.delegate = self
        xzScrollView.addSubview(xzImageView)
        
        self.addSubview(xzScrollView)
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        showAnimation()
        sureAction(parament: "",image: image)
    }
    
    /**
     close效果
     */
    func colseAnimation(complete:()->()) {
        
        UIView.animateWithDuration(0.3, animations: {
            self.xzImageView.transform = CGAffineTransformIdentity
            self.xzImageView.frame = self.originFrame
            self.xzBackgroundView.alpha = 0
        }) { (aa) in
            if aa{
                complete()
            }
        }
    }
    
    /**
     show效果
     */
    func showAnimation() {
     
        UIView.animateWithDuration(0.3) {
            self.xzImageView.transform = CGAffineTransformIdentity
            let size = ((self.xzImageView.image) != nil) ? self.xzImageView.image?.size : self.xzImageView.frame.size
            let ratio = min(UIScreen.mainScreen().bounds.size.width / (size?.width)!, UIScreen.mainScreen().bounds.size.height / (size?.height)!)
            let w = ratio * (size?.width)!
            let h = ratio * (size?.height)!
            self.xzImageView.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width - w) / 2, (UIScreen.mainScreen().bounds.size.height - w) / 2, w, h)
        }
 
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
