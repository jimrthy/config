{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}  ; Q: Will I ever find occasion to actually use this?
        :dependencies [;; Q: what's this really for? A: modifying CLASSPATH at runtime
                       [alembic "0.3.2" :exclusions [org.tcrawley/dynapath]]
                       [commons-logging "1.2"]
                       ;; TODO: Replace this with whatever replaced it
                       ;; Careful: 0.3.4 was working OK
                       ;; Q: Did hara replace this too?
                       #_[im.chit/vinyasa "0.4.7" :exclusions [im.chit/hara.reflect
                                                             org.clojure/clojure
                                                             org.codehaus.plexus/plexus-utils
                                                             org.slf4j/jcl-over-slf4j]]
                       [leiningen #= (leiningen.core.main/leiningen-version) :exclusions [cheshire
                                                                                          com.fasterxml.jackson.core/jackson-core
                                                                                          com.fasterxml.jackson.dataformat/jackson-dataformat-smile
                                                                                          #_commons-io
                                                                                          commons-logging
                                                                                          commons-codec
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
                       ;; This one's gone
                       #_[nrepl-inspect "0.4.1"]
                       [org.apache.maven.wagon/wagon-provider-api "2.10"]
                       [org.codehaus.plexus/plexus-utils "3.0.24"]
                       ;; I use this everywhere. But it doesn't belong in here
                       #_[org.clojure/tools.namespace "0.2.10"]
                       ;; I know I have a lot of projects that transitively rely on this, but they really shouldn't
                       #_[org.clojure/tools.nrepl "0.2.12" :exclusions [org.clojure/clojure]]
                       [pjstadig/humane-test-output "0.8.1"]
                       ;; Q: Is there any point to this next one?
                       #_[ritz/ritz-nrepl-middleware "0.7.0"]
                       ;; This approach is long deprecated.
                       ;; See its README and put it into :aliases instead
                       #_[slamhound "1.5.5"]
                       ;; Q: Do I actually use this anywhere/for anything?
                       ;; A: leiningen does.
                       ;; Q: Why am/was I overriding?
                       #_[slingshot "0.12.2" :exclusions [org.clojure/clojure]]]
        :injections [#_(require '[vinyasa.inject :as inject])
                     ;; TODO: call install-pretty-exception
                     #_(require 'io.aviso.repl)
                     #_(inject/in
                      ;; Default injection ns is .
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      [alembic.still [distill pull]]  ; Q: what is/was this?
                      ;; I still want this.
                      ;; Q: Where did it go?
                      #_[cemerick.pomegranate add-classpath add-dependencies get-classpath resources]

                      ;;; At least 90% certain that I don't want any of the rest of this
                      ;; Inject into clojure.core
                      clojure.core
                      [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                      ;; Inject into clojure.core, with prefix
                      clojure.core >
                      [clojure.pprint pprint]
                      [clojure.java.shell sh])
                     ;;; Well, this doesn't seem awful; I think I do want something like this.
                     ;;; But it doesn't seem worth including here...really ought to be decided on
                     ;;; a case-by-case basis, oughtn't it?
                     (require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        ;;:local-repo "repo"
        :plugins [[com.jakemccrary/lein-test-refresh "0.16.0"]
                  [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
                  ;; Check for out-dated plugins in here using `lein ancient check-profiles`
                  [lein-ancient "0.6.10" :exclusions [cheshire
                                                      common-codec
                                                      commons-codec
                                                      org.clojure/clojure
                                                      #_org.clojure/tools.reader
                                                      slingshot]]
                  [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]
                  [lein-pprint "1.1.2"]
                  [mvxcvi/whidbey "1.3.0" :exclusions [org.clojure/clojure]]]
        :repl-options {:nrepl-middleware
                       []}
        :whidbey {:width 180
                  :map-delimiter ""
                  :extend-notation true
                  :print-meta true
                  :color-scheme {}
                  :print-color true}}
  :repl {:plugins [[cider/cider-nrepl "0.13.0" :exclusions [org.clojure/java.classpath]]]}}
