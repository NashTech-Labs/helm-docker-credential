# Helm - Secret - Docker credentials 


## Prerequisites

1. Helm v3 installed
2. Basic knowledge of go-templates


## Usage

### 1. Export these env vars

```
export CONTAINER_REGISTRY=<CONTAINER_REGISTRY>
export REGISTRY_USERNAME=<REGISTRY_USERNAME>
export REGISTRY_PASSWORD=<REGISTRY_PASSWORD>
```


### 2. Run script dock.sh with 1 arguement

```
./dock.sh HELM_CHART_DIR
```

### 3. Check helm template

```
helm template demo helm
```