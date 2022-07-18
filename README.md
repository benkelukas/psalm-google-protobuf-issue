# Install deps
- `docker run --rm --volume "${PWD}:/app" --workdir "/app" composer install`

# Reproduce issue with Protobuf extension installed

- Run `docker build -t local/psalm-google-protobuf-issue:with-protobuf --file docker/with-protobuf.Dockerfile .`
- Run `docker run --rm --entrypoint "" --interactive --tty --workdir "/app" --volume "${PWD}:/app" local/psalm-google-protobuf-issue:with-protobuf vendor/bin/psalm`
- See output:
```shell
Target PHP version: 8.1 (inferred from current PHP version)
Scanning files...
Analyzing files...

E

ERROR: MixedAssignment - index.php:3:1 - Unable to determine the type that $t is being assigned to (see https://psalm.dev/032)
$t = (new \Google\Protobuf\Timestamp())->setSeconds(0)->setNanos(0);


ERROR: MixedMethodCall - index.php:3:57 - Cannot determine the type of the object on the left hand side of this expression (see https://psalm.dev/015)
$t = (new \Google\Protobuf\Timestamp())->setSeconds(0)->setNanos(0);


ERROR: MixedArgument - index.php:5:6 - Argument 1 of echo cannot be mixed, expecting string (see https://psalm.dev/030)
echo $t->getSeconds();


ERROR: MixedMethodCall - index.php:5:10 - Cannot determine the type of $t when calling method getSeconds (see https://psalm.dev/015)
echo $t->getSeconds();

  The type of getSeconds is sourced from here - index.php:3:1
$t = (new \Google\Protobuf\Timestamp())->setSeconds(0)->setNanos(0);



------------------------------
4 errors found
------------------------------

Checks took 3.08 seconds and used 72.122MB of memory
Psalm was able to infer types for 20.0000% of the codebase
```

# Reproduce issue without Protobuf extension installed
- run `docker build -t local/psalm-google-protobuf-issue:without-protobuf --file docker/without-protobuf.Dockerfile .`
- run `docker run --rm --entrypoint "" --interactive --tty --workdir "/app" --volume "${PWD}:/app" local/psalm-google-protobuf-issue:without-protobuf vendor/bin/psalm`
- see output:
```shell
Target PHP version: 8.1 (inferred from current PHP version)
Scanning files...
Analyzing files...

░
------------------------------

       No errors found!

------------------------------

Checks took 3.21 seconds and used 78.039MB of memory
Psalm was able to infer types for 100% of the codebase
```
