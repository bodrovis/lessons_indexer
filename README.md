[![Gem Version](https://badge.fury.io/rb/lessons_indexer.svg)](http://badge.fury.io/rb/lessons_indexer)
[![Build Status](https://travis-ci.org/bodrovis/lessons_indexer.svg?branch=master)](https://travis-ci.org/bodrovis/lessons_indexer)
[![Code Climate](https://codeclimate.com/github/bodrovis/lessons_indexer/badges/gpa.svg)](https://codeclimate.com/github/bodrovis/lessons_indexer)
[![Test Coverage](https://codeclimate.com/github/bodrovis/lessons_indexer/badges/coverage.svg)](https://codeclimate.com/github/bodrovis/lessons_indexer/coverage)
[![Dependency Status](https://gemnasium.com/bodrovis/lessons_indexer.svg)](https://gemnasium.com/bodrovis/lessons_indexer)
# Lessons Indexer for Sitepoint Premium

Builds an index in Markdown format for the lesson files in the provided directory, adds heading images to the files, generates PDFs from Markdown, pushes changes to GitHub. Can work with multiple branches.

Relies on [messages_dictionary](https://github.com/bodrovis-learning/messages_dictionary) to store messages.

## Installation and Usage

Requires [Ruby](https://www.ruby-lang.org) 2.0+ and [RubyGems](https://rubygems.org/). `Ruby\bin` should be added
to the PATH.

Install the gem:

```
gem install lessons_indexer
```

Run:

```
lessons_indexer <options>
```

or 

```
bundle exec lessons_indexer <options>
```

If an option contains spaces, it has to be surrounded with quotes:

```
bin/lessons_indexer -p "C:\User\my test dir\"
```

## Options

* `-p` (`--path`) - path to the working directory. Defaults to `.`.
* `-s` (`--skip_index`) - skip index generation. Defaults to `false`.
* `-o` (`--output`) - output file to save index to. Defaults to `README.md`. The file will be creating in the working
directory if it does not exist. If it does exist, all its contents **will be erased**. Has no effect if `-s` is set.
* `-g` (`--git`) - if present, pushes changes to the remote branch (with the name equal to the local branch).
* `-m` (`--message`) - which commit message should be specified. Default to "Added index". Has no effect if the `-g` flag
is not set.
* `-a` (`--all`) - if present, will work with **all** branches of the specified directory (except for `master`).
* `-i` (`--headings`) - if present, heading images will be added to the beginning of each lesson file. If the file already
has a heading in the beginning, it will be skipped.
* `-d` (`--headings_dir`) - relative path to the directory with heading images.
Defaults to `headings`, has no effect if the `-i` flag is not set.
* `-f` (`--pdf`) - should PDFs be generated from the lesson files in markdown format. PDFs will have the same name as the
lesson files, read more [below](#pdf-generation). Defauls to `false`.

## Some Assumptions

Here are some guidelines to follow when using the program:

* The working directory (provided with the `-p` flag) should have a nested folder that contains all lesson files. This folder should be named after
the course and end with the `_handouts` (the program will do its best to convert folder's name to proper title, for example "Introduction_to_less_handouts" will
be converted to "Introduction To Less").
* Lesson files should have the lesson and step numbers in their title separated by `.` or `-`. It may contain any other
words, but they have to have *.md* extension. Here is an example of a valid file name: `lesson3.2.md` or `h3-2.md`. All other
files will be ignored.
* If the `-i` flag is set (to add headings to the lesson files), the `*_handouts` folder has to contain directory with the images.
This directory's name can be provided with the `-d` flag. Files inside should follow the same naming conditions as for the lesson
files (of course, they don't need to have the *.md* extension). Valid files names: `Git Course 1.1.jpg` or `google_maps10-3.png`.
All other files will be ignored. If the program cannot find a header image for a specific step,
this step will be just skipped and the corresponding warning message will be displayed.

## PDF Generation

Starting from version **0.2.0** Indexer supports PDF generation ([GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) is expected). It is disabled by default - provide `-f` flag to enable this feature.

PDF generation is not a very simple process, so some additional software has to be installed on your machine:

* [Pandoc](http://pandoc.org/) - the main program that makes conversion possible. It supports all major platforms, just select the [version](http://pandoc.org/installing.html) that suits you.
* [LaTex](http://www.latex-project.org/). Unfortunately, it is not possible to convert directly to PDF, so LaTex is required. Pandoc [lists](http://pandoc.org/installing.html) the recommended
implementations of LaTex for various platforms.
* [xetex](http://xetex.sourceforge.net/) - extension for LaTex to integrate typesetting capabilities. By default changing the default
font family is a huge pain, therefore xetex is used. Please note, that it is already a part of some LaTex implementations
(for example, if you install full version of MIKTex, xetex will already be present, so no additional actions are needed).

Make sure Pandoc is present in your PATH by typing

```
pandoc -v
```

in your terminal.

Indexer uses [Open Sans](http://www.fontsquirrel.com/fonts/open-sans) as a main font and [Liberation Mono](http://www.fontsquirrel.com/fonts/Liberation-Mono) as monotype font (for code examples). Both of these fonts
are free (in contrast to Helvetica Neue that has to be purchased), so if you don't have those fonts just download them and install into the fonts directory.

After that you are ready to generate PDFs! Just remember that it will take some time (about 5-10 seconds per lesson file).

## Testing

```
bundle install
rspec .
```

## License

Licensed under the [MIT License](https://github.com/bodrovis/LessonsIndexer/blob/master/LICENSE).

Copyright (c) 2015 [Ilya Bodrov](http://radiant-wind.com)