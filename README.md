

# SurfGen
[![Build Status](https://travis-ci.com/JohnReeze/SurfGen.svg?token=ZXokqeDnBGm8WAqyowYA&branch=master)](https://travis-ci.com/JohnReeze/SurfGen) [![codebeat badge](https://codebeat.co/badges/09676c44-a507-48e8-bfa7-c286ce949212)](https://codebeat.co/projects/github-com-johnreeze-surfgen-master) [![codecov](https://codecov.io/gh/JohnReeze/SurfGen/branch/master/graph/badge.svg)](https://codecov.io/gh/JohnReeze/SurfGen)
 ![Swift Version](https://img.shields.io/badge/swift-5.0-orange) ![LISENCE](https://img.shields.io/badge/LICENSE-MIT-green)

SurfGen is a CLI written in Swift for generating Swift code from OpenApi specification(maybe from blueprint in future). Main purpose is to generate DTO and application layer models for [NodeKit](https://github.com/surfstudio/NodeKit). But you can modify templates written in Stencil or just change models generation to suit your needs in own your fork. 

## Installation

Just add next snippet to your Podfile
```
pod 'SurfGen', :git => "https://github.com/JohnReeze/SurfGen.git", :tag => "0.1.0"
```

Also you can build it from source and just add it to your project using next snippet
```sh
git clone https://github.com/JohnReeze/SurfGen
cd SurfGen
make executable
cp -R Binary <your_project_path>
```
In order to use generate command you need to setup configuration file. See Configuration File 

## Usage

Example:

```sh
surfgen generate ../openapi.yaml --modelNames Order,StatusType --config ./config.yaml
```

Use `--help` to see usage information

```
surfgen --help
Usage: surfgen <command> [options]

surfgen code generator

Commands:
  generate        Generates models for provided spec
  help            Prints help information
  version         Prints the current version of this app
```

Use `surfgen generate --help` to see the list of generation options

```

Usage: surfgen generate <spec> [options]

Generates models for provided spec

Options:
  --config, -c <value>        Path to config yaml-file
  --modelNames, -m <value>    Model names to be generated. Example: --modelNames Order,StatusType
  -h, --help                  Show help information
```
---
**NOTE**

* You can specify not only local path, but any URL of your yaml spec.
* In order to use generate command you need to setup configuration file. See Configuration File 

---



## Configuration File

Configuration file is a yaml-file which could contain next parameters

```yaml
# Generation Pathes

entities_path: ./Common/Models/Models/Entity
entries_path: .Common/Models/Models/Entry
enums_path: ./Common/Models/Models/Shared

# Project Info

# Path to .xcodeproj file where generated files are supposed to be added
project_path: .Common/Models/Models.xcodeproj

# Name of root main project directory. Used to detect correct subgroup in project tree
project_main_group: Models

# Targets in provided Project for generated files
targets:
    - Models
    - AnyOtherTargetInProject

# Flag responsible for properties and models comments
generate_descriptions: true

# Types of models supposed to be generated, current avaliable values: 'nodeKitEntry', 'nodeKitEntity', 'enum'"
generation_types:
  - nodeKitEntity
  - nodeKitEntry
  - enum

# Resources Pathes

# Path to template files.
templates_path: ./surfgen/Templates

# Path to black list file. Model names in this list will be ignored during generation proccess
black_list_path: ./surfgen/black_list.txt

# If your spec is located at private repo on gitlab you can specify personal access token (for more info see https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
gitlab_token: HkDpUKE87yWEHET-_Mns

```

---
**NOTE**

After you set gitlab_token value, you need to correctly configure your spec URL.
Spec URL in general for using with personal access token would be like

```
https://gitlab.com/api/v4/projects/<your_project_id>/repository/files/<path_to_your_spec>/raw?ref=<branch_name>
```
Where: 
- your_project_id is an integer id value (you can find it under your project name in gitlab on main repo's page).
- path_to_your_spec is a relative path to your yaml-file

Tips:

If you using gitlab personal access token, you can add next snippet to your Makefile

```makefile
model:
    /Pods/SurfGen/Binary/surfgen generate https://gitlab.com/api/v4/projects/<your_project_id>/repository/files/<path_to_your_spec>/raw?ref=master --modelNames $(modelNames) 
```
---

## Models

Currently there are only three types of models avaliable (btw you can create you own):

* nodeKitEntity
* nodeKitEntry
* enum

First two types are supposed to be used with [NodeKit](https://github.com/surfstudio/NodeKiti). 
Enum model is a regular Codable enum:

```swift
public enum ExampleType: Int, Codable { 
}
```

## Editing

```
$ swift package generate-xcodeproj
$ open SurfGen.xcodeproj
```
This use Swift Project Manager to create an `xcodeproj` file that you can open, edit and run in Xcode, which makes editing any code easier.

If you want to pass any required arguments when running in XCode, you can edit the scheme to include launch arguments.

## How it works

![](./Docs/surfgen_work_scheme.jpg)

## Templates

Templates are just .txt files in Templates directory. You need to specify path to that directory in config file. These files follow the **Stencil** file format outlined here [https://stencil.fuller.li](https://stencil.fuller.li)

