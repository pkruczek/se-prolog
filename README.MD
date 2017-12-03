### Known problems:

#### no jpl in java.library.path


Solution (Fedora): 
* install pl-jpl `sudo dnf install pl-jpl`
* `-Djava.library.path="/usr/lib64/swipl-jpl/"`

Solution (Mac OS X): 
* install swipl `brew install swi-prolog --with-jpl`
* `-Djava.library.path="-Djava.library.path="/usr/local/Cellar/swi-prolog/7.6.3/libexec/lib/swipl-7.6.3/lib/x86_64-darwin16.7.0/""`