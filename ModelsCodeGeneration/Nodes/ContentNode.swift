//
//  ContentNode.swift
//  ModelsCodeGeneration
//
//  Created by Mikhail Monakov on 26/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

public final class ContentNode: ASTNode {
    
    public var next: [ASTNode]

    public init(_ nodes: [ASTNode]) {
        self.next = nodes
    }

    public var nodeToken: ASTToken {
        return .content
    }

}
