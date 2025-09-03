//
//  ContentView.swift
//  Getapi
//
//  Created by Ricky Vishwas on 31/08/25.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
        Image(uiImage: uiimage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .background(Color.gray)
    } else {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .background(Color.gray)
            .onAppear {
                fetchData()
            }
    }
}


    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.apidata, id: \.self) { listdata in
                    HStack {
                        URLImage(urlString: listdata.image)
                        
                        Text(listdata.name)
                            .bold()
                    }
                    .padding(4)
                }
            }
            .navigationTitle(Text("W L PROJECT"))
            .onAppear {
                viewModel.getData()
            }
        }
    }
}

#Preview {
    ContentView()
}
