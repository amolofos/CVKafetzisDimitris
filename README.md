# CV based on (Xe/Lua)LaTeX.

## Table of Contents

1. [Overview](#Ooerview)
2. [Change Log](#change-log)
3. [Inspirations](#inspirations)
4. [Build](#build)
5. [License](#license)

## Overview
This is the curriculum vitae of Kafetzis Dimitris, written in latex.

![Build Status - main](https://github.com/amolofos/CVKafetzisDimitris/actions/workflows/release.yml/badge.svg)

## Build

* Linux
    ```
    $ ./scripts/build.sh clean compile
    ```

## Change Log

* 2023-12-16
    * Added SRE/Platform engineer role in VegaSolutions
    * Move to Github Actions
    * Introduced a local docker image
* 2020-10-17
    * Add SRE role
* 2020-07-13
    * Added a one column layout
    * Added a two column anonymous cv
    * Changed two column cv
        * Removed the work experience subgroup
        * Updated the skills and technology stack
        * Remove cryptography project as it is not finished yet
* 2020-06-30
    * Created a no icon, no color version
    * Applied changes based on feedback from Francis and Bing commenters
    * Applied changes based on feedback from https://resumeworded.com ATS scanning
* 2020-06-06
    * Initial creation and merge of the two repositories into one.
    * Deletion of the existing content to start from scratch.
* Pre 2020-06
    * There were two separate repositories - one for the English
version and one for the Greek.

## Inspirations

Inspirations for this layout have been drawn one by the following templates
* [LimeCV](https://github.com/opieters/limecv), [Article part 1](https://olivierpieters.be/blog/2017/09/12/designing-a-cv-in-latex-part-1), [Article part 2](https://olivierpieters.be/blog/2017/10/02/designing-a-cv-in-latex-part-2), [Article part 3](https://olivierpieters.be/blog/2017/10/29/designing-a-cv-in-latex-part-3)
* [AltaCV Template](https://www.overleaf.com/latex/templates/altacv-template/trgqjpwnmtgv)
* [Sidebar CV](https://www.overleaf.com/latex/templates/sidebar-cv/kssfdykmmdvz)
* [Great CV Türkçe](https://www.overleaf.com/latex/templates/great-cv-turkce/fphpdpqbjfbk)
* [YAAC: Another Awesome CV](https://www.overleaf.com/latex/templates/awesome-source-cv/wrdjtkkytqcw), [github](https://www.github.com/darwiin/yaac-another-awesome-cv)
* [Freeman CV](http://www.latextemplates.com/template/freeman-cv)
* [Twenty Seconds Resume/CV](http://www.latextemplates.com/template/twenty-seconds-resumecv)
* [Deedy Resume/CV](http://www.latextemplates.com/template/deedy-resume-cv)
* [Developer CV](http://www.latextemplates.com/template/developer-cv)

Elegant solutions from
* [How can you create a vertical timeline?](https://tex.stackexchange.com/questions/196794/how-can-you-create-a-vertical-timeline) in TeX stackexchange

CI/CD integration from
* [A short postmortem on moving to Docker for LaTeX continuous integration](https://ljvmiranda921.github.io/notebook/2018/04/23/postmortem-shift-to-docker/) & [github cv](https://github.com/ljvmiranda921/cv) by Lj Miranda (ljvmiranda921)
* [Using Travis CI with LaTeX documents](https://shankarkulumani.com/2018/10/travis-and-latex.html) by Shankar Kulumani

## License

The content of this repository are restricted under the following licenses

* [MIT License](./LICENSE)
The structure of this project, the layout of the cv document defined in tex
and the integration with CI/CD tools are governed under the [MIT License](./LICENSE).
* Personal information and details that consist the context of the tex and pdf
documents are under strict copyright and cannot be used without prior permission
of the author.
* The initial versions of the cv were making use of [europecv2013](https://github.com/leinardi/europecv2013) Latex class
developed by Roberto Leinardi and copyrighted under LaTeX Project Public License.
See [coverletter2013.cls](coverletter2013.cls) & [europecv2013.cls](europecv2013.cls) files.
* The latex templates under LatexTemplateCVs directory have their own licenses.
Check the accompanied license of each template before use.
