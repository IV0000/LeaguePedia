//
//  RunesView.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import SwiftUI

let keystoneDescription = [
    LocalizedStringKey("Hunt and eliminate prey.\nBurst damage and target access"),
    LocalizedStringKey("Outwit mere mortals.\nCreative tools and rule bending"),
    LocalizedStringKey("Become a legend.\nImproved attack and sustained damage"),
    LocalizedStringKey("Live forever.\nDurability and crowd control"),
    LocalizedStringKey("Unleash destruction.\nEmpowered abilities and resource manipulation")
]

let imageName = [
    "Domination",
    "Inspiration",
    "Precision",
    "Resolve",
    "Sorcery"
]

struct RunesView: View {
    
    @StateObject var runeFetcher = RuneFetcher()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:15){
                    ForEach(runeFetcher.runesList.indices , id:\.self){ index in
                        RuneListRow(index: index, runeFetcher: runeFetcher)
                    }
                    Spacer()
                }
                .navigationTitle("Runes")
                .onAppear{
                    runeFetcher.loadRunesData()
                }
            }
        }
    }
}

struct RuneListRow: View {
    
    var index: Range<Array<MainRune>.Index>.Element
    @ObservedObject var runeFetcher: RuneFetcher
    
    var body: some View {
        NavigationLink(destination: RunesDetail(mainRune:runeFetcher.runesList[index]), label:{
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
                    }
                    .frame(width: 70, height: 70)
                    VStack(alignment: .leading){
                        Text(runeFetcher.runesList[index].name)
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
        })
    }
}

//MARK: - PREVIEW
struct RunesView_Previews: PreviewProvider {
    static var previews: some View {
        RunesView()
    }
}
