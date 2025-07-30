import Foundation


func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("Task \(taskNumber) started")
    sleep(delay)
    print("Task \(taskNumber) finished")
}

func executeTasks() {
    let group = DispatchGroup()
    
    let queue1 = DispatchQueue(label: "com.example.queue1", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue2", attributes: .concurrent)
    let queueFinal = DispatchQueue(label: "com.example.finalQueue")
    
    queue1.async(group: group) {
        executeTask(1, delay: 2)
    }
    
    queue2.async(group: group) {
        executeTask(2, delay: 3)
    }
    
    DispatchQueue.global().async {
        group.wait()
        queueFinal.async {
            executeTask(3, delay: 1)
        }
    }
}

executeTasks()

