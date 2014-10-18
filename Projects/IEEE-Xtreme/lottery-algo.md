# A recursive solution #
The question gave the **hint** to treat *numbers* as *strings*.

So the core idea is to compare each string in list1 (lottery) with
list2 (lucky).

To satisfy the question, the **lucky number** (saying 62) must be a
**substring** of lottery number. (aka, (substring "62" "162") => true)

In this question, numbers are strings. To be more understandable, I
use number.

## Recursion ##
* Pop 1 number `alpha` from (lottery) (eg 162)
* Check whether `beta` from (lucky) (eg 62) is a substring of `alpha`
    * If true, add to a new list to be indexed (aka the result list)
        * Pop another element from (lottery). Do the same
          checking. (This is called **recursion**)
    * else, check another number (say `beta 2`) from (lucky) is a
      substring of `alpha`. 


The tricky part is to implement a fault-proof (substring-matching?
...)

I am NEW with Scheme programming language, so......



