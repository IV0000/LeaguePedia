//
//  CacheAsyncImage.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 03/01/22.
//

import Foundation
import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transcation: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transcation: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ){
        self.url = url
        self.scale = scale
        self.transcation = transcation
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageCache[url]{
            let _ = print("cached \(url.absoluteString)")
            content(.success(cached))
        }
        else{
            let _ = print("request \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transcation
            ){phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View{
        if case .success(let image) = phase
        {
            ImageCache[url] = image
        }
        return content(phase)
    }
}


fileprivate class ImageCache {
    static var cache: [URL : SwiftUI.Image] = [:]
    
    static subscript(url: URL) -> SwiftUI.Image? {
        get{
            ImageCache.cache[url]
        }
        set{
            ImageCache.cache[url] = newValue
        }
    }
}
