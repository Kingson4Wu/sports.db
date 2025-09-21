# sportsdb-client

A lightweight Python client for accessing sports data from sports.db.

## Features

- Simple API for accessing sports data
- Automatic caching with intelligent updates
- Support for multiple data sources (GitHub Release, jsDelivr CDN)

## Installation

```bash
pip install sportsdb-client
```

## Usage

```python
from sportsdb import get_match_results

# Directly get data (automatic caching + async updates + expiration cleanup)
results = get_match_results("WorldCup", 2022)
print(results.head())
```

## Cache Directory

The client uses the following cache directory structure:

```
~/.sportsdb/cache/
  ├── football/
  │     ├── worldcup_2022.json
  │     └── worldcup_2022.meta
```