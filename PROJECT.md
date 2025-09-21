# sports.db Project Standards

This document outlines the standards and conventions for the sports.db project.

## Project Structure

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

## Data vs. Assets

The sports.db repository contains two main types of files:

1. **Data Files**: Structured information in formats like JSON, CSV, or Parquet. These are organized in the `data/` directory with subdirectories for each sport and further organized by processing stage:
   - `raw/`: Unprocessed data as collected from sources
   - `structured/`: Cleaned and formatted data following project standards
   - `aggregated/`: Statistical summaries and derived data

2. **Assets**: Non-data files such as images, logos, or other media. These are organized in the `assets/` directory, separated from data files to maintain a clear distinction between informational content and media assets.

## Data Source Documentation Standards

All data added to the sports.db repository must include proper documentation of its source. This documentation should be included in one or both of the following locations:

1. **Directory-level README.md**: Each data subdirectory (e.g., `data/football/raw/`) should contain a README.md file that documents:
   - The source of the data
   - Licensing information
   - Any usage restrictions
   - Instructions for updating or regenerating the data

2. **Project-level documentation**: For major data sources, information should be included in this document (PROJECT.md) to provide an overview of all data sources used in the project.

### Example Data Source Documentation

```
# Football Logos

This directory contains football team and league logos.

## Data Source

The logos in this directory are sourced from the [football-logos](https://github.com/Leo4815162342/football-logos) repository.

## Usage

Logos are organized by league and team. The naming convention for logo files is:
- League logos: `{league_code}.{extension}` (e.g., `premier-league.png`)
- Team logos: `{league_code}-{team_code}.{extension}` (e.g., `premier-league-arsenal.png`)

## License

Please refer to the original repository for licensing information.
```

## Data Organization

Data in the sports.db repository is organized into three main categories:

1. **Raw Data**: Unprocessed data as collected from sources
2. **Structured Data**: Cleaned and formatted data following project standards
3. **Aggregated Data**: Statistical summaries and derived data

Each sport category should follow this organization pattern in the `data/` directory.