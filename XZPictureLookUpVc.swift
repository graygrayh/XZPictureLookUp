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
    fileprivate var originFrame : CGRect!
    /// 缩放大小，暂时未用到
    fileprivate var scale : CGFloat!
    /// 图片
    var image : UIImage!
    /// 图片imageview
    fileprivate var xzImageView : UIImageView!
    /// 背景视图
    fileprivate var xzBackgroundView : UIView!
    /// 图片查看scrollview
    fileprivate var xzScrollView : UIScrollView!
    
    /// 展示回调事件
    var sureAction:(_ parament:AnyObject,_ image:UIImage)->() = ({_ in
        
    })
    /// 关闭回调事件
    var cancelAction:(_ parament:AnyObject,_ image:UIImage)->() = ({_ in
        
    })
    
    static func creat() -> XZPictureLookUpView
    {
        let view = XZPictureLookUpView()
        view.frame = UIScreen.main.bounds
        return view
    }
    
    //MARK: - 背景点击事件
    func backgroundTap(_ sender:AnyObject) {
        
        close {
            self.cancelAction("" as AnyObject,UIImage())
        }
    }
    
    //MARK: - 关闭查看器
    func close(_ complete:@escaping ()->()) {
        
        colseAnimation {
            print(self.cancelAction)
            self.removeFromSuperview()
            complete()
        }
    }
    
    //MARK: - 显示查看器
    func showWithImage(_ image:UIImage,frame:CGRect,fromView:UIView)  {
        
        /**
         配置imageview
         
         - parameter frame: xzImageView
         */
        xzImageView = UIImageView.init(frame: self.bounds)
        xzImageView.contentMode = UIViewContentMode.scaleAspectFit
        xzImageView.image = image
        xzImageView.frame = self.convert(frame, from: fromView)
        originFrame = self.convert(frame, from: fromView)
        /**
         配置backgroudview
         
         - parameter frame: xzBackgroundView
         */
        xzBackgroundView = UIView.init(frame: self.bounds)
        xzBackgroundView.backgroundColor = colorFromHex("000000")
        self.insertSubview(xzBackgroundView, at: 0)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.backgroundTap(_:)))
        self.addGestureRecognizer(tap)
        
        /**
         配置scrollview
         
         - parameter frame: xzScrollView
         */
        xzScrollView = UIScrollView.init(frame: self.bounds)
        xzScrollView.contentSize = xzImageView.size()
        xzScrollView.delegate = self
        xzScrollView.zoomScale = 1
        xzScrollView.maximumZoomScale = 2.0
        xzScrollView.minimumZoomScale = 0.5
        xzScrollView.isScrollEnabled = true;

        xzScrollView.delegate = self
        xzScrollView.addSubview(xzImageView)
        
        self.addSubview(xzScrollView)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        showAnimation()
        sureAction("" as AnyObject,image)
    }
    

    
    /**
     close效果
     */
    func colseAnimation(_ complete:@escaping ()->()) {
        //        let ani = CABasicAnimation()
        //        ani.duration = 0.23
        //        ani.removedOnCompletion = true
        //        ani.keyPath = "transform.scale"
        //        ani.fromValue = NSNumber.init(float: 1)
        //        ani.toValue = NSNumber.init(float: 0.01)
        //
        //        self.layer.addAnimation(ani, forKey: "close")
        
        UIView.animate(withDuration: 0.3, animations: {
            self.xzImageView.transform = CGAffineTransform.identity
            self.xzImageView.frame = self.originFrame
            self.xzBackgroundView.alpha = 0
        }, completion: { (aa) in
            if aa{
                complete()
            }
        }) 
    }
    
    /**
     show效果
     */
    func showAnimation() {
        //        let ani = CABasicAnimation()
        //        ani.duration = 0.23
        //        ani.removedOnCompletion = false
        //        ani.keyPath = "transform.scale"
        //        ani.fromValue = NSNumber.init(float: 1)
        //        ani.toValue = NSNumber.init(float: Float(scale))
        
        //        let traslationx = CABasicAnimation()
        //        traslationx.duration = 0.23
        //        traslationx.keyPath = "transform.translation.x"
        //        traslationx.fromValue = NSNumber.init(float: Float(xzScrollView.center.x))
        //        traslationx.fromValue = NSNumber.init(float: Float(self.center.x))
        //
        //        let traslationy = CABasicAnimation()
        //        traslationy.duration = 0.23
        //        traslationy.keyPath = "transform.translation.y"
        //        traslationy.fromValue = NSNumber.init(float: Float(xzScrollView.center.y))
        //        traslationy.fromValue = NSNumber.init(float: Float(self.center.y))
        //
        //        let group = CAAnimationGroup()
        //        group.animations = [ani,traslationx,traslationy]
        
        //        xzImageView.layer.addAnimation(ani, forKey: "show")
        UIView.animate(withDuration: 0.3, animations: {
            self.xzImageView.transform = CGAffineTransform.identity
            let size = ((self.xzImageView.image) != nil) ? self.xzImageView.image?.size : self.xzImageView.frame.size
            let ratio = min(UIScreen.main.bounds.size.width / (size?.width)!, UIScreen.main.bounds.size.height / (size?.height)!)
            let w = ratio * (size?.width)!
            let h = ratio * (size?.height)!
            self.xzImageView.frame = CGRect(x: (UIScreen.main.bounds.size.width - w) / 2, y: (UIScreen.main.bounds.size.height - w) / 2, width: w, height: h)
        }) 
 
    }
    //MARK: - 代理
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return xzImageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        xzImageView.center = scrollView.center
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1
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
