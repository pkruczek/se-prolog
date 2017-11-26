### Known problems:

#### no jpl in java.library.path


Solution: 
* install pl-jpl (for Fedora `sudo dnf install pl-jpl`)
* `-Djava.library.path="/usr/lib64/swipl-jpl/"`