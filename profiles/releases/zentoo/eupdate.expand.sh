#!/bin/bash

case $1 in

# docbook slots
app-text/docbook-sgml-dtd)               echo "=$1-3.0-r3"
                                         echo "=$1-3.1-r3"
                                         echo "=$1-4.0-r3"
                                         echo "=$1-4.1-r3";;
app-text/docbook-xml-dtd)                echo "=$1-4.1.2-r6"
                                         echo "=$1-4.2-r2"
                                         echo "=$1-4.4-r2"
                                         echo "=$1-4.5-r1";;
app-text/docbook-xml-simple-dtd)         echo "=$1-1.0-r1"
                                         echo "=$1-4.1.2.4-r2";;

# autoconf/make slots
sys-devel/autoconf)                      echo "$1";;
sys-devel/automake)                      echo "$1";;

# python
dev-lang/python)                         echo "=$1-2.7.7";;
dev-lang/python-exec)                    echo "=$1-0.3.1-r1"
                                         echo "=$1-2.0.1-r1";;
dev-python/ctypesgen)                    echo "=$1-0_p72-r1";;
dev-python/gdata)                        echo "=$1-2.0.18";;
dev-python/python-openid)                echo "=$1-2.2.5-r1";;
dev-python/rpy)                          echo "=$1-2.5.0-r1";;
dev-python/suds)                         echo "=$1-0.4-r1";;

# ruby
dev-lang/ruby)                           echo "=$1-1.9.3_p551"
                                         echo "=$1-2.0.0_p598";;
virtual/rubygems)                        echo "=$1-4"
                                         echo "=$1-6";;
virtual/ruby-ffi)                        echo "=$1-2";;
virtual/ruby-ssl)                        echo "=$1-1"
                                         echo "=$1-3";;
virtual/ruby-threads)                    echo "=$1-1"
                                         echo "=$1-4";;
dev-ruby/activesupport)                  echo "=$1-3.2.21";;
dev-ruby/bson)                           echo "=$1-1.6.2-r1";;
dev-ruby/childprocess)                   echo "=$1-0.5.5";;
dev-ruby/eventmachine)                   echo "=$1-1.0.3-r1";;
dev-ruby/log4r)                          echo "=$1-1.1.10-r1";;
dev-ruby/multi_json)                     echo "=$1-1.9.3";;
dev-ruby/net-scp)                        echo "=$1-1.1.2-r1";;
dev-ruby/net-ssh)                        echo "=$1-2.7.0-r1";;
dev-ruby/net-ssh-multi)                  echo "=$1-1.1";;
dev-ruby/yard)                           echo "=$1-0.8.7.6";;

# php
dev-lang/php)                            echo "=$1-5.5.18";;
virtual/httpd-php)                       echo "=$1-5.5";;

# java
dev-java/oracle-jdk-bin)                 echo "=$1-1.7.0.71"
                                         echo "=$1-1.8.0.25";;
dev-java/javatoolkit)                    echo "=$1-0.3.0-r9";;
virtual/jdk)                             echo "=$1-1.7.0"
                                         echo "=$1-1.8.0";;
virtual/jre)                             echo "=$1-1.7.0"
                                         echo "=$1-1.8.0";;

# kernel
sys-kernel/gentoo-sources)               echo "=$1-3.14.21";;
sys-kernel/linux-headers)                echo "=$1-3.14";;

# virtualbox
app-emulation/virtualbox-extpack-oracle) echo "=$1-4.3.20.96996";;
app-emulation/virtualbox*)               echo "=$1-4.3.20";;
dev-util/kbuild)                         echo "=$1-0.1.9998_pre20131130";;

dev-db/postgresql-*)                     echo "=$1-9.4_rc1";;
dev-libs/zziplib)                        echo "=$1-0.13.62";;
dev-vcs/bzr)                             echo "=$1-2.6.0";;
media-gfx/graphviz)                      echo "=$1-2.36.0";;
sys-apps/systemd)                        echo "=$1-217-r2";;
sys-block/btrace)                        echo "=$1-1.0.3";;
sys-devel/bc)                            echo "=$1-1.06.95-r1";;
virtual/jpeg)                            echo "=$1-0-r2";;
*)                                       echo $1;;
esac
