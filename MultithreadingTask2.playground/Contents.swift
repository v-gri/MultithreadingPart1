import Foundation

let semaphore = DispatchSemaphore(value: 2)

func performTask(id: Int) {
    
    
    DispatchQueue.global().async {
        semaphore.wait()
        let thread = Thread.current
        print("Task \(id) started on thread: \(thread)")
        sleep(1)
        print("Task \(id) finished on thread: \(thread)")
        semaphore.signal()
    }
}

func runConcurrentTasks() {
    let threads = (1...5).map { id in
        Thread {
            performTask(id: id)
        }
    }
    
    threads.forEach { $0.start() }
}

runConcurrentTasks()
