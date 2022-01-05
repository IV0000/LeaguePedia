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
        ForEach(mainRune.slots,id:\.self){slots in
            ForEach(slots.runes,id:\.self){ runes in
                Text(runes.name)
            }
        
        }
    }
}

//struct RunesDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RunesDetail()
//    }
//}
