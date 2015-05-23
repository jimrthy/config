;; TODO:
;; Have a :plugins vector.
;; Add [lein-outdated "1.0.0"] to it
{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :dependencies [[alembic "0.3.2"]
                       #_[clj-ns-browser "1.3.1" :exclusions [hiccup]]
                       ;; We inherit this next through vinyasa.
                       ;; Shouldn't need to declare it
                       ;; Actually, this doesn't make sense in here. It's entire purpose
                       ;; is life is to split away from vinyasa. It's a general purpose
                       ;; library, such as useful.
                       ;; TODO: Verify that nothing else in here depends on it.
                       ;; (I'm pretty sure it doesn't, because my general profiles.clj
                       ;; doesn't have this)
                       #_[im.chit/hara "2.1.11"]
                       [im.chit/vinyasa "0.3.4" :exclusions [org.codehaus.plexus/plexus-utils]]
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
                       [org.codehaus.plexus/plexus-utils "3.0"]
                       [org.clojure/tools.namespace "0.2.10"]
                       [pjstadig/humane-test-output "0.7.0"]
                       ;; Q: Is there any point to this next one?
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [slamhound "1.5.5"]
                       [spyscope "0.1.5"]]
        :injections [(require 'spyscope.core)
                     (require '[vinyasa.inject :as inject])
                     ;; TODO: call install-pretty-exception
                     (require 'io.aviso.repl)
                     (inject/in
                      ;; Default injection ns is .
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      #_[vinyasa.lein :exclude [*project*]]
                      #_[vinyasa.pull :all]
                      [alembic.still [distill pull]]
                      [cemerick.pomegranate add-classpath add-dependencies get-classpath resources]


                      ;; Inject into clojure.core
                      clojure.core
                      [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]
                      
                      ;; Inject into clojure.core, with prefix
                      clojure.core >
                      [clojure.pprint pprint]
                      [clojure.java.shell sh]
                      #_[clj-ns-browser.sdoc sdoc])
                     (require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        ;;:local-repo "repo"
        :plugins [[com.jakemccrary/lein-test-refresh "0.9.0"]
                  [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
                  [lein-ancient "0.6.7" :exclusions [cheshire common-codec commons-codec slingshot]]
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
        :whidbey {:width 180
                  :map-delimiter ""
                  :extend-notation true
                  :print-meta true
                  :color-scheme {}
                  :print-color true}}
 :repl {:plugins [[cider/cider-nrepl "0.8.2" :exclusions [org.clojure/java.classpath]]]}}
