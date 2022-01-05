//
//  RunesDetail.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 04/01/22.
//

import SwiftUI

struct RunesDetail: View {
    var mainRune : MainRune
    var body: some View {
        VStack(alignment: .leading){
            Text("Keystones")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .font(.system(size: 20))
            Spacer()
            
                ScrollView(.horizontal){
                    HStack{
                    ForEach(mainRune.slots.first!.runes,id:\.self){runes in
                        VStack(alignment: .leading){
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .foregroundColor(Color("cardColor"))
                                AsyncImage(url : URL(string: "https://ddragon.leagueoflegends.com/cdn/img/"+(runes.icon))){phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 160, height: 160)
                                            //.cornerRadius(15)
                                           // .overlay(RoundedRectangle(cornerRadius: 15)
                                                       // .stroke(Color.primary, lineWidth: 3))
                                        // .shadow(radius: 5)
                                        
                                    }
                                    else if phase.error != nil {
                                        Color.red
                                            .frame(width: 80, height: 80)
                                        
                                    }
                                    else{
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }
                                }
                                
                            }.frame(width: 320, height: 170, alignment: .center)
                            Text(runes.name)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .font(.system(size: 18))
                            Text(runes.longDesc.replacingOccurrences(of: "\\s?\\<[^>]*\\>", with: " ", options: .regularExpression))
                                .foregroundColor(.secondary)
                                .font(.system(size: 15))
                        }.frame(width: 320, height: 335, alignment: .leading)
                    }
                }
                Spacer()
            }
        }.navigationTitle(mainRune.name)
    }
}


//struct RunesDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RunesDetail(mainRune: )
//    }
//}
