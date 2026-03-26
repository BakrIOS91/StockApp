//
//  SearchBar.swift
//  StockApp
//
//  Created by Bakr Mohamed on 26/03/2026.
//

import SwiftUI
import BMSwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onEditing: ((String) -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.searchGrayColor)
                .font(.system(size: 16, weight: .medium))
            
            TextField(placeholder, text: $text)
                .textStyle(weight: .regular, size: 16, color: .appBlack)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            if !text.isEmpty {
                Button {
                    text = ""
                    onEditing?("")
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.searchGrayColor)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.appLightGray.opacity(0.4))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.searchBorderColor, lineWidth: 1)
        )
        .onChange(of: text) { oldValue, newValue in
            onEditing?(newValue)
        }
    }
}

#Preview {
    SearchBar(text: .constant(""), placeholder: "Search stocks...")
        .padding()
}
