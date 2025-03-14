## R CMD check results

0 errors | 0 warnings | 2 notes

1. New submission. 

This package was archived on 2024-06-28. We fixed the outstanding issues.

2. checking compiled code ... NOTE

```
File 'orbweaver/libs/x64/orbweaver.dll':
  Found non-API calls to R: 'BODY', 'CLOENV', 'DATAPTR', 'ENCLOS',
    'FORMALS'
``` 

We'll monitor R-devel and remove the non-API calls if this becomes a warning or
error.

* Also, the installed size is a bit over 5Mb because we vendor dependencies.
