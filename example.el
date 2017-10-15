(defvar movies "https://api.graph.cool/simple/v1/movies")

(graphql-request movies "{
  allActors {
    id
    name
  }
}")


(mapcar
 (lambda (actor)
   (gethash "name" actor))
 (gethash
  "allActors"
  (gethash
   "data"
   (graphql-request movies
                    "query ($name: String!) {
                       allActors(filter: {name_starts_with: $name}) {
                         id
                         name
                       }
                     }"
                    (list (cons 'name "A"))))))
