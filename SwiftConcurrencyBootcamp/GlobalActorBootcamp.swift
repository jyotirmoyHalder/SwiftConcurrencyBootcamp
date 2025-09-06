//
//  GlobalActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by jyotirmoy_halder on 6/9/25.
//

import SwiftUI

@globalActor final class MyFirstGlobalActor {
    
    static var shared = MyNewDataManager()
    
}

actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String] {
        
        return ["One", "Two", "Three", "Four", "Five"]
    }
    
}

class GlobalActorBootcampViewModelf: ObservableObject {
    
    @MainActor @Published var dataArray: [String] = []
    let manager = MyFirstGlobalActor.shared
    
    @MyFirstGlobalActor
    func getData() {
        
        // HEAVY COMPLES METHODS5
        
        Task {
            let data = await manager.getDataFromDatabase()
            await MainActor.run {
                self.dataArray = data
            }
        }
        
    }
    
}

struct GlobalActorBootcamp: View {
    
    @StateObject private var viewModel = GlobalActorBootcampViewModelf()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorBootcamp()
}
