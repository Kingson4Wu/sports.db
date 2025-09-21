# Development Guide

This guide is for contributors who want to help develop and maintain the sports.db project.

## Project Overview

The sports.db project is an open-source sports database containing raw, structured, and aggregated sports data.

### Project Structure

```
sports.db/
  ├── data/
  │     ├── football/
  │     │     ├── raw/
  │     │     ├── structured/
  │     │     ├── aggregated/
  │     │     └── worldcup_2022.json
  │     ├── basketball/
  │     │     └── nba_2021.json
  │     └── tennis/
  ├── assets/
  │     └── football/
  │           └── logos/
  │                 └── README.md
  ├── scripts/   # Data cleaning/generation scripts
  ├── README.md
  └── LICENSE
```

## Cloning the Repository

To avoid downloading large files when cloning the repository, use the following command which utilizes the `clone_repo.sh` script:

```bash
curl -fsSL https://raw.githubusercontent.com/Kingson4Wu/sports.db/main/clone_repo.sh | bash
```

This script clones the repository with Git LFS smudging disabled, which prevents large files from being downloaded during the initial clone. You can then selectively download only the LFS files you need.

## Setting Up the Development Environment

This project provides a conda environment file for setting up the development environment.

### Using Conda

To create and activate the conda environment:

```bash
conda env create -f environment.yml
conda activate sports.db
```

After activating the environment, install the development package:

```bash
pip install -e .
```

## Data Distribution

### GitHub Release
- Used to publish snapshots of a specific version (e.g., v1.0.0)
- Files under each Release have stable download URLs that don't change with branch updates
- Example: `https://github.com/yourname/sports.db/releases/download/v1.0.0/worldcup_2022.json`

### jsDelivr CDN
- Used to accelerate access to GitHub files
- Directly pull from main branch or specified tag:
  - Latest data: `https://cdn.jsdelivr.net/gh/yourname/sports.db@main/data/football/worldcup_2022.json`
  - Specific version: `https://cdn.jsdelivr.net/gh/yourname/sports.db@v1.0.0/data/football/worldcup_2022.json`

### Direct Access (Not Currently Implemented)
- Direct access to files in the repository is technically possible via GitHub's raw URL format
- However, this approach is not implemented or recommended for the following reasons:
  - It would create unnecessary complexity in the repository architecture
  - Current traffic expectations are low, so performance optimization through direct access is not needed
  - Direct file access from the repository could lead to bandwidth limitations or throttling
  - Using GitHub Releases and CDN provides better control, versioning, and performance
- Files should be accessed through the established distribution channels (GitHub Releases or CDN) rather than direct repository access

## Data Processing Scripts

This repository includes Python scripts for processing sports data. These scripts can be used to process raw data into structured formats and generate aggregated statistics.

### Available Scripts

1. `process_data.py` - Processes raw sports data into structured formats
2. `generate_stats.py` - Generates aggregated statistics from structured data

### Running the Scripts

You can run the scripts directly with Python:

```bash
python scripts/process_data.py
python scripts/generate_stats.py
```

Or install the utilities as a package and use them as commands:

```bash
pip install -e .
process-sports-data
generate-sports-stats
```

## Data Retrieval, Cleaning, and Generation

The sports.db project follows a specific workflow for data retrieval, cleaning, and generation:

1. **Data Retrieval**: Raw data is collected from various sources and stored in the `data/{sport}/raw/` directories.

2. **Data Cleaning**: The `process_data.py` script is used to clean and structure the raw data, producing files in the `data/{sport}/structured/` directories.

3. **Data Generation**: The `generate_stats.py` script is used to generate aggregated statistics from structured data, producing files in the `data/{sport}/aggregated/` directories.

## Publishing to Releases

To publish a new version of the data:

1. Ensure all data is properly processed and validated
2. Update the version number in the repository
3. Create a new GitHub Release with the version number
4. Upload the relevant JSON/CSV/Parquet files to the release
5. Update the documentation with the new version URLs

## Contributing

We welcome contributions to the sports.db project! Here's how you can help:

1. Adding new data
2. Improving data quality
3. Writing scripts to clean or generate data
4. Improving documentation

Please make sure to follow the project structure when adding new data or scripts.
