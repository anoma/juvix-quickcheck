# Property-based testing for Juvix

Obtain the Juvix compiler at https://github.com/anoma/juvix

## Example

Here's an example module that defines and tests a property.

```
module Example;

import Stdlib.Prelude open;
import Stdlib.Data.Nat.Ord open;

import Test.QuickCheckTest as QC;

prop-reverseReverseIsIdentity (xs : List Int) : Bool :=
  Eq.eq xs (reverse (reverse xs));

reverseTest : QC.Test :=
  QC.mkTest
    "reverse of reverse is identity"
    prop-reverseReverseIsIdentity;

main : IO :=
  readLn
    \ {seed :=
      QC.runTestsIO 100 (stringToNat seed) [reverseTest]};
```

To run this you need to pass a random seed to the runner:

``` shell
$ juvix compile Example.juvix
$ od -An -N2 -t u2 /dev/urandom | xargs | ./Example
'reverse of reverse is identity': success
All tests passed
```

For a larger example see [Example.juvix](Example.juvix) and you can run this using:

``` shell
make run-quickcheck
```
