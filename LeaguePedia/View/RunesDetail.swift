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
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Text("Keystones")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .font(.system(size: 20))
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:20){
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
                                    .frame(alignment:.topLeading)
                                Spacer()
                            }.frame(width: 320, alignment: .leading)
                        }
                    }
                    Spacer()
                }
                Spacer()
                Text("Secondary")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .font(.system(size: 20))
                
                LazyVStack(alignment:.leading,spacing:20){
                    ForEach(mainRune.slots.dropFirst(),id:\.self) {slots in
                        // List(mainRune.slots,id:\.self){slots in
                        ForEach(slots.runes,id:\.self){ rune in
                            HStack{
                                CacheAsyncImage(url : URL(string: "https://ddragon.leagueoflegends.com/cdn/img/"+(rune.icon))!){phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 64, height: 64)
                                    }
                                    else if phase.error != nil {
                                        Color.red
                                            .frame(width: 64, height: 64)
                                        
                                    }
                                    else{
                                        ProgressView()
                                            .frame(width: 64, height: 64)
                                    }
                                }
                                VStack(alignment:.leading){
                                    Text(rune.name)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 18))
                                    Text(rune.longDesc.replacingOccurrences(of: "\\s?\\<[^>]*\\>", with: " ", options: .regularExpression))
                                        .foregroundColor(.secondary)
                                        .font(.system(size: 15))
                                    
                                }
                                
                            }
                            Divider()
                        }
                        
                    }//.listStyle(.plain)
                }
            }
            Spacer()
        }.navigationTitle(mainRune.name)
            .padding()
    }
}


//struct RunesDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RunesDetail(mainRune: )
//    }
//}
