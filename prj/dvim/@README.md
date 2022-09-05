@name v@version
====================================
@description

# Dependencies

## General
@for(dependencies)
* @key (https://@.) @end

# Features
@for(features)
@key\. @. @end

# Api

## Functions
@for(functions)
### @key
```C
@.
```@end

# Install

```
git clone git\@github.com:Denpus/@name\.git
cd @name && mkdir build && cd build && cmake ..
make install
````

# Info

* Homepage: [@homepage](@homepage)
* Language code: @language
* License: [@license](https://www.gnu.org/licenses/gpl-3.0.html)
* Author: Denis Karabadjak <denkar\@mail.ru>

Copyright (C) 2019 Denis Karabadjak
