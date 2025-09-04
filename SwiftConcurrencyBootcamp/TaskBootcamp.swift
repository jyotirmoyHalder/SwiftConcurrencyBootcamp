//
//  TaskBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by jyotirmoy_halder on 3/9/25.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        
        
        try? await Task.sleep(for: .nanoseconds(5_000_000_000))
        
//        for x in array {
//            // work
//            
//            try Task.checkCancellation()
//            
//            
//        }
//        
        do {
            guard let url  = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image = UIImage(data: data)
                print("Image returned")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url  = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image2 = UIImage(data: data)
                print("Image returned")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("click me") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<Void, Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onDisappear() {
//            fetchImageTask?.cancel()
//        }
//        .onAppear() {
//            fetchImageTask = Task(priority: .high) {
//                await viewModel.fetchImage()
//            }
//            Task(priority: .background) {
//                print(Thread.isMainThread)
//                print(Task.currentPriority)
//                await viewModel.fetchImage2()
//            }
            
//            Task(priority: .userInitiated) {
////                try? await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield()
//                print("Userinitiated : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("Medium : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .low) {
//                print("Low : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("Utility : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("background : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .high) {
//                print("High : \(Thread.current) : \(Task.currentPriority)")
//            }
            
//            Task(priority: .low) {
//                print("Userinitiated : \(Thread.current) : \(Task.currentPriority)")
//                
//                Task.detached {
//                    print("detached : \(Thread.current) : \(Task.currentPriority)")
//                }
//            }
            
//        }
    }
}

#Preview {
    TaskBootcamp()
}
