;; TODO:
;; Have a :plugins vector.
;; Add [lein-outdated "1.0.0"] to it
{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :dependencies [[alembic "0.2.1"]
                       #_[clj-ns-browser "1.3.1" :exclusions [hiccup]]
                       [im.chit/iroh "0.1.11"]
                       ;; TODO: figure out how to exclude plexus-utils
                       ;; The obvious approach doesn't work
                       [im.chit/vinyasa "0.2.2"]  ; :exclusions [org.codehaus.plexus/plexus-utils]
                       [io.aviso/pretty "0.1.16"]
                       [leiningen #= (leiningen.core.main/leiningen-version)  :exclusions [cheshire
                                                                                           com.fasterxml.jackson.core/jackson-core
                                                                                           com.fasterxml.jackson.dataformat/jackson-dataformat-smile
                                                                                           common-logging
                                                                                           commons-codec
                                                                                           org.apache.httpcomponents/httpclient
                                                                                           org.apache.httpcomponents/httpcore
                                                                                           org.apache.maven.wagon/wagon-http
                                                                                           org.apache.maven.wagon/wagon-http-shared4
                                                                                           org.apache.maven.wagon/wagon-provider-api
                                                                                           org.clojure/tools.cli
                                                                                           org.clojure/tools.reader
                                                                                           ;;org.codehaus.plexus/plexus-utils
                                                                                           org.jsoup/jsoup
                                                                                           potemkin]]
                       [nrepl-inspect "0.3.0"]
                       [pjstadig/humane-test-output "0.7.0"]
                       ;; Q: Is there any point to this next one?
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [slamhound "1.5.5"]
                       [spyscope "0.1.5"]]
        :injections [(require '[vinyasa.inject :as inject])
                     (inject/in
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      [vinyasa.lein :exclude [*project*]]
                      [vinyasa.pull :all]
                      [cemerick.pomegranate add-classpath add-dependencies get-classpath resources]

                      clojure.core [iroh.core .> .? .* .% .%>]
                      
                      clojure.core >
                      [clojure.pprint pprint]
                      [clojure.java.shell sh]
                      #_[clj-ns-browser.sdoc sdoc])
                     (require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        ;;:local-repo "repo"
        :plugins [[jonase/eastwood "0.2.1"]
                  [lein-ancient "0.5.5" :exclusions [cheshire common-codec commons-codec slingshot]]
                  ;; This next one's super useful, but its dependencies are out of date
                  ;; TODO: Update!
                  #_[lein-kibit "0.0.8"]
                  [lein-pprint "1.1.1"]
                  [mvxcvi/whidbey "0.6.0"]]
        :repl-options {:nrepl-middleware
                       [inspector.middleware/wrap-inspect
                        ;;ritz.nrepl.middleware.apropos/wrap-apropos
                        ;;ritz.nrepl.middleware.javadoc/wrap-javadoc
                        ;;ritz.nrepl.middleware.simple-complete/wrap-simple-complete
                        ]}
        :signing {:gpg-key "69327CA8"}
        :whidbey {:width 180
                  :map-delimiter ""
                  :extend-notation true
                  :print-meta true
                  :color-scheme {}
                  :print-color true}}
 :repl {:plugins [[cider/cider-nrepl "0.8.2" :exclusions [org.clojure/java.classpath]]]}}
