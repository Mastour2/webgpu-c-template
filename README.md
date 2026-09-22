# webgpu-c-template

Startup template for Dawn WebGPU graphics using native C99 for low-level graphics programming.

Requirements

- CMake
- Ninja
- Dawn


## macOS Setup

Create a directory for libraries and clone Dawn:

```bash
mkdir -p ~/libs
cd ~/libs

git clone https://dawn.googlesource.com/dawn
cd dawn
```

Configure Dawn From the Dawn directory:

```bash
cmake -S . -B out/Release -G Ninja  -DDAWN_FETCH_DEPENDENCIES=ON  -DDAWN_ENABLE_INSTALL=ON -DCMAKE_BUILD_TYPE=Release
```
Build Dawn

```bash
cmake --build out/Release
```

Install Dawn

```bash
cmake --install out/Release --prefix install/Release
```

Dawn will now be installed at: `~/libs/dawn/install/Release`

# Build the Project

Pass the Dawn installation path to CMake

```bash 
cmake -S . -B build -DDAWN_DIR=$HOME/libs/dawn/install/Release
```

Then build
```bash
cmake --build build
or
make build DAWN_DIR=$HOME/libs/dawn/install/Release
```


Run:
```bash
make run DAWN_DIR=$HOME/libs/dawn/install/Release
```

Clean:
```bash
make clean
```
⸻

## Windows Setup

Create a directory for libraries
```bash
mkdir C:\libs
cd C:\libs

git clone https://dawn.googlesource.com/dawn
cd dawn
```
Configure Dawn

```bash 
cmake -S . -B out/Release -G Ninja `  -DDAWN_FETCH_DEPENDENCIES=ON` -DDAWN_ENABLE_INSTALL=ON ` -DCMAKE_BUILD_TYPE=Release
```

Build Dawn
```bash 
cmake --build out/Release
```
Install Dawn
```bash 
cmake --install out/Release --prefix install/Release
```

Dawn will now be installed at `C:\libs\dawn\install\Release`

## Build the Project on Windows

```bash
cmake -S . -B build -DDAWN_DIR=C:/libs/dawn/install/Release
```

Then:
```bash 
cmake --build build
or
make build DAWN_DIR=C:/libs/dawn/install/Release
```

