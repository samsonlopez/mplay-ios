# MPlay - Music Playstore Demo App (iOS)
Music PlayStore App as a demo for a **scalable**, **modular**, **feature** based archtecture using SPM modules and a modern tech stack.

## Features
A simple set of features for demonstrating a feature based modular architecture.
- Display a list of albums.
- Dynamic loading/pagination of the albums list.
- [More to be added, a work in progress..]

## Modules
- Main app - Hosts the modules as SPM packages.
- Landing - Hosts the landing page to navigate to other modules.
- Home - Contains the main feature of displaying the albums list.
Each module (as of now its only Home as a full feature) contains a full set of appliction layers to be independently worked on by a team and is managed as an SPM dependency.

## Tech Stack
- **Modular**, **scalable** architecture with code organised into feature based **SPM Modules** for **large teams**.
- **MVVM**+Clean Architecture with protocol based abstraction and implementations.
- **SwiftUI** - for a modern declarative UI.
- **Combine** - Works great with SwiftUI for a reactive approach to data.
- **GraphQL** - Backend For Frontend, using latest version of Apollo.
