{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}  ; Q: Will I ever find occasion to actually use this?
        :dependencies [;; Q: what's this really for? A: modifying CLASSPATH at runtime
                       [alembic "0.3.2" :exclusions [org.tcrawley/dynapath]]
                       [com.cemerick/pomegranate "0.3.1" :exclusions [org.apache.maven.wagon/wagon-http
                                                                      org.tcrawley/dynapath]]
                       [commons-io "2.5"]
                       [commons-logging "1.2"]
                       [leiningen #= (leiningen.core.main/leiningen-version) :exclusions [cheshire
                                                                                          com.fasterxml.jackson.core/jackson-core
                                                                                          com.fasterxml.jackson.dataformat/jackson-dataformat-smile
                                                                                          commons-codec
                                                                                          commons-io
                                                                                          commons-logging
                                                                                          #_org.apache.httpcomponents/httpclient
                                                                                          #_org.apache.httpcomponents/httpcore
                                                                                          #_org.apache.maven.wagon/wagon-http
                                                                                          org.apache.maven.wagon/wagon-http-shared4
                                                                                          org.apache.maven.wagon/wagon-provider-api
                                                                                          org.clojure/clojure
                                                                                          org.clojure/tools.reader
                                                                                          org.jsoup/jsoup
                                                                                          potemkin
                                                                                          slingshot]]
                       ;; Q: How many of any of the rest of these do I actually use?
                       [org.apache.maven.wagon/wagon-provider-api "2.12"]
                       [org.codehaus.plexus/plexus-utils "3.0.24"]
                       [pjstadig/humane-test-output "0.8.2"]]
        :injections [;; TODO: call install-pretty-exception
                     ;;; Well, this doesn't seem awful; I think I do want something like this.
                     ;;; But it doesn't seem worth including here...really ought to be decided on
                     ;;; a case-by-case basis, oughtn't it?
                     (require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        ;;:local-repo "repo"
        :plugins [#_[cider/cider-nrepl "0.15.0" :exclusions [org.clojure/java.classpath]]
                  [com.jakemccrary/lein-test-refresh "0.20.0"]
                  [jonase/eastwood "0.2.4" :exclusions [org.clojure/clojure]]
                  ;; Check for out-dated plugins in here using `lein ancient check-profiles`
                  [lein-ancient "0.6.10" :exclusions [cheshire
                                                      common-codec
                                                      commons-codec
                                                      org.clojure/clojure
                                                      #_org.clojure/tools.reader
                                                      slingshot]]
                  [lein-kibit "0.1.5" :exclusions [org.clojure/clojure]]
                  [lein-pprint "1.1.2"]
                  [mvxcvi/whidbey "1.3.1" :exclusions [org.clojure/clojure]]]
        :repl-options {:nrepl-middleware
                       []}
        :whidbey {:width 180
                  :map-delimiter ""
                  :extend-notation true
                  :print-meta true
                  :color-scheme {}
                  :print-color true}}
 :repl {:plugins [[cider/cider-nrepl "0.15.0" :exclusions [org.clojure/java.classpath]]]}}
