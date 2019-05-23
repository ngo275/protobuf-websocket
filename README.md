# Protocol Buffers & WebSocket iOS Sample

## Requirement

- Node.js (v10.15.3)
- yarn (v1.13.0)
- Swift (5)
- Xcode (10.2)
- CocoaPods (1.6.2)
- protoc (1.15.0) - only for complie
  
## Set up

### Backend

```
git clone https://github.com/ngo275/protobuf-websocket.git
cd ws-server
yarn
yarn start:ws
```

### iOS

```
cd WS-Protobuf-Demo
pod install
open WS-Protobuf-Demo.xcworkspace on Xcode
```

## Usage

You have to generate a new proto file, and then compile the file to `.js` and `.swift`.

### Set up compilers

```
# for .js
npm i -g protocol-buffers
```

```
# for swift
cd /path/to/your/workspace/
git clone https://github.com/apple/swift-protobuf.git
cd swift-protobuf
git checkout tags/1.5.0
swift build --static-swift-stdlib -c release
```

### Complie

```
# to .js
protocol-buffers YourModel.proto -o YourModel.js

# to .swift
protoc --swift_out=. YourModel.proto
```
