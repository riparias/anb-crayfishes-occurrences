[![funding](https://img.shields.io/static/v1?label=published+through&message=LIFE+RIPARIAS&labelColor=00a58d&color=ffffff)](https://www.riparias.be/)

## Rationale

This repository contains the functionality to standardize the crayfishes data from a targeted monitoring of the [Agentschap voor Natuur en Bos](https://www.natuurenbos.be/) (ANB) to a [Darwin Core Archive](https://ipt.gbif.org/manual/en/ipt/2.5/dwca-guide) that can be harvested by a [GBIF IPT](https://ipt.gbif.org/manual/en/ipt/2.5/).

## Workflow

[source data](https://github.com/riparias/anb-crayfishes-occurrences/tree/main/data/raw) → Darwin Core [mapping script](https://riparias.github.io/anb-crayfishes-occurrences/dwc_mapping.html) → generated [Darwin Core files](https://github.com/riparias/anb-crayfishes-occurrences/tree/main/data/processed)


## Published dataset

* [Dataset on the IPT](#) - TBD
* [Dataset on GBIF](#) - TBD

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── anb-crayfishes-occurrences.Rproj : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
|
├── sql                    : Darwin Core transformations
│   ├── dwc_event.sql
│   └── dwc_occurrence.sql
|
├── src
│   ├── dwc_mapping.Rmd    : Darwin Core mapping script
│   ├── _site.yml          : Settings to build website in docs/
│   └── index.Rmd          : Template for website homepage
│
├── docs                   : Repository website GENERATED
│
└── data
    ├── raw                : Source data, input for mapping script
    └── processed          : Darwin Core output of mapping script GENERATED
```

## Installation

1. Clone this repository to your computer
2. Open the RStudio project file
5. Open the `dwc_mapping.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio to map data to DwC manually
6. Click `Run > Run All` to generate the processed data

## License

[MIT License](https://github.com/riparias/anb-crayfishes-occurrences/blob/main/LICENSE) for the code and documentation in this repository. The included data is released under another license.
