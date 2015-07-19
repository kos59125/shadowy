shadowy
=======

shadowy is a RESTful API framework for R.

shadowy is inspired by [SuaveIO](http://suave.io/)

Installation
------------

```r
devtools::install_github("kos59125/shadowy")
```

Example
-------

```r
library(Rook)
library(shadowy)

## Defines an API application.
topPage <- "<!DOCTYPE html>
<html>
<head><title>shadowy</title></head>
<style type='text/css'>
input { width: 3em; }
</style>
<script type='text/javascript'>
function goRandom() {
   var min = document.getElementById('min').value;
   var max = document.getElementById('max').value;
   location.href = 'api/random/' + min + '/' + max;
   return false;
}
</script>
<body>
<h1>Welcome to the shadowy</h1>
<dl>
<dt><a href='api/secret'>/secret</a></dt>
<dd>Forbidden Example</dd>
<dt><a href='api/random'>/random</a></dt>
<dd>Generates a random number in [0, 1).</dd>
<dt><a href='api/random/10/20' onclick='return goRandom()'>/random/{{min}}/{{max}}</a></dt>
<dd>Generates a random number in [min, max).
Click the link after filling the textboxes:<br />
min <input type='text' name='min' id='min' value='10' /> /
max <input type='text' name='max' id='max' value='20' /></dd>
</dl>
</body>
</html>"
building <- route(
   ## simple response
   path("") %>>%
      CONTENT_TYPE("text/html") %>>%
      setBody(topPage),
   ## 403 error
   path("/secret") %>>%
      FORBIDDEN %>>%
      setBody("You cannot access the requested URL."),
   ## returns a random number
   path("/random") %>>%
      setBodyLazy(quote(runif(1))),
   ## returns a random number with parameters
   path.scan("/random/{{min}}/{{max}}", function(min, max) {
      ## parameters are given as character
      some(runif(1, as.numeric(min), as.numeric(max)))
   }) %|>>%
      function(u) { setBody(u) }
)

## Launches the API server.
httpd <- Rhttpd$new()
httpd$add(name = "api", app = api(building))
httpd$start(quiet = TRUE)
httpd$browse("api")
```

Documentation
-------------

ToDo
