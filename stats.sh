#!/bin/bash
#
# This script prints the stats for this repo:
# Number of cookbooks, number or recipes, number of attributes, etc.
# Also, it provides a breakdown of different resources used in recipes
#
# Author : Dmitry Duplyakin
#
# To run: /bin/bash stats.sh
#

r_count=0
t_count=0
for c in cookbooks/emulab-* ; do
  if [[ -d "$c" ]]; then
    if [[ -d "$c/recipes" ]]; then
      tmp=`ls $c/recipes/*rb | wc -l`
      let "r_count=r_count+tmp"
    fi
    if [[ -d "$c/templates/default" ]]; then
      tmp=`ls $c/templates/default/*erb | wc -l`
      let "t_count=t_count+tmp"
    fi
  fi;
done
echo "Number of recipes:"
echo $r_count
echo "Number of templates:"
echo $t_count


TMP=/tmp/resources
:> $TMP
for c in cookbooks/emulab-* ; do 
  if [[ -d "$c" ]]; then
    for r in $c/recipes/*.rb ; do 
      cat $r | grep -v '^$\|^#\|^[[:space:]]*$\|^[[:space:]]*\#' \
             | grep -v '^end' \
             | grep -v '^[[:space:]]' \
             | grep -v '^if\|^else' \
             | grep -v '\.each' \
             | grep -v 'Chef::Log' \
             | grep -v '^[[:alnum:]]*=' \
             >> $TMP
    done
  fi; 
done
echo "Used Chef resources:"
cat $TMP | awk '{ print $1 }' | sort | uniq -c | sort -nr

TMP=/tmp/ifs
:> $TMP
for c in cookbooks/emulab-* ; do
  if [[ -d "$c" ]]; then
    for r in $c/recipes/*.rb ; do
      cat $r | grep -v '^$\|^#\|^[[:space:]]*$\|^[[:space:]]*\#' \
             | grep '[[:space:]]if[[:space:]]\|only_if\|not_if' \
             >> $TMP
    done
  fi;
done
echo "Used conditionals:"
cat $TMP | awk '{ print $1 }' | sort | uniq -c | sort -nr

TMP=/tmp/attributes
:> $TMP
for c in cookbooks/emulab-* ; do
  if [[ -d "$c/attributes" ]]; then
    for r in $c/attributes/*.rb ; do
      cat $r | grep -v '^$\|^#\|^[[:space:]]*$\|^[[:space:]]*\#' >> $TMP
    done
  fi;
done
echo "Number of attributes inside all cookbooks:"
cat $TMP | wc -l

TMP=/tmp/depends
:> $TMP
for c in cookbooks/emulab-* ; do
  if [[ -e "$c/metadata.rb" ]]; then
    d=`cat "$c/metadata.rb" | grep depends | grep -v emulab`
    if [ ! -z "$d" ]; then
      l=`echo $d | sed -s 's/depends//g'`
      echo " - $c depends on: $l" >> $TMP
    fi;
  fi;
done
echo "External dependecies (most likely, cookbooks from Supermarket):"
cat $TMP
