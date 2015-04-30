# Lessons Indexer for Learnable

Builds an index in Markdown format for the lesson files in the provided directory and pushes the result
 to the remote Git branch. Available options:

* `-p` (`--path`) - path to the working directory. Defaults to `.`.
* `-o` (`--output`) - output file to save index to. Defaults to `README.md`. The file will be creating in the working
directory if it does not exist. If it does exist, all its contents **will be erased**.

## Some Assumptions

The program makes two assumptions:

* The working directory should have a nested folder that contains all lesson files. This folder should be named after
the course (the program will do its best to convert folder's name to proper title, for example "Introduction_to_less" will
be converted to "Introduction To Less").
* Lesson files should have the lesson and step numbers in their title separated by `.` or `-`. It may contain any other
words, but they have to have *.md* extension. Here is an example of a valid file name: `lesson3.2.md` or `h3-2.md`. All other
files will be ignored.

## License

Licensed under the [MIT License](https://github.com/bodrovis/LessonsIndexer/blob/master/LICENSE).

Copyright (c) 2015 [Ilya Bodrov](http://radiant-wind.com)