//
//  ProductSoldList.swift
//  Cashdeck
//
//  Created by Revarino Putra on 04/08/21.
//

import SwiftUI

struct ProductSoldList: View {
    
    let data = ProductSoldViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
                Text("Best Seller")
                    .font(Font.custom("SFProDisplay-Semibold", size: 18))
                    .foregroundColor(Color("AccentColor2"))
                    .padding(.bottom, 24)
            
                HStack {
                    Text("SKU")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(width: 150, alignment: .leading)
                    
                    Text("Name")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(minWidth: 350, alignment: .leading)
                    
                    Text("Colour")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(minWidth: 105, alignment: .leading)
                    
                    Text("Size")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(minWidth: 90, alignment: .leading)
                    
                    Text("Quantity")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(minWidth: 118, alignment: .leading)
                    
                    Text("Net Income")
                        .font(Font.custom("SFProDisplay-Semibold", size: 16))
                        .frame(minWidth: 120, alignment: .leading)
                }
                .padding(.bottom, 16)
            ScrollView {
                ForEach(self.data.soldData, id: \.self) { data in
                    HStack {
                        
                        if let product = data.td_product, let sku = product.sku, let productName = product.name {
                            Text(sku)
                                .frame(width: 150, alignment: .leading)
                            Text(productName)
                                .frame(minWidth: 330, alignment: .leading)
                        }
                        
                    }
                }
            }
            Spacer()
        }
        .frame(minWidth: 1009, maxWidth: .infinity, minHeight: 650.94, maxHeight: 700, alignment: .leading)
        .background(Color.white)
        .cornerRadius(15)
        .clipped()
    }
}

struct ProductSoldList_Previews: PreviewProvider {
    static var previews: some View {
        ProductSoldList()
    }
}
