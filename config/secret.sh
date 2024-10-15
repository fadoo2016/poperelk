#!/bin/bash
kubectl -nelk delete secret popersecret
kubectl -nelk create secret generic popersecret \
	--from-literal=es-username=elastic \
	--from-literal=es-password=abcd1234 \
	--from-literal=logstash-username=logstash_system \
	--from-literal=logstash-password=abcd1234 \
	--from-literal=ls-keystore-password=abcd1234 \
	--from-literal=kibana-username=kibana_system \
	--from-literal=kibana-password=abcd1234
