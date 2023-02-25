//
//  AddNewTrackUnitView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import SwiftUI

struct AddNewTrackUnitView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var track: Track
    
    @StateObject
    var viewModel = AddNewTrackUnitViewModel()


    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 10) {
                ForEach(viewModel.availableTrackUnits, id: \.self) { unit in
                    Button(action: {
                        // handle button tap here
                    }, label: {
                        Text("\(unit.componentDescription.componentManufacturer)")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                    })
                }
            }
            .padding()
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(.black)
        }
        
        .onAppear() {
            viewModel.update()
        }
    }
}

