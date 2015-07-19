if (!require(Rook) || !require(RJSONIO)) {
   stop("Install Rook package and RJSONIO package before trying this demo.")
}
library(shadowy)

packageList <- rownames(installed.packages())
packageList <- setdiff(packageList, c("base", "stats"))  # these packages redirect to datasets package.

allDatasets <- Reduce(function(acc, packageName) {
   datasets <- data(package = packageName)$results
   if (nrow(datasets) == 0L) {
      acc
   } else {
      rbind(acc, datasets)
   }
}, packageList, NULL)

getPackageDatasets <- function(packageName) {
   allDatasets[allDatasets[, "Package"] == packageName, , drop = FALSE]
}

getDataset <- function(packageName, datasetName) {
   allDatasets[allDatasets[, "Package"] == packageName & allDatasets[, "Item"] == datasetName, , drop = FALSE]
}

json <- function(datasets) {
   result <- sapply(seq(nrow(datasets)), function(i) {
      as.list(datasets[i, c("Package", "Item", "Title")])
   }, simplify = FALSE, USE.NAMES = FALSE)
   toJSON(result)
}

## Defines an API application.
topPage <- "<!DOCTYPE html>
<html>
<head><title>datasets</title></head>
<body>
<h1>datasets</h1>
<dl>
<dt><a href='datasets/'>/</a></dt>
<dd>All datasets.</dd>
<dt><a href='datasets/rpart'>/{{package}}</a></dt>
<dd>Datasets in the specified package.</dd>
<dt><a href='datasets/rpart/car90'>/{{package}}/{{dataset}}</a></dt>
<dd>Dataset.</dd>
</dl>
</body>
</html>"
building <- route(
   path("") %>>%
      CONTENT_TYPE("text/html") %>>%
      setBody(topPage),
   path("/") %>>%
      CONTENT_TYPE("application/json") %>>%
      setBody(json(allDatasets)),
   path.scan("/{{packageName}}", function(packageName) {
      some(getPackageDatasets(packageName))
   }) %|>>%
      function(datasets) {
         CONTENT_TYPE("application/json") %>>%
            setBody(json(datasets))
      },
   path.scan("/{{packageName}}/{{datasetName}}", function(packageName, datasetName) {
      some(getDataset(packageName, datasetName))
   }) %|>>%
      function(datasets) {
         CONTENT_TYPE("application/json") %>>%
            setBody(json(datasets))
      }
)

## Launches the API server.
httpd <- Rhttpd$new()
httpd$add(name = "datasets", app = api(building))
httpd$start(quiet = TRUE)
httpd$browse("datasets")

message("To stop demo, run: httpd$stop()")
