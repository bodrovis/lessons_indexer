![Build Status](https://travis-ci.org/bodrovis/LessonsIndexer.svg?branch=master)

# Lessons Indexer for Learnable

Builds an index in Markdown format for the lesson files in the provided directory and optionally adds heading images to the files. Available options:

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
Defaults to `headers`, has no effect if the `-i` flag is not set.

## Running

Requires Ruby 2.0+. Install the necessary gems using

```
bundle install
```

To run on nix systems use

```
bin/lessons_indexer <options>
```

For Windows use

```
bin/lessons_indexer.bat <options>
```

If any option's value contains spaces, it has to be surrounded with quotes:

```
bin/lessons_indexer -p "C:\User\my test dir\"
```

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

## Testing

```
rspec .
```

## License

Licensed under the [MIT License](https://github.com/bodrovis/LessonsIndexer/blob/master/LICENSE).

Copyright (c) 2015 [Ilya Bodrov](http://radiant-wind.com)