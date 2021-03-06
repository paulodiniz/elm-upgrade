When a dependency has not yet been upgraded:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_application/" ./
  $ jq '.dependencies += { "avh4/fake-package": "1.0.1 <= v < 2.0.0" }' elm-package.json > tmp && mv tmp elm-package.json
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected an application project (this project has no exposed modules)
  INFO: Switching from NoRedInk/elm-decode-pipeline (deprecated) to NoRedInk/elm-json-decode-pipeline
  INFO: Installing latest version of NoRedInk/elm-json-decode-pipeline
  Here is my plan:
    
    Add:
      NoRedInk/elm-json-decode-pipeline    1\.[0-9]+\.[0-9]+ (re)
  
  Would you like me to update your elm.json accordingly? [Y/n]: Success!
  INFO: Switching from elm-lang/core (deprecated) to elm/core
  INFO: Installing latest version of elm/core
  It is already installed!
  INFO: Detected use of elm-lang/core#Json.Decode; installing elm/json
  I found it in your elm.json file, but in the "indirect" dependencies.
  Should I move it into "direct" dependencies for more general use? [Y/n]: Success!
  INFO: Detected use of elm-lang/core#Random; installing elm/random
  Here is my plan:
    
    Add:
      elm/random    1\.[0-9]+\.[0-9]+ (re)
      elm/time      1\.[0-9]+\.[0-9]+ (re)
  
  Would you like me to update your elm.json accordingly? [Y/n]: Success!
  INFO: Switching from elm-lang/html (deprecated) to elm/html
  INFO: Installing latest version of elm/html
  Here is my plan:
    
    Add:
      elm/html           1\.[0-9]+\.[0-9]+ (re)
      elm/virtual-dom    1\.[0-9]+\.[0-9]+ (re)
  
  Would you like me to update your elm.json accordingly? [Y/n]: Success!
  INFO: Switching from evancz/url-parser (deprecated) to elm/url
  INFO: Installing latest version of elm/url
  Here is my plan:
    
    Add:
      elm/url    1\.[0-9]+\.[0-9]+ (re)
  
  Would you like me to update your elm.json accordingly? [Y/n]: Success!
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  and the documentation for your dependencies for more information.
  
  WARNING! 1 of your dependencies have not yet been upgraded to
  support Elm 0.19.
    - https://github.com/avh4/fake-package
  
  Here are some common upgrade steps that you will need to do manually:
  
  - NoRedInk/elm-json-decode-pipeline
    - [ ] Changes uses of Json.Decode.Pipeline.decode to Json.Decode.succeed
  - elm/core
    - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
  - elm/html
    - [ ] If you used Html.program*, install elm/browser and switch to Browser.element or Browser.document
    - [ ] If you used Html.beginnerProgram, install elm/browser and switch Browser.sandbox
  - elm/url
    - [ ] Change code using UrlParser.* to use Url.Parser.*
  
  $ git add -N .
  $ git status --short
  D  elm-package.json
   A elm-upgrade-[-0-9.TZ]*\.log (re)
   A elm.json
   M src/Main.elm
  $ git diff elm.json
  diff --git a/elm.json b/elm.json
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  +++ b/elm.json
  @@ -0,0 +1,26 @@
  +{
  +    "type": "application",
  +    "source-directories": [
  +        "src"
  +    ],
  +    "elm-version": "0.19.1",
  +    "dependencies": {
  +        "direct": {
  \+            "NoRedInk/elm-json-decode-pipeline": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/core": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/html": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/json": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/random": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/url": "1\.[0-9]+\.[0-9]+", (re)
  +            "avh4/fake-package": "1.0.1"
  +        },
  +        "indirect": {
  \+            "elm/time": "1\.[0-9]+\.[0-9]+", (re)
  \+            "elm/virtual-dom": "1\.[0-9]+\.[0-9]+" (re)
  +        }
  +    },
  +    "test-dependencies": {
  +        "direct": {},
  +        "indirect": {}
  +    }
  +}
  \ No newline at end of file

Running `elm-upgrade` again:

  $ git add .
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  
  ***
  *** ./elm.json already exists.
  *** It looks like this project has already been upgraded to Elm 0.19.
  *** Would you like me to upgrade your project's dependencies?
  ***
  
  [Y/n]: 
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  
  
  SUCCESS! Your project's dependencies have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  $ git add -N .
  $ git status --short
  D  elm-package.json
  A  elm-upgrade-[-0-9.TZ]*\.log (re)
   A elm-upgrade-[-0-9.TZ]*\.log (re)
  A  elm.json
  M  src/Main.elm
  $ git diff
  diff --git a/elm-upgrade-[-0-9.TZ]*\.log b/elm-upgrade-[-0-9.TZ]*\.log (re)
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  \+\+\+ b/elm-upgrade-[-0-9.TZ]*\.log (re)
  @@ -0,0 +1,19 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.1
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  \+INFO: Found elm-format 0\.8\.[0-9]+ (re)
  +
  +***
  +*** ./elm.json already exists.
  +*** It looks like this project has already been upgraded to Elm 0.19.
  +*** Would you like me to upgrade your project's dependencies?
  +***
  +
  +
  +WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  +
  +
  +SUCCESS! Your project's dependencies have been upgraded.
  +However, your project may not yet compile due to API changes in your
  +dependencies.
  +
