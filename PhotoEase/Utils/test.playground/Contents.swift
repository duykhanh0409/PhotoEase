import UIKit

var greeting = "Hello, playground"



import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//func processImage() {
//    // Xử lý ảnh – tác vụ ưu tiên cao
//    DispatchQueue.global(qos: .userInitiated).async {
//        print("🧠 Bắt đầu xử lý ảnh... [\(Thread.current)]")
//        sleep(2) // Giả lập xử lý nặng
//
//        print("✅ Xử lý ảnh xong")
//
//        // Gọi tiếp lưu ảnh vào ổ đĩa
//        saveImageToDisk()
//    }
//}
//
//func saveImageToDisk() {
//    // Lưu ảnh – ưu tiên thấp hơn, không cần gấp
//    DispatchQueue.global(qos: .userInteractive).async {
//        print("💾 Đang lưu ảnh vào disk... [\(Thread.current)]")
//        sleep(1) // Giả lập lưu file
//
//        print("✅ Lưu ảnh xong")
//
//        // Quay lại UI để cập nhật
//        updateUI()
//    }
//}
//
//func updateUI() {
//    DispatchQueue.main.async {
//        print("🖼️ Cập nhật giao diện người dùng! [\(Thread.current)]")
//    }
//}
//
//// Simulate button tap
//processImage()


protocol StudentDelegate: AnyObject {
    func didFinishedHomeWork()
}

class Student {
    weak var delegate: StudentDelegate?
    
    func doHomework() {
        print("Doing homework...")
        delegate?.didFinishedHomeWork()
    }
}


class Teacher: StudentDelegate {
    func didFinishedHomeWork() {
        print("you did good job")
    }
}

var teacher = Teacher()
var student = Student()

student.delegate = teacher

student.doHomework()
