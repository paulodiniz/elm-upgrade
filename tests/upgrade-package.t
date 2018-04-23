Upgrading a package from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_package/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.7.0-exp-105-gf2936580
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected a package project (this project has exposed modules)
  INFO: Installing latest version of elm-lang/core
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <TODO: upgrade docs link>
  and the documentation for your dependencies for more information.
  

The transformed project should look like:

  $ git add -N .
  $ git status --short elm-package.json
  D  elm-package.json
  $ git diff
  diff --git a/elm.json b/elm.json
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -0,0 +1,15 @@
  +{
  +    "type": "package",
  +    "name": "avh4/project",
  +    "summary": "helpful summary of your project, less than 80 characters",
  +    "license": "MIT",
  +    "version": "1.0.0",
  +    "exposed-modules": [
  +        "CoolData"
  +    ],
  +    "elm-version": "0.19.0 <= v < 0.20.0",
  +    "dependencies": {
  +        "elm-lang/core": "6.0.0 <= v < 7.0.0"
  +    },
  +    "test-dependencies": {}
  +}
  \ No newline at end of file