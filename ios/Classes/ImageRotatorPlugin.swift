import Flutter
import UIKit
import ImageIO
import MobileCoreServices

public class ImageRotatorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "image_rotator", binaryMessenger: registrar.messenger())
    let instance = ImageRotatorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "rotate":
      let arguments = call.arguments as? NSDictionary
      let path = arguments!["path"] as? String
      let angle = arguments!["angle"] as? CGFloat
      let outputPath = arguments!["outputPath"] as? String
      
      guard let path = path, let angle = angle, let outputPath = outputPath else {
        result(FlutterError(code:"Invalid_Arguments", message: "path, angle, outputPath must not be null", details: ""))
        return
      }
        
        DispatchQueue.global().async {
            self.rotateImage(filePath:path, angleInDegrees: angle, outputPath: outputPath)
            result(path)
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }


  func rotateImage(filePath: String, angleInDegrees: CGFloat, outputPath: String) {
    if let image = UIImage(contentsOfFile: filePath) {
        let rotatedImage = image.rotate(radians: angleInDegrees * .pi / 180)
        
        let croppedImage = rotatedImage.cropTo4x3()
        
        if croppedImage == nil {
            return
        }
        
        let rotatedImageData = croppedImage!.jpegData(compressionQuality: 1)
        
        do {
            try rotatedImageData!.write(to: URL(fileURLWithPath: outputPath))
        } catch {
            print("An error occurred: \(error)")
        }
    }
  }
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        var newSize = CGRect(origin: .zero, size: self.size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .integral.size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        self.draw(in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
    
    func cropTo4x3() -> UIImage? {
        let desiredWidth: CGFloat
        let desiredHeight: CGFloat
        let startX: CGFloat
        let startY: CGFloat
        
        if size.width > size.height {
            desiredWidth = size.height / 3 * 4
            desiredHeight = size.height
            startX = (size.width - desiredWidth) / 2
            startY = 0
        } else {
            desiredWidth = size.width
            desiredHeight = size.width / 3 * 4
            startX = 0
            startY = (size.height - desiredHeight) / 2
        }
        
        let rect = CGRect(x: startX, y: startY, width: desiredWidth, height: desiredHeight)
        
        if let cgImage = cgImage?.cropping(to: rect) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
