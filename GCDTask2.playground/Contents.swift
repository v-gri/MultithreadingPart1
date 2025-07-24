import Foundation


func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("Task \(taskNumber) started")
    sleep(delay) // Simulate work
    print("Task \(taskNumber) finished")
}

func executeTasks() {
    let group = DispatchGroup()

    let queue1 = DispatchQueue(label: "com.example.queue1", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue2", attributes: .concurrent)
    let queueFinal = DispatchQueue(label: "com.example.finalQueue")

    group.enter()
    queue1.async {
        executeTask(1, delay: 2)
        group.leave()
    }

    group.enter()
    queue2.async {
        executeTask(2, delay: 3)
        group.leave()
    }

    group.notify(queue: .main) {
        queueFinal.async {
            executeTask(3, delay: 1)
        }
    }
}

// Run the function
executeTasks()

