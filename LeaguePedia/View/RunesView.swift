//
//  RunesView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

struct RunesView: View {
    
    let keystoneDescription = [
        "Hunt and eliminate prey.\nBurst damage and target access.",
        "Outwit mere mortals.\nCreative tools and rule bending",
        "Become a legend.\nImproved attack and sustained damage",
        "Live forever.\nDurability and crowd control",
        "Unleash destruction.\nEmpowered abilities and resource manipulation"]
    
    let imageName = [
        "Domination",
        "Inspiration",
        "Precision",
        "Resolve",
        "Sorcery"
    ]
    
    @StateObject var runeManager = RuneClass()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:15){
                    ForEach(runeManager.runes.indices , id:\.self){ index in
                        NavigationLink(destination: RunesDetail(mainRune:runeManager.runes[index]), label:{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color("cardColor"))
                                HStack{
                                    
                                    ZStack{
                                        Rectangle()
                                            .cornerRadius(20)
                                            .foregroundColor(Color("innerCard"))
                                        SwiftUI.Image(imageName[index])
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }.frame(width: 70, height: 70)
                                    VStack(alignment: .leading){
                                        Text(runeManager.runes[index].name)
                                            .foregroundColor(.primary)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        Text(keystoneDescription[index])
                                            .foregroundColor(.secondary)
                                            .font(.system(size: 15))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(width: 230, height: 80,alignment: .leading)
                                    Spacer()
                                    Text(">")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    
                                }
                                .padding(.leading,20)
                            }
                            .frame(width:373,height:108)
                            // .padding(to)
                        })
                    }
                    Spacer()
                    
                        .onAppear{
                            runeManager.loadRunesData()
                        }
                    // Spacer()
                }.navigationTitle("Runes")
            }
        }
    }
}
struct RunesView_Previews: PreviewProvider {
    static var previews: some View {
        RunesView()
    }
}
