;; TODO:
;; Have a :plugins vector.
;; Add [lein-outdated "1.0.0"] to it
{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}  ; Q: Will I ever find occasion to actually use this?
        :dependencies [[alembic "0.3.2"]   ; Q: what's this really for? A: modifying CLASSPATH at runtime
                       ;; We inherit this next through vinyasa.
                       ;; Shouldn't need to declare it
                       ;; Actually, this doesn't make sense in here. Its entire purpose
                       ;; in life is to split away from vinyasa. It's a general purpose
                       ;; library, such as useful.
                       ;; TODO: Verify that nothing else in here depends on it.
                       ;; (that seems to be done)
                       ;; (I'm pretty sure it doesn't, because my general profiles.clj
                       ;; doesn't have this)
                       #_[im.chit/hara "2.1.11"]
                       ;; This should probably go away
                       ;; Q: Did hara replace this too?
                       [im.chit/vinyasa "0.3.4" :exclusions [org.codehaus.plexus/plexus-utils]]
                       [io.aviso/pretty "0.1.24"]
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
                                                                                           org.clojure/clojure
                                                                                           org.clojure/tools.cli
                                                                                           #_org.clojure/tools.reader
                                                                                           org.jsoup/jsoup
                                                                                           potemkin
                                                                                           slingshot]]
                       ;; Q: How many of any of the rest of these do I actually use?
                       ;; This one's gone
                       #_[nrepl-inspect "0.3.0"]
                       [org.codehaus.plexus/plexus-utils "3.0.17"]
                       ;; I use this everywhere. But it doesn't belong in here
                       #_[org.clojure/tools.namespace "0.2.10"]
                       ;; I know I have a lot of projects that transitively rely on this, but they really shouldn't
                       #_[org.clojure/tools.nrepl "0.2.12" :exclusions [org.clojure/clojure]]
                       [pjstadig/humane-test-output "0.7.0"]
                       ;; Q: Is there any point to this next one?
                       #_[ritz/ritz-nrepl-middleware "0.7.0"]
                       ;; This approach is long deprecated.
                       ;; See its README and put it into :aliases insted
                       #_[slamhound "1.5.5"]]
        :injections [(require '[vinyasa.inject :as inject])
                     ;; TODO: call install-pretty-exception
                     (require 'io.aviso.repl)
                     (inject/in
                      ;; Default injection ns is .
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      #_[vinyasa.lein :exclude [*project*]]
                      #_[vinyasa.pull :all]
                      [alembic.still [distill pull]]  ; Q: what is/was this?
                      ;; Actually, I think I want to keep something along these lines
                      [cemerick.pomegranate add-classpath add-dependencies get-classpath resources]


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
        :plugins [[cider/cider-nrepl "0.11.0" :exclusions [org.clojure/java.classpath]]
                  [com.jakemccrary/lein-test-refresh "0.14.0"]
                  [jonase/eastwood "0.2.2" :exclusions [org.clojure/clojure]]
                  [lein-ancient "0.6.8" :exclusions [cheshire
                                                     common-codec
                                                     commons-codec
                                                     org.clojure/clojure
                                                     #_org.clojure/tools.reader
                                                     slingshot]]
                  ;; This next one's super useful, but its dependencies are out of date
                  ;; TODO: Update!
                  [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]
                  [lein-pprint "1.1.1"]
                  [mvxcvi/whidbey "1.3.0" :exclusions [org.clojure/clojure]]]
        :repl-options {:nrepl-middleware
                       []}
        :whidbey {:width 180
                  :map-delimiter ""
                  :extend-notation true
                  :print-meta true
                  :color-scheme {}
                  :print-color true}}
  :repl {:plugins [[cider/cider-nrepl "0.11.0" :exclusions [org.clojure/java.classpath]]]}}
