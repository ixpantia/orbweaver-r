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

We'll monitor R-devel and remove non-API calls if we see warnings or errors.

* Also, the installed size is over 5Mb because we vendor system dependencies.
