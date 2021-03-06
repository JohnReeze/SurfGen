//
//  GASTDeclNodeBuilderTests.swift
//  SurfGen
//
//  Created by Mikhail Monakov on 13/03/2020.
//

import XCTest
@testable import YamlParser
import Swagger
import SurfGenKit

class GASTDeclNodeBuilderTests: XCTestCase {

    var schemas: [ComponentObject<Schema>]!
    var shopObject: ComponentObject<Schema>!
    var deleveryEnumObject: ComponentObject<Schema>!

    // MARK: - Constants

    override func setUp() {
        do {
            schemas = try SwaggerSpec(string: FileReader().readFile("TestFiles/rendezvous.yaml")).components.schemas
            shopObject = schemas.first(where: { $0.name == "ShopLocation" })!
            deleveryEnumObject = schemas.first(where: { $0.name == "DeliveryType" })!
        } catch {
            XCTFail("Error loading test spec")
        }
    }

    func testDeclNodeBuilder() {
        do {
            let node = try GASTDeclNodeBuilder().buildDeclNode(for: shopObject)


            // check for correct node
            guard case .decl = node.token else {
                XCTFail("built node with incorrect token")
                return
            }

            // check subnodes

            guard case let .name(value) = node.subNodes[0].token else {
                XCTFail("built node with incorrect token")
                return
            }

            XCTAssert(value == "ShopLocation", "Name subnode is incorrect")

            guard case .content = node.subNodes[1].token else {
                XCTFail("built node with incorrect token")
                return
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEnumDeclNodeBuilder() {
        do {
            let node = try GASTDeclNodeBuilder().buildDeclNode(for: deleveryEnumObject)


            // check for correct node
            guard case .decl = node.token else {
                XCTFail("built node with incorrect token")
                return
            }

            // check subnodes

            guard case let .name(value) = node.subNodes[0].token else {
                XCTFail("built node with incorrect token")
                return
            }

            XCTAssert(value == "DeliveryType", "Name subnode is incorrect")

            guard case .content = node.subNodes[1].token else {
                XCTFail("built node with incorrect token")
                return
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
