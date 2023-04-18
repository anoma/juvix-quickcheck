# Property-based testing for Juvix

Obtain the Juvix compiler at https://github.com/anoma/juvix

## Example

Here's an example module that defines and tests a property.

```
module Example;

open import Stdlib.Prelude;
open import Stdlib.Data.Nat.Ord;

import Test.QuickCheckTest as QC;

prop-partition : List Int -> (Int -> Bool) -> Bool;
prop-partition xs p :=
  case partition p xs
    | lhs, rhs :=
      all p lhs
        && not (any p rhs)
        && length xs == length (lhs ++ rhs);

partitionTest : QC.Test;
partitionTest :=
  QC.mkTest
    QC.testableListIntHofIntBool
    "partition: test predicate on result"
    prop-partition;

main : IO;
main :=
  readLn
    \ {
      | seed := QC.runTestsIO
        100
        (stringToNat seed)
        (partitionTest :: nil)
    };
```

To run this you need to pass a random seed to the runner:

``` shell
$ juvix compile Example.juvix
$ od -An -N2 -t u2 /dev/urandom | xargs | ./Example
'partition: test predicate on result': success
All tests passed
```

For a larger example see <Example.juvix> and you can run this using:

``` shell
make run-quickcheck
```
